class CheckInsController < ApplicationController
  # require 'rspotify'

  skip_before_action :authenticate_user!

  def new
    @check_in = CheckIn.new
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @check_in.user = current_user
    if @check_in.save
      redirect_to check_in_path(@check_in)
    else
      render :new
    end
  end

  def show
    set_check_in
    @tracks = music
  end


  def index
    @check_ins = CheckIn.where("created_at >= ?", 7.days.ago)
  end

  private

  def check_in_params
    params.require(:check_in).permit(:score, :details, :photo)
  end

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end

  def music
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    set_check_in
    if @check_in.score >= 1 && @check_in.score <= 3
      tracks = RSpotify::Track.search("anxiety relief")
      results = tracks.select do |track|
        audio_features = track.audio_features
        audio_features.valence >= 0.007 && audio_features.energy <= 0.3
      end
    end
    results.map(&:id)
  end
end

