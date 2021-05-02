//REMEMBER TO CREDIT ME

#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;

function init()
{
    level.shootables = getentarray("shootable", "targetname");
    level.count = 0;
    level.needed = level.shootables.size;
    level.points = 10; //Change total amount of points awarded per shootable here!!!! Set to 0 if you do not want to give points.
    
    foreach(shootable in level.shootables)
    {
        shootable thread j_shootable_logic();
    }    
}
//IceGrenade Func
function give_all_perks()
{
    a_str_perks = GetArrayKeys( level._custom_perks );
    foreach( str_perk in a_str_perks )
    {
        if( !self HasPerk( str_perk ) )
        {
            self zm_perks::give_perk( str_perk, false );
            if (isdefined(level.perk_bought_func))
                self [[ level.perk_bought_func ]]( str_perk );
        }
    }
}

function j_shootable_logic()
{
    self setCanDamage( true );
    self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
    PlayFX(level._effect["powerup_grabbed"], self.origin);
    self Delete();
    
    if (inflictor) {
        level.count += 1;
        inflictor zm_score::add_to_player_score( level.points );
    } else {
        level.count += 1;
        attacker zm_score::add_to_player_score( level.points );
    }
    
    if (level.count === level.needed) {
            foreach(player in GetPlayers())
            {
                player give_all_perks(); // Add // just before player to disable a perkaholic reward: "//player give_all_perks();"
            }
    }
}