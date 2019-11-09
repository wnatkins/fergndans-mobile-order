//
// CheckoutAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class CheckoutAPI {
    /**
     CreateCheckout
     - parameter body: (body) An object containing the fields to POST for the request.

See the corresponding object definition for field details.      - parameter locationId: (path) The ID of the business location to associate the checkout with. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createCheckout(body: CreateCheckoutRequest, locationId: String, completion: @escaping ((_ data: CreateCheckoutResponse?,_ error: Error?) -> Void)) {
        createCheckoutWithRequestBuilder(body: body, locationId: locationId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     CreateCheckout
     - POST /v2/locations/{location_id}/checkouts
     - Links a `checkoutId` to a `checkout_page_url` that customers will be directed to in order to provide their payment information using a payment processing workflow hosted on connect.squareup.com.
     - OAuth:
       - type: oauth2
       - name: oauth2
     - examples: [{contentType=application/json, example={
  "checkout" : {
    "id" : "CAISEHGimXh-C3RIT4og1a6u1qw",
    "checkout_page_url" : "https://connect.squareup.com/v2/checkout?c=CAISEHGimXh-C3RIT4og1a6u1qw&l=CYTKRM7R7JMV8",
    "ask_for_shipping_address" : true,
    "merchant_support_email" : "merchant+support@website.com",
    "pre_populate_buyer_email" : "example@email.com",
    "pre_populate_shipping_address" : {
      "address_line_1" : "1455 Market St.",
      "address_line_2" : "Suite 600",
      "locality" : "San Francisco",
      "administrative_district_level_1" : "CA",
      "postal_code" : "94103",
      "country" : "US",
      "first_name" : "Jane",
      "last_name" : "Doe"
    },
    "redirect_url" : "https://merchant.website.com/order-confirm",
    "order" : {
      "location_id" : "CYTKRM7R7JMV8",
      "reference_id" : "reference_id",
      "line_items" : [ {
        "name" : "Printed T Shirt",
        "quantity" : "2",
        "taxes" : [ {
          "name" : "Sales Tax",
          "type" : "ADDITIVE",
          "percentage" : "8.5",
          "applied_money" : {
            "amount" : 103,
            "currency" : "USD"
          }
        } ],
        "discounts" : [ {
          "name" : "7% off previous season item",
          "type" : "FIXED_PERCENTAGE",
          "percentage" : "7",
          "applied_money" : {
            "amount" : 210,
            "currency" : "USD"
          },
          "scope" : "LINE_ITEM"
        }, {
          "name" : "Father's day 12% OFF",
          "type" : "FIXED_PERCENTAGE",
          "percentage" : "12",
          "applied_money" : {
            "amount" : 335,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        }, {
          "name" : "$3 off Customer Discount",
          "type" : "FIXED_AMOUNT",
          "amount_money" : {
            "amount" : 300,
            "currency" : "USD"
          },
          "applied_money" : {
            "amount" : 300,
            "currency" : "USD"
          },
          "scope" : "LINE_ITEM"
        }, {
          "name" : "Global Sales $55 OFF",
          "type" : "FIXED_AMOUNT",
          "amount_money" : {
            "amount" : 5500,
            "currency" : "USD"
          },
          "applied_money" : {
            "amount" : 949,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        } ],
        "base_price_money" : {
          "amount" : 1500,
          "currency" : "USD"
        },
        "total_tax_money" : {
          "amount" : 103,
          "currency" : "USD"
        },
        "total_discount_money" : {
          "amount" : 1794,
          "currency" : "USD"
        },
        "total_money" : {
          "amount" : 1309,
          "currency" : "USD"
        }
      }, {
        "name" : "Slim Jeans",
        "quantity" : "1",
        "taxes" : [ {
          "name" : "Sales Tax",
          "type" : "ADDITIVE",
          "percentage" : "8.5",
          "applied_money" : {
            "amount" : 105,
            "currency" : "USD"
          }
        } ],
        "discounts" : [ {
          "name" : "Father's day 12% OFF",
          "type" : "FIXED_PERCENTAGE",
          "percentage" : "12",
          "applied_money" : {
            "amount" : 300,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        }, {
          "name" : "Global Sales $55 OFF",
          "type" : "FIXED_AMOUNT",
          "amount_money" : {
            "amount" : 5500,
            "currency" : "USD"
          },
          "applied_money" : {
            "amount" : 968,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        } ],
        "base_price_money" : {
          "amount" : 2500,
          "currency" : "USD"
        },
        "total_tax_money" : {
          "amount" : 105,
          "currency" : "USD"
        },
        "total_discount_money" : {
          "amount" : 1268,
          "currency" : "USD"
        },
        "total_money" : {
          "amount" : 1337,
          "currency" : "USD"
        }
      }, {
        "name" : "Wooven Sweater",
        "quantity" : "3",
        "taxes" : [ {
          "name" : "Fair Trade Tax",
          "type" : "ADDITIVE",
          "percentage" : "5",
          "applied_money" : {
            "amount" : 228,
            "currency" : "USD"
          }
        }, {
          "name" : "Sales Tax",
          "type" : "ADDITIVE",
          "percentage" : "8.5",
          "applied_money" : {
            "amount" : 387,
            "currency" : "USD"
          }
        } ],
        "discounts" : [ {
          "name" : "Father's day 12% OFF",
          "type" : "FIXED_PERCENTAGE",
          "percentage" : "12",
          "applied_money" : {
            "amount" : 1260,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        }, {
          "name" : "$11 off Customer Discount",
          "type" : "FIXED_AMOUNT",
          "amount_money" : {
            "amount" : 1100,
            "currency" : "USD"
          },
          "applied_money" : {
            "amount" : 1100,
            "currency" : "USD"
          },
          "scope" : "LINE_ITEM"
        }, {
          "name" : "Global Sales $55 OFF",
          "type" : "FIXED_AMOUNT",
          "amount_money" : {
            "amount" : 5500,
            "currency" : "USD"
          },
          "applied_money" : {
            "amount" : 3583,
            "currency" : "USD"
          },
          "scope" : "ORDER"
        } ],
        "base_price_money" : {
          "amount" : 3500,
          "currency" : "USD"
        },
        "total_tax_money" : {
          "amount" : 615,
          "currency" : "USD"
        },
        "total_discount_money" : {
          "amount" : 5943,
          "currency" : "USD"
        },
        "total_money" : {
          "amount" : 5172,
          "currency" : "USD"
        }
      } ],
      "total_money" : {
        "amount" : 7818,
        "currency" : "USD"
      },
      "total_tax_money" : {
        "amount" : 823,
        "currency" : "USD"
      },
      "total_discount_money" : {
        "amount" : 9005,
        "currency" : "USD"
      }
    },
    "created_at" : "2017-06-16T22:25:35Z",
    "additional_recipients" : [ {
      "location_id" : "057P5VYJ4A5X1",
      "description" : "Application fees",
      "amount_money" : {
        "amount" : 60,
        "currency" : "USD"
      }
    } ]
  }
}}]
     - parameter body: (body) An object containing the fields to POST for the request.

See the corresponding object definition for field details.      - parameter locationId: (path) The ID of the business location to associate the checkout with. 

     - returns: RequestBuilder<CreateCheckoutResponse> 
     */
    open class func createCheckoutWithRequestBuilder(body: CreateCheckoutRequest, locationId: String) -> RequestBuilder<CreateCheckoutResponse> {
        var path = "/v2/locations/{location_id}/checkouts"
        let locationIdPreEscape = "\(locationId)"
        let locationIdPostEscape = locationIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{location_id}", with: locationIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<CreateCheckoutResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
