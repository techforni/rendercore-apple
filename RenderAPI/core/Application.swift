import MetalKit
import SwiftUI

open class Application : NSObject, MTKViewDelegate
{
    private var instance: Instance!
    
    open func onStart(instance: Instance) {}
    open func onUpdate(instance: Instance) {}
    open func onDraw(instance: Instance) {}
    
    public required init(_ parentView: ApplicationPresenter)
    {
        super.init()
        self.instance = Instance()
        self.onStart(instance: self.instance)
    }
    
    public final func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize)
    {
        
    }
    
    public final func draw(in view: MTKView)
    {
        self.instance.startFrame(view: view)
        self.onUpdate(instance: self.instance)
        self.instance.startEncoder()
        self.onDraw(instance: self.instance)
        self.instance.submit()
    }
}

#if os(iOS)
public struct ApplicationPresenter : UIViewRepresentable
{
    private var delegateType: Application.Type
    
    public init(delegateClass: Application.Type)
    {
        self.delegateType = delegateClass
    }
    
    public func makeCoordinator() -> Application {
        return delegateType.init(self)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ApplicationPresenter>) -> MTKView
    {
        let metalView = MTKView()
        metalView.device = MTLCreateSystemDefaultDevice()
        metalView.preferredFramesPerSecond = 120
        metalView.delegate = context.coordinator
        
        return metalView
    }
    
    public func updateUIView(_ nsView: MTKView, context: UIViewRepresentableContext<ApplicationPresenter>)
    {
        
    }
    
    public typealias UIViewType = MTKView
}
#elseif os(macOS)
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
#endif
