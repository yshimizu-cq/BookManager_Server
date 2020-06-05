require 'httpclient'

IMGER_URL = 'https://api.imgur.com/3/upload'
CLIENT_ID = '19aad8d7321ca00'

class ImgerImageUpload
  def self.upload_image(image_url)
    http_client = HTTPClient.new
    response = http_client.
      post(URI.parse(IMGER_URL), { image: image_url }, { Authorization: "Client-ID #{CLIENT_ID}" })
    result_hash = JSON.load(response.body)
    result_hash['data']['link']
  end
end
