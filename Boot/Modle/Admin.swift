//
//  Admin.swift
//
//  Created by Nitin on 03/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Admin {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tokenPasskey = "token_passkey"
    static let email = "email"
    static let id = "id"
    static let admistrator = "admistrator"
    static let password = "password"
    static let imeiNumber = "imei_number"
  }

  // MARK: Properties
  public var tokenPasskey: String?
  public var email: String?
  public var id: String?
  public var admistrator: String?
  public var password: String?
  public var imeiNumber: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    tokenPasskey = json[SerializationKeys.tokenPasskey].string
    email = json[SerializationKeys.email].string
    id = json[SerializationKeys.id].string
    admistrator = json[SerializationKeys.admistrator].string
    password = json[SerializationKeys.password].string
    imeiNumber = json[SerializationKeys.imeiNumber].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tokenPasskey { dictionary[SerializationKeys.tokenPasskey] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = admistrator { dictionary[SerializationKeys.admistrator] = value }
    if let value = password { dictionary[SerializationKeys.password] = value }
    if let value = imeiNumber { dictionary[SerializationKeys.imeiNumber] = value }
    return dictionary
  }

}
