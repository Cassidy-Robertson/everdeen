class PoliticiansController < ApplicationController

  def index
    @politicians = Politician.all
  end

  def show
    @politician = Politician.find(params[:id])

    if @politician.indiv_contributors.empty?
      @indiv_contributors = @politician.get_top_indiv_contributors("candContrib",2014)
    else
      @indiv_contributors = @politician.indiv_contributors
    end

    if @politician.indus_contributors.empty?
      @indus_contributors = @politician.get_top_indus_contributors("candIndustry",2014)
    else
      @indus_contributors = @politician.indus_contributors
    end
  end

  def times_articles
    @politician = Politician.find(params[:politician_id])
    if @politician.nytimes_articles.empty?
      @articles = @politician.get_articles
    else
      @articles = @politician.nytimes_articles
    end

    respond_to do |format|
      format.html {render action: "show"}
      format.js
    end
  end
  
  def findyourreps
    @district = District.find_by(zipcode: params["zipcode"])
    district_num = @district.district_num
    state = @district.state
    @politicians = Politician.where(title: "Sen").where(state: state).where(in_office: true)
    @politicians+=(Politician.where(district: district_num).where(state: state).where(in_office: true))
  end

end
