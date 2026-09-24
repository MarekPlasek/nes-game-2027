# Contributing

Tento dokument popisuje domluvené protokoly pro spolupráci na této repozitáři.

## Větve

- `main` - hlavní branže do které jsou spojované veškeré změny
- `stable` - do této větve bude cca. každý měsíc spojována main větev

## Počátek práce na funkci

Po tom, co člověk vytvoří a přidělí si/je člověku přidělen úkol v tasklistě Game Design Docu, musí
vytvořit novou větev pojmenovanou po funkci kterou přidává.

Název větve by měl být co nejstručnější s tím, že si z něho dokáže člověk
udělat hrubou představu, v čem vyvinutá funkce bude spočívat. Zde je uvedený příklad:

```
				 /----(backgrounds)-------------\
				/								 \
--(main)-------------------------------------------------
			   \						     /
				\--(movement-prototype)-----/
```

## Publikování funkce

Po zhotovení funkce je nutné spojit větev do `main` větve. Toto je možné
pomocí odeslání pull requestu, kterou musí projít alespoň 2 členové skupiny.

## `stable` větev

Každý cca. měsíc (vždycky před prezentacema) se `main` větev spojí do `stable`
větve přes PR.

## O čem to mluvíš???

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
git push -u <branch> <branch>
```

jinak po ostatních dělej jenom `git push`.

Potom co jseš hotovej/-á, tak to vraž na pull request.
