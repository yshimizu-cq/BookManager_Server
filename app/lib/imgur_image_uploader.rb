require 'httpclient'

class ImgurImageUploader
  def self.upload_image(base64)
    http_client = HTTPClient.new
    response = http_client.post(URI.parse(ENV['IMGUR_URL']),
                                { image: base64 },
                                { Authorization: "Client-ID #{ENV['CLIENT_ID']}" })
    result_hash = JSON.load(response.body)
    if result_hash['data']['link'].present?
      return result_hash['data']['link']
    else
      raise "Imgurアップロードに失敗しました"
    end
  end
end
