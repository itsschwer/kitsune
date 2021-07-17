schedule function extinguish:tick 1

execute as @a[predicate=extinguish:valid_target] run function extinguish:apply_fire_resistance

advancement revoke @a only extinguish:enter_fire_source
