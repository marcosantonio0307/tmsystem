class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	
	def datebr(date)
		if date != nil
			date = date.strftime("%d/%m/%Y")
		end
	end

	def moneybr(money)
		if money != nil
			money = number_to_currency(money)
		end		
	end

	def filter_today(base)
		today = Time.zone.now
		filter = []
		@total = 0
		base.each do |b|
			if datebr(b.created_at) == datebr(today)
				filter << b
				@total += b.total
			end
		end
		base = filter		
	end

	private
		def set_message
			@message = ''
		end
end
