-- main.lua

require("vector")
require("particle")
require("particlesystem")
require("reppeler")

function love.load()
    width = love.graphics.getWidth()
    heigth = love.graphics.getHeight()
    particle = Particle:create(Vector:create(width/2, heigth/2))
    ps = ParticleSystem:create(Vector:create(width/2, heigth/2),100)

    ps_systems = {}

    ps_systems[1] = ParticleSystem:create(Vector:create(100, 150), 50)
    ps_systems[2] = ParticleSystem:create(Vector:create(350, 250), 100)
    ps_systems[3] = ParticleSystem:create(Vector:create(600, 400), 200)

    reppeler = Repeller:create(width/2+100, heigth/2+150)
end

function love.update()
    for k,v in pairs(ps_systems) do
        ps_systems[k]:update()
     end
end

function love.draw()
    for k,v in pairs(ps_systems) do 
        ps_systems[k]:draw()  
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        for k,v in pairs(ps_systems) do
            if x >= ps_systems[k].origin.x - ps_systems[k].size / 2 and x <= ps_systems[k].origin.x + ps_systems[k].size / 2
                and y >= ps_systems[k].origin.y - ps_systems[k].size / 2 and y <= ps_systems[k].origin.y + ps_systems[k].size / 2 then
                for k, v in pairs(ps_systems[k].particles) do
                    v.isActive = true
                end
            end
        end
    end
end

