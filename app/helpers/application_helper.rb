module ApplicationHelper

  def title(page_title, show_title = true)
    @show_title = show_title
    @content_for_title = page_title.to_s
  end

  def show_title?
    @show_title
  end

  def price value
    if value == 0
      'FREE'
    else
      number_with_precision value, precision: 2
    end
  end

end
