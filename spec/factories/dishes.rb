# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    name "MyString"
    price 1.5
    category nil
    cover "MyText"
    content "MyText"
  end
end
