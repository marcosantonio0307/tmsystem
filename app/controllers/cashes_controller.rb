class CashesController < ApplicationController

	before_action :set_message

	def index
		@cashes = Cash.all
	end

	def new
		today
		@cash = Cash.create(sales_total: @total_sales, expenses_total: @total_expenses, total: @total_cash)
		redirect_to cashes_path, notice: 'Caixa fechado com sucesso!'
	end

	def today
		@sales = Sale.where(status: 'pago')
		@sales = filter_today(@sales)
		@total_sales = @sales.sum.total

		@expenses = Expense.where(status: true)
		@expenses = filter_today(@expenses)
		@total_expenses = @expenses.sum.total

		@total_cash = @total_sales - @total_expenses
	end

	def open
		cash = Cash.last
		cash.destroy
		redirect_to cashes_today_path, notice: 'Caixa reaberto'
	end

	private
		def total_sales_day
			@sales = Sale.where(status: 'pago')
			@sales = filter_today(@sales)
			@total_sales = @sales.sum.total
		end
end
