module ApplicationHelper
  def increase_user index, users
    index + (users.current_page - Settings.each_user)*
      Settings.users_paginates + Settings.each_user
  end

  def full_title page_title = ""
    base_title = t "title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def increase_index objects, index
    index + (objects.current_page - Settings.each_index) *
      Settings.pagination.size + Settings.each_index
  end

  def paginate objects, options = {}
    options.reverse_merge! theme: "twitter-bootstrap-3"
    super objects, options
  end

  def show_number_of_staffs department_id, users_size
    if users_size[department_id].nil?
      Settings.default_staff_number
    else
      users_size[department_id]
    end
  end

  def staff_with_position position_user_id
    User.find_by id: [position_user_id]
  end
end
