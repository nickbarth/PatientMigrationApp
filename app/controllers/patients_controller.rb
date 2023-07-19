class PatientsController < ApplicationController
  def index
    # show dashboard
  end

  def new
    @patient_import = PatientImport.new
  end

  def progress
  end

  def import
    @patient_import = PatientImport.new(import_params)
    if @patient_import.valid?
      # PatientImportJob.perform_later(@patient_import.id)
      redirect_to progress_patients_path, notice: "Patient import started."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def import_params
      params[:patient_import]&.permit(:file)
    end
end
