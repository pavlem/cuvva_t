import Foundation

// MARK: JSONDecoder config
let apiJsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var date: Date? = nil
        date = dateFormatter.date(from: dateStr)
        
        guard let date_ = date else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
        }
        print("DATE DECODER \(dateStr) to \(date_)")
        return date_
    })
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
}()

// MARK: JSON Response Decodable
typealias JSONResponse = [JSONEvent]

struct JSONEvent: Decodable {
    let type: String
    let payload: JSONEventPayload
}

// MARK: JSONEventPayload
struct JSONEventPayload: Codable {
    let timestamp: Date
    let policyId: String?
    let originalPolicyId: String?
    let startDate: Date?
    let endDate: Date?
    let vehicle: JSONEventVehicle?
}

// MARK: JSONEventVehicle
struct JSONEventVehicle: Codable {
    let prettyVrm: String
    let make: String
    let model: String
    let variant: String?
    let color: String
    let notes: String
}
