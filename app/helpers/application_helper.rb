module ApplicationHelper
  # Set the html title from controller
  def title(page_title)
    base_title = "ODH"
    if page_title.nil?
      base_title
    else
      @title || base_title
    end
  end
end
