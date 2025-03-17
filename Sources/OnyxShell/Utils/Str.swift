import Foundation

extension Onyx.Utils {
    public enum Str {
        
        private static let invalidChars: Set<Character> = [
            " ", "`",  "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "=", "+",
            "[", "]", "{", "}", "\\", "|",
            ";", ":", "'", "\"",
            ",", "<", ">", "/", "?"
        ]
        
        static func isValidName(_ s: String) -> Bool {
            return !s.contains { invalidChars.contains($0) }
        }
        
        // Can only contain letters, numbers, and underscores, and the first character cannot be a number.
        private static let identifierPattern = #"^[A-Za-z_\p{XID_Start}][A-Za-z0-9_\p{XID_Continue}]*$"#
        
        static func isIdentifier(_ s: String) -> Bool {
            return s.range(of: identifierPattern, options: .regularExpression) != nil
        }
        
        private static let kebabRegex = try! NSRegularExpression(pattern: #"([a-z0-9])([A-Z])|([A-Z]+)([A-Z][a-z])"#, options: [])
        
        public static func toKebabCase(_ identifier: String) -> String {
            let modified = kebabRegex.stringByReplacingMatches(
                in: identifier,
                options: [],
                range: NSRange(location: 0, length: identifier.utf16.count),
                withTemplate: "$1$3-$2$4"
            )
            
            return modified.lowercased()
        }
    }
}
