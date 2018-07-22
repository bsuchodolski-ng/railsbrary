class AddUniqueIndexOnBookRating < ActiveRecord::Migration[5.2]
  def change
    add_index :book_ratings, [:book_id, :user_id], unique: true
  end
end
