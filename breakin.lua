-- title:  Breakin
-- author: Triceratops 
-- desc:   Game developed for Retro Jam 2021
-- script: lua

require "collisions"
require "graphics"
require "input"

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
        color = 2,
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

init()

function update()
    local px = paddle.x
    local py = paddle.y
    local psx = paddle.speed.x
    local psy = paddle.speed.y
    local smax = paddle.speed.max

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

function TIC()
    cls()
    input()
    update()
    collisions()
    draw()
 end

-- <TILES>
-- 000:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <PALETTE>
-- 000:140c1cfa183430346d4e4a4f854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

