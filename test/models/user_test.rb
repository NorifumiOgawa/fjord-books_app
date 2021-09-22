# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_alice = users(:alice)
    @user_bob = users(:bob)
  end

  test 'ユーザ名もしくはメールアドレスを返す' do
    assert_equal 'alice@example.com', @user_alice.name_or_email

    @user_alice.name = 'Alice Cooper'
    assert_equal 'Alice Cooper', @user_alice.name_or_email
  end

  test 'フォロー関連メソッド' do
    assert_not @user_alice.following?(@user_bob)
    assert_not @user_bob.followed_by?(@user_alice)

    @user_alice.follow(@user_bob)
    assert @user_alice.following?(@user_bob)
    assert @user_bob.followed_by?(@user_alice)

    @user_alice.unfollow(@user_bob)
    assert_not @user_alice.following?(@user_bob)
    assert_not @user_bob.followed_by?(@user_alice)
  end
end
