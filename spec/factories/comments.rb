# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user_id 1
    attach_id 1
    attach_type "MyString"
    content "MyText"
  end
end