class CheckIn < ApplicationRecord
  belongs_to :user
  has_many :media, dependent: :destroy
  has_one_attached :photo
  before_save :set_details_content
  before_save :set_video_content
  before_save :set_music_content
  # before_save unless: video_content.blank? do
  #   video
  # end
  # before_save unless: music_content.blank? do
  #   video
  # end

  def set_music_content
    client = OpenAI::Client.new
    chaptgpt_music_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "take the mental health score #{score} out of 10, and the input #{details}, and generate key words for a spotify music search, limit to 4 words, just reply with the keywords without absolutely no addition comments. Do not include the word 'keywords'"}]
    })
    self.music_content = chaptgpt_music_response["choices"][0]["message"]["content"]
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
      messages: [{ role: "user", content: "take the mental health score #{score} out of 10, and the input #{details}, and generate 4 key words for a youtube video search for upbeat yoga or meditation and other activities and videos with corresponding energy, just reply with the keywords, separated with an plus sign"}]
    })
    self.video_content = chaptgpt_video_response["choices"][0]["message"]["content"]
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
      messages: [{ role: "user", content: "take this input #{details}, and the mental health score of #{score} out of 10, and present it telling me how i feel and giving a positive outlook on, or helpfull steps towards solving it, only provide the requested response, limit response to a maximum count of 300 characters"}]
    })
    self.details_content = chaptgpt_details_response["choices"][0]["message"]["content"]
  end

  def video
    p self.video_content
    response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?key=#{ENV["YOUTUBE_API_KEY"]}&q=#{self.video_content}&part=snippet&maxResults=10&type=video")
    unless response["error"]
      response["items"].map do |video|
        Medium.create!(check_in: self, video_id: video["id"]["videoId"], media_type: "video")
        # video["id"]["videoId"]
      end
    end
  end

  def music
    # lowest_mood = anxiety relief, calming, music for low mood.
    # low_mood = chill meditation, chill music, meditation music, chill music for low mood.
    # medium_mood = acoustic chill, acoustic, uplifting chilled music, daily meditation.
    # higher_mood = feel good chilled, upbeat acoustic, feel good lo-fi.
    # best_mood = happy music, chilled happy, party music.
    RSpotify.authenticate(ENV.fetch("SPOTIFY_ID"), ENV.fetch("SPOTIFY_SECRET"))
    # set_check_in
    # if @check_in.score >= 1 && @check_in.score <= 3
    if (1..2).include?(self.score)
      tracks = RSpotify::Track.search(self.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.3
      end
    elsif (3..5).include?(self.score)
      tracks = RSpotify::Track.search(self.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.5
      end
    elsif (6..7).include?(self.score)
      tracks = RSpotify::Track.search(self.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.7
      end
    elsif (8..10).include?(self.score)
      tracks = RSpotify::Track.search(self.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.8
      end
    end
    results.map do |track|
      Medium.create!(check_in: self, music_id: track.id, media_type: "music")
    end
  end
end
