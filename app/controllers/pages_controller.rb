class PagesController < ApplicationController
  def home
    @scan = Scan.new
  end
end
