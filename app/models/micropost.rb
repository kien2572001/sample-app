class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :content, presence: true,
length: {maximum: Settings.validates.micropost.content.max_length}
  validates :image,
            content_type: {in: Settings.configs.image.accept_type.split(", ").map(&:strip),
                           message: I18n.t("microposts.validate.image_valid_format")},
                              size: {less_than: 5.megabytes,
                                     message: I18n.t("microposts.validate.less_than_5MB")}
  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :user, prefix: true
end
