class Toy < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [300, nil]
    attachable.variant :display, resize_to_limit: [700, 700]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
                     size:         { less_than: 5.megabytes,
                                     message:   "should be less than 5MB" }
  
  # def images_as_thumbnail
  #   images.map do |image|
  #     image.variant resize_to_limit: [350, 350]
  #   end
  # end

  # def images_as_display
  #   images.map do |image|
  #     image.variant resize_to_limit: [950, 950]
  #   end
  # end
end
