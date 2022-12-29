class Post < ApplicationRecord
  has_one_attached :image
  validates_presence_of :title, :slug, :post_identifier, :user_id
  validates_uniqueness_of :slug, :post_identifier
  paginates_per 6
end
