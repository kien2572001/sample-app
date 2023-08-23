class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.validates.name.length.max}
  validates :email, presence: true,
            length: {maximum: Settings.validates.email.length.max},
            format: {with: Settings.validates.email.format}, uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
