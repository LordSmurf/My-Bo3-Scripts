//REMEMBER TO CREDIT ME: JULES

#using scripts\shared\array_shared;
#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_score;

function init()
{
    collectables = GetEntArray("collectable", "targetname");
    level.total_collectables = collectables.size;
    array::thread_all(collectables, &j_collectable_logic);

    level thread collectable_complete();
}

function j_collectable_logic()
{
    trig = Spawn("trigger_radius_use", self.origin, 25, 20);
    trig setCursorHint("HINT_NOICON");
    trig setVisibleToAll();
    trig setTeamForTrigger("allies");

    trig waittill("trigger", player);
    playFX(level._effect["powerup_grabbed"], self.origin);
    self Delete();
    trig Delete();
    level.total_collectables--;

    if (level.total_collectables <= 0) { level notify("collectables_found"); }
}

function collectable_complete()
{
    level waittill("collectables_found");

    iPrintLnBold("Congrats, you got them all!");
    foreach(player in GetPlayers())
    {
        player zm_score::add_to_player_score(1000);
    }
}