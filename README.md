
# CatBNB

[Live](http://catbnb.us)

![Front Page](/public/cover.jpg)

CatBNB is a full-stack web application inspired by AirBNB. It utilizes Ruby on Rails on the backend, a PostgreSQL database, and React.js with a Redux architectural framework on the frontend.

## Features and Implementation

### Map Search

One of the highlights of this project was creating a flexible map that displays all the listing within the containing boundaries. Changing in the map boundaries by dragging the cursor should instantaneously trigger an AJAX request that then updates the state of the application through Redux's reducer function. Then, once updated, the listings (on left) and price points should refresh to display information of listing on the map.

What I really enjoyed was creating specific price points on the map. This was possible by creating a png file (through some finagling) and passing in the price of each listing to the Google map.

In addition, I realized that the listings on the left half took some time to load, and this gave incorrect information (old information as the map was updating). I didn't want the user to think this information was valid, so I found a way to "hide" the content with an overlay and loading gif, that way, users know that the information is being loaded from the the server. The overlay is removed when the search has finished updating.

![Map Search](/public/map.jpg)

### Rendering Listings

Users should see a beautiful display of pertinent information of each listing. What is essential is gathering information from the state and rendering it in a coherent, aesthetically-pleasing way that doesn't break on different screen sizes. There are over 34 attributes from state to render on the screen, including potentially dozens reviews.

![Listing](/public/listing.jpg)

Sample state:

![State](/public/state.jpg)

I had to figure out a way to add and remove CSS properties in React to get the strike-through lines and font weight of amenities. This was done through Javascript introduced CSS styling.

```javascript
renderStyle(bool) {
  if (bool) {
    return {
      textDecoration: "line-through",
      fontWeight: 300
    }
  } else {
    return { fontWeight: "500"}
  }
}
```

![Amenities](/public/amenities.jpg)

Clicking Write Review renders a form component that immediately updates state when a review is written, so that the review can be seen without refreshing the page.

### Adding Listings

Users should be able to add a listing, and I accomplished this by introducing a new React component that overlays, when activated, over the main page. Users are denied access to this modal if they are not logged in.

There is front-end verification that ensures that the user has typed in proper information. With more time, I would like to introduce backend error propagation through errors reducers to ensure that only valid addresses can be added as listings.

![Add Listing](/public/add-listing.jpg)

### Navigation

A crucial part of user experience is a navigations bar that responds quickly to user actions. I used setState properties in React to allow components to render immediately when the user clicks a button. "Host Your Spot", "Trips", "Visitors", "Profile", "Become a Host", "Log In", and "Sign Up" are all wired so that the components render appropriately when clicked. This was a major performance improvement over a method with jQuery I used earlier.

### Search and Autocomplete

I wanted to ensure that users could search popular destinations without having to typing it out specific, so one of the first things I did was populate the database with popular locations in California, like San Francisco and Los Angeles. I then used a Ruby gem called Geocoder that automatically inserts Latitude and Longitude to each of the cities and locales, which allows the user to see the location on the map instantly.

The server is a bit slow, but if you types "S" in the search bar, it will slowly process all locations that start with "S" and display them as an unordered list over the search component.

![Search](/public/search.jpg)

### Stars

This took some more effort that I had imagined to create Stars, because I wanted to offer the user two ways of seeing a listing's rating: By precise number (to two decimal places), as well as a 5 stars count, which rounds to the nearest 0.5.

I created a Stars component that could be reused, which takes the rating in precise number to be parsed in a stars count. I also used some complex logic to help differentiate between a half-star and a full-star. See code below:

```javascript
class Stars extends React.Component {
  renderHalfStar(truth) {
    if (truth) {
      return <img src="http://res.cloudinary.com/mwong9968/image/upload/v1506384102/half-star_ciyzbg.png"/>
    } else {
      return
    }
  }

  render() {
    let half_star, full_stars, empty_stars;

    if (this.props.num == 0) {
      return (
        <div className="no-stars">No reviews yet.</div>
      )
    }

    if (parseFloat(this.props.num) % 1 != 0) {
      half_star = true;
      full_stars = parseInt(this.props.num.slice(0,1));
      empty_stars = 4 - full_stars;
    } else {
      half_star = false;
      full_stars = parseInt(this.props.num.slice(0,1));
      empty_stars = 5 - full_stars;
    }

    let stars_array = [];
    for(let i = 0; i < full_stars; i++) {
      stars_array.push("star");
    }

    let empty_stars_array = [];
    for(let i = 0; i < empty_stars; i++) {
      empty_stars_array.push("star");
    }

    return(
      <div className="stars">
        {stars_array.map( (_, idx) => (<img key={idx} src='http://res.cloudinary.com/mwong9968/image/upload/v1506384098/full-star_o1vvcd.png' ></img>))}
        {this.renderHalfStar(half_star)}
        {empty_stars_array.map( (_, idx) => (
          <img key={idx} src='http://res.cloudinary.com/mwong9968/image/upload/v1506384093/empty-star_fprlrb.png' ></img>
        ))}
      </div>
    )
  }
}
```

## Future Direction on Project

In addition to the features already implemented, I plan to continue work on this project. The next steps for HairBNB are outlined below.

### Profiles

Profiles are a standard feature on AirBNB and inform guests about the person hosting them. I will add a profiles page that allows the user to share public information with other users they interact with, once a connection is made.

### Host Approval

Hosts should be able to accept or decline requests from other users. I would like to create a way for hosts to validating a reservation.

### Uploading pictures and gallery

It would be amazing to allow users to view multiple pictures of a listing, instead of just the cover image. I managed to create galleries for my other projects, and with some more time I would like to create a JavaScript gallery to display multiple pictures of the listing.

### Fixed Reservation Box

I would also like to make the reservation box fixed, so that the box continues to appear on the screen as the viewer scrolls down the page.
