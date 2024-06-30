import Metal
import simd

public struct Vertex
{
    var pos: simd_float3
    var color: simd_float4
    var texCoord: simd_float2
    
    public init(pos: simd_float3, color: simd_float4)
    {
        self.pos = pos
        self.color = color
        self.texCoord = .zero
    }
    
    public init(pos: simd_float3, texCoord: simd_float2)
    {
        self.pos = pos
        self.color = .zero
        self.texCoord = texCoord
    }
}

public final class IndexBuffer
{
    internal var bufferObj: MTLBuffer!
    
    public init(_ instance: Instance, indexArray: [ushort])
    {
        self.bufferObj = instance.device.makeBuffer(bytes: indexArray, length: MemoryLayout<ushort>.stride * indexArray.count, options: .storageModeShared)
    }
}

public final class VertexBuffer
{
    internal var bufferObj: MTLBuffer!
    
    public init(_ instance: Instance, vertexArray: [Vertex])
    {
        self.bufferObj = instance.device.makeBuffer(bytes: vertexArray, length: MemoryLayout<Vertex>.stride * vertexArray.count, options: .storageModeShared)
    }
    
    public func draw(_ instance: Instance)
    {
        instance.renderEncoder.setVertexBuffer(self.bufferObj, offset: 0, index: 0)
    }
}
