class GptApiImageCallService < ApplicationService
  def initialize(scan)
    @scan = scan
  end

  def call
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
    chaptgpt_response = client.chat(
      parameters: {
        model: 'gpt-4-vision-preview',
        messages: [
          { role: 'user',
            content: [
              {
                type: 'text', text: 'This is an album cover. Give me the name,
                date and artist with this format: name, date, artist.'
              },
              {
                type: 'image_url',
                image_url: {
                  url: @scan.image.url
                }
              }
            ]
          }
        ]
      }
    )
    return chaptgpt_response
  end
end
