module JwtAuthenticator
  require 'jwt'

  rsa_private = OpenSSL::PKey::RSA.generate 2048
  rsa_public = rsa_private.public_key

  token = JWT.encode payload, rsa_private, 'RS256'

  puts token

  decoded_token = JWT.decode token, rsa_public, true, { algorithm: 'RS256' }

  puts decoded_token
end
