class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }       
  validates :name, uniqueness: { case_sensitive: true}
  validates :name, presence: true
  validates :avatar, presence: true
  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png'] }
              

  has_many :posts, dependent: :destroy   
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_one_attached :avatar

  def owner?(user) 
    user == self.user
  end

  def following?(user)
    self.followees.include?(user)
  end

  def self.search(search)
    User.all
  end
end
