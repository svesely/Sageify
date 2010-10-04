module LessonsHelper
  def sorting_controls(sortable, options)
    [higher_control(sortable, options), lower_control(sortable, options)].compact.join
  end
  
  def higher_control(sortable, options)
    button_to("&uarr;".html_safe,  sort_lesson_pages_path(sortable.lesson, :page_id => sortable.id, :direction => "up") , :method => :post, :class => "up_button") unless sortable.first?
  end
  
  def lower_control(sortable, options)
    button_to("&darr;".html_safe,  sort_lesson_pages_path(sortable.lesson, :page_id => sortable.id, :direction => "down") , :method => :post, :class => "down_button") unless sortable.last?
  end
  
  def sortable_list(sortable_array, options)
    sortable_array.inject([]) do |list_item_array, page|
      list_item_array << "<li class=\"sortable\"><div class=\"sorting_controls\">#{sorting_controls(page, options)}</div>#{link_to( h(page.title), lesson_page_path(page.lesson,page))}</li>"
      list_item_array
    end.join
  end
  
  def pages_links(pages)
    if pages.nil?
      link_text = "<p>There are no pages for this lesson</p>"
    else
      link_text = pages.inject([]) do |links, page|
        links << "<li>#{link_to(page.title, lesson_page_path(page.lesson,page))}</li>"
        links
      end.join
    end
  end
end
