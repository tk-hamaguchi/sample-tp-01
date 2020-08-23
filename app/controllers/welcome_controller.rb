class WelcomeController < ApplicationController
  def index
    @images = Array.new(30) { |i| "https://loremflickr.com/200/#{rand(2..4) * 100}?random=#{i + 1}" }
  end
end
