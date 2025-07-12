//
//  Throttled.swift
//  RABFoundation
//
//  Created by Stéphane on 28/06/2025.

import Foundation



///  Throttled.swift
///
///  Provides a property wrapper to throttle the assignment of values to a property,
///  ensuring that updates only occur at a specified minimum interval.



/// A property wrapper that throttles updates to its wrapped value.
///
/// When applied, this wrapper ensures that value assignments only take effect
/// if a specified time interval has elapsed since the last update.
/// Useful for cases where frequent updates should be limited, such as for UI state or network calls.
///
/// Example usage:
/// ```swift
/// @Throttled(timeInterval: 2) var searchText: String = ""
/// ```
///
/// - Parameter Value: The type of value being wrapped.
@propertyWrapper struct Throttled<Value> {
    /// The current underlying value, updated only if the throttle interval has passed.
    private var value: Value
    /// The date when the value was last successfully set.
    private var lastSet: Date
    /// The minimum interval (in seconds) that must elapse between updates.
    private let interval: TimeInterval

    /// Creates the property wrapper with an initial value and throttle interval.
    ///
    /// - Parameters:
    ///   - wrappedValue: The initial value to wrap.
    ///   - timeInterval: The minimum interval between updates (default is 1 second).
    init(wrappedValue: Value, timeInterval: TimeInterval = 1) {
        value = wrappedValue
        interval = timeInterval
        lastSet = Date()
    }

    /// Accesses the wrapped value. Assignments only succeed if the minimum interval has elapsed since the last update.
    var wrappedValue: Value {
        get { value }
        set {
            let now = Date()

            guard interval <= now.timeIntervalSince(lastSet) else {
                return
            }
            value = newValue
            lastSet = now
        }
    }
}

