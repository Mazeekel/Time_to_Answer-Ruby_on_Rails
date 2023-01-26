class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true ,inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true


  # Scopes
  scope :_search_, ->(page, term){
    includes(:answers)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .page(page)
  }

  scope :_search_subject_, ->(page, subject_id){
    includes(:answers)
    .where(subject_id: subject_id)
    .page(page)
  }

  scope :last_questions, ->(page) {
    includes(:answers).order('created_at desc').page(page)
  }

  
end
