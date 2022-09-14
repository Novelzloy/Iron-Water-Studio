import Foundation

func versionComparable(_ mainStr: String, _ comparableStr: String) throws -> ComparisonResult {

    let separator = "."

    var mainStrDotted = mainStr.components(separatedBy: separator)
    var comparableStrDotted = comparableStr.components(separatedBy: separator)
    
    var mainStrDottedJoined = mainStrDotted.joined(separator: separator)
    var comparableStrDottedJoined = comparableStrDotted.joined(separator: separator)
    
    var dotsCountMainStr = 0
    var dotsCountСomparableStr = 0

    let zeroDifferent = mainStrDotted.count - comparableStrDotted.count

    for (index, item) in mainStrDotted.enumerated() {
        let mainStrDotted_i = String(item)
        let comparableStrDotted_i = String(comparableStrDotted[index])
        let result = mainStrDotted_i.compare(
            comparableStrDotted_i,
            options: .numeric,
            range: nil,
            locale: nil
        )

        if comparableStrDotted.count <= index {
            return .orderedDescending
        }

        switch result {
        case .orderedSame:
             continue
        case .orderedAscending:
            return .orderedAscending
        case .orderedDescending:
            return .orderedDescending
        }
    }
    
    while mainStrDottedJoined.hasPrefix(".") {
        mainStrDottedJoined.removeFirst()
        dotsCountMainStr += 1
    }

    let zeroVersionsMainStr = String(repeating: "0.", count: dotsCountMainStr)
    mainStrDottedJoined += zeroVersionsMainStr
    
    while comparableStrDottedJoined.hasPrefix(".") {
        comparableStrDottedJoined.removeFirst()
        dotsCountСomparableStr += 1
    }

    let zeroVersionsСomparableStr = String(repeating: "0.", count: dotsCountСomparableStr)
    comparableStrDottedJoined += zeroVersionsСomparableStr
    
    if mainStrDottedJoined.count > comparableStrDottedJoined.count {
        comparableStrDottedJoined.append(".0")
    } else {
        mainStrDottedJoined.append(".0")
    }
    
    if zeroDifferent == 0 {
        return mainStrDottedJoined.description.compare(
            comparableStrDottedJoined,
            options: .numeric,
            range: nil,
            locale: nil
        )
    }
//    } else {
//        let zeros = Array(repeating: "0", count: abs(zeroDifferent))
//        if zeroDifferent > 0 {
//            mainStrDotted.append(contentsOf: zeros)
//        } else {
//            comparableStrDotted.append(contentsOf: zeros)
//        }
//        return comparableStrDotted.joined(separator: separator)
//            .compare(comparableStrDotted.joined(separator: separator), options: .numeric)
//    }
    return .orderedDescending
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
var j = try versionComparable("1.3", "1.2")
var f = try versionComparable("1.2.3.4", "1.2.3.4.5")

let results = [a,b,c,d,e,j,f].map { $0.result }
for result in results {
  print(result)
}


