class AddCoinToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :coin, :integer
  end
end
