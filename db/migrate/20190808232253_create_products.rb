class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.integer :amount
      t.decimal :price
      t.decimal :cost
      t.string :category

      t.timestamps
    end
  end
end
