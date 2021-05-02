#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_score;

function init()
{
    level.shootables = getentarray("shootable", "targetname");
    level.count = 0;
    level.needed = level.shootables.size;
    level.points = 10;
    
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
    self waittill("damage", amount, attacker, dir, p, type);
    self Delete();
    level.count += 1;
    attacker zm_score::add_to_player_score( level.points );

    if (level.count === level.needed) {
            foreach(player in GetPlayers())
            {
                player give_all_perks();
            }
    }
}