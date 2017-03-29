class User < ApplicationRecord
  has_secure_password

  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :auctions_bid_on, through: :bids, source: :auction

  has_many :watches, dependent: :destroy
  has_many :watched_auctions, through: :watches, source: :auction

  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

  private

  def downcase_email
    self.email&.downcase!
  end

end
