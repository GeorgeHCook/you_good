class CheckInsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @check_in = CheckIn.new
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @check_in.user = current_user
    if @check_in.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def check_in_params
    params.require(:check_in).permit(:score, :details)
  end
end
