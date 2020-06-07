require 'httpclient'

class ImgerImageUpload
  def self.upload_image(image_url)
    http_client = HTTPClient.new
    response = http_client.
      post(URI.parse(ENV['IMGER_URL']), { image: image_url }, { Authorization: "Client-ID #{ENV['CLIENT_ID']}" })
    result_hash = JSON.load(response.body)
    result_hash['data']['link']
  end
end
