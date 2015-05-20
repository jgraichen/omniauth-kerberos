require 'omniauth'
require 'krb5_auth'
require 'omniauth/multipassword/base'

module OmniAuth
  module Strategies
    class Kerberos
      include OmniAuth::Strategy
      include OmniAuth::MultiPassword::Base

      def initialize(app, *args, &block)
        super
        @krb5 = ::Krb5Auth::Krb5.new
      end

      info do
        { username: username,
          email: username + '@' + @krb5.get_default_realm.downcase }
      end

      def authenticate(username, password)
        @krb5.get_init_creds_password(username, password)
      rescue ::Krb5Auth::Krb5::Exception
        false
      end
    end
  end
end
