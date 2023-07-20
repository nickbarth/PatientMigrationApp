class Patient < ApplicationRecord
  validates :health_identifier, presence: true # , uniqueness: { scope: :health_identifier_province }
  validates :health_identifier_province, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, length: { is: 10 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address_1, presence: true
  validates :address_province, presence: true
  validates :address_city, presence: true
  validates :address_postal_code, presence: true
  validates :date_of_birth, presence: true
  validates :sex, presence: true

  def phone=(number)
    super(number.nil? ? nil : number.gsub!(/[^0-9]/, ""))
  end
end
