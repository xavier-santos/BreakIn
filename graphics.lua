function draw()
    draw_game_objects()
    draw_gui()
end

function draw_game_objects()
    -- Draw black hole
    rect(
        black_hole.center_x,
        black_hole.center_y,
        black_hole.rx,
        black_hole.ry,
        black_hole.color
    )

    -- Draw paddle
    tri(paddle.x1, paddle.y1, paddle.x2, paddle.y2, paddle.x3, paddle.y3, 1)
    tri(paddle.x2, paddle.y2, paddle.x3, paddle.y3, paddle.x4, paddle.y4, 1)

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
end

function draw_gui() 
end

function rotate(x, y, angle) 
    _x = x * math.cos(angle) - y * math.sin(angle)
    _y = x * math.sin(angle) + y * math.cos(angle)

    return _x, _y
end

function translate(x, y, w, h)
    return x + w, y + h
end