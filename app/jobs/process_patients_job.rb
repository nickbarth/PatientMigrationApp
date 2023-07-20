require 'csv'

class ProcessPatientsJob < ApplicationJob
  queue_as :default

  def perform(file)
    patients = []
    progress = 0
    total_rows = CSV.read(file).count

    CSV.foreach(file, headers: true, header_converters: :symbol).with_index(1) do |row, i|
      patient_attributes = row.to_hash
      patient = Patient.new(patient_attributes)
      # patients << patient_attributes.except(:id)
      patients << patient
      progress = (i.to_f / total_rows * 100).round(2)

      if not patient.valid?
        ActionCable.server.broadcast 'patient_import_channel', {
          progress: progress,
          status: "warning",
          message: "Patient import aborted. Error validating patient at row #{i}: #{patient.errors.full_messages.to_sentence}"
        }
        return # abort if invalid
      end

      ActionCable.server.broadcast 'patient_import_channel', {
        progress: progress,
        status: "success",
        message: "Validating patient at row #{i}...."
      }

      sleep(0.1)
    end

    # skip validations and formatting
    # Patient.create_with(created_at: Time.now, updated_at: Time.now).insert_all(patients)

    # validate and clean patient data
    patients.each do |patient|
      patient.save()
    end

    ActionCable.server.broadcast 'patient_import_channel', {
      progress: 100,
      status: "success",
      message: "All patients imported successfully!"
    }

    rescue => e
      ActionCable.server.broadcast 'patient_import_channel', {
        progress: 0,
        status: "warning",
        message: "Patient import aborted. Error occurred while importing patients: #{e.message}"
      }
  end
end
