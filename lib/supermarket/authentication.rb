module Supermarket
  module Authentication
    #
    # Include the following methods as helper methods.
    #
    def self.included(controller)
      controller.send(:helper_method, :current_user, :signed_in?)
    end

    #
    # The currently logged in user, or nil if there is no user logged in.
    #
    # @return [User, nil]
    #
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    #
    # Is there a signed in user?
    #
    # @return [Boolean] is there a signed in user?
    #
    def signed_in?
      !!current_user
    end

    #
    # Redirect to the sign in url if there is no current_user
    #
    # @TODO: use i18n here for the notice
    #
    def authenticate_user!
      unless signed_in?
        redirect_to sign_in_url, notice: 'You must be signed in to do that.'
      end
    end
  end
end
