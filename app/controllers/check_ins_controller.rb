class CheckInsController < ApplicationController
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
end
