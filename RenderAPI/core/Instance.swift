import Dispatch
import MetalKit

public final class Instance
{
    internal var device: MTLDevice!
    internal var commandQueue: MTLCommandQueue!
    
    internal var rlQueue: DispatchQueue!    // Resource Loading Queue
    internal var raQueue: DispatchQueue!    // Resource Allocation Queue
    internal var rpcQueue: DispatchQueue!   // Pipeline Compiler Queue
    
    internal var renderEncoder: MTLRenderCommandEncoder!
    internal var renderPass: MTLRenderPassDescriptor!
    internal var commandBuffer: MTLCommandBuffer!
    internal var drawable: MTLDrawable!
    
    internal init()
    {
        self.device = MTLCreateSystemDefaultDevice()
        self.commandQueue = device.makeCommandQueue()
    }
    
    internal func startFrame(view: MTKView)
    {
        guard let renderPass = view.currentRenderPassDescriptor else { return }
        guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }
        guard let drawable = view.currentDrawable else { return }
        
        self.renderPass = renderPass
        self.commandBuffer = commandBuffer
        self.drawable = drawable
    }
    
    internal func startEncoder()
    {
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: self.renderPass) else { return  }
        self.renderEncoder = renderEncoder
    }
    
    internal func submit()
    {
        self.renderEncoder.endEncoding()
        commandBuffer.present(self.drawable)
        commandBuffer.commit()
    }
}
