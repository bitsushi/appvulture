class MacsController < AppsController

  # def index
  #   if current_user
  #     @apps = Mac.text_search(params[:query])
  #     .select("apps.*, CASE WHEN users.id = '#{current_user.id}' THEN 'true' ELSE 'false' END AS is_watched")
  #     .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
  #     .page params[:page]
  #   else
  #     @apps = Mac.text_search(params[:query])
  #     .select("apps.*, CASE WHEN users.id IS NOT NULL THEN 'false' ELSE 'false' END AS is_watched")
  #     .joins('LEFT OUTER JOIN "lenses" ON "lenses"."app_id" = "apps"."id" LEFT OUTER JOIN "users" ON "users"."id" = "lenses"."watcher_id"')
  #     .page params[:page]
  #   end
  # end

end
