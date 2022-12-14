  class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @surveys = Survey.order(created_at: :desc)
    @categories = Category.order(:name)
    @enrollments = Enrollment.all
    authorize @surveys, :index?
  end

  def show
    authorize @survey, :show?
    @completed_survey = current_user.completed_surveys.find_by(id: @survey.id)
  end

  def new
    @survey = Survey.new

    authorize @survey, :new?
  end

  def edit
    authorize @survey, :edit?
  end

  def update
    authorize @survey, :update?

    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to survey_url(@survey), notice: "Survey was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @survey, :destroy?
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url, notice: "Survey was successfully destroyed." }
    end
  end

  private
    def set_survey
      @survey = Survey.find(params[:id])

      rescue ActiveRecord::RecordNotFound
      flash.alert = "The page you requested does not exist"
      redirect_to surveys_path

    end

    def survey_params
      params.require(:survey).permit(:survey_name, 
                                    :description, 
                                    :location,
                                    :start_date,
                                    :end_date,
                                    :cpi,
                                    :loi,
                                    :survey_id,
                                    :category_id,
                                    :experience,
                                    :rewards_cash,
                                    :survey_reward
                                    )
    end
end
