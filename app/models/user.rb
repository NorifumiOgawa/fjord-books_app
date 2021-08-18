# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :icon # icon

  validate :verify_icon_type

  def verify_icon_type
    return unless icon.attached?

    allowed_file_types = %w[image/jpg image/jpeg image/gif image/png]
    errors.add(:icon, :icon_type) unless allowed_file_types.include?(icon.blob.content_type)
  end
end
