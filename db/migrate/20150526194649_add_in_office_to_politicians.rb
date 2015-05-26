class AddInOfficeToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :in_office, :boolean
  end
end
