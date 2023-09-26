import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()
    private let baseURL = "https://randomuser.me/api/"

    private init() {}

    func fetchData<T: Codable>(endpoint: String, modelType: T.Type) async throws -> T {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(baseURL + endpoint, method: .get).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }        }
    }
}
