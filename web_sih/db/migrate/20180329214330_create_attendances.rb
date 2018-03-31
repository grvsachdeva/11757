class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.string :image_uri
      t.string :location
      t.text :remarks
      t.datetime :timeIn
      t.datetime :timeOut
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
