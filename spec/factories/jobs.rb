# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7) }
  end
end
