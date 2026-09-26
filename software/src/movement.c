#include <stdbool.h>
#include <nes.h>
#include "apu.h"
#include "joypad.h"
#include "ppu.h"
int default_step;

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
void movementRight(int current_position) {
    if (checkForCollision(true, current_position + default_step)) { //placeholders - default_step -- how big is one "step" in pixels
        move(1,1);
    }
}
/**
 * idk if the position will be like this or nah, just a prototype
 * int current_position - just a placeholder
 */
void movementLeft(int current_position) {
    if (checkForCollision(true, current_position - default_step)) { //placeholders - default_step -- how big is one "step" in pixels
        move(1,1);
    }
}
/**
 * zakladni funkce pro pohyb, urcite projde jeste hodne refactoringem
 */
void movement() {
    unsigned char pad;
    int current_position; //placeholder
    while (true) {
        waitvsync();
		pad = readJoypadOne();
        if (pad & JOYPAD_RIGHT) {
            movementRight(current_position);
        };
        if (pad & JOYPAD_LEFT) {
            movementLeft(current_position);
        }
    }
   

}
