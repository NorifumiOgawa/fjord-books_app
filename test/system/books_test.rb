# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @user_alice = create(:alice)
    @book = create(:war_games)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'トップページの表示' do
    visit books_url
    assert_selector 'h1', text: '本'
    assert_text 'ウォーゲーム'
    assert_text '三目並べ'
    assert_text 'ジョン・バダム'
  end

  test '本の新規登録' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'スターウォーズ'
    fill_in 'メモ', with: 'いい本です'
    fill_in '著者', with: 'george lucas'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'スターウォーズ'
    assert_text 'いい本です'
    assert_text 'george lucas'
  end

  test '本の編集' do
    visit books_url
    click_on '編集'

    fill_in 'タイトル', with: 'スターウォーズ2'
    fill_in 'メモ', with: 'もっといい本です'
    fill_in '著者', with: 'george lucas2'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'スターウォーズ2'
    assert_text 'もっといい本です'
    assert_text 'george lucas2'
  end

  test '本の削除' do
    visit books_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
  end
end
