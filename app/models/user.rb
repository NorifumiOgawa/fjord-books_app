# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :icon # icon

  validate :icon_type

  def icon_type
    return unless icon.attached? && !icon.content_type.in?(%('image/jpeg image/png image/gif'))

    errors.add(:icon, 'にはjpeg, pngまたはgifファイルを添付してください')
  end
end
