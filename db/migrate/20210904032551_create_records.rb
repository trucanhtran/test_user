class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.belongs_to :invited_user
      t.belongs_to :users

      t.timestamps
    end
  end
end
