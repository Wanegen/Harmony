class GptApiImageCallService < ApplicationService
  def initialize(vinyl)
    @vinyl = vinyl
  end

  def call
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    chaptgpt_response = client.chat(
      parameters: {
        model: "gpt-4-vision-preview",
        messages: [
          { role: "user",
           content: [
            {
              type: "text", text: "Give me the name year band of this album with this format: name, year, band",
            },
            {
              type: "image_url",
              image_url: {
                url: @vinyl.image.url,
              },
            },
          ] },
        ],
      },
    )
    return chaptgpt_response["choices"][0]["message"]["content"]
  end
end
