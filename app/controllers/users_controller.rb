# frozen_string_literal: true

# controller of users
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    authorize! @user
  end

  def edit
    authorize! @user
  end

  def update
    authorize! @user

    role_id = user_params[:role].to_i
    update_params = { role: role_id }

    if @user.update(update_params)
      flash[:success] = 'User updated successfully!'
      redirect_to user_path(@user)
    else
      flash[:danger] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def set_user
    @user ||= ::User.find(params[:id])
  end

  def user_params
    params.require(:user)
  end
end
