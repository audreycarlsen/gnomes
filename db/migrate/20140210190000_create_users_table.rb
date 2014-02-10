class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users_tables do |t|
      t.string   "username"
      t.boolean  "admin"
      t.timestamps
    end
  end
end
