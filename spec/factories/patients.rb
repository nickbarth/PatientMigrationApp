FactoryBot.define do
  factory :patient do
    health_identifier { "HID" }
    health_identifier_province { "Alberta" }
    first_name { "John" }
    last_name { "Doe" }
    middle_name { "J" }
    phone { "123-456-7890" }
    email { "john.doe@example.com" }
    address_1 { "123 St" }
    address_2 { "Apt 456" }
    address_province { "Alberta" }
    address_city { "Edmonton" }
    address_postal_code { "T8N1B2" }
    date_of_birth { "1990-01-01" }
    sex { "M" }
  end
end
