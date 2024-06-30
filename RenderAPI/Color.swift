import Metal

public func bgClearColor(_ inst: Instance, red: Double, green: Double, blue: Double, alpha: Double)
{
    inst.renderPass.colorAttachments[0].clearColor = MTLClearColorMake(red, green, blue, alpha)
    inst.renderPass.colorAttachments[0].storeAction = .store
    inst.renderPass.colorAttachments[0].loadAction = .clear
}
