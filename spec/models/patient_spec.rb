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
    expect(build(:patient, phone: nil)).to_not be_valid
    expect(build(:patient, email: nil)).to_not be_valid
    expect(build(:patient, address_1: nil)).to_not be_valid
    expect(build(:patient, address_province: nil)).to_not be_valid
    expect(build(:patient, address_city: nil)).to_not be_valid
    expect(build(:patient, address_postal_code: nil)).to_not be_valid
    expect(build(:patient, date_of_birth: nil)).to_not be_valid
    expect(build(:patient, sex: nil)).to_not be_valid
  end

  it "is not valid with an invalid email" do
    patient = build(:patient, email: "invalid.email")
    expect(patient).to_not be_valid
  end

  it "has a correctly formatted phone number" do
    patient = build(:patient, phone: "(123) 456-7890")
    expect(patient.phone).to eq("1234567890")
  end

  it "has a phone number of the correct length" do
    expect(build(:patient, phone: "123")).to_not be_valid
    expect(build(:patient, phone: "11111111111")).to_not be_valid
  end
end
