class Product < ApplicationRecord
	validates :sku, :name, :price, :amount, presence: true
	has_many :item
end
