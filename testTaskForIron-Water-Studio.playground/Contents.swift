import Foundation

func versionComparable(_ mainStr: String, _ comparableStr: String) -> ComparisonResult {

    let separator = "."

    var mainStrDotted = mainStr.components(separatedBy: separator)
    var comparableStrDotted = comparableStr.components(separatedBy: separator)
    
    let mainStrDottedJoined = mainStrDotted.map{$0 == "" ? "0" : $0}.joined(separator: separator)
    let comparableStrDottedJoined = comparableStrDotted.map{$0 == "" ? "0" : $0}.joined(separator: separator)

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

var a = versionComparable("01", "1")
var b = versionComparable("01.234.56", "2.0.0")
var c = versionComparable("1.2", "1.2.3")
var d = versionComparable(".0", "1")
var e = versionComparable("1.3", "1.2")
var j = versionComparable("1.3", "1.2.4")
var f = versionComparable(".1", "0.1")

let results = [a,b,c,d,e,j,f].map { $0.result }
for result in results {
  print(result)
}
