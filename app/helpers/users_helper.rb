module UsersHelper
  def edit_link_if_editable(user)
    link_to "(Edit)", edit_user_url(user) if user.is_editable_by_user?(current_user)
  end

end
