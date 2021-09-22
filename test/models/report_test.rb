# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @user_alice = users(:alice)
    @user_bob = users(:bob)
    @report = Report.create!(user_id: @user_alice.id, title: 'alice report', content: 'report content')
  end

  test '編集可能チェック' do
    assert @report.editable?(@user_alice)
    assert_not @report.editable?(@user_bob)
  end

  test '作成日を日付型に変換' do
    assert @report.created_on.instance_of?(Date)
  end

  test 'titleとcontentが有れば有効' do
    assert @report.valid?
  end

  test 'titleは必須' do
    @report.title = nil
    assert @report.invalid?
    assert_includes @report.errors[:title], "を入力してください"
  end

  test 'contentは必須' do
    @report.content = nil
    assert @report.invalid?
    assert_includes @report.errors[:content], "を入力してください"
  end

end
