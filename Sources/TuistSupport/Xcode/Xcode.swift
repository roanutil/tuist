import FileSystem
import Foundation
import Path

public enum XcodeError: FatalError, Equatable {
    case infoPlistNotFound(AbsolutePath)

    public var description: String {
        switch self {
        case let .infoPlistNotFound(path):
            return "Couldn't find Xcode's Info.plist at \(path.pathString). Make sure your Xcode installation is selected by running: sudo xcode-select -s /Applications/Xcode.app"
        }
    }

    public var type: ErrorType {
        switch self {
        case .infoPlistNotFound:
            return .abort
        }
    }
}

public struct Xcode {
    /// It represents the content of the Info.plist file inside the Xcode app bundle.
    public struct InfoPlist: Codable {
        /// App version number (e.g. 10.3)
        public let version: String

        /// Initializes the InfoPlist object with its attributes.
        ///
        /// - Parameter version: Version.
        public init(version: String) {
            self.version = version
        }

        enum CodingKeys: String, CodingKey {
            case version = "CFBundleShortVersionString"
        }
    }

    /// Path to the Xcode app bundle.
    public let path: AbsolutePath

    /// Info plist content.
    public let infoPlist: InfoPlist

    /// Initializes an Xcode instance by reading it from a local Xcode.app bundle.
    ///
    /// - Parameter path: Path to a local Xcode.app bundle.
    /// - Returns: Initialized Xcode instance.
    /// - Throws: An error if the local installation can't be read.
    static func read(path: AbsolutePath) async throws -> Xcode {
        let infoPlistPath = path.appending(try RelativePath(validating: "Contents/Info.plist"))
        let fileSystem = FileSystem()
        if try await !fileSystem.exists(infoPlistPath) {
            throw XcodeError.infoPlistNotFound(infoPlistPath)
        }
        let plistDecoder = PropertyListDecoder()
        let data = try Data(contentsOf: infoPlistPath.url)
        let infoPlist = try plistDecoder.decode(InfoPlist.self, from: data)

        return Xcode(path: path, infoPlist: infoPlist)
    }

    /// Initializes an instance of Xcode which represents a local installation of Xcode
    ///
    /// - Parameters:
    ///     - path: Path to the Xcode app bundle.
    ///     - infoPlist: Info plist content.
    public init(
        path: AbsolutePath,
        infoPlist: InfoPlist
    ) {
        self.path = path
        self.infoPlist = infoPlist
    }
}

#if DEBUG
    extension Xcode {
        public static func test(
            path: AbsolutePath = try! AbsolutePath(validating: "/Applications/Xcode.app"), // swiftlint:disable:this force_try
            infoPlist: Xcode.InfoPlist = .test()
        ) -> Xcode {
            Xcode(path: path, infoPlist: infoPlist)
        }
    }

    extension Xcode.InfoPlist {
        public static func test(version: String = "3.2.1") -> Xcode.InfoPlist {
            Xcode.InfoPlist(version: version)
        }
    }

#endif
