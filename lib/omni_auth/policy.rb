module OmniAuth
  module Policy
    class << self
      #
      # Finds a policy object for the given auth hash and returns a new policy
      # object instance for the auth hash.
      #
      # @param [Hash]
      #   the hash returned from omniauth
      #
      # @return [~OmniAuth::Policy]
      #
      def load(auth)
        provider = auth['provider'].classify

        begin
          "OmniAuth::Policies::#{provider}".constantize.new(auth)
        rescue NameError
          raise RuntimeError, "#{provider} is not a valid policy!"
        end
      end
    end

    # @return [OmniAuth::AuthHash]
    attr_reader :auth

    #
    # Create a new instance of this policy object.
    #
    # @param [OmniAuth::AuthHash] auth
    #
    def initialize(auth)
      @auth = auth
    end

    #
    # The unique signature (like composite key) used by ActiveRecord to
    # identify this policy.
    #
    # @example
    #   { provider: 'github', uid: 'abcd1234' }
    #
    # @return [Hash]
    #
    def signature
      { provider: auth['provider'], uid: uid }
    end

    #
    # The name for this OAuth policy.
    #
    # @return [Symbol]
    #
    def provider
      self.class.key
    end

    #
    # @abstract The first name of the OAuth user.
    #
    # @return [String, nil]
    #
    def first_name; end

    #
    # @abstract The last name of the OAuth user.
    #
    # @return [String, nil]
    #
    def last_name; end

    #
    # @abstract The email of the OAuth user.
    #
    # @return [String, nil]
    #
    def email; end

    #
    # @abstract The username of the OAuth user.
    #
    # @return [String, nil]
    #
    def username; end

    #
    # @abstract The url to the image of the OAuth user.
    #
    # @return [String, nil]
    #
    def image_url; end

    #
    # @abstract The uid of the OAuth user.
    #
    # @return [String, nil]
    #
    def uid; end

    #
    # @abstract The oauth token of the OAuth user.
    #
    # @return [String, nil]
    #
    def oauth_token; end

    #
    # @abstract The oauth expires of the OAuth user.
    #
    # @return [String, nil]
    #
    def oauth_expires; end

    #
    # @abstract The oauth secret of the OAuth user.
    #
    # @return [String, nil]
    #
    def oauth_secret; end

    private
      def split_name
        name = auth['info']['name']

        if name.include?(' ')
          last_name  = name.split(' ').last
          first_name = name.split(' ')[0...-1].join(' ')
        else
          first_name = name
          last_name  = nil
        end

        [first_name, last_name]
      end

  end
end
