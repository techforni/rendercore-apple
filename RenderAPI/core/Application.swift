import MetalKit
import SwiftUI

open class Application : NSObject, MTKViewDelegate
{
    open func onStart() {}
    open func onUpdate() {}
    open func onDraw() {}
    
    public required init(_ parentView: ApplicationPresenter)
    {
        super.init()
        self.onStart()
    }
    
    public final func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize)
    {
        
    }
    
    public final func draw(in view: MTKView)
    {
        self.onUpdate()
        self.onDraw()
    }
}

public struct ApplicationPresenter : NSViewRepresentable
{
    private var delegateType: Application.Type
    
    public init(delegateClass: Application.Type)
    {
        self.delegateType = delegateClass
    }
    
    public func makeCoordinator() -> Application {
        return delegateType.init(self)
    }
    
    public func makeNSView(context: NSViewRepresentableContext<ApplicationPresenter>) -> MTKView
    {
        let metalView = MTKView()
        metalView.device = MTLCreateSystemDefaultDevice()
        metalView.preferredFramesPerSecond = 120
        metalView.delegate = context.coordinator
        
        return metalView
    }
    
    public func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<ApplicationPresenter>)
    {
        
    }
    
    public typealias NSViewType = MTKView
}
