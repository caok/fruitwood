# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user nil
    content "MyText"
    attach_id 1
    attach_type "MyString"
  end
end
