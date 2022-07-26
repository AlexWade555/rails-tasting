class Product < ApplicationRecord
  belongs_to :user
  has_many :notes
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }
end
