//
//  OnlineTool.swift
//
//  Created by Nitin on 30/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class OnlineTool {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let id = "id"
    static let type = "type"
    static let url = "url"
  }

  // MARK: Properties
  public var title: String?
  public var id: String?
  public var type: String?
  public var url: String?

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
    title = json[SerializationKeys.title].string
    id = json[SerializationKeys.id].string
    type = json[SerializationKeys.type].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

}
