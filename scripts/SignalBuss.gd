extends Node

#signalbuss for signals between objects
signal level_ready(level: Level)

signal checkpoit_triggered(checkpoint: Checkpoint)

signal spawn_player(spawn_point: SpawnPoint)
signal player_died()
signal bubble_release(power: float)
#signalbuss for signals between objects
signal _can_grab

#signalbuss for signals between objects
signal level_ready(level: Level)

signal checkpoit_triggered(checkpoint: Checkpoint)

signal spawn_player(spawn_point: SpawnPoint)
signal player_died()
