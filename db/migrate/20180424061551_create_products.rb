class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name
      t.text :branch
      t.integer :price

      t.timestamps
    end
  end
end
