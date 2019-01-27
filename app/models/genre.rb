class Genre < ApplicationRecord
  has_many :posts

  validates :name, presence: {message: 'は必須項目です。'}
end
