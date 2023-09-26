import SwiftUI
import CachedAsyncImage

struct UserComponent: View {
    var photoUrl: String
    var name: String

    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: photoUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 50))

            Text(name)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

struct UserComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserComponent(photoUrl: "https://www.pcgamesn.com/wp-content/sites/pcgamesn/2023/07/wow-dragonflight-10-1-7-sylvanas-spell.jpg", name: "Sylvanas Windrunner")
    }
}
