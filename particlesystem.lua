-- particlesystem.lua

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, length, n, cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.csize = 10
    system.size = system.csize
    system.index = 0
    system.length = length
    system.particles = {}
    return system
end

function ParticleSystem:createParticle()
    return self.cls:create(self.origin:copy())
end

function ParticleSystem:applyReppeler()
    for k, v in pairs(self.particles) do
        local force = reppeler:repel(v)
        v:applyForce(force)
    end

end

function ParticleSystem:update()
    if #self.particles < self.n then
        self.particles[self.index] = self:createParticle()
        self.index = self.index + 1
    end
    for k, v in pairs(self.particles) do
        if v:isDead() then
            v = self:createParticle()
            self.particles[k] = v
        end
        v:update()
    end
    for k,v in pairs(self.particles) do
        v:update()
    end
    
end

function ParticleSystem:draw()
    table.sort(self.particles, function(a, b)
        return a.size < b.size
    end)
    for k, v in pairs(self.particles) do
        v:draw()
    end
end

function ParticleSystem:applyForce(force)
    for k, v in pairs(self.particles) do
        v:applyForce(force)
    end
end