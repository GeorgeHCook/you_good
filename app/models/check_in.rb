class CheckIn < ApplicationRecord
  belongs_to :user
  has_many :media, dependent: :destroy
  has_one_attached :photo
  before_save :set_details_content

  def set_music_content
    client = OpenAI::Client.new
    chaptgpt_music_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "take the mental health score #{score} out of 10, and the input #{details}, and generate key words for a spotify music search, limit to 4 words, just reply with the keywords"}]
    })
    return chaptgpt_music_response["choices"][0]["message"]["content"]
  end

  def music_content
    if super.blank?
      set_music_content
    else
      super
    end
  end

  def set_video_content
    client = OpenAI::Client.new
    chaptgpt_video_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "take the mental health score #{score} out of 10, and the input #{details}, and generate key words for a youtube video search for upbeat yoga or meditation and other activities and videos with corresponding energy, just reply with the keywords, separated with an plus sign"}]
    })
    return chaptgpt_video_response["choices"][0]["message"]["content"]
  end

  def video_content
    if super.blank?
      set_video_content
    else
      super
    end
  end

  def set_details_content
    client = OpenAI::Client.new
    chaptgpt_details_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "take this input #{details}, and the mental health score of #{score} out of 10, and present it telling me how i feel and giving a positive outlook on, or helpfull steps towards solving it, only provide the requested response"}]
    })
    self.details_content = chaptgpt_details_response["choices"][0]["message"]["content"]
  end

  # def details_content
  #   if super.blank?
  #     set_details_content
  #   else
  #     super
  #   end
  # end
end
