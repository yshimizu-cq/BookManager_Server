class Book < ApplicationRecord
  before_save :convert_image # コールバック処理
  validates :name, presence: true
  belongs_to :user

  def convert_image
    self.image_url = ImgurImageUploader.upload_image(image_url) if image_url.present?
  end
end
