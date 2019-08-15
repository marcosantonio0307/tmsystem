class ProductsController < ApplicationController

	before_action :set_product, only:[:edit, :update, :show, :add_amount, :entry_amount]
	before_action :set_message
	before_action :set_categories

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		product_params = params.require(:product).permit!
		@product = Product.new product_params

		validation = Product.where(sku: @product.sku)
		if validation.empty?
			@product.save
			if @product.save
				redirect_to products_path, notice: 'Produto Cadastrado com Sucesso!'
			else
				@message = 'Campos obrigatórios não preenchidos!'
				render :new
			end
		else
			@message = 'SKU ja existe!'
			render :new
		end
	end

	def edit
		
	end

	def update
		product_params = params.require(:product).permit!
		sku = params[:product][:sku]
		validation = Product.where(sku: sku)

		if sku == @product.sku
			@product.update product_params
			if @product.save
				redirect_to products_path, notice: 'Produto Atualizado com Sucesso!'
			else
				@message = 'Campos obrigatórios não preenchidos!'
				render :new
			end
		else
			if validation.empty?
				@product.update product_params
				if @product.save
					redirect_to products_path, notice: 'Produto Atualizado com Sucesso!'
				else
					@message = 'Campos obrigatórios não preenchidos!'
					render :new
				end
			else
				@message = 'SKU ja existe!'
				render :new
			end
		end
		

	end

	def add_amount
		
	end

	def entry_amount
		entry = params[:entry].to_i
		if entry != nil && entry > 0
			new_amount = @product.amount + entry
			@product.update(amount: new_amount)
			redirect_to product_path(@product), notice: 'Entrada realizada com Sucesso!'
		else
			redirect_to product_path(@product), notice: 'Valor incorreto! Não foi realizada Entrada!'
		end
	end

	def show

	end

	private

		def set_message
			@message = ''
		end

		def set_product
			@product = Product.find(params[:id])
		end

		def set_categories
			@categories = ['t-shirt', 'polo', 'social', 'swetter', 'bermudas', 'calças', 'calçados', 'acessórios']
		end
end