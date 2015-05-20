require 'spec_helper'
require 'rack/test'

describe OmniAuth::Strategies::Kerberos do
  include Rack::Test::Methods

  before do
    fake = double 'krb5'
    allow(::Krb5Auth::Krb5).to receive(:new).and_return fake

    allow(fake).to receive(:get_default_realm).and_return 'example.org'

    allow(fake).to receive(:get_init_creds_password) do |username, password|
      if username == 'john' && password == 'secret'
        true
      else
        fail ::Krb5Auth::Krb5::Exception
      end
    end
  end

  let(:app) do
    Rack::Builder.new do
      use OmniAuth::Test::PhonySession
      use OmniAuth::Strategies::Kerberos
      run ->(env) { [404, {}, [env['omniauth.auth']['uid'].to_s]] }
    end.to_app
  end

  it 'shows login FORM' do
    get '/auth/kerberos'
    expect(last_response.body).to include '<form'
  end

  it 'redirect on wrong password' do
    post '/auth/kerberos/callback', username: 'paul', password: 'wrong'
    expect(last_response).to be_redirect
    expect(last_response.headers['Location']).to eq \
      '/auth/failure?message=invalid_credentials&strategy=kerberos'
  end

  it 'authenticates with password' do
    post '/auth/kerberos/callback', username: 'john', password: 'secret'
    expect(last_response.body).to eq 'john'
  end
end
