class Scan < ApplicationRecord
  has_one_attached :image

  def release_title
    return unless ai_response

    ai_response['release_title']
  end

  def artist_name
    return unless ai_response

    ai_response['artist_name']
  end

  def year
    return unless ai_response

    ai_response['year']
  end
end
