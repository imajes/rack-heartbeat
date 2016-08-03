require 'helper'
require 'base64'
require 'rack/request'

class Rack::TestHeartbeat < Minitest::Test
  def setup
    @app = Minitest::Mock.new
    @heartbeat = Rack::Heartbeat.new(@app)
  end

  def teardown
    Rack::Heartbeat.setup do |config|
      config.heartbeat_path = 'heartbeat'
      config.heartbeat_headers = {'Content-Type' => 'text/plain'}
      config.heartbeat_response = 'OK'
      config.heartbeat_allowed_ip_list = []
     end
  end

  def test_initialize_sets_default_heartbeat_path
    assert_match(/\Aheartbeat\z/, @heartbeat.heartbeat_path)
  end

  def test_call_when_env_empty_sends_app_call
    env = {}

    @app.expect :call, nil, [env]
    @heartbeat.call(env)
    @app.verify
  end

  def test_call_when_path_info_is_nil_sends_app_call
    env = {'PATH_INFO' => nil}

    @app.expect :call, nil, [env]
    @heartbeat.call(env)
    @app.verify
  end

  def test_call_when_path_info_does_not_match_heartbeat_sends_app_call
    env = {'PATH_INFO' => 'some-path'}

    @app.expect :call, nil, [env]
    @heartbeat.call(env)
    @app.verify
  end

  def test_call_when_path_info_matches_heartbeat_path_returns_200_response
    env = {'PATH_INFO' => '/heartbeat'}

    assert_equal [200, {'Content-Type' => 'text/plain'}, ['OK']], @heartbeat.call(env)
  end

  def test_call_when_request_ip_matches_one_of_heartbeat_path_returns_200_response
    env = {'PATH_INFO' => '/heartbeat', 'REMOTE_ADDR' => '127.0.0.1'}

    Rack::Heartbeat.setup do |config|
      config.heartbeat_allowed_ip_list = ['127.0.0.1']
    end

    assert_equal [200, {'Content-Type' => 'text/plain'}, ['OK']], @heartbeat.call(env)
  end

  def test_call_when_request_ip_does_not_match_one_of_heartbeat_path_returns_403_response
    env = {'PATH_INFO' => '/heartbeat', 'REMOTE_ADDR' => '127.0.0.1'}

    Rack::Heartbeat.setup do |config|
      config.heartbeat_allowed_ip_list = ['192.168.0.1']
    end

    assert_equal [403, {'Content-Type' => 'text/plain'}, ["Request forbidden for 127.0.0.1"]], @heartbeat.call(env)
  end

  def test_setup_configures_heartbeat_path
    expected_path = 'health-check.txt'
    expected_headers = {'Content-Type' => 'image/gif'}
    expected_response = Base64.decode64('R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    expected_allowed_ip_list = ['127.0.0.1']

    env = {'PATH_INFO' => "/#{expected_path}", 'REMOTE_ADDR' => '127.0.0.1'}

    Rack::Heartbeat.setup do |config|
      config.heartbeat_path = expected_path
      config.heartbeat_headers = expected_headers
      config.heartbeat_response = expected_response
      config.heartbeat_allowed_ip_list = expected_allowed_ip_list
    end

    assert_match expected_path, Rack::Heartbeat.heartbeat_path
    assert_equal expected_headers, Rack::Heartbeat.heartbeat_headers
    assert_equal expected_response, Rack::Heartbeat.heartbeat_response
    assert_equal expected_allowed_ip_list, Rack::Heartbeat.heartbeat_allowed_ip_list
    assert_equal [200, expected_headers, [expected_response]], @heartbeat.call(env)
  end
end
