class Keyword < ActiveRecord::Base
has_many :user_keywords
has_many :users, through: :user_keywords
end
