class Vinyl < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
  against: [:title, :artist_name],
  using: {
    tsearch: { prefix: true }
  }
  belongs_to :user
  validates :title, :artist_name, :year, presence: true
  has_one_attached :cover
end
