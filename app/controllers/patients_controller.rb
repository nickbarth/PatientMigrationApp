class PatientsController < ApplicationController
  def index
    @patients = Patient.paginate(page: params[:page], per_page: 5)
    @total_patients = Patient.count
    @gender_distribution = Patient.group(:sex).count
    @age_distribution = Patient.age_distribution
    @location_distribution = Patient.group(:health_identifier_province).count
  end

  def new
    @patient_import = PatientImport.new
  end

  def progress
  end

  def create
    @patient_import = PatientImport.new(import_params)

    if @patient_import.valid?
      file_path = Rails.root.join('tmp', @patient_import.file.original_filename)
      File.open(file_path, 'wb') do |file|
        file.write(@patient_import.file.read)
      end
      ProcessPatientsJob.perform_later(file_path.to_s)
      render :progress, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def import_params
      params[:patient_import]&.permit(:file)
    end
end
