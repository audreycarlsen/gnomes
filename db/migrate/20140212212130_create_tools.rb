class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
