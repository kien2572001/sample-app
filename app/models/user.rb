class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
length: {maximum: Settings.validates.name.length.maximum}
  validates :email, presence: true,
length: {maximum: Settings.validates.email.length.maximum},
format: {with: Settings.validates.email.format}, uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
