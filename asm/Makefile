TARGET=calc.bin
TARGET_TMP=calc.tmp
OBJS=calc.o
LD=z88dk-z80asm
AS=z88dk-z80asm
RM=rm -f

all:$(TARGET)

$(TARGET):$(TARGET_TMP)
	python mkbsave.py $(TARGET_TMP) $(TARGET) da00
	cp -p $(TARGET) ..

$(TARGET_TMP):$(OBJS)
	$(LD) -b -o=$(TARGET_TMP) -m $(ASCONFIGS) $(OBJS)

.SUFFIXES: .asm .o
.asm.o:
	$(AS) $(ASCONFIGS) $<

clean:
	$(RM) $(OBJS) $(TARGET) $(TARGET_TMP) *.map
