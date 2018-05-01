|=======================================================|
|							|
|			Tetrix4LN			|
|							|
|=======================================================|


Infos
-----

Version 1.0 rc1 by Martial Demolins.

Originally, this game has been written to allow my wife to play. It
has been designed to run only on my TI89 HW2. It runs now on
89/92+/v200 (on-calc compatibility). The game has no presentation,
highscores or options, but it's very light (less than 3400 bytes).  It
can be run archived, but the random generator will be reinitialized
each time the game will be run (the game use rand(), a TIGCCLIB
function).

This program should run on TI89 / TI89ti  / TI92+ / v200
Thanx to report bugs to mdemolins >> gmail >> com

Sorry for my poor english (en gros si vous etes pas content, apprenez
le francais, ca ira tout de suite mieux :p).


Requirements
------------

You need to have PreOS and graphlib installed. If you are beginner,
just download preos here : http://www.yaronet.com/t3/ install it
following instructions of "preos.txt" (install preos AND stdlib!)


Play!
-----

Just send the binary file according to your calculator model. Then
type < tetrix() > in the command line (HOME) and press enter.

Keys :
Left arrow   >   moves a block one step left
Right arrow  >   moves a block one step right
Down arrow   >   makes a block fall (step by step, but very quickly)
F1           >   rotates a block
F2           >   while kept pressed, pauses the game
ESC          >   quits the game


Compilation
-----------

A tpr (tigcc/ktigcc) is provided, you need to add tios.h, romcalls.h
and graphlib.h (provided with PreOS, http://www.yaronet.com/t3/).


License
-------

GPL v3. Look at the file gpl.txt 


Credits
-------

Thanx to :
- the TIGCC team for TIGCCLIB (http://tigcc.ticalc.org/)
- Kernel Killer (Kevin Kofler) for KTIGCC
  (http://tigcc.ticalc.org/linux/) and its advices
- PpHd (Patrick PELISSIER) for its wonderfull kernel "PreOS"
  (http://www.yaronet.com/t3/) and for all its tips
- Thibaut (Thibaut BARTHELEMY) who made me release the game ;)
  (also tests, bugs report and feedback)
- Romain Lievin and Kevin Kofler for TiEmu
  (http://lpg.ticalc.org/prj_tiemu/)
- the french community (mainly on http://www.yaronet.com)


Dedicace
--------

Dedicated to my wife who wanted to play what she called "tetrix" ;)
