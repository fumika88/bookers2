class UsersController < ApplicationController
before_action :authenticate_user!,except: [:top]
before_action :baria_user, only: [:edit, :destroy, :update]

  def index
    @user = current_user
    @users = User.all
    @books = Book.all
    @new_book = Book.new
  end

  def show

    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books

  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])

    if @user.update(user_params)
       flash[:notice] = "successfully"
       redirect_to user_path(@user.id)
    else
       render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
     @user = User.find(params[:id])
     if current_user != @user
     redirect_to user_path(current_user)
     end
  end
end
