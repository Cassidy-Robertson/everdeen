class CreateIndivContributors < ActiveRecord::Migration
  def change
    create_table :indiv_contributors do |t|
      t.string :organization_name
      t.integer :total
      t.integer :pacs
      t.integer :indivs
      t.integer :year
      t.belongs_to :politician, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
