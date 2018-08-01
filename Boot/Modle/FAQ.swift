//
//  FAQ.swift
//
//  Created by Nitin on 01/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class FAQ {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let iD = "ID"
    static let answer = "answer"
    static let entrydate = "entrydate"
    static let question = "question"
  }

  // MARK: Properties
  public var iD: String?
  public var answer: String?
  public var entrydate: String?
  public var question: String?

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
    answer = json[SerializationKeys.answer].string
    entrydate = json[SerializationKeys.entrydate].string
    question = json[SerializationKeys.question].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = iD { dictionary[SerializationKeys.iD] = value }
    if let value = answer { dictionary[SerializationKeys.answer] = value }
    if let value = entrydate { dictionary[SerializationKeys.entrydate] = value }
    if let value = question { dictionary[SerializationKeys.question] = value }
    return dictionary
  }

}
