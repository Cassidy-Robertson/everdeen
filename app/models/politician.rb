class Politician < ActiveRecord::Base
  has_many :nytimes_articles
  has_many :indiv_contributors
  has_many :indus_contributors

  def get_mentions(politician_name)
    # binding.pry
    results = twitter_client.search(politician_name,count:10)
    tweets = []
    results.attrs[:statuses].each_with_index do |tweet,i|
      tweets << tweet[:text]
      break if i == 10
    end
    tweets
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def get_articles
    nytimes_base_uri = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
    api_key = ENV['NYTIMES_DEVELOPER_KEY']
    page = 0
    count = 0

    while count < 5
      uri_firstname = URI.escape(self.first_name)
      uri_lastname = URI.escape(self.last_name)
      # binding.pry
      uri = URI(nytimes_base_uri+uri_firstname+"+"+uri_lastname+"&fq=type_of_material:News&sort=newest&page=#{page}&api-key="+api_key)
      result = Net::HTTP.get(uri)

      break if page == 49
      
      JSON.load(result)["response"]["docs"].each do |article|

        if !article["keywords"].empty?
          if article["keywords"][0]["value"].include?("#{self.last_name}")
            NytimesArticle.create(headline: article["headline"]["main"], url: article["web_url"], politician_id: self.id)
            count += 1
          end
        end 
      end

      page += 1
      if page % 9 == 0
        sleep(1)
      end

    end

    NytimesArticle.where(politician_id: self.id)
  end 

  def get_top_indiv_contributors(method, year)
    open_secrets_base_uri = "http://www.opensecrets.org/api/?method="
    api_key = ENV['OPENSECRETS_DEVELOPER_KEY']

    uri = URI(open_secrets_base_uri+method+"&cid="+self.crpid+"&cycle=#{year}&output=json&apikey="+api_key)
    result = Net::HTTP.get(uri)

    JSON.load(result)["response"]["contributors"]["contributor"].each do |contributor_hash|
      IndivContributor.create(organization_name: contributor_hash["@attributes"]["org_name"], total: contributor_hash["@attributes"]["total"].to_i, pacs: contributor_hash["@attributes"]["pacs"].to_i, indivs: contributor_hash["@attributes"]["indivs"].to_i, year: year, politician_id: self.id)
    end
    
    IndivContributor.where(politician_id: self.id)
  end

  def get_top_indus_contributors(method, year)
    open_secrets_base_uri = "http://www.opensecrets.org/api/?method="
    api_key = ENV['OPENSECRETS_DEVELOPER_KEY']

    uri = URI(open_secrets_base_uri+method+"&cid="+self.crpid+"&cycle=#{year}&output=json&apikey="+api_key)
    result = Net::HTTP.get(uri)

    JSON.load(result)["response"]["industries"]["industry"].each do |contributor_hash|
      IndusContributor.create(industry_name: contributor_hash["@attributes"]["industry_name"], total: contributor_hash["@attributes"]["total"].to_i, pacs: contributor_hash["@attributes"]["pacs"].to_i, indivs: contributor_hash["@attributes"]["indivs"].to_i, year: year, politician_id: self.id)
    end
    
    IndusContributor.where(politician_id: self.id)
  end
end
