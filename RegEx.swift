
//  Created by Sirichai Monhom on 6/2/2560 BE.


import Foundation

class RegEx {
    
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: .withoutAnchoringBounds, range:NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
    
    func replace(input:String, with:String) -> String {
        return self.internalExpression.stringByReplacingMatches(in: input, options: .withoutAnchoringBounds, range: NSMakeRange(0, input.characters.count), withTemplate: with)
    }
    
    func match(input:String) -> [String:String]? {
        var out:[String:String]?
        self.internalExpression.enumerateMatches(in: input, options: .withoutAnchoringBounds, range: NSMakeRange(0, input.characters.count)) { (result, flags, done) in
            out = result?.components
        }
        return out
    }
}

extension RegEx {
    static let integer = RegEx("^\\d+$")
    static let landLine = RegEx("^02[0-9]{1,7}$")
    static let mobileNumbers = RegEx("^0[0-9]{1,9}$")
    static let validLoginNumber = RegEx("^[0-9]+$")
    static let validEmail = RegEx("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
}

extension String {
    
    func replace(_ pattern:RegEx, with:String) -> String {
        return pattern.replace(input: self, with: with)
    }
    
    func `is`(_ pattern:RegEx) -> Bool {
        return pattern.test(input: self)
    }
}
