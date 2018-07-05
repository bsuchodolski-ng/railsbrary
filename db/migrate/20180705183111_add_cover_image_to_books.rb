class AddCoverImageToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :cover_image, :string
  end
end
