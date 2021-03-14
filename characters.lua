require "screens"

sanic = {
	x = HUD.middle_align,
	y = 20,
	sprite = 0,
	size = 4,
	text = "Gotta go feeeeeest!\n\nGet the time controlling powers\nof the blue wonder."
}

xbox = {
	x = HUD.left_align,
	y = 20,
	sprite = 4,
	size =	4,
	text = "X-Box One X... Box One X...\n\nExplode blocks in a pattern that will make\nany Playstation owner look at you weird."
}

stab = {
	x = HUD.right_align,
	y = 20,
	sprite = 8,
	size = 4,
	text = "Stabby stab!\n\nSlash blocks like you're a yandere and\nsomeone is stealing your boyfriend."
}

help = {
	x = HUD.right_align,
	y = 64,
	sprite = 12,
	size = 4,
	text = "Everyone needs a lil help sometimes.\n\nThis nice boi will make your paddle bigger and\nmake you feel safe and cozy."
}

sus = {
	x = HUD.middle_align,
	y = 64,
	sprite = 64,
	size = 4,
	text = "Puppy eyes that will melt the game devs'\nhearts and grant you a sneaky extra life\ncheat code.\n\nShhh... don't tell the others."
}

creeper = {
	x = HUD.left_align,
	y = 64,
	sprite = 68,
	size = 4,
	text = "Boom!"
}

depressed = {
	x = HUD.middle_align - 16,
	y = 32,
	sprite = 72,
	size = 4,
	text = "Use your reactions and cry again..."
}

Renderer = {
	sprite_grid = {{xbox, sanic, stab}, {creeper, sus, help}},
	v = 1,
	h = 1
}

t = 0

function generate_sprites(name, scale)
	if scale then
		spr(name.sprite, name.x, name.y, -1, 2, 0, 0, name.size, name.size)
	else
		spr(name.sprite, name.x, name.y, -1, 1, 0, 0, name.size, name.size)
	end
end

function animate(name)
	spr(name.sprite, name.x, name.y - t, -1, 1,	0, 0, name.size, name.size)
end

function select()
	--0 - UP, 1 - DOWN, 2 - LEFT, 3 - RIGHT
	
	if btnp(0) then Renderer.v = Renderer.v - 1 end
	if btnp(1) then Renderer.v = Renderer.v + 1 end
	if btnp(2) then Renderer.h = Renderer.h - 1 end
	if btnp(3) then Renderer.h = Renderer.h + 1 end
	
	if Renderer.v < 1 then Renderer.v = 1 end
	if Renderer.v > 2 then Renderer.v = 2 end
	if Renderer.h < 1 then Renderer.h = 1 end
	if Renderer.h > 3 then Renderer.h = 3 end
	
	animate(Renderer.sprite_grid[Renderer.v][Renderer.h])
	print(Renderer.sprite_grid[Renderer.v][Renderer.h].text, 0, 100, 12)
end

function character_select()
	cls()
	print("Choose your fighter", 60, 0, 12)
		for i = 1, 2 do
			for j = 1, 3 do
			generate_sprites(Renderer.sprite_grid[i][j], false)
			end
		end
	
	t = (time()*2//10)%60//30
	
	select()
	if btnp(4) then 
		init(Renderer.sprite_grid[Renderer.v][Renderer.h])
		HUD.screen = "play"
	end
end