class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_reference :auctions, :user, foreign_key: true, index: true
    add_reference :bids, :user, foreign_key: true, index: true
  end
end
