class CheckInsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @check_in = CheckIn.new
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @check_in.user = current_user
    if @check_in.save
      # create_medium(@check_in)
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

  # def create_medium(check_in)
  #   @tracks = music(check_in)
  #   @videos = video(check_in)
  # end

  def check_in_params
    params.require(:check_in).permit(:score, :details, :photo)
  end

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end


end
