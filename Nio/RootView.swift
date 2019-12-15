import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: MatrixStore<AppState, AppAction>

    var body: some View {
        switch store.state.loginState {
        case .loggedIn(let userId):
            return AnyView(
                RecentRoomsContainerView()
                .environment(\.userID, userId)
            )
        case .loggedOut:
            return AnyView(
                LoginContainerView()
            )
        case .authenticating:
            return AnyView(
                LoadingView()
            )
        case .failure(let error):
            return AnyView(
                VStack {
                    Text(error.localizedDescription)
                    Button(action: {
                        self.store.send(AppAction.loginState(.loggedOut))
                    }, label: {
                        Text("Go to login")
                    })
                }
            )
        }
    }
}
