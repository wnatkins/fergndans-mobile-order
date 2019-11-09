//
// ApplePayAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class ApplePayAPI {
    /**
     RegisterDomain
     - parameter body: (body) An object containing the fields to POST for the request.

See the corresponding object definition for field details. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func registerDomain(body: RegisterDomainRequest, completion: @escaping ((_ data: RegisterDomainResponse?,_ error: Error?) -> Void)) {
        registerDomainWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     RegisterDomain
     - POST /v2/apple-pay/domains
     - Activates a domain for use with Web Apple Pay and Square. A validation will be performed on this domain by Apple to ensure is it properly set up as an Apple Pay enabled domain.  This endpoint provides an easy way for platform developers to bulk activate Web Apple Pay with Square for merchants using their platform.  To learn more about Apple Pay on Web see the Apple Pay section in the [Embedding the Square Payment Form](/payment-form/add-digital-wallets/apple-pay) guide.
     - OAuth:
       - type: oauth2
       - name: oauth2
     - examples: [{contentType=application/json, example={
  "status" : "VERIFIED"
}}]
     - parameter body: (body) An object containing the fields to POST for the request.

See the corresponding object definition for field details. 

     - returns: RequestBuilder<RegisterDomainResponse> 
     */
    open class func registerDomainWithRequestBuilder(body: RegisterDomainRequest) -> RequestBuilder<RegisterDomainResponse> {
        let path = "/v2/apple-pay/domains"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<RegisterDomainResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
