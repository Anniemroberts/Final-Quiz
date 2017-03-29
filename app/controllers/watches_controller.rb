class WatchesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_watch, only: [:destroy]
    before_action :find_auction, only: [:create]

    def index
      @user = User.find(params[:user_id])
      @auctions = @user.watched_auctions
    end

    def create
      if cannot? :watch, @auction
        redirect_to auction_path(@auction), alert: 'Watching your own auction isn\'t allowed'
        return
      end

      watch = Watch.new(user: current_user, auction: @auction)

      if watch.save
        redirect_to auction_path(@auction)
      else
        redirect_to auction_path(@auction), alert: 'Couldn\'t watch auction! 💔'
      end
    end

    def destroy
      redirect_to(
        auction_path(@watch.auction),
        @watch.destroy ? {notice: 'Auction un-watched! 💔'} : {alert: @watch.errors.full_messages.join(', ')}
      )
    end

    private

    def find_watch
      @watch ||= Watch.find(params[:id])
    end

    def find_auction
      @auction ||= Auction.find(params[:auction_id])
    end

  end
