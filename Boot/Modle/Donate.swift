//
//  Donate.swift
//
//  Created by Nitin on 30/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Donate {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let iD = "ID"
    static let donateInstruction = "donate_instruction"
    static let bankAccountName = "bank_account_name"
    static let paymentInstruction = "payment_instruction"
    static let bankAccountNumber = "bank_account_number"
  }

  // MARK: Properties
  public var iD: String?
  public var donateInstruction: String?
  public var bankAccountName: String?
  public var paymentInstruction: String?
  public var bankAccountNumber: String?

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
    iD = json[SerializationKeys.iD].string
    donateInstruction = json[SerializationKeys.donateInstruction].string
    bankAccountName = json[SerializationKeys.bankAccountName].string
    paymentInstruction = json[SerializationKeys.paymentInstruction].string
    bankAccountNumber = json[SerializationKeys.bankAccountNumber].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = iD { dictionary[SerializationKeys.iD] = value }
    if let value = donateInstruction { dictionary[SerializationKeys.donateInstruction] = value }
    if let value = bankAccountName { dictionary[SerializationKeys.bankAccountName] = value }
    if let value = paymentInstruction { dictionary[SerializationKeys.paymentInstruction] = value }
    if let value = bankAccountNumber { dictionary[SerializationKeys.bankAccountNumber] = value }
    return dictionary
  }

}
