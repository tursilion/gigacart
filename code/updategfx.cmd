@rem set your path here, if needed for Python
@set PATH=%PATH%;C:\Python27\

@rem update the graphics
d:
cd \work\ti\dragonslair\dl_pics
d:\work\ti\videobitmap2border\debug\videobitmap2border BORDER2 BorderOut.bin BORDER
d:\work\ti\videobitmap2border\debug\videobitmap2border BORDERC BorderC.bin BORDER
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYARCADE ConfigHintsEasyArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYHOME ConfigHintsEasyHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDARCADE ConfigHintsHardArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDHOME ConfigHintsHardHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYARCADE ConfigNoHintsEasyArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYHOME ConfigNoHintsEasyHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDARCADE ConfigNoHintsHardArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDHOME ConfigNoHintsHardHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSPRACTICEARCADE ConfigHintsPracticeArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSPRACTICEHOME ConfigHintsPracticeHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSPRACTICEARCADE ConfigNoHintsPracticeArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSPRACTICEHOME ConfigNoHintsPracticeHome.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border F18A F18A.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border HLSPLASH HLSplash.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border HLTITLE HLTitle.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION1JOY Instruction1Joy.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION1KEY Instruction1Key.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION2JOY Instruction2Joy.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION2KEY Instruction2Key.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border GAMEOVER GameOver.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border COLORBARS ColorBars.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG1 Diag1.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG2 Diag2.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG3 Diag3.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG4 Diag4.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG5 Diag5.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG6 Diag6.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG7 Diag7.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG8 Diag8.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG9 Diag9.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG14 Diag14.bin CONTENT COL 31
d:\work\ti\videobitmap2border\debug\videobitmap2border ALPHALOCKUP AlphaLockUp.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border WINSCREEN WinScreen.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border THANKS Thanks.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border COPYRIGHT Copyright.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border GRID grid.bin CONTENT

@rem prepare the video file
@rem first -8192 removes the code page, which we don't want
@rem cart size pads to the first data page as in ROM LAYOUT.txt
cd ..
D:\work\ti\video\tools\cartrepack.exe output.bin output_Cart8.bin
@rem Yes, now I'm happy with this. It claims to patch 169M pixels out of about 402M, a respectable 42%! 
d:\work\ti\videodespeckle\release\videodespeckle output_Cart8.bin
d:\work\setbinsize\release\setbinsize output_Cart8.bin -8192
d:\work\setbinsize\release\setbinsize output_Cart8.bin 88596480
d:\work\ti\uncartify\debug\uncartify output_Cart8.bin

@rem rebuild the code
cd code
@rem main code
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R DragonsLair.a99 -L DragonsLair.lst -o D:\classic99\dsk1\DragonsLair.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\DragonsLair.obj DragonsLairC.bin -raw -block
d:\work\setbinsize\release\setbinsize DragonsLairC.bin 8192
@rem keyboard version
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R DragonsLairKey.a99 -L DragonsLairKey.lst -o D:\classic99\dsk1\DragonsLairKey.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\DragonsLairKey.obj DragonsLairKeyC.bin -raw -block
d:\work\setbinsize\release\setbinsize DragonsLairKeyC.bin 8192
@rem Diagnostics
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R Dragonostics.a99 -L Dragonostics.lst -o D:\classic99\dsk1\Dragonostics.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\Dragonostics.obj DragonosticsC.bin -raw -block
d:\work\setbinsize\release\setbinsize DragonosticsC.bin 8192
@rem sprites
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R sprites.a99 -L sprites.lst -o D:\classic99\dsk1\sprites.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\sprites.obj spritesC.bin -raw -block
d:\work\setbinsize\release\setbinsize spritesC.bin 8192

