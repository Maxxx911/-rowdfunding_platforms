FactoryBot.define do
  factory :user do
    login { 'Best' }
    email { 'example@email.com' }
    password { 'qwerty' }
    confirm_password { 'qwerty' }
    first_name { 'Maxim' }
    middle_name { 'Middle name' }
    last_name { 'Last name' }
    birthday { Date.today }
  end
end
