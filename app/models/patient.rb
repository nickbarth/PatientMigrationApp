require 'date'

class Patient < ApplicationRecord
  before_validation :format_phone_number
  before_validation :clean_email
  before_save :format_sex
  before_save :format_province

  validates :health_identifier, presence: true # , uniqueness: { scope: :health_identifier_province }
  validates :health_identifier_province, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, allow_blank: true, length: { is: 11 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :address_1, presence: true
  validates :address_province, presence: true
  validates :address_city, presence: true
  # validates :address_postal_code, presence: true
  # validates :date_of_birth, presence: true
  validates :sex, presence: true

  def self.age_distribution
    all.reject { |p| p.age.nil? }.group_by(&:age).transform_values(&:count)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def phone_number
    return unless phone
    "1-#{phone[1..3]}-#{phone[4..6]}-#{phone[7..10]}"
  end

  def age
    return unless date_of_birth
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
  end

  private
    def clean_email
      return unless self.email
      self.email = self.email.downcase.strip.gsub(/;$/, "")
    end

    def format_phone_number
      return unless self.phone
      self.phone = self.phone.gsub!(/[^0-9]/, "")
      if self.phone and self.phone.length == 10
        self.phone = "1#{self.phone}"
      else
        self.phone = nil
      end
    end

    def format_sex
      self.sex = self.sex.upcase
    end

    def format_province
      provinces = {
        AB: "Alberta",
        BC: "British Columbia",
        MB: "Manitoba",
        NB: "New Brunswick",
        NL: "Newfoundland and Labrador",
        NS: "Nova Scotia",
        NT: "Northwest Territories",
        NU: "Nunavut",
        ON: "Ontario",
        PE: "Prince Edward Island",
        QC: "Quebec",
        SK: "Saskatchewan",
        YT: "Yukon"
      }

      if self.address_province.strip and self.address_province.strip.length == 2
        self.address_province = provinces[self.address_province.strip.upcase.to_sym]
      end

      if self.health_identifier_province.strip and self.health_identifier_province.strip.length == 2
        self.health_identifier_province = provinces[self.health_identifier_province.strip.upcase.to_sym]
      end
    end
end
