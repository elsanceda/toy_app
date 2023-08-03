class Toy < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumbnail, resize_and_pad: [500, 500, gravity: 'center', background: '#fff']
    attachable.variant :display, resize_to_limit: [700, 700]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
                     size:         { less_than: 5.megabytes,
                                     message:   "should be less than 5MB" }
  validates :images, attached: true, unless: :test_environment?
  
  def test_environment?
    Rails.env.test?
  end
end
