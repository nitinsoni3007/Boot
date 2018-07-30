//
//  Intro.swift
//
//  Created by Nitin on 30/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Intro {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descriptionValue = "description"
    static let status = "status"
    static let title = "title"
    static let sno = "sno"
  }

  // MARK: Properties
  public var descriptionValue: String?
  public var status: String?
  public var title: String?
  public var sno: String?

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
    descriptionValue = json[SerializationKeys.descriptionValue].string
    status = json[SerializationKeys.status].string
    title = json[SerializationKeys.title].string
    sno = json[SerializationKeys.sno].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = sno { dictionary[SerializationKeys.sno] = value }
    return dictionary
  }

}
