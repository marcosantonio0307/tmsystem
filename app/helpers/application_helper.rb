module ApplicationHelper
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
end
