#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;

function init()
{
    level.collectables = getentarray("collectable", "targetname");
    level.count = 0;
    level.needed = level.collectables.size;
    
    foreach(collectable in level.collectables)
    {
        collectable thread j_collectable_logic();
    }    
}

function j_collectable_logic()
{
    trig = Spawn("trigger_radius_use", self.origin, 10, 20);
    trig setCursorHint("HINT_NOICON");
    //trig setHintString("Press &&1 to collect");
    trig setvisibletoall();
    trig setTeamForTrigger("allies");
    trig waittill("trigger", player);
    while (1) {
        //iPrintLnBold("Collected");
        PlayFx(level._effect["powerup_grabbed"], self.origin);
        self delete();
        trig delete();
        level.count += 1;
        break;
    };

    if (level.count === level.needed) {
        iPrintLnBold("All collected!");
        iPrintLnBold("EE Shite here!");
    }
}