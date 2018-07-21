//
//  Event.swift
//
//  Created by Nitin on 21/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Event {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reserved = "reserved"
    static let reservation = "reservation"
    static let descriptionValue = "description"
    static let meetingtype = "meetingtype"
    static let iD = "ID"
    static let speakersImg = "speakers_img"
    static let latitude = "latitude"
    static let location = "location"
    static let speakersName = "speakers_name"
    static let eventno = "eventno"
    static let endtime = "endtime"
    static let starttime = "starttime"
    static let title = "title"
    static let longitude = "longitude"
  }

  // MARK: Properties
  public var reserved: String?
  public var reservation: String?
  public var descriptionValue: String?
  public var meetingtype: String?
  public var iD: String?
  public var speakersImg: String?
  public var latitude: String?
  public var location: String?
  public var speakersName: String?
  public var eventno: String?
  public var endtime: String?
  public var starttime: String?
  public var title: String?
  public var longitude: String?

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
    reserved = json[SerializationKeys.reserved].string
    reservation = json[SerializationKeys.reservation].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    meetingtype = json[SerializationKeys.meetingtype].string
    iD = json[SerializationKeys.iD].string
    speakersImg = json[SerializationKeys.speakersImg].string
    latitude = json[SerializationKeys.latitude].string
    location = json[SerializationKeys.location].string
    speakersName = json[SerializationKeys.speakersName].string
    eventno = json[SerializationKeys.eventno].string
    endtime = json[SerializationKeys.endtime].string
    starttime = json[SerializationKeys.starttime].string
    title = json[SerializationKeys.title].string
    longitude = json[SerializationKeys.longitude].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reserved { dictionary[SerializationKeys.reserved] = value }
    if let value = reservation { dictionary[SerializationKeys.reservation] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = meetingtype { dictionary[SerializationKeys.meetingtype] = value }
    if let value = iD { dictionary[SerializationKeys.iD] = value }
    if let value = speakersImg { dictionary[SerializationKeys.speakersImg] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = speakersName { dictionary[SerializationKeys.speakersName] = value }
    if let value = eventno { dictionary[SerializationKeys.eventno] = value }
    if let value = endtime { dictionary[SerializationKeys.endtime] = value }
    if let value = starttime { dictionary[SerializationKeys.starttime] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    return dictionary
  }

}
