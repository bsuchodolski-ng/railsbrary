class CreateBookReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :book_reviews do |t|
      t.belongs_to :book
      t.belongs_to :user
      t.text :body
      t.index [:user_id, :book_id]
      t.index [:book_id, :user_id], unique: true
      t.timestamps
    end
  end
end
