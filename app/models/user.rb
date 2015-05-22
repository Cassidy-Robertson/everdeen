class User < ActiveRecord::Base
has_many :user_keywords
has_many :keywords, through: :user_keywords
end

