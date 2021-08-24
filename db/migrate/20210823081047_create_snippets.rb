class CreateSnippets < ActiveRecord::Migration[6.1]
  def change
    create_table :snippets do |t|
      t.text :description, null: false
      t.boolean :private 
      t.string :url 
      t.belongs_to :user, foreign_key: true 
      t.timestamps
    end
  end
end
