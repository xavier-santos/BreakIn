-- title:  Breakin
-- author: Triceratops 
-- desc:   Game developed for Retro Jam 2021
-- script: lua

function init()
    player = {
        x = (240 /2 ) - 12,
        y = 120,
        width = 24,
        height = 4,
        color = 1,
        speed = {
            x = 0,
            max = 4
        }
    }
end

init()

function input()
    local sx = player.speed.x
    local smax = player.speed.max

    -- Move to left
    if btn(2) then
        if sx>-smax then
            sx=sx-2

        else
            sx=-smax

        end	 
    end

    -- Move to right
    if btn(3) then
        if sx<smax then
            sx=sx+2
            
        else
            sx=smax

        end
    end

    player.speed.x = sx
    player.speed.max = smax
end

function update()
    local px = player.x
    local psx = player.speed.x
    local smax = player.speed.max

    -- Update player position
    px = px + psx

    -- Reduce player speed
    if psx ~= 0 then
        if psx > 0 then
            psx=psx-1

        else
            psx=psx+1

        end
    end

    player.x = px
    player.speed.x = psx
    player.speed.max = smax
end

function draw()
    draw_game_objects()
    -- draw_gui()
end

function draw_game_objects()
    rect(player.x,
        player.y,
        player.width,
        player.height,
        player.color
    )
end

function TIC()
    cls()
    input()
    update()
    draw()
 end

-- <TILES>
-- 000:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <PALETTE>
-- 000:000000f60404000000000000000000000000000000000000000000000000000000000000000000000000000000ffffff
-- </PALETTE>

