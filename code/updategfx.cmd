@rem set your path here, if needed for Python
@set PATH=%PATH%;C:\Python27\

@rem update the graphics
d:
cd \work\ti\dragonslair\dl_pics
d:\work\ti\videobitmap2border\debug\videobitmap2border BORDER2 BorderOut.bin BORDER
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYARCADE ConfigHintsEasyArcade.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSEASYENHANCED ConfigHintsEasyEnhanced.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDARCADE ConfigHintsHardArcade.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGHINTSHARDENHANCED ConfigHintsHardEnhanced.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYARCADE ConfigNoHintsEasyArcade.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSEASYENHANCED ConfigNoHintsEasyEnhanced.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDARCADE ConfigNoHintsHardArcade.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border CONFIGNOHINTSHARDENHANCED ConfigNoHintsHardEnhanced.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border F18A F18A.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border HLSPLASH HLSplash.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border HLTITLE HLTitle.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION1JOY Instruction1Joy.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION1KEY Instruction1Key.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION2JOY Instruction2Joy.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border INSTRUCTION2KEY Instruction2Key.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border GAMEOVER GameOver.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border COLORBARS ColorBars.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG1 Diag1.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG2 Diag2.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG3 Diag3.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG4 Diag4.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG5 Diag5.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG6 Diag6.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG7 Diag7.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG8 Diag8.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG9 Diag9.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border DIAG14 Diag14.bin CONTENT
d:\work\ti\videobitmap2border\debug\videobitmap2border ALPHALOCKUP AlphaLockUp.bin CONTENT

@rem prepare the video file
@rem first -8192 removes the code, then removes the first three frames of video to keep the alignment (32768 total)
cd ..
D:\work\ti\video\tools\cartrepack.exe output.bin output_Cart8.bin
d:\work\setbinsize\release\setbinsize output_Cart8.bin -32768
d:\work\setbinsize\release\setbinsize output_Cart8.bin 88571904
d:\work\ti\uncartify\debug\uncartify output_Cart8.bin

@rem append the still frames to the video file (note they are not in video format!)
@rem note we are assuming that the still frames are each exactly 8k and not padding individually
@rem final size is 128MB minus 8192 * 3 for the program and 256 for the GPL (so not based on size of data!)
cd dl_pics
copy /y /b ..\output_Cart8.bin + /b BorderOut.bin + /b ConfigHintsEasyArcade.bin + /b ConfigHintsEasyEnhanced.bin + /b ConfigHintsHardArcade.bin + /b ConfigHintsHardEnhanced.bin + /b ConfigNoHintsEasyArcade.bin + /b ConfigNoHintsEasyEnhanced.bin + /b ConfigNoHintsHardArcade.bin + /b ConfigNoHintsHardEnhanced.bin + /B F18A.bin + /b HLSplash.bin + /b HLTitle.bin + /b ..\code\sprites.bin + /b Instruction1Joy.bin + /b Instruction1Key.bin + /b Instruction2Joy.bin + /b Instruction2Key.bin + /b GameOver.bin + /b ColorBars.bin + /b Diag1.bin + /b Diag2.bin + /b Diag3.bin + /b Diag4.bin + /b Diag5.bin + /b Diag6.bin + /b Diag7.bin + /b Diag8.bin + /b Diag9.bin + /b Diag14.bin + /b AlphaLockUp.bin /b CartROMData.bin
d:\work\setbinsize\release\setbinsize CartROMData.bin 134192896

@rem rebuild the code
cd ..\code
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


@rem pad up to size and add the GPL part for boot
copy /y gpl.bin gpl.tmp
d:\work\setbinsize\release\setbinsize gpl.tmp 256
copy /y /b DragonsLairC.bin + /b DragonsLairKeyC.bin + /b DragonosticsC.bin + /b ..\dl_pics\CartROMData.bin + /b gpl.tmp /b Test8.bin
goto :EOF

:error
@ECHO ***
@ECHO * Assembly failed
@echo ***