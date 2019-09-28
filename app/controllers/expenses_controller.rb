class ExpensesController < ApplicationController
	before_action :set_message
	before_action :set_expense, only:[:edit, :update, :pay, :destroy]

	def new_expense
		@expense = Expense.new(status: true)
		render :new
	end

	def new_debt
		@expense = Expense.new(status: false)
		render :new
	end

	def create
		values = params.require(:expense).permit!
		@expense = Expense.create values
		if @expense.status == true
			redirect_to expenses_today_path, notice: 'Despesa cadastrada com sucesso!'
		else
			redirect_to expenses_debts_path, notice: 'Conta a pagar casdastrada com sucesso!'
		end
	end

	def edit
	end

	def update
		due_date = params[:expense][:due_date]
		description = params[:expense][:description]
		total = params[:expense][:total].to_f
		if @expense.status == true
			@expense.update(description: description, total: total)
			redirect_to expenses_today_path, notice: 'Alterado com sucesso!'
		else
			@expense.update(description: description, total: total, due_date: due_date)
			redirect_to expenses_debts_path, notice: 'Alterado com sucesso!'
		end
	end

	def pay
		@expense.update(status: true, created_at: Time.zone.now)
		redirect_to expenses_debts_path, notice: 'Pagmento realizado!'
	end

	def today
		@title = 'Despesas do dia'
		@type = 'expenses'
		@expenses = Expense.where(status: true)
		@expenses = filter_today(@expenses)

		render :index
	end

	def debts
		@title = 'Contas a pagar'
		@type = 'debts'
		@expenses = Expense.where(status: false)
		@expenses = @expenses.order :due_date
		@total = 0
		@expenses.each do |expense|
			if expense.total != nil
				@total += expense.total
			end
		end
		render :index
	end

	def destroy
		Expense.destroy @expense.id

		if @expense.status == true
			redirect_to expenses_today_path, notice: 'Despesa excluída com sucesso!'
		else
			redirect_to expenses_debts_path, notice: 'Conta excluída com sucesso!'
		end
	end

	private
		def set_expense
			@expense = Expense.find(params[:id])
		end
end
