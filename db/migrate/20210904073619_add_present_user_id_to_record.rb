class AddPresentUserIdToRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :present_user_id, :integer, index: true
  end
end
