import Foundation

@MainActor class UserListViewModel : ObservableObject {
    private let usersUseCase = UsersUseCase(repository: UsersRepository.shared)
    private let encoder = JSONEncoder()

    private var page = 1
    
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var userList: [UserModel] = []

    func getUserList() {
        Task {
            do {
                if isLoading {
                    return
                }

                isLoading = true
                let response = try await usersUseCase.getUserList(page: 1)
                userList = response
                isLoading = false
            } catch {
                print(error)
            }
        }
    }
    
    func loadMoreUserList() {
        Task {
            do {
                if isLoadingMore {
                    return
                }

                isLoadingMore = true
                page += 1
                let response = try await usersUseCase.getUserList(page: page)
                userList.append(contentsOf: response)
                isLoadingMore = false
            } catch {
                print(error)
            }
        }
    }
    
    // Checks if are the last user visible in the list to load more.
    func handleUserAppeared(_ user: UserModel) {
        do {
            let obj1 = try encoder.encode(user)
            let obj2 = try encoder.encode(userList.last)
            
            if obj1 == obj2 {
                loadMoreUserList()
            }
        } catch {
            
        }
    }
    
    func getFilteredUserList(_ searchText: String) -> [UserModel] {
        return userList.filter { user in
            searchText.isEmpty || user.name.first.localizedCaseInsensitiveContains(searchText)
        }
    }
}
