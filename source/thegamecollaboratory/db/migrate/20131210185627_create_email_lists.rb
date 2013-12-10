class CreateEmailLists < ActiveRecord::Migration
  def change
    create_table :email_lists do |t|
      t.string :email, :null => false
      t.boolean :is_active, :null => false, :default => true
      t.string :unique_hash, :null => false
      t.timestamps
    end
  end
end
