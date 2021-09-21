# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '編集可能チェック' do
    user_foo = User.create!(email: 'foo@example.com', password: 'password')
    report = Report.create!(user_id: user_foo.id, title: 'foo', content: 'report content')
    assert report.editable?(user_foo)

    user_bar = User.create!(email: 'bar@example.com', password: 'password')
    assert_not report.editable?(user_bar)
  end

  test '作成日を日付型に変換' do
    user = User.create!(email: 'foo@example.com', password: 'password')
    report = Report.create!(user_id: user.id, title: 'foo', content: 'report content')
    assert report.created_on.instance_of?(Date)
  end
end
