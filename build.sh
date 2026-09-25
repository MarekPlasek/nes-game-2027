#!/usr/bin/env bash

readarray -d '' sources < <(find . -name '*.c')

detect_deps () {
	if command -v cl65; then
		printf "[OK] CC65 is installed!\n"
	else
		printf "[FATAL] CC65 is NOT installed!\n\nMake sure you install cc65 via either:\n- your package manager\n- https://cc65.github.io"
		exit 1
	fi
}

prep_build() {
	if [[ "$1" == "clean" ]]; then
		printf "Removing build/\n"
		rm -r build
	fi

	detect_deps
	if [[ "$DEBUG" == "true" ]] || [[ "$DEBUG" == "True" ]]; then
		build --debug-info -Wl --dbgfile,"out.dbg"
	else
		build
	fi
}

build () {
	mkdir -p build
	cl65 --verbose -t nes -I ./software/include $@ -o build/out.nes $sources
}

run_game () {
	fceux build/out.nes
}

main () {
	if [[ "$1" == "purge" ]]; then
		printf "Removing build/\n"
		rm -r build
		exit
	elif [[ "$1" == "run" ]]; then
		prep_build
		run_game
	else
		prep_build
	fi
}

main $@
