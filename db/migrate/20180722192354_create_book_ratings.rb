class CreateBookRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :book_ratings do |t|
      t.belongs_to :book
      t.belongs_to :user
      t.integer :rating
      t.timestamps
    end
  end
end