@rem SceneA1 - drawbridge
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneA1Drawbridge.a99 -L SceneA1Drawbridge.lst -o D:\classic99\dsk1\SceneA1Drawbridge.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneA1Drawbridge.obj SceneA1Drawbridge.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneA1Drawbridge.bin 8192
@rem SceneA1 - vestible
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneA1vestible.a99 -L SceneA1vestible.lst -o D:\classic99\dsk1\SceneA1vestible.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneA1vestible.obj SceneA1vestible.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneA1vestible.bin 8192
@rem SceneB2 - Drinkme
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB2DrinkMe.a99 -L SceneB2DrinkMe.lst -o D:\classic99\dsk1\SceneB2DrinkMe.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB2DrinkMe.obj SceneB2DrinkMe.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB2DrinkMe.bin 8192
@rem Scene B2 - Vines
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB2Vines.a99 -L SceneB2Vines.lst -o D:\classic99\dsk1\SceneB2Vines.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB2Vines.obj SceneB2Vines.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB2Vines.bin 8192
@rem Scene B2 - Wind
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB2Wind.a99 -L SceneB2Wind.lst -o D:\classic99\dsk1\SceneB2Wind.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB2Wind.obj SceneB2Wind.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB2Wind.bin 8192
@rem Scene B3 - Fire
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB3Fire.a99 -L SceneB3Fire.lst -o D:\classic99\dsk1\SceneB3Fire.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB3Fire.obj SceneB3Fire.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB3Fire.bin 8192
@rem Scene B3 - Pot
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB3Pot.a99 -L SceneB3Pot.lst -o D:\classic99\dsk1\SceneB3Pot.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB3Pot.obj SceneB3Pot.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB3Pot.bin 8192
@rem Scene B3 - Throne
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB3Throne.a99 -L SceneB3Throne.lst -o D:\classic99\dsk1\SceneB3Throne.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB3Throne.obj SceneB3Throne.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB3Throne.bin 8192
@rem Scene B4 - Goons
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB4Goons.a99 -L SceneB4Goons.lst -o D:\classic99\dsk1\SceneB4Goons.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB4Goons.obj SceneB4Goons.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB4Goons.bin 8192
@rem Scene B4 - Snakes
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB4Snakes.a99 -L SceneB4Snakes.lst -o D:\classic99\dsk1\SceneB4Snakes.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB4Snakes.obj SceneB4Snakes.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB4Snakes.bin 8192
@rem Scene B4 - Wall
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneB4Wall.a99 -L SceneB4Wall.lst -o D:\classic99\dsk1\SceneB4Wall.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneB4Wall.obj SceneB4Wall.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneB4Wall.bin 8192
@rem Scene C5 - Lizardking
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC5Lizardking.a99 -L SceneC5Lizardking.lst -o D:\classic99\dsk1\SceneC5Lizardking.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC5Lizardking.obj SceneC5Lizardking.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC5Lizardking.bin 8192
@rem Scene C5 - Pit
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC5Pit.a99 -L SceneC5Pit.lst -o D:\classic99\dsk1\SceneC5Pit.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC5Pit.obj SceneC5Pit.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC5Pit.bin 8192
@rem Scene C5 - Ropes1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC5Ropes1.a99 -L SceneC5Ropes1.lst -o D:\classic99\dsk1\SceneC5Ropes1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC5Ropes1.obj SceneC5Ropes1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC5Ropes1.bin 8192
@rem Scene C5 - Ropes2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC5Ropes2.a99 -L SceneC5Ropes2.lst -o D:\classic99\dsk1\SceneC5Ropes2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC5Ropes2.obj SceneC5Ropes2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC5Ropes2.bin 8192
@rem Scene C6 - Horse1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Horse1.a99 -L SceneC6Horse1.lst -o D:\classic99\dsk1\SceneC6Horse1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Horse1.obj SceneC6Horse1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Horse1.bin 8192
@rem Scene C6 - Horse2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Horse2.a99 -L SceneC6Horse2.lst -o D:\classic99\dsk1\SceneC6Horse2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Horse2.obj SceneC6Horse2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Horse2.bin 8192
@rem Scene C6 - Smithy1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Smithy1.a99 -L SceneC6Smithy1.lst -o D:\classic99\dsk1\SceneC6Smithy1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Smithy1.obj SceneC6Smithy1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Smithy1.bin 8192
@rem Scene C6 - Smithy2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Smithy2.a99 -L SceneC6Smithy2.lst -o D:\classic99\dsk1\SceneC6Smithy2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Smithy2.obj SceneC6Smithy2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Smithy2.bin 8192
@rem Scene C6 - Wizard1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Wizard1.a99 -L SceneC6Wizard1.lst -o D:\classic99\dsk1\SceneC6Wizard1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Wizard1.obj SceneC6Wizard1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Wizard1.bin 8192
@rem Scene C6 - Wizard2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC6Wizard2.a99 -L SceneC6Wizard2.lst -o D:\classic99\dsk1\SceneC6Wizard2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC6Wizard2.obj SceneC6Wizard2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC6Wizard2.bin 8192
@rem Scene C7 - Crypt1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Crypt1.a99 -L SceneC7Crypt1.lst -o D:\classic99\dsk1\SceneC7Crypt1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Crypt1.obj SceneC7Crypt1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Crypt1.bin 8192
@rem Scene C7 - Crypt2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Crypt2.a99 -L SceneC7Crypt2.lst -o D:\classic99\dsk1\SceneC7Crypt2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Crypt2.obj SceneC7Crypt2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Crypt2.bin 8192
@rem Scene C7 - Knight1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Knight1.a99 -L SceneC7Knight1.lst -o D:\classic99\dsk1\SceneC7Knight1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Knight1.obj SceneC7Knight1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Knight1.bin 8192
@rem Scene C7 - Knight2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Knight2.a99 -L SceneC7Knight2.lst -o D:\classic99\dsk1\SceneC7Knight2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Knight2.obj SceneC7Knight2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Knight2.bin 8192
@rem Scene C7 - Pond1
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Pond1.a99 -L SceneC7Pond1.lst -o D:\classic99\dsk1\SceneC7Pond1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Pond1.obj SceneC7Pond1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Pond1.bin 8192
@rem Scene C7 - Pond2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneC7Pond2.a99 -L SceneC7Pond2.lst -o D:\classic99\dsk1\SceneC7Pond2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneC7Pond2.obj SceneC7Pond2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneC7Pond2.bin 8192
@rem Scene D1 - Platform
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneD1Platform.a99 -L SceneD1Platform.lst -o D:\classic99\dsk1\SceneD1Platform.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneD1Platform.obj SceneD1Platform.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneD1Platform.bin 8192
@rem Scene D1 - Platform2
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneD1Platform2.a99 -L SceneD1Platform2.lst -o D:\classic99\dsk1\SceneD1Platform2.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneD1Platform2.obj SceneD1Platform2.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneD1Platform2.bin 8192
@rem Scene D1 - Platshort
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneD1Platshort.a99 -L SceneD1Platshort.lst -o D:\classic99\dsk1\SceneD1Platshort.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneD1Platshort.obj SceneD1Platshort.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneD1Platshort.bin 8192
@rem Scene E1 - Bats
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE1Bats.a99 -L SceneE1Bats.lst -o D:\classic99\dsk1\SceneE1Bats.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE1Bats.obj SceneE1Bats.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE1Bats.bin 8192
@rem Scene E2 - Blacknight
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE2Blacknight.a99 -L SceneE2Blacknight.lst -o D:\classic99\dsk1\SceneE2Blacknight.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE2Blacknight.obj SceneE2Blacknight.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE2Blacknight.bin 8192
@rem Scene E3 - Catwalk
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE3Catwalk.a99 -L SceneE3Catwalk.lst -o D:\classic99\dsk1\SceneE3Catwalk.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE3Catwalk.obj SceneE3Catwalk.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE3Catwalk.bin 8192
@rem Scene E4 - Electriccage
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE4Electriccage.a99 -L SceneE4Electriccage.lst -o D:\classic99\dsk1\SceneE4Electriccage.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE4Electriccage.obj SceneE4Electriccage.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE4Electriccage.bin 8192
@rem Scene E5 - Mudmen
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE5Mudmen.a99 -L SceneE5Mudmen.lst -o D:\classic99\dsk1\SceneE5Mudmen.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE5Mudmen.obj SceneE5Mudmen.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE5Mudmen.bin 8192
@rem Scene E6 - Poolballs
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE6Poolballs.a99 -L SceneE6Poolballs.lst -o D:\classic99\dsk1\SceneE6Poolballs.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE6Poolballs.obj SceneE6Poolballs.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE6Poolballs.bin 8192
@rem Scene E7 - River
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE7River.a99 -L SceneE7River.lst -o D:\classic99\dsk1\SceneE7River.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE7River.obj SceneE7River.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE7River.bin 8192
@rem Scene E7 - River (arcade page)
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE7RiverArcade.a99 -L SceneE7RiverArcade.lst -o D:\classic99\dsk1\SceneE7RiverArcade.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE7RiverArcade.obj SceneE7RiverArcade.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE7RiverArcade.bin 8192
@rem Scene E8 - Vanishingfloor
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneE8Vanishingfloor.a99 -L SceneE8Vanishingfloor.lst -o D:\classic99\dsk1\SceneE8Vanishingfloor.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneE8Vanishingfloor.obj SceneE8Vanishingfloor.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneE8Vanishingfloor.bin 8192
@rem Scene F1 - Dragonslair
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneF1Dragonslair.a99 -L SceneF1Dragonslair.lst -o D:\classic99\dsk1\SceneF1Dragonslair.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneF1Dragonslair.obj SceneF1Dragonslair.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneF1Dragonslair.bin 8192

