alignment = {
	left_align = 44,
	middle_align = 104,
	right_align = 164,
}

sanic = {
	name = "sanic",
	x = alignment.middle_align,
	y = 20,
	sprite = 0,
	size = 4,
	text = "Gotta go feeeeeest!\n\nGet the time controlling powers\nof the blue wonder."
}

xbox = {
	name = "xbox",
	x = alignment.left_align,
	y = 20,
	sprite = 4,
	size =	4,
	text = "X-Box One X... Box One X...\n\nExplode blocks in a pattern that will make\nany Playstation owner look at you weird."
}

stab = {
	name = "stab",
	x = alignment.right_align,
	y = 20,
	sprite = 8,
	size = 4,
	text = "Stabby stab!\n\nSlash blocks like you're a yandere and\nsomeone is stealing your boyfriend."
}

help = {
	name = "help",
	x = alignment.right_align,
	y = 64,
	sprite = 12,
	size = 4,
	text = "Everyone needs a lil help sometimes.\n\nThis nice boi will make your paddle bigger and\nmake you feel safe and cozy."
}

sus = {
	name = "sus",
	x = alignment.middle_align,
	y = 64,
	sprite = 64,
	size = 4,
	text = "Puppy eyes that will melt the game devs'\nhearts and grant you a sneaky extra life\ncheat code.\n\nShhh... don't tell the others."
}

creeper = {
	name = "creeper",
	x = alignment.left_align,
	y = 64,
	sprite = 68,
	size = 4,
	text = "Boom!"
}

depressed = {
	name = depressed,
	x = alignment.middle_align - 16,
	y = 32,
	sprite = 72,
	size = 4,
	text = "Use your reactions and cry again..."
}

hype = {
	name = "hype",
	x = alignment.middle_align - 16,
	y = 40,
	sprite = 76,
	size = 4,
	text = "Ninja reflexes!"
}

heart = {
	name = "heart",
	x = 240 - 36,
	y = 16,
	sprite = 128,
	size = 1,
	text = "Undertale FTW!"
}

Renderer = {
	sprite_grid = {{xbox, sanic, stab}, {creeper, sus, help}},
	v = 1,
	h = 1
}

function character_select()

	--Title
	print("Choose your fighter", 60, 0, 12)
	print("(Press Z to select)", 60, 8, 12)
	
	--Render sprite grid
	for i = 1, 2 do
		for j = 1, 3 do
		generate_sprites(Renderer.sprite_grid[i][j], false)
		end
	end
	
	--Hover animation and selection
	return select()
end

function generate_sprites(name, scale, x, y)
	if x ~= nil and y ~= nil then
		spr(name.sprite, x, y, -1, 1, 0, 0, name.size, name.size)
	else	
		if scale then
			spr(name.sprite, name.x, name.y, -1, 2, 0, 0, name.size, name.size)
		else
			spr(name.sprite, name.x, name.y, -1, 1, 0, 0, name.size, name.size)
		end
	end
end

function select()
	--0 - UP, 1 - DOWN, 2 - LEFT, 3 - RIGHT, 4 - A BUTTON
	
	if btnp(0) then Renderer.v = Renderer.v - 1 end
	if btnp(1) then Renderer.v = Renderer.v + 1 end
	if btnp(2) then Renderer.h = Renderer.h - 1 end
	if btnp(3) then Renderer.h = Renderer.h + 1 end
	if btnp(4) then return Renderer.sprite_grid[Renderer.v][Renderer.h] end

	if Renderer.v < 1 then Renderer.v = 1 end
	if Renderer.v > 2 then Renderer.v = 2 end
	if Renderer.h < 1 then Renderer.h = 1 end
	if Renderer.h > 3 then Renderer.h = 3 end
	
	animate(Renderer.sprite_grid[Renderer.v][Renderer.h])
	print(Renderer.sprite_grid[Renderer.v][Renderer.h].text, 0, 100, 12)
end

