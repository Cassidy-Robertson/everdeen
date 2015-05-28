class CreateIndusContributors < ActiveRecord::Migration
  def change
    create_table :indus_contributors do |t|
      t.string :industry_name
      t.integer :total
      t.integer :pacs
      t.integer :indivs
      t.integer :year
      t.belongs_to :politician, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
