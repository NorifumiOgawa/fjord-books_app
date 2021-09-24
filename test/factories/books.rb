# frozen_string_literal: true

FactoryBot.define do
  factory :war_games, class: Book do
    title { 'ウォーゲーム' }
    memo { 'カプラでハッキングして三目並べで世界を救う' }
    author { 'ジョン・バダム' }
  end
end
