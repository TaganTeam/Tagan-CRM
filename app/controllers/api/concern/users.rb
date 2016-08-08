module API
  module Concern::Users
    extend ActiveSupport::Concern
    included do

      segment :users do
        desc "Return Users data."
        params do
          optional :access_token, type: String, desc: 'User access token'
        end

        get '/users' do
          users = User.all
          success!(users.as_api_response(:basic), status)
        end

        desc "Return an user data"
        params do
          optional :access_token, type: String, desc: 'User access token'
        end
        get '/:id' do
          begin
            user = User.find_by_id params[:id]
            success! user.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end

        desc "update exist user"
        params do
          optional :access_token, type: String, desc: 'User access token'
          optional :email, type: String, desc: 'User email'
          optional :role, type: Integer, desc: 'User role'
          optional :status, type: Integer, desc: '0-> offline, 1->online, 2->away'
        end
        put ':id' do
          begin
            user = User.find_by_id params[:id]
            user_params = ActionController::Parameters.new(params).permit(:email, :role, :status, :first_name, :last_name)
            user.update_attributes(user_params)
            success! user.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end

        desc "delete exist user"
        params do
          optional :access_token, type: String, desc: 'User access token'
        end
        delete ':id' do
          begin
            user = User.find_by_id params[:id]
            technologies = Technology.find_by_user_id(params[:id])
            technologies.delete
            user.destroy

            success! user.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end
      end
    end
  end
end
