FactoryBot.define do
  factory :user do
    username { 'Erica' }
    email { 'erica@gmail.com' }
    handle { 'test' }
    password { 'password' }
  end

  factory :tweet do
    content { 'A tweet' }
  end
end
