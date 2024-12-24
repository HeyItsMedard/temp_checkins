# 1. Pokémon GO Meetup szervezés

Szilveszter és Medárd nagykövetek meetupokat szeretnének szervezni egy bizonytalan mennyiségű játékosnak.
Mindkettejüknek vannak teendőik is, ezért nem garancia, hogy minden meetup megtartható. 

Constraint:
- Amely meetupot legalább egy ambassador megtart, az rewardos lesz.
- Szilveszter piros betűs napokon és hétvégéken tud kint lenni, hétközben dolgozik.
- Medárd hétközben legtöbbször ráér, kivétel hétfőt, mivel sokáig tart az órája egyetemen. Hétvégén ha két meetup van mindkét napra, akkor abból az egyiken garantált, hogy nem vesz részt. Általában a legtöbben az eventek első napjára jönnek el.
- Hetente egy nagykövet nem fog vállalni 3-nál több meetupot, de legalább egyet biztosan. Ez azt is jelentheti, hogy Medárd és Szilveszter találkoznak egy hétvégi meetupon (ahol nincs mindkét hétvégi napon meetup, pl. csak szombaton van).
- megtartott eventek előtt Lure Partyt is szoktak csinálni, amivel megduplázhatják a checkinek számát. Nagyjából minden lure party a normál eventhez képest átlagosan 3 checkinnel kevesebbet kap. A Lure Party nem digitális rewardos meetupnak számít, de a checkin számít az osztályzáshoz.

Van egy bizonyos adat arról, hány játékos jelezte, hogy jönni fog meetupokra (ez randomizált Pythonból). A meetupok mind valódiak (json).
- maximalizálunk kiosztott virtuális rewardok számát -> vajon elér a közösség egy magasabb osztályt?
- itt a random adatok mellett érdemes adni egy ceiling számlálást is, ahhoz mérni a többi értékeket
- feltételek az osztályokhoz:
    - negyedéves számlálás
    - intervallumok (és ezekhez majd döntési változó, constraint kell):
        - Origin: 0-60
        - Great: 61-249
        - Ultra: 250-749
        - Master: 750-1499
        - Legendary: 1499-...
    - eszerint kapunk egy bizonyos mennyiségű szétosztható nyereményt (fizikai)
    - természetesen egyszerre csak egy ligában lehetünk bent (constraint)
- írjuk ki a megtartott meetupokat, azokhoz a játékosok mennyiségét, a végén azzal, hogy hány checkint szereztek, melyik osztályba kerülnek.

Meetup lista (októbertől kezdődően):  
Nevek amúgy nem fontosak, később lehet nem is írom mellé.  
Garantáltan hétközi események: Max Mondays, Spotlight Hour, Raid Hour.  

**October 2024:**

- **Spotlight Hours:**
  - *October 1:* Pidove
  - *October 8:* Galarian Slowpoke
  - *October 15:* Shroomish
  - *October 22:* Ghosts
  - *October 29:* Costume Froakie & Rowlet

- **Raid Hours:**
  - *October 2:* Zacian
  - *October 9:* Zamazenta.
  - *October 16:* Giratina (Origin Forme).
  - *October 23:* Giratina (Origin Forme).
  - *October 30:* Darkrai.

Egyéb eventek:
- **Community Day:**
  - *October 5:* Sewaddle

- **Mega Raid Day:**
  - *October 10:* Mawile

- **Research Day:**
  - *October 19:* Yamask & Galarian Yamask

- **Gigantamax Raid Day 1:**
  - *October 26:* Kanto

- **Gigantamax Raid Day 2:**
  - *October 27:* Kanto

- **Gigantamax Raid Day 0 Gengar:**
  - *October 31:* Gengar, CSÜTÖRTÖK! hétközi

**November 2024:**

- **Max Mondays:**
  - Novemberben lett bevezetve, azelőtt nem volt hétfői meetup. Ebben a hónapban 3 alkalom volt. (11, 18, 25) Mivel nincs piros betűs ünnep, ezért senki nem tudja megtartani.

- **Spotlight Hours:**
  - *November 5* 
  - *November 12*
  - *November 26*

- **Raid Hours:**
  - *November 6* 
  - *November 13*
  - *November 19*
  - *November 20*
  - *November 21*
  - *November 22*
  - *November 27*

Egyéb eventek:

- **Gigantamax Raid Day 2 Gengar:**
  - *November 1:* Gengar, PÉNTEK! hétközi

- **Gigantamax Raid Day 2 Gengar:**
  - *November 2:* Gengar, SZOMBAT

- **Gigantamax Raid Day 3 Gengar:**
  - *November 3:* Gengar, VASÁRNAP

- **Community Day:**
  - *November 10:* Mankey

- **Wild Area Day 1**:
  - *November 23:* Global

- **Wild Area Day 2**:
  - *November 24:* Global

**December 2024:**

- **Max Mondays:**
  - Folytatódik Decemberben, 5 alkalommal lenne (2, 9, 16, 23, 30). Mivel nincs piros betűs ünnep, ezért senki nem tudja megtartani.

- **Spotlight Hours:**
  - *December 3:* Sableye 
  - *December 10:* Murkrow
  - *December 17:* Slugma 
  - *December 24:* Delibird

- **Raid Hours:**
  - *December 4:* Genesect (Chill Drive).
  - *December 11:* Genesect (Chill Drive).
  - *December 18:* Mega Latios.
  - *December 25:* Mega Latias.

Egyéb eventek:
- **Aspiring Dragons Research Day:**
  - *December 7*

- **Gigantamax Lapras Max Battle Day:**
  - *December 8*

- **Necrozma Fusion Raid Day:**
  - *December 14*

- **Community Day Weekend Day 1:**
  - *December 21*

- **Community Day Weekend Day 1:**
  - *December 22*
