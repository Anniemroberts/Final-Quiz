class BidsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @auctions = @user.auctions_bid_on
  end

  def create
    @auction        = Auction.find params[:auction_id]
    bid_params    = params.require(:bid).permit(:bid)
    @bid_amount = params[:bid][:bid].to_i
    @bid          = Bid.new bid_params
    if @bid_amount > @auction.current_price
      @bid.auction = @auction
      @auction.current_price = @bid_amount
      @bid.user = current_user
      if @bid_amount >= @auction.reserve_price && @bid.save
        @auction.reserve_has_met!
        redirect_to auction_path(params[:auction_id]), notice: 'You have won this auction!'
      elsif @bid.save
        redirect_to auction_path(params[:auction_id]), notice: `Bid Created! #{@bid_amount}`
      else
        flash[:alert] = 'please fix errors'
        render 'auctions/show'
      end
    else
      @bid.destroy
      flash[:alert] = 'Bid must be higher than the current price.'
      render 'auctions/show'
    end
  end

end
