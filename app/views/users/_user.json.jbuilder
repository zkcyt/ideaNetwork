json.extract! user, :id, :nickname, :profile, :post_id, :like_id, :created_at, :updated_at
json.url user_url(user, format: :json)
