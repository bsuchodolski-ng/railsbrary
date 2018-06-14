class CreateBooksAndAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.belongs_to :author
      t.string :title
      t.datetime :published_at
      t.timestamps
    end

    create_table :authors do |t|
      t.string :name
      t.timestamps
    end
  end
end
