import SwiftUI
import CachedAsyncImage

struct UserDetailView: View {
    @Binding var user: UserModel?
    @Binding var isVisible: Bool

    var body: some View {
        VStack {
            Spacer()
            
            CachedAsyncImage(url: URL(string: user!.picture.large)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: .infinity))

            Text(user!.name.first + " " + user!.name.last)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            Spacer()
            
            UserInformationComponent(icon: "house.fill", description: "user-localization-string \(user!.location.city) \(user!.location.state) \(user!.location.country)")
            
            UserInformationComponent(icon: "person.fill", description: "user-gender-string \(user!.gender)")
            
            UserInformationComponent(icon: "phone.fill", description: "user-phone-string \(user!.cell)")
            
            UserInformationComponent(icon: "envelope.fill", description: "user-email-string \(user!.email)")
            
            Spacer()
            
            Button {
                isVisible = false
            } label: {
                ZStack {
                    Image(systemName: "phone")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(x: 20)

                    Text("call-string")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .frame(height: 55)
                .frame(maxWidth: 300)
                .background(Color(.link))
                .cornerRadius(10)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let userJson = """
        {
             "gender":"female",
             "name":{
                "title":"Ms",
                "first":"Lorena",
                "last":"Lorenzo"
             },
             "location":{
                "street":{
                   "number":3321,
                   "name":"Calle de Atocha"
                },
                "city":"Móstoles",
                "state":"Comunidad Valenciana",
                "country":"Spain",
                "postcode":53664,
                "coordinates":{
                   "latitude":"-37.0671",
                   "longitude":"143.6620"
                },
                "timezone":{
                   "offset":"-9:00",
                   "description":"Alaska"
                }
             },
             "email":"lorena.lorenzo@example.com",
             "login":{
                "uuid":"87c15698-7177-4a51-b19e-54f1918634c2",
                "username":"tinyfrog374",
                "password":"mozart",
                "salt":"hECPwh0e",
                "md5":"81efa1505f2a17a08d871f3a2c480f34",
                "sha1":"6d4b95cd734e8b956995cbf9ac39963ebd737fed",
                "sha256":"cf54fe5a16edfb659e239d105c40a7e9e8121f554cc0e470f142605680cf97a7"
             },
             "dob":{
                "date":"1999-09-14T22:35:27.749Z",
                "age":24
             },
             "registered":{
                "date":"2003-09-22T18:47:23.709Z",
                "age":19
             },
             "phone":"905-322-719",
             "cell":"650-328-789",
             "id":{
                "name":"DNI",
                "value":"73578373-D"
             },
             "picture":{
                "large":"https://randomuser.me/api/portraits/women/54.jpg",
                "medium":"https://randomuser.me/api/portraits/med/women/54.jpg",
                "thumbnail":"https://randomuser.me/api/portraits/thumb/women/54.jpg"
             },
             "nat":"ES"
          }
    """.data(using: .utf8)
    
    static var previews: some View {
        return UserDetailView(user: Binding.constant(try! JSONDecoder().decode(UserModel.self, from: userJson!)), isVisible: Binding.constant(true))
    }
}
