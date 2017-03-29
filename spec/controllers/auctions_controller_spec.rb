require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe '#index' do
    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    it 'renders show' do
      a = FactoryGirl.create(:auction)
      a.save
      get :show, params: { id: a.id }
      expect(response).to render_template(:show)
    end
  end


  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns an auction instance variable' do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe '#create' do
    def valid_request
      post :create, params: { auction: FactoryGirl.attributes_for(:auction) }
    end
    context 'with valid attributes' do
      it 'creates a new auction in the database' do
        count_before = Auction.count
        post :create, params: {auction: FactoryGirl.attributes_for(:auction) }
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to root path' do
        valid_request
        expect(response).to redirect_to(auction_path( Auction.last.id ))
      end
    end
    context 'with invalid attributes' do
      it 'doesn\'t create an auction in the database' do
      count_before = Auction.count
      post :create, params: { auction: { title: ''} }
      count_after = Auction.count
      expect(count_before).to eq(count_after)
      end
      it 'renders the new template' do
        post :create, params: { auction: { title: '' } }
        expect(response).to render_template(:new)
      end
    end
  end


end
