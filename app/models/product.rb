class Product < ApplicationRecord
	validates :sku, :name, :price, :amount, presence: true
end
