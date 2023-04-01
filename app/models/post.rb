class Post < ApplicationRecord
    belongs_to :user
    has_many :comments 
    has_many :likes, dependent: :destroy
    has_one_attached :image

    validates :image, presence: true
    validates :title, presence: true, length: { minimum: 2, maximum: 255 }
    validates :body, presence: true, length: { minimum: 2 }
    validates :image, file_size: { less_than_or_equal_to: 2.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png'] }

    def image_size_validation
            errors[:image] << "should be less than 5MB" if image.size > 2.megabytes 
    end
end
