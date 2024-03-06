class ScansController < ApplicationController
  def show
    @scan = Scan.find(params[:id])
  end

  def new
    @scan = Scan.new
  end

  def create
    @scan = Scan.new(scan_params)
    @scan.user = current_user
    @scan.save

    chaptgpt_response = GptApiImageCallService.call(@scan)# background job

    infos = chaptgpt_response["choices"][0]["message"]["content"].split(",").map(&:strip)

    @scan.ai_response = {
      title: infos[0],
      year: infos[1],
      artist_name: infos[2]
    }

    @scan.save

    redirect_to user_vinyls_path(current_user)
  end
end
