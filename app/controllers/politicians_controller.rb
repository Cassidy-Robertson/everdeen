class PoliticiansController < ApplicationController
  
  def findyourreps
    # binding.pry
    @district = District.find_by(zipcode: params["zipcode"])
    district_num = @district.district_num
    state = @district.state
    @politicians = []
    @politicians << Politician.find_by(district: district_num)
    binding.pry
  end
end
