<!-- Project Shields -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

# Whether, Sweater?

## About The Project
"Whether, Sweater?" is a rails application that is the final solo project for Turing's mod three back-end program. This project gives current weather information for a given city and the weather for a road trip destination when a user arrives. "Whether, Sweater?" is a service-oriented project. We are responsible for consuming external APIs and exposing them in endpoints for a hypothetical front-end team to consume and expose to the end user. The back-end is developed based on JSON contracts and wireframes from our hypothetical front-end team. 

Learn more about this project from the assigment page [here](https://backend.turing.edu/module3/projects/sweater_weather/).

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

### Built With:
[![Ruby][Ruby]][Ruby-url]
[![Rails][Rails]][Rails-url]
[![PostgreSQL][Postgres]][Postgres-url]
[![VS Code][vs-code]][vs-code-url]

"Whether, Sweater?" is built with these API integerateions
- [Weather API](https://www.weatherapi.com/)
- [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [MapQuest’s Directions API](https://developer.mapquest.com/documentation/directions-api/)
- [OpenLibrary API](https://openlibrary.org/developers/api)

## Getting Started
To demo "Whether, Sweater?" on your local machine follow these steps:

1. Get a free MapQuest API key [here](https://developer.mapquest.com/documentation/)
  -- You will use this key for both the `geocoding` and the `directions` APIs from MapQuest.
2. Sign up for your free Weather API [here](https://www.weatherapi.com/)
3. Clone this repository
4. Run: `bundle install`
5. Run: `rails db:{create,migrate}`
6. Run: `bundle exec figaro install`
7. Add `WEATHER_API_KEY`, and `MAPQUEST_API_KEY` to `config/application.yml` file

### Prerequisites
- Ruby Version 3.1.1
- Rails Version 7.0.5

## Testing
 
`bundle exec rspec` will run the entire test suite. *All tests are passing at time of writing.*

The team tested happy paths, sad paths, and edge cases when needed. Error responses were added where applicable.

## Endpoints

### `GET /api/v0/forecast?location=`

**Request:**

*example*
 ```
GET /api/v0/forecast?location=cincinatti,oh
Content-Type: application/json
Accept: application/json
```

**Response:**

*Example*
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
```

### `POST /api/v0/users`
**Request:**

*Example*
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response:**

*Example*
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### `POST /api/v0/sessions`
**Request:**

*example*
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

**Response:**

*example*
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
### `POST /api/v0/road_trip`

**Request:**

*example*
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```

**Response:**

*example*
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/SMcPhee19/whether-sweater.svg?style=for-the-badge
[contributors-url]: https://github.com/SMcPhee19/whether-sweater/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/SMcPhee19/whether-sweater.svg?style=for-the-badge
[forks-url]: https://github.com/SMcPhee19/whether-sweater/network/members
[stars-shield]: https://img.shields.io/github/stars/SMcPhee19/whether-sweater.svg?style=for-the-badge
[stars-url]: https://github.com/SMcPhee19/whether-sweater/stargazers
[issues-shield]: https://img.shields.io/github/issues/SMcPhee19/whether-sweater.svg?style=for-the-badge
[issues-url]: https://github.com/SMcPhee19/whether-sweater/issues
[license-shield]: https://img.shields.io/github/license/SMcPhee19/whether-sweater.svg?style=for-the-badge
[Ruby]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[Ruby-url]: https://www.ruby-lang.org/en/
[Rails]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/
[Postgres]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/
[vs-code]: https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white
[vs-code-url]: https://code.visualstudio.com/
