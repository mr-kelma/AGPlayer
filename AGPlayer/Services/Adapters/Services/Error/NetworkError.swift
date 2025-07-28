import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidKeyword
    case invalidURL
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidKeyword:
            return "Invalid search keyword."
        case .invalidURL:
            return "Invalid URL."
        case .noData:
            return "No data received from server."
        }
    }
}
