function draw()
    draw_game_objects()
    -- draw_gui()
end

function draw_game_objects()
    -- Draw paddle
    draw_paddle()

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
            brick.x,
            brick.y,
            brick.width,
            brick.height,
            brick.color
        )
    end

    rect(
        center_x,
        center_y,
        rx,
        ry,
        1
    )

end

function draw_paddle()
    x = paddle.x
    y = paddle.y
    h = paddle.height
    w = paddle.width
    angle = paddle.angle

    x1, y1 = rotate(-w, h, angle)
    x1, y1 = translate(x1, y1, x, y)

    x2, y2 = rotate(-w, -h, angle)
    x2, y2 = translate(x2, y2, x, y)
    
    x3, y3 = rotate(w, h, angle)
    x3, y3 = translate(x3, y3, x, y)

    x4, y4 = rotate(w, -h, angle)
    x4, y4 = translate(x4, y4, x, y)

    tri(x1, y1, x2, y2, x3, y3, 1)
    tri(x2, y2, x3, y3, x4, y4, 1)
end

function rotate(x, y, angle) 
    _x = x * math.cos(angle) - y * math.sin(angle)
    _y = x * math.sin(angle) + y * math.cos(angle)

    return _x, _y
end

function translate(x, y, w, h)
    return x + w, y + h
end