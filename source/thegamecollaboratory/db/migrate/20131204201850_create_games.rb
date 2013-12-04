class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :user, :index => true
      t.string :name, :null => false
      t.string :effect, :null => false
      t.string :idea, :null => true
      t.string :prototype, :null => true
      t.string :first_playable, :null => true
      t.string :alpha, :null => true
      t.string :beta, :null => true
      t.string :gold, :null => true
      t.string :shipped, :null => true
      t.string :current_request, :null => false, :default => ""
    end
  end
end
