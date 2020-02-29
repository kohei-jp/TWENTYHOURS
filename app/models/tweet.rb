class Tweet < ApplicationRecord
  validates:time, presence: true
  validates:text, length: { maximum: 10 }
  belongs_to :user
  has_many :comments
  belongs_to :tag
  accepts_nested_attributes_for :tag
  has_many :favorites

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
