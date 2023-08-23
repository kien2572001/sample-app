class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.validates.name.length.max}
  validates :email, presence: true,
            length: {maximum: Settings.validates.email.length.max},
            format: {with: Settings.validates.email.format}, uniqueness: true

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end
end
