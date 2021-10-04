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
    @user_alice.active_relationships.create(following: @user_bob)
    assert @user_alice.following?(@user_bob)
  end

  test 'followed_by? / フォローされているか否かを返す' do
    assert_not @user_alice.followed_by?(@user_bob)
    @user_bob.active_relationships.create(following: @user_alice)
    assert @user_alice.followed_by?(@user_bob)
  end

  test 'follow / フォローする' do
    assert_not @user_alice.active_relationships.where(following: @user_bob).exists?
    @user_alice.follow(@user_bob)
    assert @user_alice.active_relationships.where(following: @user_bob).exists?
  end

  test 'unfollow / アンフォローする' do
    @user_alice.active_relationships.create(following: @user_bob)
    assert @user_alice.active_relationships.where(following: @user_bob).exists?
    @user_alice.unfollow(@user_bob)
    assert_not @user_alice.active_relationships.where(following: @user_bob).exists?
  end
end
