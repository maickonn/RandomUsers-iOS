import SwiftUI

struct UserInformationComponent: View {
    var icon: String?
    var description: String
    

    init(icon: String?, description: String.LocalizationValue) {
        self.icon = icon
        self.description = String(localized: description)
    }

    var body: some View {
        HStack {
            Image(systemName: icon ?? "")
            Text(description)
        }
        .padding(EdgeInsets(top: 1, leading: 30, bottom: 0, trailing: 30))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct UserInformationComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationComponent(icon: "house.fill", description: "Aloha")
    }
}
