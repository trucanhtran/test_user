class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :invited_user_id
      t.belongs_to :users

      t.timestamps
    end
  end
end
