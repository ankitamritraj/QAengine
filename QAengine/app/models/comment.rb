class Comment < ApplicationRecord
  belongs_to :question
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # validates :user_id, presence: true;
  # validates :question_id, presence: true;
  # validates :content, presence: true;
end
