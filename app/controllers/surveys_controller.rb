  class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @surveys = Survey.order(created_at: :desc)
    @categories = Category.order(:name)
    @enrollments = Enrollment.all
    authorize @surveys, :index?
    @page_title = "Surveys"
  end

  def show
    authorize @survey, :show?
    @page_title = @survey.survey_name
  end

  def new
    @survey = Survey.new

    authorize @survey, :new?
  end

  def edit
    authorize @survey, :edit?
  end

  def create
    @survey = Survey.new(survey_params)

    authorize @survey, :create?
    @survey.organizer = current_user

    respond_to do |format|
      if @survey.save
        format.html { redirect_to survey_url(@survey), notice: "Survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @survey, :update?

    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to survey_url(@survey), notice: "Survey was successfully updated." }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @survey, :destroy?
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url, notice: "Survey was successfully destroyed." }
      format.json { head :no_content }
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
                                    :survey_id
                                    )
    end
end
