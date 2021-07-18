schedule function kitseudo:tick 1

# Prepare for conversion
execute as @e[type=fox,name="kitseudo",tag=!sks_kitsune] at @s run function kitseudo:kitsune_mark
# Main Kitsune tick (also handles conversion)
execute as @e[type=fox,tag=sks_kitsune] at @s run function kitseudo:kitsune_tick
