# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    name "tiramisu"
    price 15.5
    category_id 1
    cover "MyText"
    content "Contents here"

    trait :markdown do
      content <<-MD
# Awesome Event #
  
-   free wifi
-   free coffee
      MD
      cover <<-MD
subway line 2, foo station
      MD
    end

  end
end
