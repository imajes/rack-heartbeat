require 'helper'

class Rack::TestHeartbeat < Minitest::Test
  def setup
    @app = Minitest::Mock.new
    @heartbeat = Rack::Heartbeat.new(@app)
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
  
  def test_call_when_request_method_does_not_match_heartbeat_sends_app_call
    env = {'PATH_INFO' => '/', 'REQUEST_METHOD' => 'GET'}
  
    @app.expect :call, nil, [env]
    @heartbeat.call(env)
    @app.verify
  end

  def test_call_when_path_info_matches_heartbeat_path_returns_200_response
    env = {'PATH_INFO' => '/', 'REQUEST_METHOD' => 'OPTIONS'}

    assert_equal [200, {'Content-Type' => 'text/plain', 'Allow' => 'HEAD,GET,PUT,DELETE,OPTIONS'}, ['OK']], @heartbeat.call(env)
  end
  
  def test_call_with_custom_allow_when_path_info_matches_heartbeat_path_returns_200_response
    env = {'PATH_INFO' => '/', 'REQUEST_METHOD' => 'OPTIONS'}
  
    @heartbeat.allow = %w(GET)
    assert_equal [200, {'Content-Type' => 'text/plain', 'Allow' => 'GET'}, ['OK']], @heartbeat.call(env)
  end
end
