//
// LocationsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class LocationsAPI {
    /**
     ListLocations

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listLocations(completion: @escaping ((_ data: ListLocationsResponse?,_ error: Error?) -> Void)) {
        listLocationsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     ListLocations
     - GET /v2/locations
     - Provides the details for all of a business's locations.  Most other Connect API endpoints have a required `location_id` path parameter. The `id` field of the [`Location`](#type-location) objects returned by this endpoint correspond to that `location_id` parameter.
     - OAuth:
       - type: oauth2
       - name: oauth2
     - examples: [{contentType=application/json, example={
  "locations" : [ {
    "id" : "18YC4JDH91E1H",
    "name" : "your location name",
    "address" : {
      "address_line_1" : "123 Main St",
      "locality" : "San Francisco",
      "administrative_district_level_1" : "CA",
      "postal_code" : "94114",
      "country" : "US"
    },
    "timezone" : "America/Los_Angeles",
    "capabilities" : [ "CREDIT_CARD_PROCESSING" ],
    "status" : "ACTIVE",
    "created_at" : "2016-09-19T17:33:12Z",
    "merchant_id" : "3MYCJG5GVYQ8Q",
    "country" : "US",
    "language_code" : "en-US",
    "currency" : "USD",
    "phone_number" : "+1 650-354-7217",
    "business_name" : "Pumbaa's business name"
  } ]
}}]

     - returns: RequestBuilder<ListLocationsResponse> 
     */
    open class func listLocationsWithRequestBuilder() -> RequestBuilder<ListLocationsResponse> {
        let path = "/v2/locations"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<ListLocationsResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
