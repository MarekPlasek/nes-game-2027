#include <stdbool.h>
#include <nes.h>
#include "apu.h"
#include "joypad.h"
#include "ppu.h"
int default_step;
int default_jump;
int default_dash;
int last_movement;

/**
 * > Jsem velmi confused z wiki
 * > Chci si udelat zakladni logiku
 * > Toto ma udelat nekdo jiny
 * > Prozatim musi stacit toto
 * > Potom se to bude muset rozsirit o posunuti opravdovy aktualni polohy spritu (bude se pocitat stred nebo levy horni roh?)
 *
 * int direction - docasny parametr (neco vymysleneho), prozatim bude 1 - doprava 2 - doleva 3 - nahoru 4 - dolu
 *               - az to nekdo predela na neco rozumneho, zsikanujte me na predelani kodu
 *
 */
void move(int direction, int pixels) {
	/* We will definetly need to either pass a pointer
	 * to the current player position variable, or just
	 * keep a constant player position variable in the zeropage
	 * and address it from here.
	 */
}
/**
 * > Zatim nevim jak to delat, ale dumpnu sem alespon napady
 * 1. kontrolovat, jestli na necem stoji
 * 2. mozna pouzit transparent pixely at opravdu charactery muzou az ke zdi -- asi dobry napad probrat
 * 
 * bool sprite - placeholder
 * int position - placeholder, kde chce ten sprite byt umisten
 */

bool checkForCollision(bool sprite, int position) {
}
/**
 * idk if the position will be like this or nah, just a prototype
 * int current_position - just a placeholder
 */

/* 
 * Unsigned ints for positioning will *maybe* result
 * in some math fuckery when dealing with actually
 * drawing the player but it will definetly result
 * in faster code
 */

void movementRight(unsigned int* current_position) {
    if (checkForCollision(true, *current_position + default_step)) { //placeholders - default_step -- how big is one "step" in pixels
        move(1,1);
    }
}
/**
 * idk if the position will be like this or nah, just a prototype
 * int current_position - just a placeholder
 */
void movementLeft(unsigned int* current_position) {
    if (checkForCollision(true, *current_position - default_step)) { //placeholders - default_step -- how big is one "step" in pixels
        move(1, default_step);
    }
}
/**
 * the current position is placeholder - prob will have to differ Y a X??
 * int* current_position - placeholder
 */
void jump (unsigned int* current_position) {
    if(checkForCollision(true, *current_position + default_jump)) {
        move (3, default_jump);
    }
}

/**
 * current_position - placeholder
 */
void dash (unsigned int* current_position) {
    switch (last_movement) {
        case 1: {
            if (checkForCollision(true, *current_position + default_dash)) {
                move(1, default_dash);
            }
            break;
        };

        case 2: {
            if(checkForCollision(true, *current_position - default_dash)) {
                move(2, default_dash);
            }
            break;
        }
    }
}
/**
 * for dashing (and maybe sprite facing? i added variable which remembers where was the character moving for the last time)
 */
void movement(unsigned char* pad) {
    unsigned int current_position; //placeholder

	if (*pad & JOYPAD_RIGHT) {
        movementRight(&current_position);
        last_movement = 1;
    };
    if (*pad & JOYPAD_LEFT) {
        movementLeft(&current_position);
        last_movement = 2;
    }

    if(*pad & JOYPAD_UP) {
        jump(&current_position);
    }
    if(*pad & JOYPAD_B) {
        dash(&current_position);
    }
}

