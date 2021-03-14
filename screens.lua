require "collisions"
require "graphics"
require "init"
require "input"
require "update"
require "characters"

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
		end
	end
	
	if HUD.screen == "game over" then
		game_over()
		for k = 0, 7 do
			if btnp(k) then
				HUD.screen = "character select"
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
    print("Game Over", alignment.middle_align - 32, 0, 12, false, 2)
	
	generate_sprites(depressed, true)
	
	print(depressed.text, 24, depressed.y + 64 + 8, 12)
end

function win()
	print("FINAL _ SCORE", alignment.middle_align - 54, 0, 12, false, 2)
	
	print(player.score, alignment.middle_align + 8, 16, 12, false, 2)
	
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
end
