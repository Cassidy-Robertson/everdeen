class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :state
      t.string :district
      t.string :website
      t.string :twitter_handle

      t.timestamps null: false
    end
  end
end
