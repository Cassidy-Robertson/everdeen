class CreateNytimesArticles < ActiveRecord::Migration
  def change
    create_table :nytimes_articles do |t|
      t.belongs_to :politician, index: true, foreign_key: true
      t.text :headline
      t.text :url

      t.timestamps null: false
    end
  end
end
