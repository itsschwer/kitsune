# Add lore imitating enchantment text
data modify entity @s HandItems[0].tag.display.Lore append value '{"text":"Extinguish","color":"gray","italic":false}'
# Add enchantment glint
execute unless data entity @s HandItems[0].tag.Enchantments run data modify entity @s HandItems[0].tag.Enchantments append value {}
# Consume enchantment material
kill @e[type=item,nbt={OnGround:1b},limit=1,sort=nearest,distance=..1.425,nbt={Item:{tag:{display:{Lore:['{"text":"Extinguish","color":"gray","italic":false}']}}}}]
