class Assessment < ActiveRecord::Base
  belongs_to :exam
  belongs_to :organization
  has_many :answers
  belongs_to :learner, :class_name => "User", :foreign_key => "learner_id"

  attr_protected :exam_id, :organization_id, :learner_id
  
  def pass?
    unformatted_score >= exam.pass_requirement
  end
  
  def score
    format("%.2f",unformatted_score)
  end
  
  def unformatted_score
    if answers.size > 0
      ( (correct_answers.size / 1.00 ) /( exam.questions.size / 1.00) ) * 100
    else
      0
    end
  end
  
  def pass_or_fail_note
    pass? ? "(Pass)" : "(Fail)"
  end
  
  def display
    "#{score}% on #{exam.name} #{pass_or_fail_note} #{created_at}"
  end
  
  def answer_for_question(question)
    answer = answers.select{|answer|answer.question_id == question.id}
    answer.blank? ? nil : answer.first
  end
  
  def answer_hash
    @answer_hash ||= exam.questions.inject({}) do |temporary_answer_hash, question|
      temporary_answer_hash[question.id] = answer_for_question(question)
      temporary_answer_hash
    end
  end
  
  def question_and_answer_hash
    @question_and_answer_hash ||= exam.questions.inject({}) do |temporary_answer_hash, question|
      temporary_answer_hash[question] = answer_for_question(question)
      temporary_answer_hash
    end
  end
  
  def questions=(answers)
    case answers
    when Hash
      create_answers_from_hash(answers)
    when Array
      create_answers_from_array(answers)
    else
      raise "Inappropriate answer format"
    end
    
  end
  
  private
  
  def create_answers_from_hash(answer_hash)
    self.save!
    answer_hash.each do |answer_array|
      answer = self.answers.new
      answer.question = self.exam.questions.find(answer_array[0])
      answer.value = answer_array[1]
      answer.save!
    end
    answers
  end
  
  def create_answers_from_array(answer_array)
    self.save!
    self.exam.questions.each_with_index do |question, index|
      answer = self.answers.new
      answer.question = question
      answer.value = answer_array[index]
      answer.save!
    end
    answers
  end
  
  def correct_answers
    self.answers.select { |answer| answer.correct? }
  end
  
  def incorrect_answers
    self.answers.select { |answer| !answer.correct? }
  end
end
