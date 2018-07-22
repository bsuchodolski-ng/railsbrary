class Book < ApplicationRecord
  belongs_to :author
  mount_uploader :cover_image, CoverImageUploader

  validates :title, presence: true
  validates :author_id, presence: true

  scope :with_author, lambda { |name| joins(:author).merge(Author.with_name(name)) }
  scope :published_after, lambda { |start_date| where("published_at >= ?", start_date ) }
  scope :published_before, lambda { |end_date| where("published_at <= ?", end_date ) }
end
