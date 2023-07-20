class PatientImportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "patient_import_channel"
  end

  def unsubscribed
    stop_stream_from "patient_import_channel"
  end
end