@rem append the still frames to the video file (note they are not in video format!)
@rem note we are assuming that the still frames are each exactly 8k and not padding individually
@rem how long can a copy line be? (8192 chars, apparently)
cd ..\dl_pics
copy /y /b ..\output_Cart8.bin + /b BorderOut.bin + /b ConfigHintsEasyArcade.bin + /b ConfigHintsEasyHome.bin + /b ConfigHintsHardArcade.bin + /b ConfigHintsHardHome.bin + /b ConfigNoHintsEasyArcade.bin + /b ConfigNoHintsEasyHome.bin + /b ConfigNoHintsHardArcade.bin + /b ConfigNoHintsHardHome.bin + /B F18A.bin + /b HLSplash.bin + /b HLTitle.bin + /b ..\code\spritesC.bin + /b Instruction1Joy.bin + /b Instruction1Key.bin + /b Instruction2Joy.bin + /b Instruction2Key.bin + /b GameOver.bin + /b ColorBars.bin + /b Diag1.bin + /b Diag2.bin + /b Diag3.bin + /b Diag4.bin + /b Diag5.bin + /b Diag6.bin + /b Diag7.bin + /b Diag8.bin + /b Diag9.bin + /b Diag14.bin + /b AlphaLockUp.bin + /b ConfigHintsPracticeArcade.bin + /b ConfigHintsPracticeHome.bin + /b WinScreen.bin + /b Thanks.bin + /b ConfigNoHintsPracticeArcade.bin + /b ConfigNoHintsPracticeHome.bin + /b Copyright.bin + /b grid.bin /b CartROMData.bin

