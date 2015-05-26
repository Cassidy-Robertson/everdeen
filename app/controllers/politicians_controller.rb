class PoliticiansController < ApplicationController

  def index
    @politicians = Politician.all
  end

  def show
    @politician = Politician.find(params[:id])
  end
  
  def findyourreps
    @district = District.find_by(zipcode: params["zipcode"])
    district_num = @district.district_num
    state = @district.state
    @politicians = Politician.where(title: "Sen").where(state: state).where(in_office: true)
    @politicians+=(Politician.where(district: district_num).where(state: state).where(in_office: true))
    # binding.pry
    # redirect_to findyourreps_path
  end

  # def viewyourreps

  # end
end
