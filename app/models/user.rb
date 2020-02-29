class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
<<<<<<< Updated upstream
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


  has_many :tags, through: :tweets
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet
#   8行目は本来、"has_many :tweets, through: :favorites"と記述したいが、4行目と重複するため、favorite_tweetsに名称を変更している。
#   →勝手に変えていいのか。  optionで参照元のモデルを "source: :tweet"としているからOK。 

 # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :following
  # =======================================================================================

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end
=======
         :recoverable, :rememberable, :validatable, :omniauthable
         
  def self.find_for_oauth(auth)
  user = User.where(uid: auth.uid, provider: auth.provider).first

  unless user
    user = User.create(
      uid:      auth.nickname,
      name:     auth.info.name,
      image:    auth.info.image,
      provider: auth.provider,
      email:    User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
  end
  user
end

private

def self.dummy_email(auth)
  "#{auth.uid}-#{auth.provider}@example.com"
end
     


>>>>>>> Stashed changes
end
