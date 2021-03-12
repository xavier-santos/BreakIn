-- title:  Breakin
-- author: Triceratops 
-- desc:   Game developed for Retro Jam 2021
-- script: lua

function init()
    -- Player
    -- TODO: Change to paddle
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

    -- Ball
    ball = {
        x = player.x + (player.width / 2) - 1.5,
        y = player.y - 5,
        width = 3,
        height = 3,
        color = 2,
        deactive = true,
        speed = {
            x = 0,
            y = 0,
            max = 1.5
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
            sx = sx - 2

        else
            sx = -smax

        end	 
    end

    -- Move to right
    if btn(3) then
        if sx < smax then
            sx = sx+2
            
        else
            sx = smax

        end
    end

    -- Deactived ball
    if ball.deactive then
        ball.x = player.x+(player.width/2)-1.5
        ball.y = player.y-5
      
        if btn(5) then
            ball.speed.x = math.floor(math.random())*2-1
            ball.speed.y = -1.5
            ball.deactive = false
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

    -- Update ball position
    ball.x = ball.x + ball.speed.x
    ball.y = ball.y + ball.speed.y

    -- Check max ball speed
    if ball.speed.x > ball.speed.max then
        ball.speed.x = ball.speed.max
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
    -- Draw paddle
    rect(
        player.x,
        player.y,
        player.width,
        player.height,
        player.color
    )

    -- Draw ball
    rect(
        ball.x,
        ball.y,
        ball.width,
        ball.height,
        ball.color
    )
end

function collisions()
    ball_ground_collision()
end

function ball_ground_collision()
    if ball.y > 136 - ball.width then
        -- Reset ball
        ball.deactive = true

        -- Loss a life
        if lives > 0 then
            lives = lives - 1

        elseif lives == 0 then
            game_over()

        end
    end
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
-- 000:000000f60404ffff00000000000000000000000000000000000000000000000000000000000000000000000000ffffff
-- </PALETTE>

