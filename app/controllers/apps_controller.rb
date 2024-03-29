class AppsController < ApplicationController

  def index
    if current_user
      @apps = controller_name.classify.constantize.text_search(params[:query])
      .select("apps.*, CASE WHEN users.id = '#{current_user.id}' THEN 'true' ELSE 'false' END AS is_watched")
      .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
      .page params[:page]
    else
      @apps = controller_name.classify.constantize.text_search(params[:query])
      .select("apps.*, CASE WHEN users.id IS NOT NULL THEN 'false' ELSE 'false' END AS is_watched")
      .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
      .page params[:page]
    end
  end

  def show
    @app = App.find(params[:id])
    # Rails.logger.info "____"
    # Rails.logger.info request.url
    # Rails.logger.info url_for(@app)
    if request.url != url_for(@app)
      redirect_to @app
    end
    if current_user and current_user.watching?(@app)
      @lens = current_user.lens_for(@app)
    end
  end

end
