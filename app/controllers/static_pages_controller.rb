class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def index; end

  def privacy_policy; end

  def terms_of_service; end

  def contact
    user_agent = request.user_agent
    @width = 350
    unless user_agent&.match?(/Mobile|Android|iPhone|iPad/)
      @width = 600
    end
  end
end
