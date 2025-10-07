//
//  ApiRoute.swift
//  App
//
//  Created by andrew on 10/7/25.
//

import Parsing
import URLRouting

/// Models the API routes of Align's server
public enum ApiRoute: Hashable, Sendable {
    /// `/user`
    case user

    /// Parse an ``ApiRoute`` from an `URLRequest` or print an `URLRequest` from an ``ApiRoute``
    public static func router() -> AnyParserPrinter<URLRequestData, Self> {
        Parse {
            OneOf {
                Route(.case(user)) {
                    Path {
                        "user"
                    }
                }
            }
        }.eraseToAnyParserPrinter()
    }
}
