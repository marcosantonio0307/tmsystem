class Client < ApplicationRecord
	validates :name, :cpf, :phone, presence: true
end
