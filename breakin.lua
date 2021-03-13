-- title:  Breakin
-- author: Triceratops 
-- desc:   Game developed for Retro Jam 2021
-- script: lua

function init()
    -- Player
    -- TODO: Change to paddle
    player = {
        x = (240 / 2) - 12,
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

    -- Bricks
    bricks = {}
    brick_count_height = 1
    brick_count_width = 19
    
    for i = 0, brick_count_height, 1 do
        for j = 0, brick_count_width, 1 do
            local brick = {
                x = 10 + j * 11,
                y = 10 + i * 5,
                width = 10,
                height = 4,
                color = i + 1
            }

            table.insert(bricks, brick)
        end
   end
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
        ball.x = player.x + (player.width/2) - 1.5
        ball.y = player.y - 5
      
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

    -- Draw bricks
    for i, brick in pairs(bricks) do
        rect(
            bricks[i].x,
            bricks[i].y,
            bricks[i].width,
            bricks[i].height,
            bricks[i].color
        )
    end
end

function collisions()
    player_wall_collision()
    ball_wall_collision()
    ball_ground_collision()
    player_ball_collision()
    ball_brick_collisions()
end

function player_wall_collision()
    if player.x < 0 then
        player.x = 0

    elseif player.x + player.width > 240 then
        player.x = 240 - player.width

    end
end

function ball_wall_collision()
    if ball.y < 0 then
        -- Top
        ball.speed.y = -ball.speed.y

    elseif ball.x < 0 then
        -- Left
        ball.speed.x = -ball.speed.x

    elseif ball.x > 240 - ball.width then
        -- Right
        ball.speed.x = -ball.speed.x

    end
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

function player_ball_collision()
    if collide(player, ball) then
        ball.speed.y = -ball.speed.y
        ball.speed.x = ball.speed.x + 0.3 * player.speed.x
    end
end

function ball_brick_collisions()
    for i, brick in pairs(bricks) do
        -- Get parameters
        local x = bricks[i].x
        local y = bricks[i].y
        local w = bricks[i].width
        local h = bricks[i].height
       
        -- Check collision
        if collide(ball, bricks[i]) then
            -- Collide left or right side
            if y < ball.y and ball.y < y + h and ball.x < x or x + w < ball.x then
                ball.speed.x = -ball.speed.x
            end

            -- Collide top or bottom side		
            if ball.y < y or ball.y > y and x < ball.x and ball.x < x + w then
                ball.speed.y = -ball.speed.y
            end

            table.remove(bricks, i)
            print(i)
         end
    end
end

function collide(a,b)
    -- Get parameters from a and b
    local ax = a.x
    local ay = a.y
    local aw = a.width
    local ah = a.height
    local bx = b.x
    local by = b.y
    local bw = b.width
    local bh = b.height
   
    -- Check collision
    if ax < bx + bw and ax + aw > bx and ay < by + bh and ah + ay > by then
        -- Collision
        return true
    end

    -- No collision
    return false
end

function TIC()
    cls()
    input()
    update()
    collisions()
    draw()
 end

-- <TILES>
-- 000:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <PALETTE>
-- 000:000000f60404ffff00000000000000000000000000000000000000000000000000000000000000000000000000ffffff
-- </PALETTE>

