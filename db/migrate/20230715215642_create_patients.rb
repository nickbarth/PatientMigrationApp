class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :health_identifier
      t.string :health_identifier_province
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :phone
      t.string :email
      t.string :address_1
      t.string :address_2
      t.string :address_province
      t.string :address_city
      t.string :address_postal_code
      t.date :date_of_birth
      t.string :sex

      t.timestamps
    end
  end
end
