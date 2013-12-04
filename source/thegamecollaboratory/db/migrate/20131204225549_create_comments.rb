class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, :index => true
      t.belongs_to :game, :index => true
      t.string :text, :null => false
    end
  end
end
