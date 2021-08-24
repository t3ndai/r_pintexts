class RemovePrivateFromSnippets < ActiveRecord::Migration[6.1]
  def change
    remove_column :snippets, :private, :boolean
  end
end
