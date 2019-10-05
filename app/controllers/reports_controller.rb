class ReportsController < ApplicationController

	before_action :set_message

	def sales_report
		@title = 'Selecione o periodo das vendas'
		@report = 'sales'
		render :index
	end
	
	def expenses_report
		@title = 'Selecione o periodo das despesas'
		@report = 'expenses'
		render :index
	end

	def resume_report
		@title = 'Selecione o periodo do resumo'
		@report = 'resume'
		render :index
	end

	def inventory_report
		@title = 'Selecione o periodo do inventario'
		@report = 'inventory'
		render :index
	end

	def salesman_report
		@title = 'Selecione o periodo das vendas por vendedor'
		@report = 'salesman'
		render :index
	end

	def amount_report
		@title = 'Produtos com menor até os com maior quantidade'
		@products = Product.order :amount
		render :report_amount
	end

	def index

	end

	def report
		report = params[:report]
		begin_date = params[:begin_date]
		end_date = params[:end_date]
		period = "#{begin_date.split("-").reverse.join("-")} e #{end_date.split("-").reverse.join("-")}"

		if report == 'sales'
			@title = "Vendas entre #{period}"
			@sales = Sale.where(status: 'pago')
			@sales = filter_date(@sales, begin_date, end_date)
			@total = @total_filter
			render :report_sales
		elsif report == 'expenses'
			@title = "Despesas entre #{period}"
			@expenses = Expense.where(status: true)
			@expenses = filter_date(@expenses, begin_date, end_date)
			@total = @total_filter
			render :report_expenses
		elsif report == 'resume'
			@title = "Resumo do periodo entre #{period}"
			@sales = Sale.where(status: 'pago')
			@sales = filter_date(@sales, begin_date, end_date)
			@total_sales = @total_filter
			@expenses = Expense.where(status: true)
			@expenses = filter_date(@expenses, begin_date, end_date)
			@total_expenses = @total_filter
			@total_resume = @total_sales - @total_expenses
			render :report_resume
		elsif report == 'inventory'
			@title = "Inventario de movimentação entre #{period}"
			sales = Sale.where(status: 'pago')
			sales = filter_date(sales, begin_date, end_date)
			@products = []
			sales.each do |sale|
				sale.item.each do |item|
					unless @products.include? item.product
						@products << item.product
					end	
				end
			end
			render :report_inventory
		elsif report == 'salesman'
			@title = "Vendas por vendedor entre #{period}"
			@salesman = User.all
			@sales = Sale.where(status: 'pago')
			@sales = filter_date(@sales, begin_date, end_date)
			render :report_salesman
		end
	end

	private
		def filter_date(base, begin_date, end_date)
			filter = []
			@total_filter = 0
			if begin_date > end_date
				@message = 'Data final é maior que data inicial!'
				render :index
			else
				base.each do |b|
					if b.created_at.strftime("%Y-%m-%d") == begin_date
						filter << b
						@total_filter += b.total
					elsif b.created_at.strftime("%Y-%m-%d") > begin_date && b.created_at.strftime("%Y-%m-%d") < end_date
						filter << b
						@total_filter += b.total
					elsif b.created_at.strftime("%Y-%m-%d") == end_date
						filter << b
						@total_filter += b.total
					end
				end
				base = filter
			end
		end
end
