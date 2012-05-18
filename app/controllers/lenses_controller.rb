class LensesController < ApplicationController

  before_filter :authorize

  def new
    if i = params[:app_id]
      @lens = current_user.lenses.build(app: App.find(i.to_i))
    else
      @lens = current_user.lenses.build
    end
  end

  def index
    @lenses = current_user.lenses
  end

  def create
    @lens = current_user.lenses.build(params[:lens])
    if @lens.save
      redirect_to app_url(@lens.app), notice: 'created lens'
    else
      render action: "new"
    end
  end

  def destroy
    @lens = current_user.lenses.find(params[:id])
    @lens.destroy
    respond_to do |format|
      format.html { redirect_to params[:return_to] || lenses_url, notice: "Deleted Lens" }
      # format.json { head :no_content }
    end
  end

end
