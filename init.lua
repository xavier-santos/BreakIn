function init(character)
    -- Player
    player = {
        powerup = character,
        score = 0,
        lives = 3
    }

    -- Black Hole

    local black_hole_size = 3 -- menor que 6

    black_hole = {
        rx = 8 * black_hole_size, --precisa de ser um número par
        ry = 6 * black_hole_size, --precisa de ser um número par
        center_x = 0,
        center_y = 0,
        color = 3 
    }
    black_hole.center_x = 240/2 - black_hole.rx/2
    black_hole.center_y = 136/2 - black_hole.ry/2 + 2 -- mais para baixo



    -- Paddle
    paddle = {
        x = (240 / 2) - 1,
        y =  black_hole.center_y - 4,
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
        color = 4,
        deactive = true,
        speed = {
            x = 0,
            y = 0,
            max = 1.5
        }
    }
    
    -- Bricks
    
    local shift_x = -4 --entre -4 e -5
    local zoom_y = 5 --entre 

        brick_width = 9
    
        -- Cima

        bricks = {}
        brick_count_height = 5
        brick_count_width = 17
        square_size = 35
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = square_size + j * (brick_width) - shift_x,
                    y = i * 5 + zoom_y,
                    width = brick_width - 1,
                    height = 4,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end

        -- Lado esquerdo
    
        -- 136 = borda + (tijolos*10)
        brick_count_height = 6
        brick_count_width = 7
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = i * 5 - shift_x,
                    y = square_size + j * (brick_width),
                    width = 4,
                    height = brick_width - 1,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end
        -- Baixo
        brick_count_width = 17
        brick_count_height = 5
    
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = 223 - (square_size + j * (brick_width)) - shift_x,
                    y = 136 - (i*5) - zoom_y,
                    width = (brick_width - 1),
                    height = 4,
                    color = i + 1
                }            
                table.insert(bricks, brick)
            end
        
        end
        -- Lado direito
        
        brick_count_width = 7
        brick_count_height = 6
        
        for i = 0, brick_count_height do
            for j = 0, brick_count_width do
                local brick = {
                    x = 227 - (i*5) - shift_x,
                    y = square_size + j * (brick_width),
                    width = 4,
                    height = brick_width - 1,
                    color = i + 1
                }
                table.insert(bricks, brick)
            end
        end
end