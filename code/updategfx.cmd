@rem set your path here, if needed for Python
@set PATH=%PATH%;C:\Python27\

@rem update the graphics
d:
cd \work\ti\dragonslair\dl_pics
d:\work\ti\videobitmap2border\debug\videobitmap2border BORDER2 BorderOut.bin BORDER
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYARCADE ConfigHintsEasyArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYENHANCED ConfigHintsEasyEnhanced.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDARCADE ConfigHintsHardArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDENHANCED ConfigHintsHardEnhanced.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYARCADE ConfigNoHintsEasyArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYENHANCED ConfigNoHintsEasyEnhanced.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDARCADE ConfigNoHintsHardArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDENHANCED ConfigNoHintsHardEnhanced.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSPRACTICEARCADE ConfigHintsPracticeArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSPRACTICEENHANCED ConfigHintsPracticeEnhanced.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSPRACTICEARCADE ConfigNoHintsPracticeArcade.bin CONTENT COL 241
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSPRACTICEENHANCED ConfigNoHintsPracticeEnhanced.bin CONTENT COL 241
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
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R SceneA1.a99 -L SceneA1.lst -o D:\classic99\dsk1\SceneA1.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\SceneA1.obj SceneA1.bin -raw -block
d:\work\setbinsize\release\setbinsize SceneA1.bin 8192

@rem append the still frames to the video file (note they are not in video format!)
@rem note we are assuming that the still frames are each exactly 8k and not padding individually
@rem how long can a copy line be? (8192 chars, apparently)
cd ..\dl_pics
copy /y /b ..\output_Cart8.bin + /b BorderOut.bin + /b ConfigHintsEasyArcade.bin + /b ConfigHintsEasyEnhanced.bin + /b ConfigHintsHardArcade.bin + /b ConfigHintsHardEnhanced.bin + /b ConfigNoHintsEasyArcade.bin + /b ConfigNoHintsEasyEnhanced.bin + /b ConfigNoHintsHardArcade.bin + /b ConfigNoHintsHardEnhanced.bin + /B F18A.bin + /b HLSplash.bin + /b HLTitle.bin + /b ..\code\spritesC.bin + /b Instruction1Joy.bin + /b Instruction1Key.bin + /b Instruction2Joy.bin + /b Instruction2Key.bin + /b GameOver.bin + /b ColorBars.bin + /b Diag1.bin + /b Diag2.bin + /b Diag3.bin + /b Diag4.bin + /b Diag5.bin + /b Diag6.bin + /b Diag7.bin + /b Diag8.bin + /b Diag9.bin + /b Diag14.bin + /b AlphaLockUp.bin + /b ConfigHintsPracticeArcade.bin + /b ConfigHintsPracticeEnhanced.bin + /b ConfigHintsPracticeEnhanced.bin + /b ConfigHintsPracticeEnhanced.bin + /b ConfigNoHintsPracticeArcade.bin + /b ConfigNoHintsPracticeEnhanced.bin /b CartROMData.bin

@rem pad up the GPL part and put the code into the cart
cd ..\code
copy /y gpl.bin gpl.tmp
d:\work\setbinsize\release\setbinsize gpl.tmp 256
copy /y /b DragonsLairC.bin + /b DragonsLairKeyC.bin + /b DragonosticsC.bin + /b SceneA1.bin + /b ..\dl_pics\CartROMData.bin /b rawcart.bin

@rem size to 128MB minus 256 bytes for the GPL code
d:\work\setbinsize\release\setbinsize rawcart.bin 134217472
copy /y /b rawcart.bin + /b gpl.tmp /b Test8.bin

d:\work\ti\checksumcart\release\checksumcart.exe Test8.bin 256
goto :EOF

:error
@ECHO ***
@ECHO * Assembly failed
@echo ***