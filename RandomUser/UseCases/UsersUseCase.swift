import Foundation

class UsersUseCase {
    private var repository: IUsersRepository

    init(repository: IUsersRepository) {
        self.repository = repository
    }
    
    func getUserList(page: Int) async throws -> [UserModel] {
        return try await repository.getUserList(page: page).results
    }
}