function animate(name)
	t = (time()*2//10)%60//30
	spr(name.sprite, name.x, name.y - t, -1, 1,	0, 0, name.size, name.size)
end
function collisions() --returns true when game over collision is detected
    paddle_wall_collision()
    ball_wall_collision()
    ball_corner_collision()
    ball_black_hole_collisions()
    paddle_ball_collision()
    ball_brick_collisions() 
    return ball_black_hole_collisions()
end

function paddle_wall_collision()
    if paddle.x < 0 then
        paddle.x = 0

    elseif paddle.x + paddle.width > 240 then
        paddle.x = 240 - paddle.width

    end
end

function ball_wall_collision()
    -- Top wall
    if ball.y < 0 then
        ball.speed.y = -ball.speed.y

    -- Bottom wall
    elseif ball.y > 136 then
        ball.speed.y = -ball.speed.y
    
    -- Left wall
    elseif ball.x < 1 then
        ball.speed.x = -ball.speed.x
    
    -- Right wall
    elseif ball.x > 240 - ball.width then
        ball.speed.x = -ball.speed.x

    end
end

function ball_corner_collision()
    local a1 = {ball.x1, ball.y1, ball.x2, ball.y2}
    local a2 = {ball.x1, ball.y1, ball.x3, ball.y3}
    local a3 = {ball.x2, ball.y2, ball.x4, ball.y4}
    local a4 = {ball.x3, ball.y3, ball.x4, ball.y4}

    local x1 = 0
    local x2 = 39
    local x3 = 200
    local x4 = 240

    local y1 = 0
    local y2 = 30
    local y3 = 106
    local y4 = 136

    -- Top left corner
    local l1 = {x2, y1, x2, y2}
    local l2 = {x1, y2, x2, y2}

    if line_intersection(a2, l1) then
        ball.speed.x = -ball.speed.x

    elseif line_intersection(a1, l2) then
        ball.speed.y = -ball.speed.y

    end

    -- Top right corner
    local l3 = {x3, y1, x3, y2}
    local l4 = {x3, y2, x4, y2}

    if line_intersection(a3, l3) then
        ball.speed.x = -ball.speed.x

    elseif line_intersection(a1, l4) then
        ball.speed.y = -ball.speed.y

    end

    -- Bottom left corner
    local l5 = {x2, y3, x2, y4}
    local l6 = {x1, y3, x2, y3}

    if line_intersection(a2, l5) then
        ball.speed.x = -ball.speed.x

    elseif line_intersection(a4, l6) then
        ball.speed.y = -ball.speed.y

    end

    -- Bottom right corner
    local l7 = {x3, y3, x3, y4}
    local l8 = {x3, y3, x4, y3}

    if line_intersection(a3, l7) then
        ball.speed.x = -ball.speed.x

    elseif line_intersection(a4, l8) then
        ball.speed.y = -ball.speed.y

    end
end

function ball_black_hole_collisions()
    a = ball.x + ball.height < black_hole.center_x + black_hole.rx + 3   -- X left limit
    b = ball.x + ball.height > black_hole.center_x + 1                   -- X rigt limit
    c = ball.y + ball.height > black_hole.center_y                       -- Top limit
    d = ball.y + ball.height < black_hole.center_y + black_hole.ry + 3   -- Top limit

    if a and b and c and d then
        -- Reset ball
        ball.deactive = true

        -- Loss a life
        if player.lives > 0 then
            player.lives = player.lives - 1
        end
        if player.lives == 0 then
            return true --returns true when game is over

        end
    end
end

function paddle_ball_collision()
    if border_collide(paddle, ball) then
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

            bricks[i] = nil
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
function draw()
    draw_game_objects()
    draw_gui()
end

function draw_game_objects()
    -- Draw black hole
    spr(
        black_hole.sprite, 
        black_hole.center_x - black_hole.rx / 2, 
        black_hole.center_y - black_hole.ry + 4,  
        -1, 
        1, 
        0, 
        0, 
        4, 
        4
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
function init(character)
    -- Player
    player = {
        powerup = character,
        score = 0,
        lives = 6,
        powerup_available = false,
        powerup_frequency = 1
    }

    -- Black Hole
    local black_hole_size = 2 -- menor que 6

    black_hole = {
        sprite = 144,
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
        width = 16,
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

    remaining_time = 1000

    track = 0
end
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

    -- Use powerup
    if btn(7) and player.powerup_available then
        use_powerup()
        player.powerup_available = false
    end

    paddle.speed.x = sx
    paddle.speed.y = sy
    paddle.speed.max = smax
end

function use_powerup()
    -- Explode in a X pattern
    if player.powerup.name == "xbox" then
        local x1 = ball.x - 21
        local y1 = ball.y - 21
        local x2 = ball.x + 21
        local y2 = ball.y + 21

        local l1 = {x1, y1, x2, y2}
        local l2 = {x1, y2, x2, y1}
  
        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y
            local l3 = {x - 5, y - 5, x + 5, y + 5}
            local l4 = {x + 5, y - 5, x - 5, y + 5}

            if line_intersection(l4, l1) or line_intersection(l3, l2) then
                bricks[i] = nil
            end
        end

    -- Slows down time
    elseif player.powerup.name == "sanic" then
        ball.speed.x = ball.speed.x / 2
        ball.speed.y = ball.speed.y / 2

    -- Cuts whole row/column
    elseif player.powerup.name == "stab" then    
        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y

            if (x > ball.x - 5 and x < ball.x + 5) or (y > ball.y - 5 and y < ball.y + 5) then
                bricks[i] = nil
            
            end
        end

    -- Explode in a square pattern
    elseif player.powerup.name == "creeper" then
        local r = 21

        for i, brick in pairs(bricks) do
            local x = brick.x
            local y = brick.y

            if x < ball.x + r and x > ball.x - r and y < ball.y + r and y > ball.y - r then
                bricks[i] = nil
            end
        end

    -- Gives one extra life
    elseif player.powerup.name == "sus" then
        player.lives = player.lives + 2

    -- Increases paddle size
    elseif player.powerup.name == "help" then
        paddle.width = paddle.width + 10
    end
end

HUD = {
	screen = "start",
	animation_speed = 4
}

function screen_manager()
    if HUD.screen == "start"  then
		start()
	end	
	
	if HUD.screen == "start animation"  then
		start_animation()
	end
	
	if HUD.screen == "character select" then
		character = character_select()

		if character ~= nil then
			init(character)
			HUD.screen = "play"
			music(0)
		end
	end
	
	if HUD.screen == "game over" then
		game_over()
		for k = 0, 7 do
			if btnp(k) then
				HUD.screen = "character select"
				music(1)
				break
			end
		end
	end

	if HUD.screen == "win" then
		win()
		for k = 0, 7 do
			if btnp(k) then
				HUD.screen = "start"
				break
			end
		end
	end

	if HUD.screen == "play" then
		input()
    	if update() then HUD.screen = "win" end
    	if collisions() then HUD.screen = "game over" end
    	draw()
		gui()
	end
end

function start()
    map(0, 0)
	print("START", 210, 88, 4)
	print("Press any key", 165, 96, 12)
		
	for k = 0, 7 do
		if btnp(k) then
			animation_start = time()//100*HUD.animation_speed
			HUD.screen = "start animation"
			break
		end
	end
end

function start_animation()
    map(0, 0)
    print("START", 210, 88, 4)
    
	local x = 80
    local y = 128
    
	t = time()//100*HUD.animation_speed
    
	if play_start_animation(x, y) then HUD.screen = "character select" end
end

function play_start_animation(x, y)
	local diff = t - animation_start
	
	if x + diff > 228 then
		return true -- returns true when animation ends
	end
	
	if x + diff < 160 then
		spr(251, x + diff, y - diff)
	else 
		spr(251, x + diff, y - 120 + diff//2)
	end
end

function game_over()
    print("Game_Over", alignment.middle_align - 32, 0, 12, false, 2)
	
	generate_sprites(depressed, true)
	
	print(depressed.text, 24, depressed.y + 64 + 8, 12)

	print("Press any key", 24, depressed.y + 64 + 24, 12)
end

function win()
	print("Final_Score", alignment.middle_align - 40, 0, 12, false, 2)
	
	print(player.score, alignment.middle_align, 16, 12, false, 2)
	
	generate_sprites(hype, true)

	print(hype.text, alignment.middle_align - 24, hype.y + 64 + 16, 12)
end

function gui()
	-- upper left corner
	generate_sprites(player.powerup, false, 0, 0)

	-- upper right corner
	for l = 0, player.lives//2 - 1 do
		generate_sprites(heart, false, heart.x + l*9, heart.y)
	end

	-- lower left corner
	print("SCORE", 4, 110, 12)
	print(player.score, 4, 124, 12)

	-- lower right corner
	print("POWER\nUP", 240 - 36, 110 ,12)
	if player.powerup_available then
		print("PRESS\nS!!!", 240 - 36, 124, 12)
	end
end
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

    if px < 45 then
        px = 45

    elseif px > 190 then
        px = 190

    end

    if py < 40 then
        py = 40

    elseif py > 104 then
        py = 104

    end

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

    -- Deactived ball
    if ball.deactive then
        ball.x = paddle.x + (paddle.width / 2) - 1.5
        ball.y = paddle.y - 6
    end

    paddle.x = px
    paddle.y = py
    paddle.speed.x = psx
    paddle.speed.y = psy
    paddle.speed.max = smax

    remaining_time = remaining_time - 0.01
    player.score = math.floor(remaining_time * (player.lives + 1))
    
    -- Generate powerup
    random = math.random(0, 100)
    if random < player.powerup_frequency then player.powerup_available = true end

    return game_ended()
end

function game_ended()
    for i, brick in pairs(bricks) do
        if brick ~= nil then
            return false
        end
    end

    return true
end
-- title:  Breakin
-- author: TriceraTOP 
-- desc:   Game developed for Retro Jam 2021
-- script: lua


music(1)

function TIC()
    cls()
    screen_manager()
end

-- <TILES>
-- 000:000000000000000000000000000000cc00000c000000c0aa0000c000000c0aaa
-- 001:000ccccc00c00000cc0aaaaa000000aaaaaaaaacaaaaaaac0000aaaaaaaa00aa
-- 002:cc00000000ccc000aa000c00aaaaa0c00aac0a0ccaacca0caa0aaa0ca44aaa0c
-- 004:0000000000000000000000000000000c000000c000000c000000c000000c0000
-- 005:0000cccc00cc00000c000000c666d000006666d00006666d0000566600000556
-- 006:cccc00000000cc00000000c0000d666c0d666600d66660006665000065500000
-- 007:000000000000000000000000c00000000c00000000c00000000c00000000c000
-- 008:00000000000000000000000c000000cd00000cdd000ccddd0ccdddddcddddddd
-- 009:000ccccc00cdddddccdddddddddddddddddddddddddddddddddddddddddddddd
-- 010:ccccccc0dddddddcdddddddddddddddddddddddddddddddddddddd4ddddddd44
-- 011:00000000cccc0000ddddc000ddddc000dddddcc0ddddddccdddddddcddddddc0
-- 012:0000000c000000c400000c440000c444000c444400c4444400c444440c444444
-- 013:c444444444444444444444444400004440000004400000044000000440000004
-- 014:4444444444444444444444444444444444444444444444444444444444444444
-- 015:4444444444444444444444444444444444444444444444444444444444444444
-- 016:0000c000000cccc000c000000c0aaaaac0aa0000c0aa0aaac0c00aa0c0c0a00a
-- 017:000000aaaaa0c0a0000a0000aaa0aaaa0a0aaaa0000aaa04aa0aaa04000aaa04
-- 018:4004a0cca44a0cc0aaaaa00a0000aaa044440aa044440aa044440aa044440aa0
-- 019:ccccc00000000c00aaaaa0c00000a0c0ccc0a0c0c0c0a0c0c0c0c0c0cc0ccc0c
-- 020:000c000000c0000000c000000c0000000c0000000c0000060c0000660c000666
-- 021:00006655000666650066665d066665dd66665dd06666d000666d000066d00000
-- 022:5566000056666000d5666600dd5666600dd56666000d66660000d66600000d66
-- 023:0000c00000000c0000000c00000000c0000000c0600000c0660000c0666000c0
-- 024:cdddddddcdddddddcddddddd0cdddddd00cddddd00cddddd0cddddddcddddddd
-- 025:dddddddddddddd4dddddd444ddddd444dddd4444dddd4888dddd8c88dddd8c88
-- 026:dddddd44dddddd44dddddd444dddddd44444444484444448c844448cc844448c
-- 027:ddddddc04dddddc04ddddc0044ddddc0444dddc08884ddc088c8dddc88c8dddc
-- 028:0ccc44440ccccc440ccccccc0ccccccc0c0ccccc0c0ccc0c0c0ccc0c0c0ccc0c
-- 029:4400004444444444cc444444cccccc44cccccccccccccccccccccccccc00000c
-- 030:44444444444444444444444444444444cccc4444cccccccccccccccccccccccc
-- 031:4400004440000004400000044000000440000004ccc00044cccccc44cccccccc
-- 032:c0cc00aac0ccc00ac0ccc0c00c000c0c00ccc0c000000c0a0000c00a000c0aa0
-- 033:0c0aaa000c0aaaa0cc0aaaaac0aaaaaa0aa00aaaa00cc0000cc00cccc0000000
-- 034:44440aa04440aa0c000aaa0caaaaa0c0aaaa0c000000a0c0ccc0a00c00c0aa0c
-- 035:0c0ccc0c00c000c0000ccc000000000000000000000000000000000000000000
-- 036:0c0006660c0066660c0066600c0666000c06600000c6000000c60000000c0000
-- 037:6000000000000000000000000000000000000000000000000000000000000000
-- 038:0000000600000000000000000000000000000000000000000000000000000000
-- 039:666000c0666600c0066600c0006660c0000660c000006c0000006c000000c000
-- 040:0cddddddcdddddddcdddddddcdddddddcdddddddcdddddddcddddddd0cdddddd
-- 041:dddd4888dddd2222dddd2222dddd2222ddddd222dddddd88dddddd88ddddd888
-- 042:84444448224888422244444222444444244444cc88888ccc8888cccc888ccccc
-- 043:888ccddc22cccddc2ccccddccccccddcccccdddcccccdddccccddddccccddddc
-- 044:0c00000c0c0ccc0c0c0ccc0c0c0ccc0c0ccccc0c0ccccccc0ccccccc0ccccccc
-- 045:cc0ccccccc0ccccccc0ccccccc0000cccc0ccccccc0ccccccc00000ccccccccc
-- 046:cccccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccccc
-- 047:ccccccccccccccccc00000ccc0cccc0cc0cccc04c00000c4c0cccc44c0ccc444
-- 048:00c0aa0c0cc0a00cc000a0c0c02220c0c02220c00c000c0000ccc00000000000
-- 050:000c0a0c000c0aa00000c0a00000c0aa00000c0a00000c00000000cc00000000
-- 051:00000000ccc00000000c00002220c0002220c000000c0000ccc0000000000000
-- 052:000c00000000c00000000c00000000c00000000c000000000000000000000000
-- 053:00000000000000000000000000000000c00000000cc00000000ccccc00000000
-- 054:000000000000000000000000000000000000000c00000cc0ccccc00000000000
-- 055:0000c000000c000000c000000c000000c0000000000000000000000000000000
-- 056:0cdddddd0cdddddd00cddddd000cdddd0000cddd00000cdd00000cc800000000
-- 057:ddddd888dddddd88dddddddddddddddcdddd8dcc8ddd88cc80d888cc00000000
-- 058:88cccccc8ccccccccccccccccccccccdccccccddcccccdd8ccccdd8800000000
-- 059:ccdddddccd8ddddcd888ddc0888cddc088cccc008ccc0000ccccc00000000000
-- 060:0ccccccc0ccccccc0ccccccc0c4ccccc0c4444cc00c4444400c4444400000000
-- 061:cccccccccccccccccccccccccccccccccccccccc4444cccc4444444400000000
-- 062:cc00000ccccccccccccccccccccccccccccccccccccccccc44cccccc00000000
-- 063:c0c44444c0444444c44444444444444444444444444444444444444400000000
-- 064:0000000000000000000000000000000c00000cc40000c444000c444400c44444
-- 065:00000ccc00ccc444cc4444444444444444444444444444444444444444444444
-- 066:cccc00004444cc00444444cc4444444444444444444444444444444444444444
-- 067:0000000000000000cc00000044c0000044cc00004444c00044444c0044444c00
-- 068:0cccccccc5557777c5557777c5557777c7776666c7776666c7776666c7776666
-- 069:cccccccc6666cccc6666cccc6666cccc77776666777766667777666677776666
-- 070:cccccccc55555555555555555555555566665555666655556666555566665555
-- 071:ccccccc06666555c6666555c6666555c7777cccc7777cccc7777cccc7777cccc
-- 072:0000000000000000000000000000000c000000c200000c220000c222000c2222
-- 073:000000000000cccc00cc2222cc22222222222222222222223222232223223222
-- 074:00000000ccc00000222ccc00222222cc22222222222222222323222232222232
-- 075:000000000000000000000000c00000002c00000022c00000232c00002222c000
-- 076:0000c33c0cc00c3cc33c00ccc333c0c10ccc0c110000c11100c0c1110c4c1111
-- 077:00ccccc1cc1111111111111111111111111111111c111111c1c1c111111c1111
-- 078:c1111111111111111111111111111111111111111111111111111c1c1c1411c1
-- 079:1ccc00001111c000111c00001111cc00111114c0c111444c1c11184c1111188c
-- 080:00c444440c44444c0c4444cc0c4444c00c4444c0c44444c0c44444c0c4433330
-- 081:c000044400000044000000040000000400000004000000040000000400000004
-- 082:444000044c0000004c0000004c0000004c0000004c0000004c0000004cc00000
-- 083:44444c00044444c0004444c00044444c0044444c0044444c0044444c0044444c
-- 084:c5550000c5550000c5550000c5550000c5550000c5550000c5550000c5550000
-- 085:0000cccc0000cccc0000cccc0000cccc00006666000066660000666600006666
-- 086:5555000055550000555500005555000066660000666600006666000066660000
-- 087:0000777c0000777c0000777c0000777c0000555c0000555c0000555c0000555c
-- 088:000c223200c233230c2223220c233233c2323232c3233333c3323233c3333333
-- 089:2223332332323232232323233222232222332333233333333333333334333333
-- 090:2232322332322322222232233332332223233233332233333333333333333334
-- 091:3232c00022332c00322332c0233222c03223232c2333233c3323333c3333333c
-- 092:c4441111c4881111c8881111c8891111c8911111c8881111c8881111c8881111
-- 093:1111141111111141111114441111144411114444111400041140444411444444
-- 094:c111141111144441114444441444444444444000444404444444443444422243
-- 095:1111189c1111198c4111888c4111888c4411888c3411189c4341198c4441118c
-- 096:c4333333c4303033c4330303c4333030c4333333c44333330c4444440c444444
-- 097:0000000400000004cc0000443cccc44434444444444444444444440044444444
-- 098:44c0000044c00000444c00004444cccc44444444444444440004444444444444
-- 099:0033334c0033033c0330303cc303033c3333333c4333334c444444c0444444c0
-- 100:c6665555c6665555c6665555c6665555c7775555c7775555c7775555c7775555
-- 101:6666000066660000666600006666000000000000000000000000000000000000
-- 102:0000555500005555000055550000555500000000000000000000000000000000
-- 103:5555666c5555666c5555666c5555666c7777cccc7777cccc7777cccc7777cccc
-- 104:c3433333c3343443c3333433c4344334c4443433044344340c4444440c444444
-- 105:4334333434333433433343343444434443434443444444330000444444000004
-- 106:3433433333433343434343343334434334343434434344444434440044440000
-- 107:3333434c4334343c3433333c3434343c4434434c444434c00004440004444c00
-- 108:c9898111c8988111c8881111c8881111c8881111c98911110c9811110c881111
-- 109:1144344214344342444344421444444411444444118888881198888811889898
-- 110:222222442223324423333344233334444444448889888888889888889988ccc8
-- 111:4441111c4411111c4811111c8881111c8881111c8911111c9811111c8ccccc1c
-- 112:00c44444000c4444000c44440000c44400000cc40000000c0000000000000000
-- 113:4444444444444444444444444444444444444444c44444440ccccccc00000000
-- 114:44444444444444444444444444444444444444444444444cccccccc000000000
-- 115:444444c044444c0044444c004444c000444c0000ccc000000000000000000000
-- 116:cccc6666cccc6666cccc6666cccc6666c6665555c66655550ccccccc00000000
-- 117:000000000000000000000000000000000000666600006666cccccccc00000000
-- 118:000000000000000000000000000000005555000055550000cccccccc00000000
-- 119:5555666c5555666c5555666c5555666c6666555c6666555cccccccc000000000
-- 120:00c4444400c44444000c44440000c44400000cc40000000c0000000000000000
-- 121:4400044444aa444444aa444444aa440044a44444c44444440ccccccc00000000
-- 122:444444004444444a4444444a0044444a44444444444444cccccccc0000000000
-- 123:a444c000a444c000a44c000044c00000cc000000000000000000000000000000
-- 124:0c88c11c0c8c2cc20c8c2cc2cc1c2cc2c11c2222c11c2cc2c11c2cc20c1c2cc2
-- 125:c8cc88882c22c88c2c22c88c2cc22cc22c8c22c22c88c22c2c8c22c82cc22c88
-- 126:c8cc222c2c2222222c22ccc22c22ccc2cc22cc228c2222cc8c22cc888c22c888
-- 127:c22222ccc22222ccc2cccc1cc22c111cc222c11cc2cccc1cc2cc22c0c2c222c0
-- 128:0cc00cc0c44cc44cc444444cc444444cc444444c0c4444c000c44c00000cc000
-- 145:0000000000000000000000000000000000000000000000cc0000cc4400cc4433
-- 146:0000000000000000000000000000000000000000cc00000044cc00003344cc00
-- 160:00000000000000000000000c0000000c000000c4000000c400000c4300000c43
-- 161:0c443322c4332211432211004321000032100000321000002100000021000000
-- 162:223344c01122334c001122340000123400000123000001230000001200000012
-- 163:0000000000000000c0000000c00000004c0000004c00000034c0000034c00000
-- 176:00000c4300000c43000000c4000000c40000000c0000000c0000000000000000
-- 177:210000002100000032100000321000004321000043221100c43322110c443322
-- 178:0000001200000012000001230000012300001234001122341122334c223344c0
-- 179:34c0000034c000004c0000004c000000c0000000c00000000000000000000000
-- 193:00cc44330000cc44000000cc0000000000000000000000000000000000000000
-- 194:3344cc0044cc0000cc0000000000000000000000000000000000000000000000
-- 240:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 241:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
-- 242:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 243:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 244:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
-- 245:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 246:9999999999999999999999999999999999999999999999999999999999999999
-- 247:8888888888888888888888888888888888888888888888888888888888888888
-- 248:7777777777777777777777777777777777777777777777777777777777777777
-- 249:6666666666666666666666666666666666666666666666666666666666666666
-- 250:5555555555555555555555555555555555555555555555555555555555555555
-- 251:4444444444444444444444444444444444444444444444444444444444444444
-- 252:3333333333333333333333333333333333333333333333333333333333333333
-- 253:2222222222222222222222222222222222222222222222222222222222222222
-- 254:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <MAP>
-- 000:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 001:ffefefffffffffffffffffffffffffffffffffffffffffff8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 002:ffefffefffffffffffffffffffffffafffffffffffffffff8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 003:ffefefffffdfdfffcfcfffffbfffffafffafffffffffffff8fff6f6f6fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 004:ffefffefffdfffffcfffffbfffbfffafafffffffffffffff8fff6fff6fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 005:ffefefffffdfffffcfcfffbfbfbfffafffafff9f9f9f9fff8fff6fff6fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 006:ffffffffffffffffcfffffbfffbfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 007:ffffffffffffffffcfcfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 008:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 009:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 010:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 011:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 012:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 013:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 014:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 015:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 016:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 017:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 018:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 019:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 020:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 021:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 022:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 023:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 024:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 025:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 026:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 027:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 028:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 029:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 030:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 031:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 032:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 033:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 034:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 035:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 036:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 037:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 038:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 039:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 040:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 041:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 042:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 043:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 044:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 045:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 046:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 047:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 048:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 049:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 050:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 051:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 052:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 053:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 054:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 055:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 056:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 057:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 058:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 059:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 060:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 061:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 062:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 063:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 064:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 065:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 066:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 067:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 068:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 069:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 070:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 071:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 072:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 073:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 074:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 075:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 076:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 077:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 078:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 079:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 080:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 081:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 082:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 083:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 084:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 085:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 086:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 087:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 088:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 089:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 090:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 091:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 092:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 093:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 094:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 095:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 096:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 097:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 098:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 099:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 100:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 101:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 102:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 103:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 104:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 105:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 106:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 107:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 108:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 109:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 110:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 111:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 112:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 113:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 114:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 115:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 116:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 117:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 118:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 119:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 120:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 121:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 122:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 123:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 124:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 125:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 126:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 127:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 128:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 129:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 130:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 131:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 132:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 133:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 134:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 135:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- </MAP>


-- <WAVES>
-- 000:ffffffffffffffffffeddcbaa9887765
-- 001:cdccccccccccc066666666660dddd0dd
-- </WAVES>

-- <SFX>
-- 000:0000000000000000000010003000500070008000a000c000d000f000d000d000e000e000e000f000f000f000f000f000f000f000f000f000f000f0002720000000c2
-- 001:70008000800080009000a000b000c000d000e000e000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000307000000000
-- 002:61006100610061006100710071007100710071009100a100a100b100d100d100e100e100e100e100e100e100f100f100f100f100f100f100f100f100209000000000
-- 003:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000407000000000
-- 016:000000000000000010002000200030004000500050007000700080009000a000a000b000c000d000e000e000f000f000f000f000f000f000f000f000102000000000
-- </SFX>

-- <PATTERNS>
-- 000:400006000000000000000000b00006000000000000000000b00006000000000000000000600006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 001:000000000000400018000000000000000000400018000000000000000000f00016000000000000000000f00016000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 002:100000000000800018000000000000000000800018000000000000000000900018000000000000000000900018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 003:80002a00000060002a40002a40002a000000000000000000f00028000000100000000000f0002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 004:80002a00000060002a40002a40002a00000040002c000000f0002800000000000000000060002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:400008000000000000000000b00006000000000000000000900006000000000000000000400006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:00000000000040001800000000000000000040002a000000000000000000d00016000000100020000000d00016000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:00000000000080001800000000000000000080002a000000000000000000900018000000000000000000900018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 008:80002a60002ab0002a100020b0002c100020d0002a000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:600006000000000000000000600006000000500006000000400006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:00000000000040001800000000000000000000000000000000000000000040002a10002040002a10002040002a100020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:00000000000090001800000000000000000000000000000000000000000080002a00000080002a00000080002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:100010b0002ad0002a000000b0002a00000090002c00000080002a000000100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000000b0002ad0002a000000b0002a00000090002a000000b0002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:400007000000000000000000b00007000000000000000000400007000000000000000000b00005000000000000000000400007000000000000000000b00007000000000000000000900007000000000000000000400007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 015:000000100010800018100010000000100010800018100010000000100010800018100010000000100010800018100010000000000000800018000000000000000000800018000000000000000000900018000000000000000000900018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 016:00000000000040001a00000000000000000040001a000000000000000000f00018000000000000000000f00018000000100010000000e0001a000000000000000000e0001a000000000000000000d0001a000000000000000000d0001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 017:80002a000000000000100020000000100020b0002a00002000000000002080002a000020f00028100020e0002800000000000000000040002a00000060002a00000080002a00000080002a00000000000000000090002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 018:400026000000000000000000b00007000000000000000000600007000000000000000000d00005000000000000000000b00005000000000000000000600007000000000000000000400007000000000000000000b00007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 019:000000000000800018000000000000000000800018000000000000000000400018000000000000000000400018000000000000000000f00016000000000000000000f00016000000000000000000400018000000000000000000400018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 020:00000000000040001a00000000000000000040001a000000000000000000900018000000000000000000900018000000000000000000900018000000000000000000900018000000000000000000b00018000000000000000000b00018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 021:80002a000000000000000000b0002a00000090002a00000010002000000080002a00000040002a000000f0002800000000002000000040002a00000060002a00000090002a00000080002a000000000020000000100020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 022:80002a00000090002a000000b0002a000000d0002a000000000000000000b0002a000000f0002a000000e0002a000000000000000000d0002a000000b0002a00000090002a00000080002a00000000000000000090002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 023:80002a000000000000000000b0002a00000090002a00000000000000000080002a00000060002a000000f0002800000000000000000090002a00000080002a00000060002a00000040002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </PATTERNS>

-- <TRACKS>
-- 000:1803011803416c1842ac2c431803011803416c1842ac2c830000000000000000000000000000000000000000000000004c0300
-- 001:f04194315595f041d5315516000000000000000000000000000000000000000000000000000000000000000000000000ab0200
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>
