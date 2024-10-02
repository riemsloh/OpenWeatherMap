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
