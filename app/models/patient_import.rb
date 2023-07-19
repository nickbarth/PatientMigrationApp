class PatientImport
  include ActiveModel::Model
  attr_accessor :file
  validates :file, presence: true
end
