//
//  DateCodable.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 26/02/2024.
//

import Foundation

public protocol DateCodableFormat {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> Date?
    static func encode(_ date: Date?) -> RawValue?
}

/// Uses a format to decode a date from Codable.
@propertyWrapper struct DateCodable<T: DateCodableFormat>: Codable {
    private let value: T.RawValue?
    var wrappedValue: Date?
    
    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        self.value = T.encode(wrappedValue)
    }
        
    public init(from decoder: Decoder) throws {
        self.value = try T.RawValue(from: decoder)
        self.wrappedValue = try T.decode(value)
    }
        
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

// MARK: - Date Formats

struct ISODateTimeFull: DateCodableFormat {
    
    static func decode(_ value: String?) throws -> Date? {
        guard let value = value else { return nil }
        return Date(fromString: value, format: .isoDate)
    }
    
    static func encode(_ date: Date?) -> String? {
        date?.toString(format: .appStandard)
    }
}

