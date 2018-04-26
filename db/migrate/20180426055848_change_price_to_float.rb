class ChangePriceToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :price, :float
    change_column :orders, :price, :float
  end
end
