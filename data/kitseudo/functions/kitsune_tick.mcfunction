# Force kitsune to drop held item when fed
execute unless entity @s[nbt={InLove:0}] run function kitseudo:kitsune_drop

# Merge kitsune data into tagged foxes (enforces data and converts tagged foxes into kitsune)
data merge entity @s {NoAI:1b,InLove:0,Sleeping:1b}
