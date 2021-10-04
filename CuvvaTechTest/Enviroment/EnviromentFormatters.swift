import Foundation
import SwiftUI
import Combine

// MARK: - DateFormatter
private struct DateFormatterKey: EnvironmentKey {
    static var defaultValue: PolicyTermFormatter = MockPolicyTermFormatter()
}

// MARK: - Time management
private struct NowKey: EnvironmentKey {
    static var defaultValue: Time = FixedTime()
}


extension EnvironmentValues {
    var policyTermFormatter: PolicyTermFormatter {
        get { self[DateFormatterKey.self] }
        set { self[DateFormatterKey.self] = newValue }
    }
    
    var now: Time {
        get { self[NowKey.self] }
        set { self[NowKey.self] = newValue }
    }
}
