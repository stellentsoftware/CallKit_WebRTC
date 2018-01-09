//  This file was automatically generated and should not be edited.

import Apollo

public final class InitiateCallMutation: GraphQLMutation {
  public static let operationString =
    "mutation InitiateCall($caller: String, $receiver: String, $handleName: String, $UUID: String) {\n  initiateCall(caller: $caller, receiver: $receiver, handleName: $handleName, UUID: $UUID) {\n    __typename\n    ...NotificationDetails\n  }\n}"

  public static var requestString: String { return operationString.appending(NotificationDetails.fragmentString) }

  public var caller: String?
  public var receiver: String?
  public var handleName: String?
  public var UUID: String?

  public init(caller: String? = nil, receiver: String? = nil, handleName: String? = nil, UUID: String? = nil) {
    self.caller = caller
    self.receiver = receiver
    self.handleName = handleName
    self.UUID = UUID
  }

  public var variables: GraphQLMap? {
    return ["caller": caller, "receiver": receiver, "handleName": handleName, "UUID": UUID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("initiateCall", arguments: ["caller": GraphQLVariable("caller"), "receiver": GraphQLVariable("receiver"), "handleName": GraphQLVariable("handleName"), "UUID": GraphQLVariable("UUID")], type: .object(InitiateCall.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(initiateCall: InitiateCall? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "initiateCall": initiateCall.flatMap { $0.snapshot }])
    }

    public var initiateCall: InitiateCall? {
      get {
        return (snapshot["initiateCall"] as? Snapshot).flatMap { InitiateCall(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "initiateCall")
      }
    }

    public struct InitiateCall: GraphQLSelectionSet {
      public static let possibleTypes = ["notificationType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .scalar(GraphQLID.self)),
        GraphQLField("roomName", type: .scalar(String.self)),
        GraphQLField("receiver", type: .scalar(String.self)),
        GraphQLField("caller", type: .scalar(String.self)),
        GraphQLField("message", type: .scalar(String.self)),
        GraphQLField("error", type: .scalar(Bool.self)),
        GraphQLField("deviceToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, roomName: String? = nil, receiver: String? = nil, caller: String? = nil, message: String? = nil, error: Bool? = nil, deviceToken: String? = nil) {
        self.init(snapshot: ["__typename": "notificationType", "_id": id, "roomName": roomName, "receiver": receiver, "caller": caller, "message": message, "error": error, "deviceToken": deviceToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["_id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "_id")
        }
      }

      public var roomName: String? {
        get {
          return snapshot["roomName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "roomName")
        }
      }

      public var receiver: String? {
        get {
          return snapshot["receiver"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiver")
        }
      }

      public var caller: String? {
        get {
          return snapshot["caller"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "caller")
        }
      }

      public var message: String? {
        get {
          return snapshot["message"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var error: Bool? {
        get {
          return snapshot["error"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "error")
        }
      }

      public var deviceToken: String? {
        get {
          return snapshot["deviceToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "deviceToken")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var notificationDetails: NotificationDetails {
          get {
            return NotificationDetails(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class SignInMutation: GraphQLMutation {
  public static let operationString =
    "mutation SignIn($email: String, $password: String, $deviceToken: String) {\n  signIn(email: $email, password: $password, deviceToken: $deviceToken) {\n    __typename\n    ...UserDetails\n  }\n}"

  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var email: String?
  public var password: String?
  public var deviceToken: String?

  public init(email: String? = nil, password: String? = nil, deviceToken: String? = nil) {
    self.email = email
    self.password = password
    self.deviceToken = deviceToken
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password, "deviceToken": deviceToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("signIn", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "deviceToken": GraphQLVariable("deviceToken")], type: .object(SignIn.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(signIn: SignIn? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "signIn": signIn.flatMap { $0.snapshot }])
    }

    public var signIn: SignIn? {
      get {
        return (snapshot["signIn"] as? Snapshot).flatMap { SignIn(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "signIn")
      }
    }

    public struct SignIn: GraphQLSelectionSet {
      public static let possibleTypes = ["userType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("loginType", type: .scalar(String.self)),
        GraphQLField("rank", type: .scalar(String.self)),
        GraphQLField("relegiousObservance", type: .scalar(String.self)),
        GraphQLField("isSaved", type: .scalar(String.self)),
        GraphQLField("yearsOfExperience", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("bio", type: .scalar(String.self)),
        GraphQLField("loginStatus", type: .scalar(Bool.self)),
        GraphQLField("deviceToken", type: .scalar(String.self)),
        GraphQLField("message", type: .scalar(String.self)),
        GraphQLField("error", type: .scalar(Bool.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, name: String? = nil, email: String? = nil, loginType: String? = nil, rank: String? = nil, relegiousObservance: String? = nil, isSaved: String? = nil, yearsOfExperience: String? = nil, state: String? = nil, bio: String? = nil, loginStatus: Bool? = nil, deviceToken: String? = nil, message: String? = nil, error: Bool? = nil) {
        self.init(snapshot: ["__typename": "userType", "_id": id, "name": name, "email": email, "loginType": loginType, "rank": rank, "relegiousObservance": relegiousObservance, "isSaved": isSaved, "yearsOfExperience": yearsOfExperience, "state": state, "bio": bio, "loginStatus": loginStatus, "deviceToken": deviceToken, "message": message, "error": error])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["_id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var loginType: String? {
        get {
          return snapshot["loginType"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginType")
        }
      }

      public var rank: String? {
        get {
          return snapshot["rank"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "rank")
        }
      }

      public var relegiousObservance: String? {
        get {
          return snapshot["relegiousObservance"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "relegiousObservance")
        }
      }

      public var isSaved: String? {
        get {
          return snapshot["isSaved"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "isSaved")
        }
      }

      public var yearsOfExperience: String? {
        get {
          return snapshot["yearsOfExperience"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "yearsOfExperience")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var bio: String? {
        get {
          return snapshot["bio"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "bio")
        }
      }

      public var loginStatus: Bool? {
        get {
          return snapshot["loginStatus"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginStatus")
        }
      }

      public var deviceToken: String? {
        get {
          return snapshot["deviceToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "deviceToken")
        }
      }

      public var message: String? {
        get {
          return snapshot["message"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var error: Bool? {
        get {
          return snapshot["error"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "error")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var userDetails: UserDetails {
          get {
            return UserDetails(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class ListUsersQuery: GraphQLQuery {
  public static let operationString =
    "query ListUsers($limit: Int) {\n  listUsers(limit: $limit) {\n    __typename\n    ...UserDetails\n  }\n}"

  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var limit: Int?

  public init(limit: Int? = nil) {
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listUsers", arguments: ["limit": GraphQLVariable("limit")], type: .list(.object(ListUser.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listUsers: [ListUser?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "listUsers": listUsers.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var listUsers: [ListUser?]? {
      get {
        return (snapshot["listUsers"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { ListUser(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "listUsers")
      }
    }

    public struct ListUser: GraphQLSelectionSet {
      public static let possibleTypes = ["userType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("loginType", type: .scalar(String.self)),
        GraphQLField("rank", type: .scalar(String.self)),
        GraphQLField("relegiousObservance", type: .scalar(String.self)),
        GraphQLField("isSaved", type: .scalar(String.self)),
        GraphQLField("yearsOfExperience", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("bio", type: .scalar(String.self)),
        GraphQLField("loginStatus", type: .scalar(Bool.self)),
        GraphQLField("deviceToken", type: .scalar(String.self)),
        GraphQLField("message", type: .scalar(String.self)),
        GraphQLField("error", type: .scalar(Bool.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, name: String? = nil, email: String? = nil, loginType: String? = nil, rank: String? = nil, relegiousObservance: String? = nil, isSaved: String? = nil, yearsOfExperience: String? = nil, state: String? = nil, bio: String? = nil, loginStatus: Bool? = nil, deviceToken: String? = nil, message: String? = nil, error: Bool? = nil) {
        self.init(snapshot: ["__typename": "userType", "_id": id, "name": name, "email": email, "loginType": loginType, "rank": rank, "relegiousObservance": relegiousObservance, "isSaved": isSaved, "yearsOfExperience": yearsOfExperience, "state": state, "bio": bio, "loginStatus": loginStatus, "deviceToken": deviceToken, "message": message, "error": error])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["_id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var loginType: String? {
        get {
          return snapshot["loginType"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginType")
        }
      }

      public var rank: String? {
        get {
          return snapshot["rank"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "rank")
        }
      }

      public var relegiousObservance: String? {
        get {
          return snapshot["relegiousObservance"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "relegiousObservance")
        }
      }

      public var isSaved: String? {
        get {
          return snapshot["isSaved"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "isSaved")
        }
      }

      public var yearsOfExperience: String? {
        get {
          return snapshot["yearsOfExperience"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "yearsOfExperience")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var bio: String? {
        get {
          return snapshot["bio"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "bio")
        }
      }

      public var loginStatus: Bool? {
        get {
          return snapshot["loginStatus"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginStatus")
        }
      }

      public var deviceToken: String? {
        get {
          return snapshot["deviceToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "deviceToken")
        }
      }

      public var message: String? {
        get {
          return snapshot["message"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var error: Bool? {
        get {
          return snapshot["error"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "error")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var userDetails: UserDetails {
          get {
            return UserDetails(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class LogOutMutation: GraphQLMutation {
  public static let operationString =
    "mutation LogOut($_id: ID) {\n  logOut(_id: $_id) {\n    __typename\n    ...UserDetails\n  }\n}"

  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var _id: GraphQLID?

  public init(_id: GraphQLID? = nil) {
    self._id = _id
  }

  public var variables: GraphQLMap? {
    return ["_id": _id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("logOut", arguments: ["_id": GraphQLVariable("_id")], type: .object(LogOut.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(logOut: LogOut? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "logOut": logOut.flatMap { $0.snapshot }])
    }

    public var logOut: LogOut? {
      get {
        return (snapshot["logOut"] as? Snapshot).flatMap { LogOut(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "logOut")
      }
    }

    public struct LogOut: GraphQLSelectionSet {
      public static let possibleTypes = ["userType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("loginType", type: .scalar(String.self)),
        GraphQLField("rank", type: .scalar(String.self)),
        GraphQLField("relegiousObservance", type: .scalar(String.self)),
        GraphQLField("isSaved", type: .scalar(String.self)),
        GraphQLField("yearsOfExperience", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("bio", type: .scalar(String.self)),
        GraphQLField("loginStatus", type: .scalar(Bool.self)),
        GraphQLField("deviceToken", type: .scalar(String.self)),
        GraphQLField("message", type: .scalar(String.self)),
        GraphQLField("error", type: .scalar(Bool.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, name: String? = nil, email: String? = nil, loginType: String? = nil, rank: String? = nil, relegiousObservance: String? = nil, isSaved: String? = nil, yearsOfExperience: String? = nil, state: String? = nil, bio: String? = nil, loginStatus: Bool? = nil, deviceToken: String? = nil, message: String? = nil, error: Bool? = nil) {
        self.init(snapshot: ["__typename": "userType", "_id": id, "name": name, "email": email, "loginType": loginType, "rank": rank, "relegiousObservance": relegiousObservance, "isSaved": isSaved, "yearsOfExperience": yearsOfExperience, "state": state, "bio": bio, "loginStatus": loginStatus, "deviceToken": deviceToken, "message": message, "error": error])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["_id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var loginType: String? {
        get {
          return snapshot["loginType"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginType")
        }
      }

      public var rank: String? {
        get {
          return snapshot["rank"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "rank")
        }
      }

      public var relegiousObservance: String? {
        get {
          return snapshot["relegiousObservance"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "relegiousObservance")
        }
      }

      public var isSaved: String? {
        get {
          return snapshot["isSaved"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "isSaved")
        }
      }

      public var yearsOfExperience: String? {
        get {
          return snapshot["yearsOfExperience"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "yearsOfExperience")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var bio: String? {
        get {
          return snapshot["bio"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "bio")
        }
      }

      public var loginStatus: Bool? {
        get {
          return snapshot["loginStatus"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "loginStatus")
        }
      }

      public var deviceToken: String? {
        get {
          return snapshot["deviceToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "deviceToken")
        }
      }

      public var message: String? {
        get {
          return snapshot["message"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var error: Bool? {
        get {
          return snapshot["error"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "error")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var userDetails: UserDetails {
          get {
            return UserDetails(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public struct NotificationDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment NotificationDetails on notificationType {\n  __typename\n  _id\n  roomName\n  receiver\n  caller\n  message\n  error\n  deviceToken\n}"

  public static let possibleTypes = ["notificationType"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .scalar(GraphQLID.self)),
    GraphQLField("roomName", type: .scalar(String.self)),
    GraphQLField("receiver", type: .scalar(String.self)),
    GraphQLField("caller", type: .scalar(String.self)),
    GraphQLField("message", type: .scalar(String.self)),
    GraphQLField("error", type: .scalar(Bool.self)),
    GraphQLField("deviceToken", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID? = nil, roomName: String? = nil, receiver: String? = nil, caller: String? = nil, message: String? = nil, error: Bool? = nil, deviceToken: String? = nil) {
    self.init(snapshot: ["__typename": "notificationType", "_id": id, "roomName": roomName, "receiver": receiver, "caller": caller, "message": message, "error": error, "deviceToken": deviceToken])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return snapshot["_id"] as? GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "_id")
    }
  }

  public var roomName: String? {
    get {
      return snapshot["roomName"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "roomName")
    }
  }

  public var receiver: String? {
    get {
      return snapshot["receiver"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "receiver")
    }
  }

  public var caller: String? {
    get {
      return snapshot["caller"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "caller")
    }
  }

  public var message: String? {
    get {
      return snapshot["message"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "message")
    }
  }

  public var error: Bool? {
    get {
      return snapshot["error"] as? Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "error")
    }
  }

  public var deviceToken: String? {
    get {
      return snapshot["deviceToken"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "deviceToken")
    }
  }
}

public struct UserDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment UserDetails on userType {\n  __typename\n  _id\n  name\n  email\n  loginType\n  rank\n  relegiousObservance\n  isSaved\n  yearsOfExperience\n  state\n  bio\n  loginStatus\n  deviceToken\n  message\n  error\n}"

  public static let possibleTypes = ["userType"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .scalar(GraphQLID.self)),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("email", type: .scalar(String.self)),
    GraphQLField("loginType", type: .scalar(String.self)),
    GraphQLField("rank", type: .scalar(String.self)),
    GraphQLField("relegiousObservance", type: .scalar(String.self)),
    GraphQLField("isSaved", type: .scalar(String.self)),
    GraphQLField("yearsOfExperience", type: .scalar(String.self)),
    GraphQLField("state", type: .scalar(String.self)),
    GraphQLField("bio", type: .scalar(String.self)),
    GraphQLField("loginStatus", type: .scalar(Bool.self)),
    GraphQLField("deviceToken", type: .scalar(String.self)),
    GraphQLField("message", type: .scalar(String.self)),
    GraphQLField("error", type: .scalar(Bool.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID? = nil, name: String? = nil, email: String? = nil, loginType: String? = nil, rank: String? = nil, relegiousObservance: String? = nil, isSaved: String? = nil, yearsOfExperience: String? = nil, state: String? = nil, bio: String? = nil, loginStatus: Bool? = nil, deviceToken: String? = nil, message: String? = nil, error: Bool? = nil) {
    self.init(snapshot: ["__typename": "userType", "_id": id, "name": name, "email": email, "loginType": loginType, "rank": rank, "relegiousObservance": relegiousObservance, "isSaved": isSaved, "yearsOfExperience": yearsOfExperience, "state": state, "bio": bio, "loginStatus": loginStatus, "deviceToken": deviceToken, "message": message, "error": error])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return snapshot["_id"] as? GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "_id")
    }
  }

  public var name: String? {
    get {
      return snapshot["name"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var email: String? {
    get {
      return snapshot["email"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "email")
    }
  }

  public var loginType: String? {
    get {
      return snapshot["loginType"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "loginType")
    }
  }

  public var rank: String? {
    get {
      return snapshot["rank"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "rank")
    }
  }

  public var relegiousObservance: String? {
    get {
      return snapshot["relegiousObservance"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "relegiousObservance")
    }
  }

  public var isSaved: String? {
    get {
      return snapshot["isSaved"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "isSaved")
    }
  }

  public var yearsOfExperience: String? {
    get {
      return snapshot["yearsOfExperience"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "yearsOfExperience")
    }
  }

  public var state: String? {
    get {
      return snapshot["state"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "state")
    }
  }

  public var bio: String? {
    get {
      return snapshot["bio"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "bio")
    }
  }

  public var loginStatus: Bool? {
    get {
      return snapshot["loginStatus"] as? Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "loginStatus")
    }
  }

  public var deviceToken: String? {
    get {
      return snapshot["deviceToken"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "deviceToken")
    }
  }

  public var message: String? {
    get {
      return snapshot["message"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "message")
    }
  }

  public var error: Bool? {
    get {
      return snapshot["error"] as? Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "error")
    }
  }
}