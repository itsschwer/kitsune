# Adapted from radiance:summon_copy
summon item ~ ~ ~ {Tags:["sks_copy"],PickupDelay:1,Health:5,Item:{id:"minecraft:poisonous_potato",Count:1b}}
data modify entity @e[tag=sks_copy,type=item,limit=1,sort=nearest] Thrower set from entity @s UUID
data modify entity @e[tag=sks_copy,type=item,limit=1,sort=nearest] Item set from entity @s HandItems[0]
tag @e[tag=sks_copy,type=item,limit=1,sort=nearest] remove sks_copy

item replace entity @s weapon.mainhand with air
