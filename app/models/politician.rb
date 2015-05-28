class Politician < ActiveRecord::Base
  has_many :nytimes_articles

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
end
