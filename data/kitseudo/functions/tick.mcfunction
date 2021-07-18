schedule function kitseudo:tick 1

# Tag foxes named "kitseudo" to convert them into kitsune
tag @e[type=fox,name="kitseudo",tag=!sks_kitsune] add sks_kitsune

execute as @e[type=fox,tag=sks_kitsune] run function kitseudo:kitsune_tick
