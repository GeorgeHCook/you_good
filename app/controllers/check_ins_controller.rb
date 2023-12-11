class CheckInsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @check_in = CheckIn.new
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @check_in.user = current_user
    if @check_in.save
      create_medium(@check_in)
      redirect_to check_in_path(@check_in)
    else
      render :new
    end
  end

  def show
    set_check_in
    @videos = @check_in.media.where(media_type: "video")
    @tracks = @check_in.media.where(media_type: "music")
  end

  def index
    @check_ins = CheckIn.where("created_at >= ?", 7.days.ago).where(user: current_user)
    # @chart = line_chart CheckIn.group_by_day_of_week(:created_at, range: 1.week.ago..Time.now, format: "%a").score
    @grouped_check_ins = @check_ins.group_by { |check_in| Date.new(check_in.created_at.year, check_in.created_at.month, check_in.created_at.day) }
    @grouped_check_ins = @grouped_check_ins.map do |key, value|
      average_score = value.sum(&:score) / value.count
      [key, average_score]
    end.to_h
  end

  private

  def create_medium(check_in)
    @tracks = music(check_in)
    @videos = video(check_in)
  end

  def check_in_params
    params.require(:check_in).permit(:score, :details, :photo)
  end

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end

  def video(check_in)
    # set_check_in
    # if @check_in.score >= 1 && @check_in.score <= 3
    #   search_input = "meditation+anxiety+relief"
    # elsif @check_in.score >= 4 && @check_in.score <= 6
    #   search_input = "chill+meditation+yoga"
    # elsif @check_in.score >= 7 && @check_in.score <= 8
    #   search_input = "feel+good+yoga"
    # elsif @check_in.score >= 9 && @check_in.score <= 10
    #   search_input = "happy+yoga+upbeat+music"
    # end
    response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?key=#{ENV["YOUTUBE_API_KEY"]}&q=#{check_in.video_content}&part=snippet&maxResults=10&type=video")
    response["items"].map do |video|
      Medium.create!(check_in: check_in, video_id: video["id"]["videoId"], media_type: "video")
      # video["id"]["videoId"]
    end
  end

  def music(check_in)
    # lowest_mood = anxiety relief, calming, music for low mood.
    # low_mood = chill meditation, chill music, meditation music, chill music for low mood.
    # medium_mood = acoustic chill, acoustic, uplifting chilled music, daily meditation.
    # higher_mood = feel good chilled, upbeat acoustic, feel good lo-fi.
    # best_mood = happy music, chilled happy, party music.
    RSpotify.authenticate(ENV.fetch("SPOTIFY_ID"), ENV.fetch("SPOTIFY_SECRET"))
    # set_check_in
    # if @check_in.score >= 1 && @check_in.score <= 3
    if (1..2).include?(check_in.score)
      tracks = RSpotify::Track.search(check_in.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.3
      end
    elsif (3..5).include?(check_in.score)
      tracks = RSpotify::Track.search(check_in.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.5
      end
    elsif (6..7).include?(check_in.score)
      tracks = RSpotify::Track.search(check_in.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.7
      end
    elsif (8..10).include?(check_in.score)
      tracks = RSpotify::Track.search(check_in.music_content)
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.8
      end
    end
    results.map do |track|
      Medium.create!(check_in: check_in, music_id: track.id, media_type: "music")
    end
  end
end
