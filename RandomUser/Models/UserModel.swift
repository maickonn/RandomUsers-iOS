import Foundation

struct UserModel: Codable {
    let gender: String
    let name: UserName
    let location: UserLocation
    let email: String
    let phone: String
    let cell: String
    let picture: UserProfilePicture
}
