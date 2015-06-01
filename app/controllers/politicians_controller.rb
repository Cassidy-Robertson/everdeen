class PoliticiansController < ApplicationController

  def index
    @politicians = Politician.all
  end

  def show
    @politician = Politician.find(params[:id])

    if @politician.indiv_contributors.empty?
      indiv_contributors = @politician.get_top_indiv_contributors("candContrib",2014)
    else
      indiv_contributors = @politician.indiv_contributors
    end

    @indiv_contributors_data = {}
    indiv_contributors.each do |indiv_contributor|
      @indiv_contributors_data[indiv_contributor.organization_name.to_sym] = indiv_contributor.total
    end

    if @politician.indus_contributors.empty?
      indus_contributors = @politician.get_top_indus_contributors("candIndustry",2014)
    else
      indus_contributors = @politician.indus_contributors
    end

    @indus_contributors_data = {}
    indus_contributors.each do |indus_contributor|
      @indus_contributors_data[indus_contributor.industry_name.to_sym] = indus_contributor.total
    end

    politician_name = @politician.twitter_handle
    if politician_name
      @get_mentions = @politician.get_mentions(politician_name)
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
    @district = District.where(zipcode: params["zipcode"])
    state = @district.first.state
    @politicians = Politician.where(title: "Sen").where(state: state).where(in_office: true)
    @district.each do |district|
      district_num = district.district_num
      @politicians+=(Politician.where(district: district_num).where(state: state).where(in_office: true))
    end
  end

end
