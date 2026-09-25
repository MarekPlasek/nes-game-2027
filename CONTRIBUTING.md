# Contributing

Tento dokument popisuje domluvené protokoly pro spolupráci na této repozitáři.

## Větve

- `main` - hlavní branže do které jsou spojované veškeré změny
- `stable` - do této větve bude cca. každý měsíc spojována main větev

## Vytváření nových funkcí

Nové funkce jsou vytvářené na krátkodobých větvích odvětvující se od větve `main`.

### Počátek práce na funkci

Po tom, co člověk vytvoří a přidělí si/je člověku přidělen úkol v tasklistě Game Design Docu, musí
vytvořit novou větev pojmenovanou po funkci kterou přidává.

Název větve by měl být co nejstručnější s tím, že si z něho dokáže člověk
udělat hrubou představu, v čem vyvinutá funkce bude spočívat.

### Publikování funkce

Po zhotovení funkce je nutné spojit větev do větve `main`. Toto je možné
pomocí odeslání pull requestu, kterou musí projít alespoň 2 členové skupiny.

### O čem to mluvíš???

Udělej tohle:

```sh
git clone git@github.com:MarekPlasek/nes-game-2027.git
```

Potom udělej tohle:

```sh
git branch -M <nazev-funkce-co-chces-v-kebab-case>
```

Potom co uděláš první commit udělej tohle:

```sh
git push -u origin <branch>
```

jinak po ostatních dělej jenom `git push`.

Potom co jseš hotovej/-á, tak to vraž na pull request.

## Etiketa kódu

Tato sekce popisuje upravenost kódu přítomná v tomto projektu.

#### Lokální proměnné

Lokální proměnné jsou proměnné přítomné ve funkcích či jiných místech nedefinovaných předprocesorem `#define`.
Lokální proměnné používají **camel case.**

#### Makra

Makra jsou proměnné a registry, či jiné paměťové adresy, definované pomocí předprocesoru `#define`.
Makra používají **kapitalizovaný snake case**. 

#### Funkce

Funkce jsou **pojmenovávány s pomocí camel case**, s tím že formátování složených závorek probíhá takto.

```c
// Správně
int goodFormatting() {
	return 69;
}

//Špatně
int badFormatting()
{
	return 67;
}
```

