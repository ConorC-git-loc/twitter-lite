require 'rails_helper'

RSpec.describe User, type: :model do
  FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { "password"} 
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end
end
end
