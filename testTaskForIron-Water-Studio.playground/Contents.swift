import Foundation

func versionComparable(_ mainStr: String, _ comparableStr: String) throws -> ComparisonResult {

    let separator = "."
    var dotsCount = 0

    var mainStrDotted = mainStr.components(separatedBy: separator)
    var comparableStrDotted = comparableStr.components(separatedBy: separator)
    
    let mainStrDottedJoined = mainStrDotted.joined(separator: separator)
    let comparableStrDottedJoined = comparableStrDotted.joined(separator: separator)
    
    while comparableStrDotted.description.hasPrefix(".") || mainStrDotted.description.hasPrefix(".") {
        comparableStrDotted.removeFirst()
        mainStrDotted.removeFirst()
        dotsCount += 1
    }
    
    let result = Array(repeating: "0.", count: dotsCount)
    comparableStrDotted.insert(contentsOf: result, at: 0)
    mainStrDotted.insert(contentsOf: result, at: 0)

    let zeroDifferent = mainStrDotted.count - comparableStrDotted.count
    
    if zeroDifferent == 0 {
        return mainStrDottedJoined.description.compare(
            comparableStrDottedJoined,
            options: .numeric,
            range: nil,
            locale: nil
        )
    } else {
        let zeros = Array(repeating: "0", count: abs(zeroDifferent))
        if zeroDifferent > 0 {
            comparableStrDotted.append(contentsOf: zeros)
        } else {
            mainStrDotted.append(contentsOf: zeros)
        }
        return mainStrDotted.joined(separator: separator)
            .compare(comparableStrDotted.joined(separator: separator), options: .numeric)
    }
}

extension ComparisonResult {
    var result: String {
        switch self {
        case .orderedAscending:
            return "ASCENDING"
        case .orderedDescending:
            return "DESCENDING"
        case .orderedSame:
            return "SAME"
        }
    }
}

var a = try versionComparable("01", "1")
var b = try versionComparable("01.234.56", "2.0.0")
var c = try versionComparable("1.2", "1.2.3")
var d = try versionComparable(".0", "1")
var e = try versionComparable("1.3", "1.2")
var j = try versionComparable("1.3", "1.2.4")
var f = try versionComparable(".1", "0.1")

let results = [a,b,c,d,e,j,f].map { $0.result }
for result in results {
  print(result)
}
