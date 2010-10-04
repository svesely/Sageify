module LearnHelper
  def lesson_user_history(lesson, user)
    tag_array = []
    tag_array << '(Assigned)' if user.is_assigned?(lesson)
    tag_array << '(Completed)' if user.has_completed?(lesson)
    tag_array.join(' ')
  end
  
  def link_if_first_page_exists(lesson)
    if lesson.pages.size > 0
      link_to lesson.name, learn_url(lesson.first_page.id)
    else
      "#{lesson.name} (No pages yet)"
    end
  end
  
  def exam_link(exam)
    link_to("Take #{exam.name}", assessment_url(exam))
  end
  
  def exam_links(lesson)
    lesson.exams.collect{|exam|"<li>#{ exam_link(exam)}</li>"}
  end
  
  def exam_link_list(page)
    if current_user.has_completed?(page.lesson)
      "<ul>#{exam_links(page.lesson).join(" \n")}</ul>"
    else
      ""
    end
  end
end
