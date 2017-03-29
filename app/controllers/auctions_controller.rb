class AuctionsController < ApplicationController

  before_action(:find_auction, { only: [:show, :edit, :destroy] })
  before_action(:find_for_publish, { only: :publish })

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    @auction.current_price = 0
    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def show
    @user = :current_user
    @bid = Bid.new
  end

  def index
    #@auctions = Auction.published.order("created_at DESC")
    @auctions = Auction.order(created_at: :desc)
  end

  def destroy
    if @auction.user == current_user
      @auction.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def publish
    if @auction.publish!
      redirect_to auctions_path, notice: "Auction published successfully."
    else
      redirect_to auctions_path, alter: "Auction publishing failed: #{@auction.errors.full_messages}"
    end
  end


  private

  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on, :reserve_price])
  end

  def find_auction
    @auction = Auction.find params[:id]
  end

  def find_for_publish
    @auction = Auction.find params[:auction_id]
  end
end
