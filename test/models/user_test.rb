# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_alice = create(:alice)
    @user_bob = create(:bob)
  end

  test 'ユーザ名もしくはメールアドレスを返す' do
    assert_equal 'alice@example.com', @user_alice.name_or_email

    @user_alice.name = 'Alice Cooper'
    assert_equal 'Alice Cooper', @user_alice.name_or_email
  end

  test 'following? / フォローしているか否かを返す' do
    assert_not @user_alice.following?(@user_bob)
    Relationship.create!(following_id: @user_bob.id, follower_id: @user_alice.id)
    assert @user_alice.following?(@user_bob)
  end

  test 'followed_by? / フォローされているか否かを返す' do
    assert_not @user_alice.followed_by?(@user_bob)
    Relationship.create!(following_id: @user_alice.id, follower_id: @user_bob.id)
    assert @user_alice.followed_by?(@user_bob)
  end

  test 'follow / フォローする' do
    assert_not Relationship.where(following_id: @user_bob.id, follower_id: @user_alice.id).exists?
    @user_alice.follow(@user_bob)
    assert Relationship.where(following_id: @user_bob.id, follower_id: @user_alice.id).exists?
  end

  test 'unfollow / アンフォローする' do
    Relationship.create!(following_id: @user_bob.id, follower_id: @user_alice.id)
    assert Relationship.where(following_id: @user_bob.id, follower_id: @user_alice.id).exists?
    @user_alice.unfollow(@user_bob)
    assert_not Relationship.where(following_id: @user_bob.id, follower_id: @user_alice.id).exists?
  end
end
