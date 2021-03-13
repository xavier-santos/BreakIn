function collisions()
    paddle_wall_collision()
    ball_wall_collision()
    ball_ground_collision()
    paddle_ball_collision()
    ball_brick_collisions()
end

function paddle_wall_collision()
    if paddle.x < 0 then
        paddle.x = 0

    elseif paddle.x + paddle.width > 240 then
        paddle.x = 240 - paddle.width

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
    if ball.y + ball.height > 136 then
        -- Reset ball
        ball.deactive = true

        -- Loss a life
        if player.lives > 0 then
            player.lives = player.lives - 1

        elseif player.lives == 0 then
            game_over()

        end
    end
end

function paddle_ball_collision()
    if collide(paddle, ball) then
        ball.speed.y = -ball.speed.y
        ball.speed.x = ball.speed.x + 0.3 * paddle.speed.x
    end
end

function ball_brick_collisions()
    for i, brick in pairs(bricks) do
        -- Get parameters
        local x = brick.x
        local y = brick.y
        local w = brick.width
        local h = brick.height
       
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
    return ax < bx + bw and ax + aw > bx and ay < by + bh and ah + ay > by
end