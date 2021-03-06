class Admin::UsersController < ApplicationController  
  before_action :block_path
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def block_path
    unless current_user.present? 
      flash[:error] = "You must be logged in to access this section"
      redirect_to admin_root_path # halts request cycle
    end
  end
  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :full_name,
      :phone_number,
      :avatar
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
