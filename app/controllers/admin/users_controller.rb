class Admin::UsersController < ApplicationController
  before_filter :authorized_admin

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

end
