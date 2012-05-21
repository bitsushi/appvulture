class AppsController < ApplicationController

  def index
    @q = controller_name.classify.constantize.search(params[:q])
    if current_user
      @apps = @q.result(:distinct => true)
      # @apps = .text_search(params[:query])
      # .select("apps.*, CASE WHEN users.id = '#{current_user.id}' THEN 'true' ELSE 'false' END AS is_watched")
      # .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
      # .page params[:page]
    else
      @apps = @q.result(:distinct => true)
      # @apps = controller_name.classify.constantize.text_search(params[:query])
      # .select("apps.*, CASE WHEN users.id IS NOT NULL THEN 'false' ELSE 'false' END AS is_watched")
      # .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
      # .page params[:page]
    end
  end

  def show
    @app = App.find(params[:id])
    if current_user and current_user.watching?(@app)
      @lens = current_user.lens_for(@app)
    end
  end

end
