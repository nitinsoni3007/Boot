//
//  Candidate.swift
//
//  Created by Nitin on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Candidate {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let candidateno = "candidateno"
    static let electionname = "electionname"
    static let candidatePicUrl = "candidate_pic_url"
    static let electionno = "electionno"
    static let candidatename = "candidatename"
    static let electionposition = "electionposition"
  }

  // MARK: Properties
  public var candidateno: String?
  public var electionname: String?
  public var candidatePicUrl: String?
  public var electionno: String?
  public var candidatename: String?
  public var electionposition: String?

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
    candidateno = json[SerializationKeys.candidateno].string
    electionname = json[SerializationKeys.electionname].string
    candidatePicUrl = json[SerializationKeys.candidatePicUrl].string
    electionno = json[SerializationKeys.electionno].string
    candidatename = json[SerializationKeys.candidatename].string
    electionposition = json[SerializationKeys.electionposition].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = candidateno { dictionary[SerializationKeys.candidateno] = value }
    if let value = electionname { dictionary[SerializationKeys.electionname] = value }
    if let value = candidatePicUrl { dictionary[SerializationKeys.candidatePicUrl] = value }
    if let value = electionno { dictionary[SerializationKeys.electionno] = value }
    if let value = candidatename { dictionary[SerializationKeys.candidatename] = value }
    if let value = electionposition { dictionary[SerializationKeys.electionposition] = value }
    return dictionary
  }

}
