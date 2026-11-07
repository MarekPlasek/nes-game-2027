CC = cc65
AS = ca65
LD = ld65

CFLAGS := -I "./include" -I "./lib/include" -Oirs --add-source
ASFLAGS := --cpu 6502 -g
LDFLAGS := -v -C linker.cfg --dbgfile dist/game.nes.dbg --mapfile dist/game.nes.map

c_sources := $(subst src/,,$(shell find src -name '*.c'))
c_lib := $(subst lib/,,$(shell find lib -name '*.c'))

s_sources := $(subst src/,,$(shell find src -name '*.s'))
s_lib := $(subst lib/,,$(shell find lib -name '*.s'))
s_musicassets := $(subst Resources/music,,$(shell find Resources/music -name '*.s'))
s_intermediate := $(patsubst %.c,build/%.s,$(c_sources))

o_files_c := $(patsubst build/%.s,build/%.o,$(s_intermediate))
o_files_s := $(patsubst %.s,build/%.o,$(s_sources))
o_files_lib := $(patsubst %.s,build/libraries/%.o,$(s_lib))
o_files_musicassets := $(patsubst %.s,build/assets/music/%.o,$(s_musicassets))
o_files := $(o_files_c) $(o_files_s) $(o_files_lib) $(o_files_musicassets)

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
	@echo Detected C libs: $(c_lib)
	@echo Detected Assembly libs: $(s_lib)
	@echo ""
	@echo Intermediate assembly: $(s_intermediate)
	@echo Object files \(C\): $(o_files_c)
	@echo Object files \(ASM\): $(o_files_s)
	@echo Object files \(lib\): $(o_files_lib)
	@echo Object files \(all\): $(o_files) 

clean:
	rm -r build dist

# Compile C source to intermediate assembly
build/%.s: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o "$@" "$<"

# External C libraries to intermediate assembly
build/libraries/%.s: lib/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $<

# Source assembly to object files
build/%.o: src/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# External assembly libraries to object files
build/libraries/%.o: lib/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# Music assets to object files
build/assets/music/%.o: Resources/music/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# Intermediate assembly to object files
build/%.o: build/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# Linking everything together
dist/game.nes: $(o_files)
	@mkdir -p dist
	$(LD) $(LDFLAGS) -o "$@" $^ nes.lib

