import Foundation

public extension NSError {
    public class func unexpectedResponseStatusCodeError(
        _ filePath: String = #file,
        _ line: UInt = #line,
        _ function: String = #function
    ) -> NSError {
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        return NSError(
            domain: "Networking",
            code: 500,
            userInfo: [
                NSLocalizedDescriptionKey: "Received unexpected response status code at \(fileName):\(line) in \(function)"
            ]
        )
    }

    public class func unknownDataFormat(
        _ filePath: String = #file,
        _ line: UInt = #line,
        _ function: String = #function
        ) -> NSError {
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        return NSError(
            domain: "Networking",
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey: "Failed to parse data structure at \(fileName):\(line) in \(function)"
            ]
        )
    }
}
