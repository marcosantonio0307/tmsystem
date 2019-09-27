class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :total
      t.boolean :status
      t.date :due_date

      t.timestamps
    end
  end
end
