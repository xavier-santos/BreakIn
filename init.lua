function init()
    -- Player
    player = {
        -- TODO: Include selected character
        score = 0,
        lives = 3
    }

    -- Paddle
    paddle = {
        x = (240 / 2) - 12,
        y = 120,
        width = 12,
        height = 2,
        color = 1,
        angle = 0,
        speed = {
            x = 0,
            y = 0,
            max = 4
        }
    }

    -- Ball
    ball = {
        x = paddle.x + (paddle.width / 2) - 1.5,
        y = paddle.y - 5,
        width = 3,
        height = 3,
        color = 3,
        deactive = true,
        speed = {
            x = 0,
            y = 0,
            max = 1.5
        }
    }

    -- Bricks
    bricks = {}
    brick_count_height = 0
    brick_count_width = 0
    
    for i = 0, brick_count_height do
        for j = 0, brick_count_width do
            local brick = {
                x = 32 + j * 11,
                y = 32 + i * 5,
                width = 10,
                height = 4,
                color = i + 1
            }

            table.insert(bricks, brick)
        end
   end
end