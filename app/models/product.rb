class Product < ApplicationRecord
	validates :name, :price, :amount, presence: true
	has_many :item
end
