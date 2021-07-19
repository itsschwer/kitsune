# kitsune
[![Datapacks](https://img.shields.io/badge/See_more-datapacks-C7A978.svg)](https://github.com/itsschwer?tab=repositories&q=&type=&language=mcfunction&sort=)

A small datapack implementing a new type of interaction with Foxes.

## Intention

This datapack aims to expand on the ability of Foxes to pick up items by adding a Fox variant *(Kitsune)* that can 'bless' items.

This datapack is intended and designed to be integrated with other datapack as a means of modifying items *(similar to custom crafting with NBT data)*. Example of datapacks that integrate with ***kitsune*** include ***[pseudo-enchantments](https://github.com/itsschwer/pseudo-enchantments)*** and ***[radiance](https://github.com/itsschwer/radiance)***.

World owners can refer to *[Integration § Datapacks](#datapacks)* to find links to datapacks that connect with ***kitsune***.

Datapack creators can refer to *[Integration § Guide](#guide-1)* to learn how to connect their datapack(s) to ***kitsune***.

## Guide
*This datapack was developed in 1.17 (`"pack_format": 7`) but should be compatible with versions using an equivalent or greater `pack_format`, barring major changes to commands/datapacks.*

1. Download:
    - [Repository as a `.zip`](https://github.com/itsschwer/kitsune/archive/refs/heads/master.zip) *(Code > Download ZIP)*
    - [Release](https://github.com/itsschwer/kitsune/releases) *(will need to unzip before installing into a save)*
2. Install into a save like any other datapack.
3. *(Optional)* Install other datapacks that connect with *kitsune*.
4. Open the advancement menu to the *Schwer* tab to view the intended hints.

## Mechanics

Kitsune is a custom Fox variant that can be visually identified by the glowing particles they emit. They are unaffected by physical forces *(pushing, gravity, water, etc)*, cannot breed, and always asleep. Players can interact with Kitsune to 'bless' items.

Foxes can be converted into Kitsune by naming them *kitseudo*.

Kitsune can be converted back into foxes by naming them *release*.

Kitsune can be tempted into dropping its held item by being fed berries.

A Kitsune holding an item can bless the item under the right conditions *(e.g. dropping a blessing material near them)*.

*This datapack does not implement any actual blessings, rather, it enables other datapacks to implement their own blessings — see [Integration § Datapacks](#datapacks)*.

## Functions
*Split between 'Available' (i.e. fine to call using `/function`) and 'Internal' (not intended to be called by `/function`).*

*Ordered alphabetically.*

### Available

#### `clear`
Removes the presence of this datapack by:
- Clearing the scheduled `tick` function
- Calling `kitsune_release` on all Kitsune

*Note that since it is possible that unloaded chunks contain Kitsune, this can't guarantee to completely remove the presence of this datapack (i.e. some Kitsune may still exist but become non-functional until the datapack is reloaded).*

### Internal

#### `grant_advancement`
Handles the logic for granting the `enchant` advancement to the player who dropped the target item.

Not used in this datapack, intended to be used by other datapacks — see *[Integration](#integration)*.

#### `kitsune_bless`
Plays sound effects for when a Kitsune blesses an item.

Not used in this datapack, intended to be used by other datapacks — see *[Integration](#integration)*.

#### `kitsune_drop`
Forcibly unequips a Kitsune's held item.

Called from `kitsune_tick` on Kitsune that have been fed *(i.e. in 'breeding mode')*.

#### `kitsune_mark`
Converts a Fox into a Kitsune.

Called from `tick` on Foxes named *kitseudo*.

#### `kitsune_release`
Converts a Kitsune back into a Fox.

Called from `kitsune_tick` on Kitsune named *release*.

#### `kitsune_tick`
The update loop for each Kitsune. Handles *(in execution order)*:
- Forcing Kitsune to drop their held item when fed *(`kitsune_drop`)*
- Enforcing Kitsune behaviour *(no AI, not in love, sleeping)*
    - *Interestingly, Foxes with `NoAI:1b` still pick up items (but never eat held food). Not sure if this is intentional game behaviour, but it works for now.*
- Releasing named Kitsune *(`kitsune_release`)*
- Trying to 'bless' a Kitsune's held item *(`#kitsune:try_enchant`)*

Additionally handles the particle effect differentiating Kitsune from normal Foxes.

#### `load`
Sets up this datapack by starting the `tick` loop.

Called through Minecraft's *`load.json`*.

#### `tick`
The main update loop. Handles marking of named Foxes to be converted into Kitsune and `kitsune_tick`.

Initialises from `load`.

## References
*(Roughly in personal use order)*
- [Minecraft Wiki](https://minecraft.fandom.com/wiki/Minecraft_Wiki)
- [Misode's Data Pack Generators](https://misode.github.io/)
- [MCStacker](https://mcstacker.net/)
- [radiance](https://github.com/itsschwer/radiance)
    - *Imitating dropping items from an inventory*

## Integration

### Guide
To integrate with ***kitsune***, your datapack should contain `data/kitsune/tags/functions/try_enchant.json`. In this file you should include check functions for each blessing interaction you wish to add. For example, from ***[pseudo-enchantments](https://github.com/itsschwer/pseudo-enchantments)***:
```json
{
    "values": [
        "extinguish:kitsune_enchant_check"
    ]
}
```

`#kitsune:try_enchant` is called on (and at) any Kitsune that is holding an item while there is an item on the ground within 1.425 blocks *(the item pickup range (for players), according to the wiki)* away. Specifically, the selector is:
```mcfunction
@e[type=item,nbt={OnGround:1b},limit=1,sort=nearest,distance=..1.425]
```
This should be used to target the item in functions called from `#kitsune:try_enchant`.

#### Check function
Your check function should check if the held item is blessable, preferrably using a predicate like so:
```json
[
    {
        "condition": "minecraft:entity_properties",
        "entity": "this",
        "predicate": {
            "equipment": {
                "mainhand": {
                    "items": [
                        "<namespace>:<item_id>"
                    ]
                }
            }
        }
    }
]
```
You could also include incompatibilities like so:
```json
// Continued from above (before closing square bracket)
    {
        "condition": "minecraft:inverted",
        "term": {
            "condition": "minecraft:entity_properties",
            "entity": "this",
            "predicate": {
                "nbt": "{HandItems:[{tag:{display:{Lore:['{\"text\":\"Extinguish\",\"color\":\"#7373DD\",\"italic\":false}']}}}]}"
            }
        }
    }
]
```
Your check function should then have a second if for the target item (blessing material).

A template for a possible check function:
```mcfunction
execute if entity @s[predicate=<namespace>:<valid_held_item>] if entity @e[type=item,nbt={OnGround:1b},limit=1,sort=nearest,distance=..1.425,predicate=<namespace>:<valid_blessing_material>] run function <namespace>:<apply_blessing>
```

#### Blessing function
How you want your blessing function to work is up to you. If you'd liked to see an example, refer to the one for [`extinguish`](https://github.com/itsschwer/pseudo-enchantments/blob/master/data/extinguish/functions/kitsune_enchant.mcfunction) in the ***[pseudo-enchantments](https://github.com/itsschwer/pseudo-enchantments)*** datapack.

Some suggestions:
- Append lore to the held item: `data modify entity @s HandItems[0].tag.display.Lore append value <value>`
- Play the Kitsune blessing sound: `function kitsune:kitsune_bless`
- Grant the advancement `kitsune:enchant`:
    ```mcfunction
    # Grant `kitsune:enchant` advancement
    data modify storage schwer:sks_store Thrower set from entity @e<item; copy from your check function> Thrower
    execute as @a run function kitsune:grant_advancement
    data remove storage schwer:sks_store Thrower
    ```
- Consume the blessing material: `kill @e<item; copy from your check function>`

### Datapacks
- [pseudo-enchantments](https://github.com/itsschwer/pseudo-enchantments)
    - *Pseudo-enchant items using Enchanted Scrolls*
- [radiance](https://github.com/itsschwer/radiance)
    - *Revert Radiance into Fragile Radiance*
