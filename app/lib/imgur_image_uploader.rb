require 'httpclient'

class ImgurImageUploader
  def self.upload_image(base64)
    http_client = HTTPClient.new
    response = http_client.post(URI.parse(ENV['IMGUR_URL']),
                                { image: base64 },
                                { Authorization: "Client-ID #{ENV['CLIENT_ID']}" })
    result_hash = JSON.load(response.body)
    raise "Imgurアップロードに失敗しました" if result_hash['data']['link'].blank?
    result_hash['data']['link']
  end
end
