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

    paddle.speed.x = sx
    paddle.speed.y = sy
    paddle.speed.max = smax
end