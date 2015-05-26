class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :zipcode
      t.string :state
      t.string :district_num

      t.timestamps null: false
    end
  end
end
