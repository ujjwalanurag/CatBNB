import React from 'react';

import FilterForm from './filter_form';
import ListingIndex from './listing_index';
import ListingMap from './listing_map';

const Search = ({updateFilter, listings, lat, lng, minPrice, maxPrice, minBeds, lb}) => (
  <div className="search">
    <div className="left-half">
      <FilterForm
        updateFilter={updateFilter}
        minPrice={minPrice}
        maxPrice={maxPrice}
        minBeds={minBeds}/>
      <ListingIndex
        listings={listings}/>
    </div>
    <div className="position-me">
      <div className='loader'>Loading...

      </div>
    </div>
    <div className="right-half">
      <ListingMap
          listings={listings}
          updateFilter={updateFilter}
          lat={lat}
          lng={lng}/>
    </div>
  </div>
)

export default Search;
