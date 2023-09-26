import SwiftUI

struct UserListView: View {
    @ObservedObject private var viewModel = UserListViewModel()
    @State private var isShowingDetailView = false
    @State private var user: UserModel?
    @State private var searchText = ""
    
    private var loadingView: some View {
        List {
            ForEach(0..<10) { _ in
                UserComponent(photoUrl: "", name: "Sylvanas Windrunner")
                    .redacted(reason: .placeholder)
            }
        }
        .listStyle(.plain)
    }
    
    private var userListView: some View {
        List {
            ForEach(viewModel.getFilteredUserList(searchText), id: \.name.first) { user in
                UserComponent(photoUrl: user.picture.medium, name: user.name.first)
                    .onTapGesture {
                        self.user = user
                        self.isShowingDetailView = true
                    }
                    .onAppear {
                        viewModel.handleUserAppeared(user)
                    }
            }
            
            if viewModel.isLoadingMore {
                ForEach(0..<5) { _ in
                    UserComponent(photoUrl: "", name: "Sylvanas Windrunner")
                        .redacted(reason: .placeholder)
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.getUserList()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            userListView
        }
    }
    
    var body: some View {
        content
            .navigationBarTitle("app-title-string")
            .searchable(text: $searchText)
            .onAppear {
                viewModel.getUserList()
            }
            .sheet(isPresented: $isShowingDetailView) {
                UserDetailView(user: self.$user, isVisible: self.$isShowingDetailView)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserListView()
        }
    }
}
