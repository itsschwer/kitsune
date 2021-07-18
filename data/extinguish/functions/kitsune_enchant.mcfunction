data modify entity @s HandItems[0].tag.display.Lore append value '{"text":"Extinguish","color":"gray","italic":false}'
kill @e[type=item,nbt={OnGround:1b},limit=1,sort=nearest,distance=..1.425,nbt={Item:{tag:{display:{Lore:['{"text":"Extinguish","color":"gray","italic":false}']}}}}]
