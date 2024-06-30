import simd
import SwiftUI
import RenderCore

class Game : Application
{
    var buffer: VertexBuffer!
    var pipeline: Pipeline!
    
    required init(_ parentView: ApplicationPresenter)
    {
        super.init(parentView)
    }
    
    override func onStart(instance: Instance) {
       
    }
    
    override func onUpdate(instance: Instance) {
        
    }
    
    override func onDraw(instance: Instance) {
        buffer.draw(instance)
        pipeline.draw(instance)
    }
}
