# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def previous_control(page)
     link_to('Previous', {:action => :show, :id => page.higher_item.id}) unless page.first?
   end

   def next_control(page)
     page.last? ? "<span class=\"last_page\">(This is the last page)</span>" : link_to('Next', {:action => :show, :id => page.lower_item.id}) 
   end

   def page_controls_for_page(page)
     [previous_control(page), next_control(page)].compact.join('|')
   end
   
   def html_title(page_title)
       content_for(:html_title) { " - #{page_title}" || "" }
   end
   
   def whitelisted_tags
     %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p)
   end
   
   def safe_textile(raw_text)
     sanitize(RedCloth.new(raw_text).to_html, :tags => whitelisted_tags, :attributes => %w(href title))
   end
   
end
