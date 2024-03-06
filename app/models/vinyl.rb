class Vinyl < ApplicationRecord
  belongs_to :user
  validates :title, :artist_name, :year, presence: true
  has_one_attached :cover
end
