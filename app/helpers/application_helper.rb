module ApplicationHelper
  def has_next_page_link?(response_body)
    response_body["pagination"]["next_url"] ? true : false
  end
end
