TARGET=strbuf.bin
TARGET1=strbuf.tmp
LD=z88dk-z80asm
OBJS=strbuf.o
AS=z88dk-z80asm
RM=rm -f

all:$(TARGET)

$(TARGET):$(TARGET1)
	python mkbsave.py $(TARGET1) $(TARGET)
	cp -p $(TARGET) ..

$(TARGET1):$(OBJS)
	$(LD) -b -o=$(TARGET1) -m $(ASCONFIGS) $(OBJS)

.SUFFIXES: .asm .o
.asm.o:
	$(AS) $(ASCONFIGS) $<

clean:
	$(RM) $(OBJS) $(TARGET) $(TARGET1) *.map
