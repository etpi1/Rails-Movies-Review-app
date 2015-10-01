class Admin::UsersController < ApplicationController
  before_filter :authorized_admin

  def index
    # @users = User.all
    @users = User.page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end
end
