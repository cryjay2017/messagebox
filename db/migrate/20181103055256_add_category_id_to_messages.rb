class AddCategoryIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :category_id, :integer
  end
end
