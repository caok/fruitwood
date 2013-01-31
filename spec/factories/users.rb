# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sample_name = ['jack', 'lucy', 'dave', 'lily', 'john', 'beth'].sample
  sequence(:name) { |n| "#{sample_name}#{n}" }
  sequence(:email) { |n| "#{sample_name}#{n}@example.com".downcase }
  sample_tel = ["1377454575", "1245456987", "1457845698", "1557845700", "5547432"].sample
  sequence(:tel) { |n| "#{sample_tel}#{n}" }

  factory :user do
    name
    tel
    email
    password ['DJX5nvyX', 'GG83Sr4{', '_pW.2P*8', 'MH^IN3B_'].sample
    password_confirmation { password }

    trait :admin do
      roles "admin"
    end

    trait :customer do
      roles "customer"
    end
  end
end
