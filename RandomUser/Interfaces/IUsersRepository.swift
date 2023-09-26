protocol IUsersRepository {
    func getUserList(page: Int) async throws -> UserResponse
}
