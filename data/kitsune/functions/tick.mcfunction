schedule function kitsune:tick 1

# Prepare for conversion
execute as @e[type=fox,name="kitsune",tag=!sks_kitsune] at @s run function kitsune:kitsune_mark
# Main Kitsune tick (also handles conversion)
execute as @e[type=fox,tag=sks_kitsune] at @s run function kitsune:kitsune_tick
