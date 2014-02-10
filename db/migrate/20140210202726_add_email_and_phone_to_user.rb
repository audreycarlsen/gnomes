class AddEmailAndPhoneToUser < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    add_column :users, :email, :string
    add_column :users, :phone, :string
  end
end
