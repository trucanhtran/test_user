class CreateInvitedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :invited_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
