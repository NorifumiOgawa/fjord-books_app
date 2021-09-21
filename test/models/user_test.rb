# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'ユーザ名もしくはメールアドレスを返す' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end

  test 'フォロー機能' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')
    assert_not me.following?(she)
    assert_not she.followed_by?(me)

    me.follow(she)
    assert me.following?(she)
    assert she.followed_by?(me)

    me.unfollow(she)
    assert_not me.following?(she)
    assert_not she.followed_by?(me)
  end
end
