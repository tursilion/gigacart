#note: no cart in this one

# Paths to TMS9900 compilation tools 
# ( Set in environment to override paths )
TMS9900_DIR?=/home/tursilion/gcc9900/bin
ELF2EA5_DIR?=/home/tursilion/gcc9900/bin
EA5_SPLIT_DIR?=/home/tursilion/gcc9900/bin
CLASSIC99_DSK1?=/mnt/d/classic99/DSK1/
LIBTI99?=/mnt/d/work/ti/libti99

# Full paths to the executables used
GAS=$(TMS9900_DIR)/tms9900-as
LD=$(TMS9900_DIR)/tms9900-ld
CC=$(TMS9900_DIR)/tms9900-gcc
AR=$(TMS9900_DIR)/tms9900-ar
ELF2EA5=$(ELF2EA5_DIR)/elf2ea5
EA5SPLIT=$(EA5_SPLIT_DIR)/ea5split

# Paths to TMS9900 compilation tools
CP=/bin/cp
NAME=cartwrite

# Flags used during linking
#
# Locate the code (.text section) and the data (.data section)
LDFLAGS_EA5=\
  --section-start .text=a000 --section-start .data=2080 -M

INCPATH=-I$(LIBTI99)
LIBPATH=-L$(LIBTI99)
LIBS=-lti99

C_FLAGS=\
  -O2 -std=c99 -s --save-temp

# List of compiled objects used in executable
OBJECT_LIST_EA5=\
  crt0_ea5.o\

OBJECT_LIST=\
  main.o		\
  scratch.o

# List of all files needed in executable
PREREQUISITES=\
  $(OBJECT_LIST_EA5) $(OBJECT_LIST)
  
all: cartwrite

# Recipe to compile the executable
cartwrite: $(PREREQUISITES)
	$(LD) $(OBJECT_LIST_EA5) $(OBJECT_LIST) $(LIBS) $(LIBPATH) $(LDFLAGS_EA5) -o $(NAME).ea5.elf > ea5.map
	$(ELF2EA5) $(NAME).ea5.elf $(NAME).ea5.bin
	$(EA5SPLIT) $(NAME).ea5.bin
	$(CP) CARTWRIT* /mnt/d/classic99/dsk1/

# Recipe to clean all compiled objects
.phony clean:
	rm *.o
	rm *.elf
	rm *.map
	rm *.bin

# Recipe to compile all assembly files

%.o: %.asm
	$(GAS) -a $< -o $@ > $<.lst

# Recipe to compile all C files
%.o: %.c
	$(CC) -c $< $(C_FLAGS) $(INCPATH) -o $@
