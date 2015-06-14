class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :approvalcount
      t.integer :disapprovalcount
      t.datetime :date
      t.belongs_to :politician, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
