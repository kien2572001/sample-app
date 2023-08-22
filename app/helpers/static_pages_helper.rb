module StaticPagesHelper
  def full_title page_title = ""
    base_title = t "static_pages.base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
