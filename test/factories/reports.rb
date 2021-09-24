# frozen_string_literal: true

FactoryBot.define do
  factory :bobs_report, class: Report do
    association :user, factory: :bob
    title { 'ボブのカレー日記' }
    content { '辛すぎた😆' }
  end
end
