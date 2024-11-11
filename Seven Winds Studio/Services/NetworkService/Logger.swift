//
//  Logger.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 04/11/24.
//

import Foundation

struct Logger {
    
    // Prints request information: URL, body, and headers
    static func printRequest(request: URLRequest) {
        let url = request.url?.absoluteString ?? ""
        let bodyString = String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "NO BODY DATA"
        let headers = request.allHTTPHeaderFields ?? [:]
        
        Logger.print("""
        ✴️⬇️
        URL: \(url);
        BODY: \(bodyString);
        HEADERS: \(headers);
        ⬆️✴️
        """)
    }
    
    // Prints response details: URL, status code, and JSON response (formatted)
    static func printResponse(url: URL?, statusCode: Int, data: Data) {
        let urlStr = url?.absoluteString ?? ""
        let icon = statusCode == 200 ? "✅" : "❌"
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let jsonString = json.flatMap { prettyPrint(json: $0) } ?? "Invalid JSON"
        
        Logger.print("""
        \(icon)⬇️
        URL: \(urlStr);
        STATUS CODE: \(statusCode);
        JSON: \(jsonString)
        ⬆️\(icon)
        """)
    }
    
    // Prints decoding error details
    static func printDecodingError(error: Error) {
        Logger.print("""
        ❗️JSON decode error. Description: \(error.localizedDescription)❗️
        """)
    }
    
    // Prints a log message with a status (success or error)
    static func printLog(_ str: String, status: LogStatus) {
        Logger.print("\(status.rawValue) LOG: \(str)")
    }
    
    // Internal print function, only logs in DEBUG mode
    private static func print(_ str: String) {
        #if DEBUG
        Swift.print(str)
        #endif
    }
    
    // Utility to pretty print JSON objects
    private static func prettyPrint(json: Any) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
           let prettyString = String(data: data, encoding: .utf8) {
            return prettyString
        }
        return "Invalid JSON format"
    }

    // Log status enumeration
    enum LogStatus: String {
        case success = "✅"
        case error = "❌"
    }
}
