class AddBookRatingsCountToBooks < ActiveRecord::Migration[5.2]
  def change
    change_table :books do |t|
      t.integer :book_ratings_count, default: 0
    end
  end
end
