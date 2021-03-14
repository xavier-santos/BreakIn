require "characters"

HUD = {
	left_align = 44,
	middle_align = 104,
	right_align = 164,
	screen = "start"
}

function screen_transition()
    if HUD.screen == "start"  then
		start()
	end	
	
	if HUD.screen == "start animation"  then
		start_animation()
	end
	
	if HUD.screen == "character select" then
		character_select()
	end

	if HUD.screen == "play" then
		input()
    	update()
    	collisions()
    	draw()
	end
	
	if HUD.screen == "game over" then
		game_over()
	end
end

function start()
    map(0, 0)
	print("START", 210, 88, 4)
	print("Press any key", 165, 96, 12)
		
	for k = 0, 7 do
		if btn(k) then
			animation_start = time()//100*3
			HUD.screen = "start animation"
			break
		end
	end
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

function start_animation()
    map(0, 0)
    print("START", 210, 88, 4)
    
	local x = 80
    local y = 128
    t = time()//100*3
    
	if play_start_animation(x, y)then HUD.screen = "character select" end
end

function game_over()
    print("Game Over", HUD.middle_align - 32, 0, 12, false, 2)
	generate_sprites(depressed, true)
	print(depressed.text, 24, depressed.y + 64 + 8, 12)
end