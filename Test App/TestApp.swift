import SwiftUI
import RenderCore


@main
struct Test_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationPresenter(delegateClass: Game.self)
        }
    }
}

