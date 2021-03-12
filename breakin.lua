function init()
    player = {
        x = (240 /2 ) - 12,
        y = 120,
        width = 24,
        height = 4,
        color = 3,
        speed = {
            x = 0,
            max = 4
        }
    }
end

init()

function TIC()
   input()
   update()
   draw()
end

function draw()
    draw_game_objects()
    draw_gui()
end

-- <TILES>
-- 000:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <PALETTE>
-- 000:000000f60404000000000000000000000000000000000000000000000000000000000000000000000000000000ffffff
-- </PALETTE>

