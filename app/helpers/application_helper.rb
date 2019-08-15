module ApplicationHelper
	def datebr(date)
		if date != nil
			date = date.strftime("%d/%m/%Y")
		end
	end
end
