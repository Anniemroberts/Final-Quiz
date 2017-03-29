class Auction < ApplicationRecord
  include AASM
  validates_presence_of :title
  validates_presence_of :details

  belongs_to :user
  has_many :bids, dependent: :destroy

  has_many :watches, dependent: :destroy
  has_many :watchers, through: :watches, source: :users

  aasm do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    state :draft do
      validates(:title, presence: true, length: { minimum: 3})
      validates(:details, presence: true, length: { minimum: 3})
      validates(:reserve_price, numericality: { greater_than_or_equal_to: 0.1 })
    end

    event :publish do
      transitions from: :draft, to: :published
    end

    event :reserve_has_met do
      transitions from: [:published, :draft], to: :reserve_met
    end

    event :auction_won do
      transitions from: :published, to: :won
    end

    event :cancel do
      transitions from: :published, to: :cancelled
    end

    event :reserve_unmet do
      transitions from: :published, to: :reserve_not_met
    end
  end

  def watched_by?(user)
    watches.exists?(user: user)
  end

  def watch_for(user)
    watches.find_by(user: user)
  end
end
