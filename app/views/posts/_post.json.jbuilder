json.extract! post, :id, :slug, :post_identifier, :title, :published_at, :published, :user_id, :image, :image_description, :body, :created_at, :updated_at
json.url post_url(post, format: :json)
json.image url_for(post.image)
