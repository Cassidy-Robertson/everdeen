class AddCrpidToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :crpid, :string
  end
end
