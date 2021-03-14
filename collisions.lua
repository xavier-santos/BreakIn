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

    elseif ball.y > 166 then
        -- Down
        ball.speed.y = -ball.speed.y

    elseif ball.x < 1 then
        -- Left
        ball.speed.x = -ball.speed.x

    elseif ball.x > 240 - ball.width then
        -- Right
        ball.speed.x = -ball.speed.x

    end
end

function ball_ground_collision()

    a = ball.x + ball.height < center_x + rx
    b = ball.x + ball.height > center_x - rx
    c = ball.y + ball.height < center_y + ry
    d = ball.y + ball.height < center_y - ry

    if a and b and c and d then
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
    if border_collide(paddle, ball) then
        print("collide")
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

function collide(a, b)
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

function border_collide(a, b)
    local a1 = {a.x1, a.y1, a.x2, a.y2}
    local a2 = {a.x1, a.y1, a.x3, a.y3}
    local a3 = {a.x2, a.y2, a.x4, a.y4}
    local a4 = {a.x3, a.y3, a.x4, a.y4}

    local b1 = {b.x1, b.y1, b.x2, b.y2}
    local b2 = {b.x1, b.y1, b.x3, b.y3}
    local b3 = {b.x2, b.y2, b.x4, b.y4}
    local b4 = {b.x3, b.y3, b.x4, b.y4}

    for _, l1 in pairs({a1, a2, a3, a4}) do
        for _, l2 in pairs({b1, b2, b3, b4}) do
            if line_intersection(l1, l2) then
                return true
            end
        end
    end

    return false
end

function on_segment(x0, y0, x1, y1, x2, y2)
    return 
        x1 <= math.max(x0, x2) and 
        x1 >= math.min(x0, x2) and 
        y1 <= math.max(y0, y2) and
        y1 >= math.min(y0, y2)
end

function orientation(x0, y0, x1, y1, x2, y2)
    -- To find the orientation of an ordered triplet (p,q,r) 
    -- 0 : Colinear points 
    -- 1 : Clockwise points 
    -- 2 : Counterclockwise 

    val = (y1 - y0) * (x2 - x1) - (x1 - x0) * (y2 - y1)

    if val > 0 then
        return 1  -- Clockwise orientation

    elseif val < 0 then
        return 2  -- Counter-clockwise orientation

    else
        return 0  -- Colinear orientation

    end
end

function line_intersection(l1, l2)
    local x0 = l1[1]
    local y0 = l1[2] 
    local x1 = l1[3] 
    local y1 = l1[4] 
    
    local x2 = l2[1] 
    local y2 = l2[2] 
    local x3 = l2[3] 
    local y3 = l2[4]

    -- Find the 4 orientations required for the general and special cases 
    o1 = orientation(x0, y0, x1, y1, x2, y2) 
    o2 = orientation(x0, y0, x1, y1, x3, y3) 
    o3 = orientation(x2, y2, x3, y3, x0, y0) 
    o4 = orientation(x2, y2, x3, y3, x1, y1)
    
    -- General case 
    if o1 ~= o2 and o3 ~= o4 then
        return true
    end

    -- p1 , q1 and x2, y1, are colinear and x2, y1, lies on segment p1q1 
    if o1 == 0 and on_segment(x0, y0, x2, y2, x1, y1) then
        return true
    end
  
    -- p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if o2 == 0 and on_segment(x0, y0, x3, y3, x1, y1) then
        return true
    end
  
    -- x2, y1 and q2 and p1 are colinear and p1 lies on segment x2, y1,q2 
    if o3 == 0 and on_segment(x2, y2, x0, y0, x3, y3) then
        return true
    end
  
    -- x2, y1, q2 and q1 are colinear and q1 lies on segment x2, y1,q2 
    if o4 == 0 and on_segment(x2, y2, x1, y1, x3, y3) then
        return true
    end
  
    -- If none of the cases 
    return False
end
