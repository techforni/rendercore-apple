import SwiftUI
import RenderCore

class Game : Application
{
    required init(_ parentView: ApplicationPresenter)
    {
        super.init(parentView)
    }
    
    override func onStart() {
        print("Join 0")
    }
    
    override func onUpdate() {
        print("Join 1")
    }
    
    override func onDraw() {
        print("Join 2")
    }
}

struct ContentView: View {
    var body: some View {
        ApplicationPresenter(delegateClass: Game.self)
    }
}

#Preview {
    ContentView()
}
