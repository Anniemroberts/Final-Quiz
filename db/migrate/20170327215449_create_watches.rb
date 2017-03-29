class CreateWatches < ActiveRecord::Migration[5.0]
  def change
    create_table :watches do |t|
      t.references :auction, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
