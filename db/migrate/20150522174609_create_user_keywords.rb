class CreateUserKeywords < ActiveRecord::Migration
  def change
    create_table :user_keywords do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :keyword, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
