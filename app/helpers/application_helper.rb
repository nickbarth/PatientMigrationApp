module ApplicationHelper
 def is_active?(link_path)
  if current_page?(link_path)
    "nav-link active"
  else
    "nav-link"
  end
 end
end
