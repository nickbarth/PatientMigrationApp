FactoryBot.define do
  factory :patient do
    health_identifier { "MyString" }
    health_identifier_province { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    middle_name { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    address_1 { "MyString" }
    address_2 { "MyString" }
    address_province { "MyString" }
    address_city { "MyString" }
    address_postal_code { "MyString" }
    date_of_birth { "2023-07-15" }
    sex { "MyString" }
  end
end
