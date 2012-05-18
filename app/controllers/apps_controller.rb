class AppsController < ApplicationController

  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
    if current_user and current_user.watching?(@app)
      @lens = current_user.lens_for(@app)
    end
  end

end
