class AddCurrentPriceToAuction < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :current_price, :integer
  end
end
