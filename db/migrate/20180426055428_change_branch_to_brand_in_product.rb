class ChangeBranchToBrandInProduct < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :branch, :brand
  end
end
