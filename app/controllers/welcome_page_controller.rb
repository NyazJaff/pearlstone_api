class WelcomePageController < ApplicationController
  def welcome
    puts request.url, 'host ***'
  end
end
