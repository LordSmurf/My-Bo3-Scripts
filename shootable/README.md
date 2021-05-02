# HOW TO INSTALL
#### If viewing in a plain text editor, do not copy the back ticks " ` " or spaces!!<br><br>

1. Place down the model you wish to use
2. Open entity browser (with model selected) and double click script_model
3. Right click (with model selected) and choose "make weapon_clip"
4. Open entity info (with model selected) and set **targetname** to **shootable**
5. Open model in APE (right click > open in APE) scroll to **BulletCollisionLOD** and select **LOD0** from the drop down
6. Save it and you can move on to script file

OPTIONALS:
    . If you do not want to give players a perkaholic (all perks) then place two " / " infront of this line: ` player give_all_perks(); `
    . The amount of points per shootable can be changed as well by editing this line: ` level.points = 10; `

Add **zm_j_shootable.gsc** to **mapname\\scripts\\zm\\** folder

Add this line to your **mapname.gsc** usings
`  #using scripts\zm\zm_j_shootable;  `

Add this line at the bottom of **function main()** in **mapname.gsc**
`  thread zm_j_shootable::init();  `

Add this line to your **mapname.zone**
`  scriptparsetree,scripts/zm/zm_j_shootable.gsc  `