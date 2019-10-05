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

		@product.save
		if @product.save
			sku_generate(@product)
			@product.update(sku: @new_sku)
			redirect_to products_path, notice: 'Produto Cadastrado com Sucesso!'
		else
			@message = 'Campos obrigatórios não preenchidos!'
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
		def set_product
			@product = Product.find(params[:id])
		end

		def set_categories
			@categories = ['t-shirt', 'polo', 'camisa', 'swetter', 'short', 'calça', 'calçado', 'acessório']
		end

		def sku_generate(product)
			all_products = Product.where(category: product.category)
			last_sku = all_products.map{|p| p.sku}[-2]
			if last_sku == nil
				num = "01"
			else
				i = last_sku.size - 2
				num = last_sku[2, i]
				num = num.to_i + 1
				if num < 10
					num = "0#{num.to_s}"
				else
					num = num.to_s
				end
			end
		
			if product.category == 't-shirt'
				@new_sku = "TS#{num}"
			elsif product.category == 'polo'
				@new_sku = "PO#{num}"
			elsif product.category == 'camisa'
				@new_sku = "CM#{num}"
			elsif product.category == 'swetter'
				@new_sku = "SW#{num}"
			elsif product.category == 'short'
				@new_sku = "SH#{num}"
			elsif product.category == "calça"
				@new_sku = "CA#{num}"
			elsif product.category == "calçado"
				@new_sku = "SP#{num}"
			else
				@new_sku = "AC#{num}"
			end

			@new_sku
		end
end