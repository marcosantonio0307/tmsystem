class CreateCashes < ActiveRecord::Migration[5.2]
  def change
    create_table :cashes do |t|
      t.decimal :sales_total
      t.decimal :expenses_total
      t.decimal :total

      t.timestamps
    end
  end
end
