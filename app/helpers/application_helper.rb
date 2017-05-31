module ApplicationHelper
  def app_owner?
    user_signed_in? && @app.user_id == current_user.id
  end
  
  def event_owner?
    user_signed_in? && @event.app.user_id == current_user.id
  end
  
  def admin?
    user_signed_in? && current_user.admin?
  end
end
