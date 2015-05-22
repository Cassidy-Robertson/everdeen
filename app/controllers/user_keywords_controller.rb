class UserKeywordsController < ApplicationController
  def index 
    @user_keyword = UserKeyword.new
  end

end