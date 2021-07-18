# Add lore imitating enchantment text
data modify entity @s HandItems[0].tag.display.Lore append value '{"text":"Extinguish","color":"#7373DD","italic":false}'
# Add enchantment glint
execute unless data entity @s HandItems[0].tag.Enchantments run data modify entity @s HandItems[0].tag.Enchantments append value {}
# Consume enchantment material
kill @e[type=item,nbt={OnGround:1b},nbt={Item:{id:"minecraft:flower_banner_pattern"}},limit=1,sort=nearest,distance=..1.425,nbt={Item:{tag:{display:{Lore:['{"text":"Extinguish","color":"#7373DD","italic":false}']}}}}]
# Play sound
playsound minecraft:entity.fox.screech neutral @a ~ ~ ~ 1.5 1
playsound minecraft:entity.illusioner.cast_spell neutral @a
