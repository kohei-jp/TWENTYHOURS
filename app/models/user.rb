class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :comments

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    username = auth[:info][:username]
    name = auth[:info][:name]
    image_url = auth[:info][:image]
    # description = auth[:info][:description]
    
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.username = username
      user.name = name
      user.image_url = image_url
      # user.description = description
    end
  end


end
