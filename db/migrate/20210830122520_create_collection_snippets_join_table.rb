class CreateCollectionSnippetsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :collections, :snippets do |t|
      t.index :collection_id 
      t.index :snippet_id 
    end 
  end
end
