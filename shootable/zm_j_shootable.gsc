//REMEMBER TO CREDIT ME: JULES
//SHOUTOUT TO VERTASEA FOR MASSIVE BUG FIXING

#using scripts\shared\util_shared;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\shared\array_shared;

function init()
{
    level.reward_points = 10;
    shootables = GetEntArray("shootable", "targetname");
    level.total_shootables = shootables.size;
    array::thread_all(shootables, &j_shootable_logic);

    level thread give_players_reward();
}

function j_shootable_logic() // self == shootable
{
    self SetCanDamage( true );

    // self waittill( "damage", damage, attacker, direction_vec, point, mod );
    self waittill("damage", amount, inflictor, direction, point, type, tagName, modelName, partName, weapon);

    PlayFX(level._effect["powerup_grabbed"], self.origin);
    self Delete();
    level.total_shootables--;

    inflictor zm_score::add_to_player_score( level.reward_points );

    IPrintLnBold("total shootables shot = " + level.shootables_shot);
    IPrintLnBold("total shootable ents = " + level.total_shootables);

    if(level.total_shootables <= 0)
        level notify("all_shootables_shot");
}

function give_players_reward()
{
    level waittill("all_shootables_shot");
    
    foreach( player in GetPlayers())
        player zm_utility::give_player_all_perks();
}