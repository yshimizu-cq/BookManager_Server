require "jwt"

module JwtAuthenticatable
  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  # ヘッダーの認証トークンを復号化してユーザー認証を行う
  def jwt_authenticate
    raise Error, "認証情報が不足しています。" if request.headers['Authorization'].blank?
    # "Bearer XXXX"でヘッダーに設定されているためXXXXを抽出
    encoded_token = request.headers['Authorization'].split('Bearer ').last
    payload = decode(encoded_token)
    @current_user = User.find_by(id: payload["user_id"])
    raise Error, "認証できません。" if @current_user.blank?
  end

  # 暗号化処理
  def encode(user_id)
    payload = { user_id: user_id, exp: 1.month.from_now.to_i } # 期限を1ヶ月に設定
    JWT.encode(payload, SECRET_KEY_BASE, 'HS256')
  end

  # 復号化処理
  def decode(encoded_token)
    JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256').first # 配列1つ目要素のpayloadを返却
  end
end
