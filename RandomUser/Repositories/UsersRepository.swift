class UsersRepository: IUsersRepository {
    static let shared = UsersRepository()

    func getUserList(page: Int) async throws -> UserResponse {
        let apiService = ApiService.shared
        let data = try await apiService.fetchData(endpoint: "?page=\(page)&results=20", modelType: UserResponse.self)
        return data
    }
}
