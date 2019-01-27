class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  belongs_to :genre

  validates :title, :summary, :content, :genre_id, presence: {message:'は、必須項目です。'}

  scope :recent, -> (count = 15){ order('created_at desc').limit(count) }
end
