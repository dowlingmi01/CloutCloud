class RewardsController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_user
  before_action :authenticate_user!
  
  def index
    @completed_surveys = current_user.completed_surveys
    @rewards_cashes = current_user.rewards_cashes.order(created_at: :desc)
    @experiences = current_user.experiences.order(created_at: :desc)
    @survey_rewards = current_user.survey_rewards.order(created_at: :desc)
  end

  private
  
	def set_user
		@user = current_user.id
	end

end
