class DiscogsApi < ApplicationService
  def initialize
    @auth_wrapper = Discogs::Wrapper.new("Harmony", user_token: "NLeTHnrtngSWvBiEKbkdrXJEHJooNjhcfqdJecDg")
  end

  def get_artist(artist_id)
   response = @auth_wrapper.get_artist(artist_id)
  end

  def get_master(master_id)
    response = @auth_wrapper.get_master(master_id).title

    # vinyl_attributes = {
    #   title: response.title,
    #   artist_name: response.artists[0].name,
    #   year: response.year,
    # }
  end
end
