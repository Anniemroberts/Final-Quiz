class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user

  #validates(:bid, numericality: { greater_than_or_equal_to: 0.1 })
  validates(:bid, numericality: { greater_than_or_equal_to: 0.1 })
end
