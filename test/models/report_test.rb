# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @user_alice = create(:alice)
    @user_bob = create(:bob)
    @report = Report.create!(user_id: @user_alice.id, title: 'alice report', content: 'report content')
  end

  test '編集可能チェック' do
    assert @report.editable?(@user_alice)
    assert_not @report.editable?(@user_bob)
  end

  test '作成日を日付型に変換' do
    assert @report.created_on.instance_of?(Date)
    assert_equal @report.created_at.strftime('%a, %d %b %Y'), @report.created_on.strftime('%a, %d %b %Y')
  end
end
