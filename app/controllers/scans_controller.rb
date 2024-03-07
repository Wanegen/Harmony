class ScansController < ApplicationController
  def show
    @scan = Scan.find(params[:id])
    @vinyl = Vinyl.new
  end

  def new
    @scan = Scan.new
  end

  def create
    @scan = Scan.new(scan_params)
    @scan.save!

    chaptgpt_response = GptApiImageCallService.call(@scan) # background job

    puts '🎂 -----'
    p chaptgpt_response

    @infos = chaptgpt_response['choices'][0]['message']['content'].split(',').map(&:strip)
    p @infos
    @scan.ai_response = {
      release_title: @infos[0],
      year: @infos[1],
      artist_name: @infos[2]
    }

    @scan.save!

    redirect_to scan_path(@scan)
  end

  private

  def scan_params
    params.require(:scan).permit(:image)
  end
end
