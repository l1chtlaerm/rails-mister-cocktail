class RemoveImgFromCocktails < ActiveRecord::Migration[6.0]
  def change
    remove_column :cocktails, :img
  end
end
