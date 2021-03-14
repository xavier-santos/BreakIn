function update()
    local px = paddle.x
    local py = paddle.y
    local psx = paddle.speed.x
    local psy = paddle.speed.y
    local smax = paddle.speed.max
    local x = paddle.x
    local y = paddle.y
    local h = paddle.height
    local w = paddle.width
    local angle = paddle.angle

    -- Update paddle corners coordinates
    paddle.x1, paddle.y1 = rotate(-w, h, angle)
    paddle.x1, paddle.y1 = translate(paddle.x1, paddle.y1, x, y)

    paddle.x2, paddle.y2 = rotate(-w, -h, angle)
    paddle.x2, paddle.y2 = translate(paddle.x2, paddle.y2, x, y)
    
    paddle.x3, paddle.y3 = rotate(w, h, angle)
    paddle.x3, paddle.y3 = translate(paddle.x3, paddle.y3, x, y)

    paddle.x4, paddle.y4 = rotate(w, -h, angle)
    paddle.x4, paddle.y4 = translate(paddle.x4, paddle.y4, x, y)

    ball.x1 = ball.x
    ball.y1 = ball.y

    ball.x2 = ball.x + ball.width
    ball.y2 = ball.y

    ball.x3 = ball.x 
    ball.y3 = ball.y + ball.height

    ball.x4 = ball.x + ball.width
    ball.y4 = ball.y + ball.height

    -- Update paddle position
    px = px + psx
    py = py + psy

    -- Reduce paddle speed
    if psx ~= 0 then
        if psx > 0 then
            psx = psx - 1

        else
            psx = psx + 1

        end
    end

    if psy ~= 0 then
        if psy > 0 then
            psy = psy - 1

        else
            psy = psy + 1

        end
    end

    -- Update ball position
    ball.x = ball.x + ball.speed.x
    ball.y = ball.y + ball.speed.y

    -- Check max ball speed
    if ball.speed.x > ball.speed.max then
        ball.speed.x = ball.speed.max
    end

    if ball.speed.y > ball.speed.max then
        ball.speed.y = ball.speed.max
    end

    paddle.x = px
    paddle.y = py
    paddle.speed.x = psx
    paddle.speed.y = psy
    paddle.speed.max = smax
end