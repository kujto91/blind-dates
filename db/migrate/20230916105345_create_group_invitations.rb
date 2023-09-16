class CreateGroupInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :group_invitations do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :group, foreign_key: true, null: false

      t.boolean :leader, default: false
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
