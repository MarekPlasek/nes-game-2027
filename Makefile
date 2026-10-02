CC = /usr/bin/cc65
AS = /usr/bin/ca65
LD = /usr/bin/ld65

CFLAGS := -I "./software/include" -Oirs --add-source
LDFLAGS := -v -C linker.cfg

c_sources := $(subst software/src/,,$(shell find software/src -name '*.c'))
s_sources := $(subst software/src/,,$(shell find software/src -name '*.s'))
s_intermediate := $(patsubst %.c,build/%.s,$(c_sources))

o_files_c := $(patsubst build/%.s,build/%.o,$(s_intermediate))
o_files_s := $(patsubst %.s,build/%.o,$(s_sources))
o_files := $(o_files_c) $(o_files_s)

.PHONY: default all

default: dist/game.nes

debug:
	@echo TOOLS:
	@echo -------
	@echo Compiler: $(CC)
	@echo Assembler: $(AS)
	@echo Linker: $(LD)
	@echo ""
	@echo Compiler flags: $(CFLAGS)
	@echo Linker flags: $(LDFLAGS)
	@echo ""
	@echo ""
	@echo PATHS:
	@echo -------
	@echo Detected C sources: $(c_sources)
	@echo Detected Assembly sources: $(s_sources)
	@echo ""
	@echo Intermediate assembly: $(s_intermediate)
	@echo Object files \(C\): $(o_files_c)
	@echo Object files \(ASM\): $(o_files_s)
	@echo Object files \(all\): $(o_files) 

clean:
	rm -r build dist

# Compile C source to intermediate assembly
build/%.s: software/src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o "$@" "$<"

# Source assembly to object files
build/%.o: software/src/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# Intermediate assembly to object files
build/%.o: build/%.s
	@mkdir -p $(dir $@)
	$(AS) -o $@ $<

# Linking everything together
dist/game.nes: $(o_files)
	@mkdir -p dist
	$(LD) $(LDFLAGS) -o "$@" $^ nes.lib

