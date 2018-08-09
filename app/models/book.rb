class Book < ApplicationRecord
  belongs_to :author
  has_many :book_ratings, dependent: :destroy

  mount_uploader :cover_image, CoverImageUploader

  validates :title, presence: true
  validates :author_id, presence: true

  scope :with_author, lambda { |name| joins(:author).merge(Author.with_name(name)) }
  scope :published_after, lambda { |start_date| where("published_at >= ?", start_date ) }
  scope :published_before, lambda { |end_date| where("published_at <= ?", end_date ) }

  def recalculate_average_rating
    update_attributes!(average_rating: book_ratings.average(:rating).to_f)
  end
end
