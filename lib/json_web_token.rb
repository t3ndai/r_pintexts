require 'jwt'

class JsonWebToken
    Secret_Key = Rails.application.secrets.secret_key_base.to_s 

    def encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i 
        JWT.encode(payload, Secret_Key)
    end 

    def decode(token)
        decoded = JWT.decode(token, Secret_Key).first
        HashWithIndifferentAccess.new decoded 
    end 

end 