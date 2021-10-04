import Foundation

struct MockPolicyTermFormatter: PolicyTermFormatter {
    
    func durationString(for duration: TimeInterval) -> String {
        // Return a random item from array of all possible policy durations
        [
            [1, 2, 3, 6, 12].map { "\($0) Hour Policy 🔥🔥" },
            (1...28).map { "\($0) Day Policy 🔥🔥" }
        ]
        .flatMap { $0 }
        .randomElement()!
    }
    
    func durationRemainingString(for term: PolicyTerm, relativeTo now: Date) -> String {
        [
            "1 minute 🔥",
            "23 minutes 🔥",
            "3 hours, 22 minutes 🔥",
            "8 hours, 1 minute 🔥",
            "1 Day, 23 hours 🔥",
            "3 weeks, 2 days 🔥"
        ].randomElement()!
    }
    
    func durationRemainingPercent(for term: PolicyTerm, relativeTo now: Date) -> Double {
        Double.random(in: 0...1)
    }
    
    func policyDateString(for: Date) -> String {
        "Mon, 9th Jan 2007 at 9:41am 🔥🔥🔥"
    }
    
}
