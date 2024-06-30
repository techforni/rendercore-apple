import Metal

public final class Pipeline
{
    internal var rpState: MTLRenderPipelineState!
    
    public init(_ instance: Instance, vs: String, fs: String)
    {
        var library: MTLLibrary!
        do {
            library = try instance.device.makeLibrary(URL: Bundle.main.url(forResource: "EngineShaders", withExtension: "metallib")!)
        } catch let error {
            print(error)
        }
        
        var pipelineDescriptor = MTLRenderPipelineDescriptor()
        
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.vertexFunction = library.makeFunction(name: vs)
        pipelineDescriptor.fragmentFunction = library.makeFunction(name: fs)
        
        do {
            self.rpState = try instance.device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch let error {
            print(error)
        }
        
    }
    
    public func draw(_ instance: Instance)
    {
        instance.renderEncoder.setRenderPipelineState(self.rpState)
    }
}
