class Question < ApplicationRecord
	#attr_accessible :tag_list,:content
	def user_params
      params.require(:feed_items).permit(:tag_list)
    end
	acts_as_taggable
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true;
  validates :content, presence: true;
end
