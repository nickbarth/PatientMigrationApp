require 'date'
require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is valid with valid attributes" do
    patient = build(:patient)
    expect(patient).to be_valid
  end

  it "is valid if missing non required fields" do
    patient = build(:patient, middle_name: nil, address_2: nil)
    expect(patient).to be_valid
  end

  it "is not valid if missing a required fields" do
    expect(build(:patient, health_identifier: nil)).to_not be_valid
    expect(build(:patient, health_identifier_province: nil)).to_not be_valid
    expect(build(:patient, first_name: nil)).to_not be_valid
    expect(build(:patient, last_name: nil)).to_not be_valid
    # expect(build(:patient, phone: nil)).to_not be_valid
    expect(build(:patient, email: nil)).to_not be_valid
    # expect(build(:patient, address_1: nil)).to_not be_valid
    expect(build(:patient, address_province: nil)).to_not be_valid
    expect(build(:patient, address_city: nil)).to_not be_valid
    # expect(build(:patient, address_postal_code: nil)).to_not be_valid
    # expect(build(:patient, date_of_birth: nil)).to_not be_valid
    expect(build(:patient, sex: nil)).to_not be_valid
  end

  it "is not valid with an invalid email" do
    patient = build(:patient, email: "invalid.email")
    expect(patient).to_not be_valid
  end

  it "clean email before saving" do
    patient = build(:patient, email: "test@test.com;")
    patient.save
    expect(patient.email).to eq("test@test.com")
  end

  it "has a correctly formatted phone number" do
    patient = build(:patient, phone: "(123) 456-7890")
    patient.save
    expect(patient.phone).to eq("11234567890")
    expect(patient.phone_number).to eq("1-123-456-7890")
  end

  it "has a phone number of the correct length" do
    patient = build(:patient, phone: "123")
    patient.save
    expect(patient.phone).to be_nil
    patient = build(:patient, phone: "1111111111111")
    patient.save
    expect(patient.phone).to be_nil
  end

  it "expands two character province codes to full province name" do
    patient = build(:patient, address_province: "ab")
    patient.save
    expect(patient.address_province).to eq("Alberta")
  end

  it "formats full name correctly" do
    patient = build(:patient, first_name: "John", last_name: "Doe")
    expect(patient.name).to eq("John Doe")
  end

  it "calculates age correctly" do
    now = Time.now.utc.to_date
    patient = build(:patient, date_of_birth: now - 30.years)
    expect(patient.age).to eq(30)
  end
end
