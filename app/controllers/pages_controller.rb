class PagesController < ApplicationController
  def home
    @response = GptApiImageCallService.call
  end
end
