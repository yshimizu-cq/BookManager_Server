class Book < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  before_save :convert_image # コールバック処理

  def convert_image
    if image_url.present?
      self.image_url = ImgerImageUpload.upload_image(image_url)
    end
  end
end
