require 'rails_helper'


RSpec.describe BidsController, type: :controller do
  def user
    @user ||= FactoryGirl.create(:user)
  end
  def auction
    @auction ||= FactoryGirl.create(:auction)
  end

  describe '#create' do
    before do
      request.session[:user_id] = user.id
      @id = auction.id
    end
    def valid_request
      post :create, params: { bid: FactoryGirl.attributes_for(:bid), auction_id: @id }
    end
    context 'with valid attributes' do
      it 'creates a new bid in the database' do
        count_before = Bid.count
        valid_request
        count_after = Bid.count
        expect(count_after).to eq(count_before + 1)
      end
    end
    context 'with invalid attributes' do
      it 'doesn\'t create an bid in the database' do
      count_before = Bid.count
      post :create, params: { bid: { bid: 'aaa'}, auction_id:  @id }
      count_after = Bid.count
      expect(count_before).to eq(count_after)
      end
    end
  end

end
