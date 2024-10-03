//
//  APIOpenWeatherMap.swift
//  OpenWeatherMap
//
//  Created by Olaf on 02.10.24.
//

import Foundation

/**
 This method is used for receiving the aggregated measurements from the station. In total are supported 3 types of units - minute, hour and day. Thus, there is possible to query history of measurements from the station for any interval of time with the necessary specification.

 At the moment the aggregation uses the fixed list of parameters from the collection of measurements - temperature, humidity, pressure, speed and wind direction, precipitation. In the future this list will extend.

 The following parameters are mandatory in the request - an interval of measurements, the internal identifier of the station, type of the unit and the maximum number of records which can be returned. They are transferred in a line of GET-request as parameters.
 */







struct Stations: Codable{
    var id: String
    var created_at: String
    var updated_at: String
    var external_id: String
    var name: String
    var longitude: Double
    var latitude: Double
    var altitude: Double
    var rank: Int
}


/**
 JSON format API response fields

 - coord
    - coord.lon Longitude of the location
    - coord.lat Latitude of the location
 - weather (more info Weather condition codes)
    - weather.id Weather condition id
    - weather.main Group of weather parameters (Rain, Snow, Clouds etc.)
    - weather.description Weather condition within the group. Please find more here. You can get the output in your language. Learn more
    - weather.icon Weather icon id
 base Internal parameter
 main
 main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
 main.feels_like Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
 main.pressure Atmospheric pressure on the sea level, hPa
 main.humidity Humidity, %
 main.temp_min Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Please find more info here. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
 main.temp_max Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Please find more info here. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
 main.sea_level Atmospheric pressure on the sea level, hPa
 main.grnd_level Atmospheric pressure on the ground level, hPa
 visibility Visibility, meter. The maximum value of the visibility is 10 km
 wind
 wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
 wind.deg Wind direction, degrees (meteorological)
 wind.gust Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
 clouds
 clouds.all Cloudiness, %
 rain
 1h(where available)Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
 snow
 1h(where available) Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
 dt Time of data calculation, unix, UTC
 sys
 sys.type Internal parameter
 sys.id Internal parameter
 sys.message Internal parameter
 sys.country Country code (GB, JP etc.)
 sys.sunrise Sunrise time, unix, UTC
 sys.sunset Sunset time, unix, UTC
 timezone Shift in seconds from UTC
 id City ID. Please note that built-in geocoder functionality has been deprecated. Learn more here
 name City name. Please note that built-in geocoder functionality has been deprecated. Learn more here
 cod Internal parameter

 */
struct Current: Codable{
    var main: Main
    var rain: Rain?
    var snow: Snow?
    var wind: Wind
    var weather: [Weather]
    
}

/**
 "weather": [
      {
         "id": 501,
         "main": "Rain",
         "description": "moderate rain",
         "icon": "10d"
      }
   ],
 */
struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}
/**
 "main": {
       "temp": 284.2,
       "feels_like": 282.93,
       "temp_min": 283.06,
       "temp_max": 286.82,
       "pressure": 1021,
       "humidity": 60,
       "sea_level": 1021,
       "grnd_level": 910
    },
 */
struct Main: Codable
{
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    var sea_level: Int
    var grnd_level: Int
}

struct Wind: Codable{
    var speed: Double
    var deg: Int
    var gust: Double
}


struct Rain: Codable{
    var houre: Double
    
    enum CodingKeys: String, CodingKey {
        case houre = "1h" // You can use "date" instead of "20170101".
    }
    
    func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(houre, forKey: .houre)

     }
    
    init(houre: Double) {
      self.houre = houre

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        houre = try container.decode(Double.self, forKey: .houre)

      }
}

struct Snow: Codable{
    var houre: Double
    
    enum CodingKeys: String, CodingKey {
        case houre = "1h" // You can use "date" instead of "20170101".
    }
    
    func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(houre, forKey: .houre)

     }
    
    init(houre: Double) {
      self.houre = houre

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        houre = try container.decode(Double.self, forKey: .houre)

      }
}
struct Sys: Codable{
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    
}




struct FiveDayForecast: Codable{
    var list: [ListForecast]
    var city: City
}

struct ListForecast: Codable{
    var dt: Int
    var main: Main
    var weather: [Weather]
    var rain: Rain3h?
    var pop: Double
}

struct Rain3h: Codable{
    var houre: Double
    
    enum CodingKeys: String, CodingKey {
        case houre = "3h" // You can use "date" instead of "20170101".
    }
    
    func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(houre, forKey: .houre)

     }
    
    init(houre: Double) {
      self.houre = houre

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        houre = try container.decode(Double.self, forKey: .houre)

      }
}

struct City: Codable{
    var name: String
}
