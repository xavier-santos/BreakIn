function init()
    -- Player
    player = {
        -- TODO: Include selected character
        score = 0,
        lives = 3
    }

    -- Black Hole

    rx = 5
    ry = 5
    center_x = 240/2 - rx/2
    center_y = 136/2 - ry/2


    -- Paddle
    paddle = {
        x = (240 / 2) - 12,
        y = 120,
        x1 = 0, 
        y1 = 0,
        x2 = 0,
        y2 = 0,
        x3 = 0,
        y3 = 0,
        x4 = 0,
        y4 = 0,
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
        y = paddle.y - 6,
        x1 = 0, 
        y1 = 0,
        x2 = 0,
        y2 = 0,
        x3 = 0,
        y3 = 0,
        x4 = 0,
        y4 = 0,
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
        brick_width = 9
    
        bricks = {}
        brick_count_height = 6
        brick_count_width = 17
        square_size = 35
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = square_size + j * (brick_width),
                    y = i * 5,
                    width = brick_width-1,
                    height = 4,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end
    
        -- 136 = borda + (tijolos*10)
        brick_count_width = 7
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = i * 5,
                    y = square_size + j * (brick_width),
                    width = 4,
                    height = brick_width - 1,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end
    
        brick_count_width = 17
    
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = 223 - (square_size + j * (brick_width)) ,
                    y = 136 - (i*5),
                    width = (brick_width - 1),
                    height = 4,
                    color = i + 1
                }            
                table.insert(bricks, brick)
            end
        end
    
        brick_count_width = 7
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = 227 - (i*5),
                    y = square_size + j * (brick_width),
                    width = 4,
                    height = brick_width - 1,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end
end