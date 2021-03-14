function input()
    local sx = paddle.speed.x
    local sy = paddle.speed.y
    local smax = paddle.speed.max

    -- Move up
    if btn(0) then
        if sy > -smax then
            sy = sy - 2

        else
            sy = -smax

        end	 
    end

    -- Move down
    if btn(1) then
        if sy < smax then
            sy = sy + 2

        else
            sy = smax

        end	 
    end

    -- Move to left
    if btn(2) then
        if sx > -smax then
            sx = sx - 2

        else
            sx = -smax

        end	 
    end

    -- Move to right
    if btn(3) then
        if sx < smax then
            sx = sx + 2
            
        else
            sx = smax

        end
    end

    -- Deactived ball
    if ball.deactive then
        if btn(6) then
            ball.speed.x = math.floor(math.random()) * 2 - 1
            ball.speed.y = -1.5
            ball.deactive = false
        end
    else
        -- Anti-clockwise rotate
        if btn(4) then
            paddle.angle = (paddle.angle + math.pi / 16) % math.pi
        end

        -- Clockwise rotate
        if btn(5) then
            paddle.angle = (paddle.angle - math.pi / 16) % math.pi
        end
    end

    -- Use powerup
    if btn(7) then
        use_powerup()
    end

    paddle.speed.x = sx
    paddle.speed.y = sy
    paddle.speed.max = smax
end

function use_powerup()
    -- Explode in a X pattern
    if player.powerup.name == "xbox" then
        local x1 = ball.x - 21
        local y1 = ball.y - 21
        local x2 = ball.x + 21
        local y2 = ball.y + 21

        local l1 = {x1, y1, x2, y2}
        local l2 = {x1, y2, x2, y1}
  
        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y
            local l3 = {x - 5, y - 5, x + 5, y + 5}
            local l4 = {x + 5, y - 5, x - 5, y + 5}

            if line_intersection(l4, l1) or line_intersection(l3, l2) then
                bricks[i] = nil
            end
        end

    -- Slows down time
    elseif player.powerup.name == "sanic" then
        ball.speed.x = ball.speed.x / 2
        ball.speed.y = ball.speed.y / 2

    -- Cuts whole row/column
    elseif player.powerup.name == "stab" then    
        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y

            if (x > ball.x - 5 and x < ball.x + 5) or (y > ball.y - 5 and y < ball.y + 5) then
                bricks[i] = nil
            
            end
        end

    -- Explode in a square pattern
    elseif player.powerup.name == "creeper" then
        local r = 21

        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y

            if x < ball.x + r and x > ball.x - r and y < ball.y + r and y > ball.y - r then
                bricks[i] = nil
            end
        end

    -- Gives one extra life
    elseif player.powerup.name == "sus" then
        player.lives = player.lives + 1

    -- Increases paddle size
    elseif player.powerup.name == "help" then
        paddle.width = paddle.width + 10
    end
end