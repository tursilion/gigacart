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

@rem prepare the video file
@rem first -8192 removes the code, second removes the first frame of video to keep the alignment
cd ..
D:\work\ti\video\tools\cartrepack.exe output.bin output_Cart8.bin
d:\work\setbinsize\release\setbinsize output_Cart8.bin -8192
d:\work\setbinsize\release\setbinsize output_Cart8.bin -8192
d:\work\setbinsize\release\setbinsize output_Cart8.bin 88588288
d:\work\ti\uncartify\debug\uncartify output_Cart8.bin

@rem append the still frames to the video file (note they are not in video format!)
@rem note we are assuming that the still frames are each exactly 8k and not padding individually
@rem final size is 128MB minus 8192 for the program and 256 for the GPL
cd dl_pics
copy /y /b ..\output_Cart8.bin + /b BorderOut.bin + /b ConfigHintsEasyArcade.bin + /b ConfigHintsEasyEnhanced.bin + /b ConfigHintsHardArcade.bin + /b ConfigHintsHardEnhanced.bin + /b ConfigNoHintsEasyArcade.bin + /b ConfigNoHintsEasyEnhanced.bin + /b ConfigNoHintsHardArcade.bin + /b ConfigNoHintsHardEnhanced.bin + /B F18A.bin + /b HLSplash.bin + /b HLTitle.bin /b CartROMData.bin
d:\work\setbinsize\release\setbinsize CartROMData.bin 134209280

@rem rebuild the code
cd ..\code
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R DragonsLair.a99 -L DragonsLair.lst -o D:\classic99\dsk1\DragonsLair.obj
@if errorlevel 1 goto error
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\DragonsLair.obj DragonsLairC.bin -raw -block
d:\work\setbinsize\release\setbinsize DragonsLairC.bin 8192

@rem pad up to size and add the GPL part for boot
copy /y gpl.bin gpl.tmp
d:\work\setbinsize\release\setbinsize gpl.tmp 256
copy /y /b DragonsLairC.bin + /b ..\dl_pics\CartROMData.bin + /b gpl.tmp /b Test8.bin
goto :EOF

:error
@ECHO ***
@ECHO * Assembly failed
@echo ***