@rem pad up the GPL part and put the code into the cart
cd ..\code
copy /y gpl.bin gpl.tmp
d:\work\setbinsize\release\setbinsize gpl.tmp 256
copy /y /b DragonsLairC.bin + /b DragonsLairKeyC.bin + /b DragonosticsC.bin ^
+ /b ..\dl_pics\BorderC.bin + /b ..\dl_pics\Diag1.bin + /b ..\dl_pics\Diag2.bin ^
+ /b ..\dl_pics\Diag8.bin + /b ..\dl_pics\Diag9.bin ^
+ /b SceneA1Drawbridge.bin ^
+ /b SceneA1vestible.bin ^
+ /b SceneB2DrinkMe.bin ^
+ /b SceneB2Vines.bin ^
+ /b SceneB2Wind.bin ^
+ /b SceneB3Fire.bin ^
+ /b SceneB3Pot.bin ^
+ /b SceneB3Throne.bin ^
+ /b SceneB4Goons.bin ^
+ /b SceneB4Snakes.bin ^
+ /b SceneB4Wall.bin ^
+ /b SceneC5Lizardking.bin ^
+ /b SceneC5Pit.bin ^
+ /b SceneC5Ropes1.bin ^
+ /b SceneC5Ropes2.bin ^
+ /b SceneC6Horse1.bin ^
+ /b SceneC6Horse2.bin ^
+ /b SceneC6Smithy1.bin ^
+ /b SceneC6Smithy2.bin ^
+ /b SceneC6Wizard1.bin ^
+ /b SceneC6Wizard2.bin ^
+ /b SceneC7Crypt1.bin ^
+ /b SceneC7Crypt2.bin ^
+ /b SceneC7Knight1.bin ^
+ /b SceneC7Knight2.bin ^
+ /b SceneC7Pond1.bin ^
+ /b SceneC7Pond2.bin ^
+ /b SceneD1Platform.bin ^
+ /b SceneD1Platform2.bin ^
+ /b SceneD1Platshort.bin ^
+ /b SceneE1Bats.bin ^
+ /b SceneE2Blacknight.bin ^
+ /b SceneE3Catwalk.bin ^
+ /b SceneE4Electriccage.bin ^
+ /b SceneE5Mudmen.bin ^
+ /b SceneE6Poolballs.bin ^
+ /b SceneE7River.bin ^
+ /b SceneE8Vanishingfloor.bin ^
+ /b SceneF1Dragonslair.bin ^
+ /b SceneE7RiverArcade.bin ^
+ /b ..\dl_pics\CartROMData.bin /b rawcart.bin

@rem size to 128MB minus 256 bytes for the GPL code
d:\work\setbinsize\release\setbinsize rawcart.bin 134217472
copy /y /b rawcart.bin + /b gpl.tmp /b Test8.bin

d:\work\ti\checksumcart\release\checksumcart.exe Test8.bin 256

@rem make some truncated dummy carts for testing
copy /y test8.bin dummy8.bin
d:\work\setbinsize\release\setbinsize dummy8.bin 65536

copy /y test8.bin dummy2M_8.bin
d:\work\setbinsize\release\setbinsize dummy2M_8.bin 2097152

copy /y test8.bin dummy32M_8.bin
d:\work\setbinsize\release\setbinsize dummy32M_8.bin 33554432

copy /y test8.bin dummybroken8.bin
d:\work\ti\checksumcart\release\checksumcart.exe dummybroken8.bin 256 8

goto :EOF

:error
@ECHO ***
@ECHO * Assembly failed
@echo ***