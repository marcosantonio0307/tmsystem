class CashesController < ApplicationController

	before_action :set_message

	def index
		@cashes = Cash.all
	end

	def new
		today
		next_cash = params[:next]
		@cash = Cash.create(start: @start, sales_total: @total_sales, expenses_total: @total_expenses, total: @total_cash, next: next_cash)
		redirect_to cashes_path, notice: 'Caixa fechado com sucesso!'
	end

	def today
		@sales = Sale.where(status: 'pago')
		@sales = filter_today(@sales)
		@total_sales = @total

		@expenses = Expense.where(status: true)
		@expenses = filter_today(@expenses)
		@total_expenses = @total

		cash_last = Cash.last
		if cash_last == nil
			@start = 0
		elsif cash_last.next == nil
			@start = 0
		else
			@start = cash_last.next
		end

		@total_cash = (@start + @total_sales) - @total_expenses
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
			@total_sales = @total
		end
end
