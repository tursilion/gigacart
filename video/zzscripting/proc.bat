del /s /q temp\*
rmdir /s /q temp
mkdir tools
copy /y ..\zzscripting\tools\* tools\
attrib -r convert9918.ini
del convert9918.ini
copy /y tools\convert9918.ini .
attrib +r convert9918.ini
echo y | ..\zzscripting\tividconvert %1
del %1.bin
del %1_8.bin
rename finalpack.bin %1.bin
rename finalpack8.bin %1_8.bin
