class ClientsController < ApplicationController

	before_action :set_client, only:[:show, :edit, :update]
	before_action :set_message

	def index
		@clients = Client.all
	end

	def new
		@client = Client.new
	end

	def create
		client_params = params.require(:client).permit!
		@client = Client.new client_params
		cpf_registred = Client.all.map{|c| c.cpf}

		if cpf_registred.include?(@client.cpf)
			@message = 'Não Cadastrado! CPF já existe!'
			render :new
		else
			@client.name.upcase!
			@client.save
			if @client.save
				redirect_to clients_path, notice: 'Cliente Cadastrado com Sucesso!'
			else
				@message = 'Campos obrigatórios não preenchidos'
				render :new
			end
		end
	end

	def edit
		@client
	end

	def update
		client_params = params.require(:client).permit!
		@client.update client_params

		if @client.save
			redirect_to client_path(@client), notice: 'Cadastro Atualizado!'
		else
			render :edit
		end
	end

	def report_birthday
		clients = Client.all
		@clients = []
		month = Time.zone.now
		month = month.strftime("%m")

		clients.each do |client|
			if client.birthday.strftime("%m") == month
				@clients << client
			end
		end
		@clients.sort_by!{|client| client.birthday.strftime("%d")}
	end

	def show
		@client
	end

	private

		def set_client
			@client = Client.find(params[:id])
		end
end
