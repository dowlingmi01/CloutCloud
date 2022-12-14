class Admin::UsersController < Admin::ApplicationController
	before_action :set_user, only: [:edit, :update, :destroy] 
	before_action :authenticate_user!, except: [:index, :show] 

	def index
		@users = User.order(:email)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notice] = "User has been created"
			redirect_to admin_users_path
		else
			flash.now[:alert] = "User has not been created"
			render "new"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user.destroy

		respond_to do |format|
			format.html { redirect_to admin_users_path, notice: "User was successfully destroyed." }
			format.json { head :no_content }
	end
end

def edit
	@user = User.find(params[:id])
end

def update
	if @user.update(user_params)
		flash[:notice] = "User has been updated"
		redirect_to admin_users_path
	else
		flash[:alert] = "User has not been updated"
		render "edit"
	end
end

private

def user_params
	params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :admin)
end

def set_user
	@user = User.find(params[:id])
end

end
