class SalesController < ApplicationController

	before_action :set_message
	before_action :set_sale, only:[:select_client, :selection, :edit, :update, :pay]

	def index
		@sales = Sale.all
	end

	def today
		@sales = Sale.where(status: 'pago')
		@sales = filter_today(@sales)
	end

	def pending
		@sales = Sale.where(status: 'pendente')
		@today = Time.zone.now
		@total = 0
		@sales.each do |sale|
			@total += sale.total
		end
	end

	def new
		@sale = Sale.new
		if Sale.last != nil
			last_id = Sale.last.id
			@sale.id = (last_id + 1)
		else
			@sale.id = 1
		end
		@sale.client_id = 1
		@sale.total = 0
		@sale.status = 'pago'
		@sale.user = current_user
		@sale.save

		redirect_to select_client_sale_path(@sale)
	end

	def select_client
		@clients = Client.all
	end

	def selection
		@client = Client.find(params[:client_id])
		@sale.update(client_id: @client.id)

		redirect_to edit_sale_path(@sale)
	end

	def edit
		@items = Item.where(sale_id: @sale.id)
	end

	def update
		status = params[:status]
		@sale.update(status: status)

		redirect_to sales_today_path, notice: 'Venda Salva com Sucesso!'
	end

	def pay
		@sale.update(created_at: Time.zone.now, status: 'pago')

		redirect_to sales_pending_path, notice: 'Recebimento efetuado com sucesso!'
	end

	def search_item
		@sale = Sale.find(params[:sale_id])
		@products = Product.all
	end

	def destroy
		@sale = Sale.find(params[:id])
		if @sale.item.empty? == true
			@sale.destroy
			redirect_to sales_today_path, notice: 'Venda Cancelada!'
		else
			@sale.item.each do |item|
				if item.amount != nil
					amount = item.amount #retorna a quantidade do produto para o estoque quando remove-o da lista
					new_amount = item.product.amount + amount
					item.product.update(amount: new_amount)
				end
			end
			@sale.destroy
			redirect_to sales_today_path, notice: 'Venda Cancelada!'
		end
	end

	def show
		@sale = Sale.find(params[:id])
		@items = Item.where(sale_id: @sale.id)
	end

	private
		def set_sale
			@sale = Sale.find(params[:id])
		end
end
