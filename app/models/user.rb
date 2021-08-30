# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower
  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy,
           inverse_of: :followed
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationship = active_relationships.create(followed_id: other_user.id)
    active_relationship.id ? true : false
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    active_relationships.exists?(followed_id: other_user.id)
  end

  def name_or_email
    name.presence || email
  end
end
