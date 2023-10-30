-- particle.lua

Particle = {}
Particle.__index = Particle

function Particle:create(location)
    local particle = {} 
    setmetatable(particle, Particle)
    particle.location = location
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    particle.lifespan = 100
    particle.decay = math.random(3,8)/10
    particle.isActive = false
    particle.size = math.random(10, 50)
    particle.texture = love.graphics.newImage("assets/coin.png") 
    return particle
end

function Particle:applyForce(force)
    if self.isActive == true then
        self.acceleration:add(force)
    end
end

function Particle:update()
    if self.isActive == true then
        self.velocity:add(self.acceleration)
        self.location:add(self.velocity)
        self.acceleration:mul(0)
        self.lifespan = self.lifespan - self.decay
    end
    
end

function Particle:draw()
    local r, g, b, a = love.graphics.getColor()
    local halfSize = self.size / 2
    love.graphics.setColor(255, 255, 255, self.lifespan / 100)
    love.graphics.draw(self.texture, self.location.x - halfSize, self.location.y - halfSize, 0, self.size / self.texture:getWidth(), self.size / self.texture:getHeight())
    love.graphics.setColor(r, g, b, a)
end


function Particle:isDead()
    return self.lifespan < 0
end