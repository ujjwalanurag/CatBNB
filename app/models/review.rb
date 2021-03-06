class Review < ApplicationRecord
  validates :listing_id, :guest_id, :rating, :description, presence: true
  validates :rating, inclusion: { in: (1..5) }

  belongs_to :guest,
  primary_key: :id,
  foreign_key: :guest_id,
  class_name: :User

  belongs_to :listing,
  primary_key: :id,
  foreign_key: :listing_id,
  class_name: :Listing
end
