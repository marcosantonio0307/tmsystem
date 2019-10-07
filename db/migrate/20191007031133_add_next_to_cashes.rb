class AddNextToCashes < ActiveRecord::Migration[5.2]
  def change
    add_column :cashes, :next, :decimal
  end
end
