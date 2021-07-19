# Adapted from gateways:grant_advancement

scoreboard objectives add sks_score dummy
scoreboard players set 0 sks_score 0

# Prep `Candidate`
data modify storage schwer:sks_store Candidate set from storage schwer:sks_store Thrower

# `match` becomes `1` if was able to set `Candidate` (i.e. player UUID ≠ Thrower UUID, ∴ player is *not* the thrower)
execute store result score match sks_score run data modify storage schwer:sks_store Candidate set from entity @s UUID

# `match` is `0`, ∴ *is* thrower and should get advancement
execute if score match sks_score = 0 sks_score run advancement grant @s only kitsune:enchant

scoreboard objectives remove sks_score

# Clean up `Candidate` (`Thrower` to be cleaned up by caller function)
data remove storage schwer:sks_store Candidate
