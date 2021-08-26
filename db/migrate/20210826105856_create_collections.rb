class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false 
      t.boolean :private

      t.timestamps

      t.index [:name, :user_id], unique: true 
    end
  end
end
