# This script concatenates all the source files of the game to export it
# The game.lua file is only appended in the end, since it contains all the assets

cd ./src/
find . -maxdepth 1 -iname '*.lua' -not -name "game.lua" -exec cat {} +> ../out/break_in.lua
cat game.lua >> ../out/break_in.lua
cd ../out/
grep -v "require.*" break_in.lua > temp && mv temp break_in.lua