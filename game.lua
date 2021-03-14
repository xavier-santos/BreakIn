-- title:  Breakin
-- author: Triceratops 
-- desc:   Game developed for Retro Jam 2021
-- script: lua

require "collisions"
require "graphics"
require "init"
require "input"
require "update"

init()

function TIC()
    cls()
    input()
    collisions()
    update()
    draw()
 end

-- <TILES>
-- 000:1111111111111111111111111111111111111111111111111111111111111111
-- </TILES>

-- <PALETTE>
-- 000:140c1cfa183430346d4e4a4f854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

