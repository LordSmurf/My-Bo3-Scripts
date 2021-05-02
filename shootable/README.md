# HOW TO INSTALL
#### If viewing in a plain text editor, do not copy the back ticks " ` " or spaces!!<br><br>

1. Place down the model you wish to use
2. Open entity browser (with model selected) and double click script_model
3. Open entity info (with model selected) and set **targetname** to **shootable**
4. Open model in APE (right click > open in APE) scroll to **BulletCollisionLOD** and select **LOD0** from the drop down
5. Save it and you can move on to script file

Add this line to your **mapname.gsc** usings
`  #using scripts\zm\zm_j_shootable;  `

Add this line at the bottom of **function main()** in **mapname.gsc**
`  thread zm_j_shootable::init();  `

Add this line to your **mapname.zone**
`  scriptparsetree,scripts/zm/zm_j_shootable.gsc  `