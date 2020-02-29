class AddColumnsToUsers2 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :location, :string
    add_column :users, :image, :string
  end
end
