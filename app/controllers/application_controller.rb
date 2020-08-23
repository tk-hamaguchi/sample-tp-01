class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by!(name: '自分')
  end

  helper_method :current_user
end
