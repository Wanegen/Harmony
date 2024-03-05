class GptApiImageCallService < ApplicationService
  def initialize
  end

  def call
    client = OpenAI::Client.new(access_token: "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")
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
                url: "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
              },
            },
          ] },
        ],
      },
    )
    return chaptgpt_response["choices"][0]["message"]["content"]
  end
end
