require 'csv'

namespace :csv do

  desc "Import District CSV Data"
  task :import_districts => :environment do

    csv_file_path = 'db/districts.csv'

    CSV.foreach(csv_file_path) do |row|
      District.create!({
        :zipcode => row[0],
        :state => row[1],
        :district_num => row[2],
      })
      puts "Row added!"
    end
  end
end