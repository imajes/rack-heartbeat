require 'helper'

class Rack::TestHeartbeat < Minitest::Test
  def setup
    @app = Minitest::Mock.new
    @heartbeat = Rack::Heartbeat.new(@app)
  end

  def teardown
    Rack::Heartbeat.setup do |config|
      config.heartbeat_path = 'heartbeat'
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

  def test_setup_configures_heartbeat_path
    expected = 'health-check.txt'
    Rack::Heartbeat.setup do |config|
      config.heartbeat_path = expected
    end

    assert_match expected, Rack::Heartbeat.heartbeat_path
  end
end
