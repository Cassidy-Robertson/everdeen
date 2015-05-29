class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def homeindex
    # binding.pry

    array_of_videos = ["https://dl.dropboxusercontent.com/u/110013595/LandingPage.mp4", "https://dl.dropboxusercontent.com/u/110013595/LandingPage2.mp4"]
    @video = array_of_videos.sample

  end

  def index_classic

  end

end
