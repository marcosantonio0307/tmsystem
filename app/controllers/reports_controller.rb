class ReportsController < ApplicationController

	before_action :set_message

	def sales_report
		@title = 'Selecione o periodo das vendas'
		@report = 'sales'
		render :index
	end

	def index

	end

	def report
		report = params[:report]
		begin_date = params[:begin_date]
		end_date = params[:end_date]

		if report == 'sales'
			@title = "Vendas entre #{begin_date} e #{end_date}"
			@sales = Sale.all
			@sales = filter_date(@sales, begin_date, end_date)
			@total = @total_filter
			render :report_sales
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
