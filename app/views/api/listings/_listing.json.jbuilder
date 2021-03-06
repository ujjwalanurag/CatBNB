json.extract! listing, :id, :latitude, :longitude, :title, :description, :host_id, :street_address, :city, :zip, :country, :apt, :price, :cover_img_url, :deluxe_bed, :house_dog_friend, :gourmet_meals, :free_grooming, :maze_playground, :air_conditioning, :laser_tag, :natural_light, :cuddling_partner, :spay_neuter, :vaccinated, :flea, :peeing, :shedding, :meowing, :max_cats

json.reviews do
  json.partial! 'api/reviews/review', collection: listing.reviews, as: :review
end
