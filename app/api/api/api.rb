require 'grape-swagger'
module Api
	class Api < Grape::API
		format :json
		version 'v1'
		prefix :api

		rescue_from ActiveRecord::RecordNotFound do |e|
			error!(e,500)
		end
		#rescue_from :all

    helpers do 
      def token
        headers["Access-Token"]
      end
      def api_key
        ApiKey.find_by(access_token: token ) 
      end
      def authenticate!
        error!("Token Invalid", 400) unless token.present?
        error!("Unauthorize", 401) unless api_key
        @current_user ||= api_key.user
      end
      def current_user
        @current_user
      end
    end
    
    mount V1::AuthApi
   
		before do
      #authenticate!
    end

    
    mount V1::PostApi
    mount V1::LogoutApi 
    mount V1::ImageApi
    mount V1::TypeHouseApi
    mount V1::DetailApi
  
   

    add_swagger_documentation
	end
end