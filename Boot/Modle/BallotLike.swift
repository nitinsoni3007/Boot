//
//  BallotLike.swift
//
//  Created by Nitin on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class BallotLike {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let iD = "ID"
    static let linkedinUrl = "linkedin_url"
    static let voteContent = "vote_content"
    static let youtubeUrl = "youtube_url"
    static let facebookUrl = "facebook_url"
    static let likeHeading = "like_heading"
    static let voteHeading = "vote_heading"
    static let twitterUrl = "twitter_url"
    static let instagramUrl = "instagram_url"
    static let likeContent = "like_content"
  }

  // MARK: Properties
  public var iD: String?
  public var linkedinUrl: String?
  public var voteContent: String?
  public var youtubeUrl: String?
  public var facebookUrl: String?
  public var likeHeading: String?
  public var voteHeading: String?
  public var twitterUrl: String?
  public var instagramUrl: String?
  public var likeContent: String?

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
    linkedinUrl = json[SerializationKeys.linkedinUrl].string
    voteContent = json[SerializationKeys.voteContent].string
    youtubeUrl = json[SerializationKeys.youtubeUrl].string
    facebookUrl = json[SerializationKeys.facebookUrl].string
    likeHeading = json[SerializationKeys.likeHeading].string
    voteHeading = json[SerializationKeys.voteHeading].string
    twitterUrl = json[SerializationKeys.twitterUrl].string
    instagramUrl = json[SerializationKeys.instagramUrl].string
    likeContent = json[SerializationKeys.likeContent].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = iD { dictionary[SerializationKeys.iD] = value }
    if let value = linkedinUrl { dictionary[SerializationKeys.linkedinUrl] = value }
    if let value = voteContent { dictionary[SerializationKeys.voteContent] = value }
    if let value = youtubeUrl { dictionary[SerializationKeys.youtubeUrl] = value }
    if let value = facebookUrl { dictionary[SerializationKeys.facebookUrl] = value }
    if let value = likeHeading { dictionary[SerializationKeys.likeHeading] = value }
    if let value = voteHeading { dictionary[SerializationKeys.voteHeading] = value }
    if let value = twitterUrl { dictionary[SerializationKeys.twitterUrl] = value }
    if let value = instagramUrl { dictionary[SerializationKeys.instagramUrl] = value }
    if let value = likeContent { dictionary[SerializationKeys.likeContent] = value }
    return dictionary
  }

}
