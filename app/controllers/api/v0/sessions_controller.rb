class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: { error: 'Invalid email or password' }, status: 400
    end
  end
end
