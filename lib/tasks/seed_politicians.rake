require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_stuff => :environment do

    csv_file_path = 'db/legislators.csv'

    CSV.foreach(csv_file_path) do |row|
      Politician.create!({
        :title => row[0],
        :first_name => row[1],
        :last_name => row[3],
        :party => row[6],
        :state => row[7],
        :district => row[8],
        :website => row[13],
        :twitter_handle => row[21],
        :bioguide_id => row[16]
      })
      puts "Row added!"
    end
  end
end