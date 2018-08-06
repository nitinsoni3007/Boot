//
//  ElectivePosition.swift
//
//  Created by Nitin on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ElectivePosition {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let id = "id"
    static let localGov = "local_gov"
    static let electionCode = "election_code"
    static let electionPicUrl = "election_pic_url"
    static let startDate = "start_date"
    static let endDate = "end_date"
    static let electionName = "election_name"
  }

  // MARK: Properties
  public var status: String?
  public var id: String?
  public var localGov: String?
  public var electionCode: String?
  public var electionPicUrl: String?
  public var startDate: String?
  public var endDate: String?
  public var electionName: String?

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
    status = json[SerializationKeys.status].string
    id = json[SerializationKeys.id].string
    localGov = json[SerializationKeys.localGov].string
    electionCode = json[SerializationKeys.electionCode].string
    electionPicUrl = json[SerializationKeys.electionPicUrl].string
    startDate = json[SerializationKeys.startDate].string
    endDate = json[SerializationKeys.endDate].string
    electionName = json[SerializationKeys.electionName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = localGov { dictionary[SerializationKeys.localGov] = value }
    if let value = electionCode { dictionary[SerializationKeys.electionCode] = value }
    if let value = electionPicUrl { dictionary[SerializationKeys.electionPicUrl] = value }
    if let value = startDate { dictionary[SerializationKeys.startDate] = value }
    if let value = endDate { dictionary[SerializationKeys.endDate] = value }
    if let value = electionName { dictionary[SerializationKeys.electionName] = value }
    return dictionary
  }

}
