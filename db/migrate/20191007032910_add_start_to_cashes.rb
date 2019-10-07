class AddStartToCashes < ActiveRecord::Migration[5.2]
  def change
  	add_column :cashes, :start, :decimal
  end
end
