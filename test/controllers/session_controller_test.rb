require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest

    test 'should sign in' do
        log_in_as users(:regular)
        assert flash[:notice]
    end

    test 'should redirect if logged in' do
        log_in_as users(:regular)
        get log_in_url
        # log_in_as users(:regular)
        assert_response :redirect
    end

end
