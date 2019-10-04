class UsersController < ApplicationController
	before_action :set_message

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		values = params.require(:user).permit!
		if params[:user][:password] == ''
			@message = 'Senha nao pode ficar em branco!'
			render :edit
		else
			@user.update values
			redirect_to root_path, notice: 'Senha alterada com sucesso!'
		end
	end
end
