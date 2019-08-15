class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :cpf
      t.string :phone
      t.string :email
      t.string :address
      t.string :city
      t.date :birthday

      t.timestamps
    end
  end
end
