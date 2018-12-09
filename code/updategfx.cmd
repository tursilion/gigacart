@rem set your path here, if needed for Python
@set PATH=%PATH%;C:\Python27\

@rem update the graphics
d:
cd \work\ti\dragonslair\dl_pics
d:\work\ti\videobitmap2border\debug\videobitmap2border BORDER2 BorderOut
d:\tools\bin2inc BorderOut_p.bin ..\code\BorderOut_p.inc BORDPAT TI
d:\tools\bin2inc BorderOut_c.bin ..\code\BorderOut_c.inc BORDCOL TI
d:\tools\bin2inc BorderOut_pat.bin ..\code\BorderOut_pat.inc BORDSIT TI
cd ..\code

@rem rebuild the code
python \work\f18a\f18a_994a_isu_updater_1.9_beta\tools\xdt99\xas99.py -R DragonsLair.a99 -L DragonsLair.lst -o D:\classic99\dsk1\DragonsLair.obj
d:\work\ti\tiobj2bin\release\tiobj2bin d:\classic99\dsk1\DragonsLair.obj DragonsLairC.bin -raw -block
d:\work\setbinsize\release\setbinsize DragonsLairC.bin 8192
copy /y /b DragonsLairC.bin + /b rawAttractVideo8.bin /b Test8.bin
