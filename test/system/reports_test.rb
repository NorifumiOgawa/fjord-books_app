# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = create(:bobs_report)

    visit root_url
    fill_in 'Eメール', with: 'bob@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'トップページの表示' do
    visit reports_url
    assert_selector 'h1', text: '日報'
    assert_text 'bob'
    assert_text 'ボブのカレー日記'
  end

  test '日報の新規登録' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'おでんを作った'
    fill_in '内容', with: '出汁が旨い'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'おでんを作った'
    assert_text '出汁が旨い'
  end

  test '日報の編集' do
    visit reports_url
    click_on '編集'

    fill_in 'タイトル', with: 'おでんを手直しした'
    fill_in '内容', with: '大根も柔らかい'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'おでんを手直しした'
    assert_text '大根も柔らかい'
  end

  test '日報の削除' do
    visit reports_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
  end
end
