# kitsune
[![Datapacks](https://img.shields.io/badge/See_more-datapacks-C7A978.svg)](https://github.com/itsschwer?tab=repositories&q=&type=&language=mcfunction&sort=)

A small datapack implementing a new type of interaction with Foxes.

## Intention

This datapack aims to expand on the ability of Foxes to pick up items by adding a Fox variant *(Kitsune)* that can 'bless' items.

This datapack is intended and designed to be integrated with other datapack as a means of modifying items *(similar to custom crafting with NBT data)*. Example of datapacks that integrate with ***kitsune*** include ***[pseudo-enchantments](https://github.com/itsschwer/pseudo-enchantments)*** and ***[radiance](https://github.com/itsschwer/radiance)***.

Datapack creators can refer to the *[Integration](#integration)* section to learn how to connect their datapack(s) to ***kitsune***.

## Guide
*This datapack was developed in 1.17 (`"pack_format": 7`) but should be compatible with versions using an equivalent or greater `pack_format`, barring major changes to commands/datapacks.*

1. Download:
    - [Repository as a `.zip`](https://github.com/itsschwer/kitsune/archive/refs/heads/master.zip) *(Code > Download ZIP)*
    - [Release](https://github.com/itsschwer/kitsune/releases) *(will need to unzip before installing into a save)*
2. Install into a save like any other datapack.
3. *(Optional)* Install other datapacks that connect with *kitsune*.
4. Open the advancement menu to the *Schwer* tab to view the intended hints.

## Mechanics

TBA

## Functions
*Split between 'Available' (i.e. fine to call using `/function`) and 'Internal' (not intended to be called by `/function`).*

*Ordered alphabetically.*

### Available

#### `clear`
TBA

### Internal

#### `grant_advancement`
Handles the logic for granting the `enchant` advancement to the player who dropped the target item.

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

TBA — *guide to adding kitsune interactions from other datapcks*
