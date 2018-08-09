class ChangeDefaultValueForBookAverageRating < ActiveRecord::Migration[5.2]
  def change
    change_column_default :books, :average_rating, from: nil, to: 0
  end
end
