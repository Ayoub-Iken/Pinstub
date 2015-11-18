class PinsController < ApplicationController

	before_action :authenticate_user!


############################ Actions
	def index
		@pin = Pin.all
	end

	def show
		get_pin
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)
		if @pin.save
			flash[:success] = "Successfully Saved"
			redirect_to @pin
		else
			render 'new'
		end
	end

	def edit
		get_pin
	end

	def update
		get_pin
		if @pin.update(pin_params)
			redirect_to root_path
			flash[:success] = "Pin edited Successfully"
		else
			render 'new'
		end
	end

	def destroy
		get_pin
		@pin.destroy
		redirect_to root_path
		flash[:success] = "Pin Deleted Successfully"
	end

####################### METHODES

private

	def get_pin
		@pin= Pin.find(params[:id])
	end

	def get_user
		@user = User.find(params[:user_id])
	end


	def pin_params
		params.require(:pin).permit(:title,:description, :image)
	end

end
