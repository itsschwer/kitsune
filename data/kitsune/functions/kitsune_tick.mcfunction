# Force kitsune to drop held item when fed
execute unless entity @s[nbt={InLove:0}] if data entity @s HandItems[0].id run function kitsune:kitsune_drop

# Merge kitsune data into tagged foxes (enforces data and converts tagged foxes into kitsune)
data merge entity @s {NoAI:1b,InLove:0,Sleeping:1b}

# Release kitsune where appropriate
execute if entity @s[name="release"] run function kitsune:kitsune_release

# Try enchanting held item
execute if data entity @s HandItems[0].id if entity @e[type=item,nbt={OnGround:1b},limit=1,sort=nearest,distance=..1.425] run function #kitsune:try_enchant

# Particle effect to indicate fox is a kitsune
particle minecraft:glow ~ ~0.2 ~ 0.3 0.2 0.3 0 1
