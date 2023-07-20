require 'rails_helper'

RSpec.describe ProcessPatientsJob, type: :job do
  include ActiveJob::TestHelper

  let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'patients.csv').to_s }

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  context "when all rows are valid" do
    it "broadcasts progress messages and imports all patients" do
      expect { 
        perform_enqueued_jobs { described_class.perform_later(file_path) }
      }.to change(Patient, :count).by(1)
      .and have_broadcasted_to('patient_import_channel').exactly(2).times
    end
  end

  context "when a row is invalid" do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'patients_invalid.csv').to_s } # A CSV file with an invalid row

    it "broadcasts an error message and aborts the import" do
      expect {
        perform_enqueued_jobs { described_class.perform_later(file_path) }
      }.not_to change(Patient, :count)

      expect {
        perform_enqueued_jobs { described_class.perform_later(file_path) }
      }.to have_broadcasted_to('patient_import_channel').with { |msg|
        expect(msg[:status]).to eq("warning")
      }
    end
  end
end
