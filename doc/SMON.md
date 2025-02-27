*Quelle: 64'er Sonderheft 35, S. 132 ff. , 1988 Markt & Technik Verlag AG*

# SMON der Profimonitor
 
Die St�rken dieses Super-Maschinensprache-Monitors sind haupts�chlich
die m�chtigen Such- und Trace-Befehle zum Austesten von Programmen in
Maschinensprache. Der SMON enth�lt auch einen vollst�ndigen
Diskmonitor und einen Disassembler, der auch illegale Opcodes
disassembliert. Ein Programm, mit dem auch Profis gern arbeiten.

Ich kann mich noch gut an unsere ersten Schritte in Maschinensprache
erinnern. Ausger�stet mit einer Befehlsliste f�r den 6502-kompatiblen
Prozessor des C64 und einem in Basic geschriebenen "Mini-Monitor"
entstanden Programme, die 3 und 5 addieren und das Ergebnis im
Speicher ablegen konnten. Dazu mu�ten wir die Befehlscodes aus der
Liste heraussuchen und dann in den Speicher "POKEn". Jeder Sprung
mu�te von Hand ausgerechnet werden, jeder falsch herausgesuchte Befehl
f�hrte zum Programmabsturz. Der erste Disassembler - ein Programm zur
Anzeige der Maschinenbefehle in Assemblersprache - war f�r uns die
Offenbarung. Von nun an konnten wir Maschinenprogramme analysieren und
daraus lernen. Zum Verst�ndnis der Maschinensprache ist es n�mlich
noch weit mehr als bei anderen Sprachen wichtig, vorhandene Programme
zu verstehen und sich dabei die wichtigsten Techniken anzueignen.

Mit der Zeit wuchsen unsere Anspr�che, ein Assembler mu�te her, um die
neugewonnenen Erkenntnisse auch auszuprobieren. Das war zuerst wieder
ein Basic-Programm, langsam und wenig komfortabel, aber immerhin. Wir
schrieben unsere ersten kleinen Routinen, vor allem, um vorhandene
Maschinenprogramme unseren eigenen W�nschen anzupassen. So entstand im
Laufe eines Jahres SMON. Immer neue Befehle und Routinen kamen hinzu,
bis wir endlich zufrieden waren.

## Was bietet SMON?

Zun�chst ist alles enthalten, was zum "Standard" geh�rt: 

- Memory-Dump, also die Anzeige des Speicherinhalts in Hex-Bytes, mit
�nderungsm�glichkeiten
- ein Disassembler mit �nderungsm�glichkeit sowie Routinen zum Laden,
Speichern und Starten von Maschinenprogrammen.

Dar�ber hinaus gibt es 

- einen kleinen Direktassembler, der sogar Labels verarbeitet
- Befehle zum Verschieben im Speicher mit und ohne
Umrechnen der Adressen 
- und Routinen zum Umrechnen von Hex-, Dezimal- und Bin�rzahlen.

Der besondere Clou von SMON liegt aber zweifellos in seinen
leistungsf�higen Suchroutinen und vor allem im Trace-Modus. Damit
lassen sich Maschinenprogramme Schritt f�r Schritt abarbeiten und
kontrollieren.

Der Monitor ben�tigt f�r alle Eingaben die hexadezimale Schreibweise,
das hei�t zu den Zahlen 1 bis 9 kommen noch die Buchstaben A (f�r
dez. 10) bis F (f�r dez. 15) hinzu.

Bei der Eingabe von Adressen ist folgendes zubeachten: `[ANFADR]`
bedeutet exakt die Startadresse, `[ENDADR]` bedeutet hierbei die erste
Adresse hinter dem gew�hlten Bereich. Im Normalfall ist die Eingabe
mit und ohne Leerzeichen zul�ssig. Beim Abweichen von dieser Regel
wird darauf besonders verwiesen. Tippen Sie zuerst das Hauptprogramm
(Listing 1) mit dem MSE ab. Befindet sich SMON auf Ihrer Diskette,
kann er mit `LOAD "SMON $C000",8,1` geladen und mit dem Befehl `SYS
49152` gestartet werden. Geben Sie vor dem SYS-Befehl aber NEW ein, um
einen sp�teren `OUT OF MEMORY` zu verhindern.

## Assemblieren

#### Syntax:

    A [ANFADR]

Assemblierung beginnt bei der angegebenen Adresse

#### Beispiel:

    A 4000	Beginn bei Startadresse $4000
    
Nach Eingabe von `RETURN` erscheint auf dem Bildschirm die gew�hlte
Adresse mit einem blinkenden Cursor. Die Befehle werden so eingegeben,
wie sie der Disassembler zeigt: LDY #00 oder LDA 400E,Y und so
weiter. `RETURN` schlie�t die Eingabe der Zeile ab.

Bei einer fehlerhaften Eingabe springt der Cursor wieder in die
Anfangsposition zur�ck. Ansonsten wird der Befehl disassembliert und
nach Ausgabe der Hex-Bytes gelistet. Zur Korrektur vorhergehender
Zeilen gehen Sie mit dem Cursor zur Anfangsposition (hinter die
Adresse) zur�ck, schreiben den Befehl neu und gehen nach `RETURN` mit
dem Cursor wieder in die letzte Zeile. Falls Ihnen bei Spr�ngen
(Branch-Befehl, JSR und JMP) die Zieladressen noch nicht bekannt sind,
geben Sie einfach sogenannte "Label" ein.

### Mit Bytes spielen

Ein Label besteht aus dem Buchstaben `M` (f�r Marke) und einer
zweistelligen Hex-Zahl von 01 bis 30.

#### Beispiel: 

    BCC M01

Wenn Sie die Zieladresse f�r diesen Sprung erreicht haben, dann
kennzeichnen Sie diese mit eben dieser "Marke".

#### Beispiel: 

    M01 LDY #00

Einzelne Bytes nimmt der Assembler an, indem Sie diese mit einem Punkt
kennzeichnen: beispielsweise `.00` oder `.AB`. In diesem Modus werden die
Eingaben nat�rlich nicht disassembliert.

Nach Beendigung des Assemblierens geben Sie `F` ein. Danach sehen Sie
alle Ihre Eingaben noch einmal aufgelistet und korrigieren dann bei
Bedarf wie beim Disassembler (!) angegeben.

Probieren Sie einmal das folgende Beispiel:

    A 4000

Der Assembier meldet sich mit: `4000` und einem blinkenden
Cursor. Geben Sie nun ein (die Adressen erscheinen automatisch):

    4000 LDY #00	
    4002 LDA 400E,Y	
    4005 JSR FFD2	
    4008 INY
    4009 CPY #12
    400B BCC 4002
    400D BRK
 
Die folgenden Bytes werden wie beschrieben mit einem Punkt
eingegeben. Sie werden nicht disassembliert.

    400E .0D	
    400F .0D	
    4010 .53
    4011 .4D	
    4012 .4F
    4013 .4E
    4014 .20
    4015 .49
    4016 .53
    4017 .54
    4018 .20
    4019 .53
    401A .55
    401B .50
    401C .45
    401D .52
    401E .0D
    401F. 0D

Dr�cken Sie anschlie�end `F`. Ihr Programm wird noch mal
aufgelistet. Starten Sie es nun mit `G 4000`. Es erscheint ein Text
auf dem Bildschirm - lassen Sie sich �berraschen.

## Disassemblieren

#### Syntax:

    D [ANFADR,ENDADR]

disassembliert den Bereich von `ANFADR` bis `ENDADR`, wobei `ENDADR`
nicht eingegeben werden mu�. Wird keine Endadresse eingegeben,
erscheint zun�chst nur eine Zeile:

     ADR   HEXBYTES   BEFEHL
     4000  A0 00      LDY #00

Mit der SPACE-Taste wird der jeweils n�chste Befehl in der gleichen
Art und Weise gezeigt. W�nschen Sie eine fortlaufende Ausgabe, dr�cken
Sie `RETURN`. Die Ausgabe wird dann so lange fortgesetzt, bis eine
weitere Taste gedr�ckt wird oder bis ENDADR erreicht ist. Mit
`RUN/STOP` springen Sie jederzeit in den Eingabemodus zur�ck. Das
Komma, das vor der Adresse auf dem Bildschirm erscheint, ist ein
"hidden command" (verstecktes Kommando). Es braucht nicht eingegeben
zu werden, da es automatisch beim Disassemblieren angezeigt wird. So
erm�glicht es ein einfaches �ndern des Programms. Fahren Sie mit dem
Cursor auf den zu �ndernden Befehl und �berschreiben Sie ihn mit dem
neuen. Wenn Sie jetzt `RETURN` dr�cken, erkennt SMON das Komma als
Befehl und f�hrt ihn im Speicher aus. Achten Sie aber darauf, da� der
neue Befehl die gleiche L�nge (in Byte) hat und f�llen Sie
gegebenenfalls mit "NOPs" auf. Zur Kontrolle k�nnen Sie den ge�nderten
Bereich noch einmal disassemblieren.

Lassen Sie als Beispiel einmal das Programm (siehe Befehl `A`) ab 4000
disassemblieren (`D 4000 4011`). �ndern Sie nun den ersten Befehl auf
LDY #0l. Die �nderung zeigt sich daran, da� die HEX-Bytes automatisch
den neuen Wert annehmen. Starten Sie nun das Programm nochmals mit `G
4000`. Jetzt erscheint der Text mit nur einer Zeile Abstand auf dem
Bildschirm.

## Starten eines Maschinenprogramms (Go)

#### Syntax: 

    G [ADRESSE]

startet ein Maschinenprogramm, das bei `ADRESSE` beginnt. Das Programm
mu� mit einem BRK-Befehl abgeschlossen werden, damit ein R�cksprung in
SMON erfolgen kann. Wird nach `G` keine Adresse eingegeben, benutzt
SMON die, die mit dem letzten BRK erreicht worden ist und bei der
Register-Ausgabe als PC auftaucht. Mit dem `R`-Befehl (siehe unten)
werden die Register vorher auf gew�nschte Werte gesetzt.

## Memory-Dump

#### Syntax: 

    M [ANFADR ENDADR)

gibt die HEX-Werte des Speichers sowie die zugeh�rigen ASCII-Zeichen
aus. Auch hier kann auf die Eingabe einer Endadresse verzichtet
werden. Die Steuerung der Ausgabe entspricht der beim Disassemblieren.

#### Beispiel:

    M 4000 

gibt die Inhalte der Speicherstellen $4000 bis $4007 aus. Weiter geht
es wie beim Disassemblieren mit SPACE oder RETURN. Die Bytes k�nnen
ebenfalls durch �berschreiben ge�ndert werden, allerdings nicht die
ASCII-Zeichen. Verantwortlich daf�r ist der Doppelpunkt, der am Anfang
jeder Zeile ausgegeben wird, ein weiterer "hidden command". Wenn Ihre
�nderung nicht durchgef�hrt werden kann, weil Sie zum Beispiel
versuchen, ins ROM zu schreiben, wird ein `?` als Fehlermeldung
ausgegeben.

## Registeranzeige

#### Syntax:

    R

zeigt den gegenw�rtigen Stand der wichtigsten 6510-Register an:
Programmz�hler (PC), Status-Register (SR), Akkumulator (AC),
X-Register (XR), Y-Register (YR), Stackpointer (SP). Au�erdem werden
die einzelnen Flags des Status-Registers mit 1 f�r "gesetzt" und 0 f�r
"nicht gesetzt" angezeigt. Durch �berschreiben werden die Inhalte auf
einen gew�nschten Wert gesetzt. Die Flags k�nnen allerdings nicht
einzeln ver�ndert werden, sondern nur durch �berschreiben des Wertes
von SR.

## Exit

#### Syntax: 

    X

springt ins Basic zur�ck. Alle Basic-Pointer bleiben erhalten. Sie
k�nnen also zum Beispiel direkt im Programm fortfahren, wenn Sie
zwischendurch mit SMON einige Speicherstellen kontrolliert
haben. Probieren Sie alle bisher beschriebenen Befehle in Ruhe aus und
machen Sie sich mit SMON vertraut. Arbeiten Sie auch parallel den Kurs
�ber Assembierprogrammierung in dieser Ausgabe durch. Alle Beispiele
dort sind auf SMON abgestimmt.

## I/O-Set

#### Syntax:

    IO 1

legt die Device-Nummer f�r LOAD und SAVE auf 1 (Kassette). Jedes Laden
und Abspeichern erfolgt jetzt auf das angegebene Ger�t. Die
voreingestellte Device-Nummer ist 8 (f�r die Floppy also: IO 8). Wenn
Sie nur mit der Floppy arbeiten, brauchen Sie diesen Befehl also
nicht.

## LOAD

#### Syntax: 

    L"name"

l�dt ein Programm vom angegebenen Ger�t (wie oben beschrieben) an die
Originaladresse in den Speicher. Die Basic-Zeiger bleiben bei diesem
Ladevorgang unbeeinflu�t, das hei�t, sie werden nicht ver�ndert.

#### Beispiel: 

Unser Monitor soll an seiner Originaladresse ($C000) im Speicher
stehen. Also brauchen Sie ihn nur mit `L"SMON"` zu laden, damit er
dort erscheint. Wenn Sie einmal ein Programm an eine andere als die
Originaladresse laden wollen, dann bietet Ihnen SMON dazu folgende
M�glichkeit: `L"name" ADRESSE` l�dt ein Programm an die angegebene
Adresse. Nehmen Sie doch bitte noch einmal unser letztes Test-Programm
und geben es mit dem Assembler ab Adresse $4000 ein. Speichern Sie es
mit `S"SUPERTEST" 4000 4023` ab und laden es dann

1. an die Originaladresse (`L"SUPERTEST"`) und
2. an eine andereAdresse (mit `L"SUPERTEST" 5000` zum Beispiel nach $5000).

Schauen Sie sich danach mit dem Disassembier-Befehl beide Routinen
einmal an. Sie werden feststellen, da� beide Programme zwar bis auf
die BRANCH-Befehle gleich aussehen, da� das Programm in $5000 aber
nicht funktionieren kann, da es eine falsche Adresse verwendet (5002
LDA 40OE,Y). 

Ein anderes Beispiel dazu: Ein Autostart-Programm beginnt bei $0120,
l��t sich aber in diesem Bereich nicht untersuchen, da dort der
Prozessor-STACK (im Bereich von $0100 bis$01FF) liegt, der vom
Prozessor selbst�ndig ver�ndert wird. Wenn Sie nun `L"name" 4120`
eingeben, befindet sich das Programm anschlie�end bei $4120 (nicht an
der Originaladresse $0120) und Sie k�nnen es ohne Einschr�nkungen -
von den falschen AbsolutAdressen abgesehen - disassemblieren.

## SAVE

#### Syntax:

    S"name", ANFADR ENDADR

speichert ein Programm von `ANFADR` bis `ENDADR-1` unter `name` auf
die Floppy ab, da diese - wie wir ja inzwischen wissen - das
voreingestellte Ger�t ist. Wenn Sie auf Kassette abspeichern wollen,
setzen Sie vorher mit `IO 1` die Device-Nummer auf 1.

#### Beispiel: 

    S " SUPERTEST" 4000 4020
    
speichert das Programm mit dem Namen `SUPERTEST` (es steht im Speicher
von $4000 bis $401F) auf Diskette ab. Bitte beachten Sie auch bei
diesem Befehl, da� die Endadresse auf das n�chste Byte hinter dem
Programm gesetzt wird.

## Printer-Set

#### Syntax:

    P 02

setzt die Prim�radresse f�r den Drucker auf 2. Voreingestellt ist hier
die 4 als Ger�tenummer (zum Beispiel f�r
Commodore-Drucker). Vielleicht haben Sie es ja schon bemerkt: Bei
allen Ausgabe-Befehlen (wie `D`, `M` etc.) k�nnen Sie auch den Drucker
ansprechen, wenn Sie das Kommando geshiftet eingeben. Die Ausgabe
erfolgt dann gleichzeitig auf Bildschirm und Drucker. (Beachten Sie
bitte die �nderung f�r die Druckerausgabe am Schlu� des Artikels.)

## Ein bi�chen Rechnerei

Die folgende Befehlsgruppe enth�lt Befehle zur Zahlenumrechnung. Sie
wissen ja: Der Mensch mit seinen zehn Fingern neigt eher zur dezimalen
Rechenweise, aber der Computer bevorzugt das Bin�rsystem, weil er nur
zwei Finger hat (siehe Netzstecker). Ein Kompromi� ist das
Hexadezimalsystem, denn das versteht keiner von beiden. Um
Verst�ndnisschwierigkeiten mit Ihrem Liebling aus dem Weg zu gehen,
haben Sie aber SMON.

### Umrechnung Dez-Hex

#### Syntax:

    # (Dezimalzahl)

rechnet die Dezimalzahl in die entsprechende Hexadezimalzahl
um. Hierbei k�nnen Sie die Eingabe in beliebiger Weise vornehmen, da
SMON Zahlen bis 65535 umrechnet.

#### Beispiel: 

    # 12
    # 144
    #3456
    #65533

und so weiter.

### Umrechnung Hex-Dez

#### Syntax: 

    $ (Hexadezimalzahl)

rechnet die Hexadezimalzahl in die entsprechende Dezimalzahl um. Die
Eingabe mu� hierbei zweistellig beziehungsweise vierstellig
erfolgen. Ist diese Zahl kleiner als $100 (=255), wird zus�tzlich auch
der Bin�rwert ausgegeben.
 
#### Beispiel: 

    $12
    $0012
    $0D
    $FFD2
    
etc. In den ersten drei Beispielen erfolgt die Anzeige auch in bin�rer
 Form.

### Umrechnung Bin�r-Hex,Dez

#### Syntax:

    % (Bin�rzahl (achtstellig))

rechnet die Bin�rzahl in die entsprechenden Hexa- und Dezimalzahlen
um. Bei diesem Befehl m�ssen Sie genau acht Bin�rzahlen
eingeben. Falls Sie einmal versehentlich mehr eingeben sollten, werden
nur die ersten acht zur Umrechnung herangezogen. 

#### Beispiel:

    %00011111
    %10101011

### Add-Sub

Syntax:

    ? 2340+156D 

berechnet die Summe der beiden vier (!)-stelligen Hex-Zahlen. Neben
der Addition ist auch Subtraktion m�glich.


## Programme auf dem Rangierbahnhof

### Occupy (Besetzen)

#### Syntax:

    O (ANFADR ENDADR HEX-Wert)

belegt den angegebenen Bereich mit dem vorgegebenen HEX-Wert. 

#### Beispiel:

    O 5000 8000 00 

f�llt den Bereich von $5000 bis $7FFF mit Nullen. Man kann mit
`OCCUPY` aber nicht nur Speicherbereiche l�schen, sondern auch mit
beliebigen Werten belegen. H�ufig hat man das Problem, festzustellen,
welcher Speicherplatz von einem Programm wirklich benutzt wird. Wir
f�llen den in Frage kommenden Bereich dann zuerst zum Beispiel mit
`AA` und laden dann unser Programm. Probieren Sie bitte das folgende

Beispiel: F�llen Sie den Speicherbereich von $3000 bis $6000 mit $AA
und laden Sie dann unser SUPERTEST-Programm. Beim Disassemblieren
k�nnen Sie erkennen, da� unser kleines Programm exakt zwischen vielen
`AA` eingebettet ist.

### Write

#### Syntax: 

    W (ANFADRalt ENDADRalt ANFADRneu)

verschiebt den Speicherbereich von ANFADRalt bis ENDADRalt nach
ANFADRneu ohne Umrechnung der Adressen! Unser kleines Testprogramm
m�ge noch einmal als Beispiel dienen:

    W 4000 4020 6000 
    
verschiebt das oben angesprochene Programm von $4000 nach
$6000. Hierbei werden weder die absoluten Adressen umgerechnet noch
die Tabellen ge�ndert. Letzteres ist sicherlich erw�nscht, aber denken
Sie daran, da� das verschobene Programm nun nicht mehr lauff�hig ist,
da die absoluten Adressen nicht mehr stimmen (zum Beispiel bei dem
Befehl `LDA 40OEY`). Falls Sie jetzt `G6000` eingeben, um das Programm
zu starten, werden Sie sich sicherlich wundern, da� es dennoch
l�uft. Doch l�schen Sie einmal das Programm in $4000 (mit `04000 4100
AA`) und starten das Programm in $6000 noch einmal! Seltsam, nicht?
Abhilfe schafft der n�chste Befehl.

### Variation

#### Syntax:

    V (ANFADRalt ENDADRalt ANFADRneu ANFADR ENDADR)
    
rechnet alle absoluten Adressen im Bereich von `ANFADR` bis `ENDADR`,
die sich auf `ANFADRalt` bis `ENDADRalt` beziehen, auf `ANFADRneu`
um. Kompliziert? Nicht, wenn Sie sich klarmachen, da� die ersten drei
Adressen exakt den Eingaben beim `W`-Befehl entsprechen. Neu hinzu
kommen nur die beiden Adressen f�r den Bereich, in dem die �nderung
tats�chlich erfolgt.

Um unser mit `W` schon verschobenes Programm auch wieder lauff�hig zu machen, geben Sie folgendes ein:

    V 4000 4020 6000 6000 600E
    
Damit werden alle Absolutadressen, die im Bereich von $6000 bis
$600E - dahinter steht die Tabelle - liegen und sich bisher auf $4000
bis $4020 bezogen haben, auf den neuen Bereich umgerechnet. Probieren
geht wie immer �ber kapieren. Eine Zusammenfassung dieser beiden
Befehle erm�glicht:

### Convertieren (Verschieben eines Programmes mit Adre�umrechnung.)

#### Syntax:

    C (ANFADRalt ENDADRalt ANFADRneu ANFADRges ENDADRges)

verschiebt das Programm von `ANFADRalt` bis `ENDADRalt` zur
`ANFADRneu`, und zwar mit Umrechnung der Adressen zwischen ANFADRges
und ENDADRges. An unserem kleinen Testprogramm l��t sich wieder einmal
demonstrieren, wie der Befehl eingesetzt wird. Laden Sie es also mit
`L"SUPERTEST"` und schauen es mit `D 4000` an. Jetzt wollen wir an der
Adresse $4008 einen 3-Byte-Befehl einf�gen: `C 4008 4020 400B 4000
4011` verschiebt das Programm von $4008 bis $4020 zur neuen
Anfangsadresse $400B. Dabei werden im Bereich von $4000 bis $4011
(neue Endadresse des `aktiven` Programmes!) die Sprungadressen
umgerechnet. Nun k�nnen Sie ab Adresse $4008 einen 3-Byte-Befehl
einf�gen, zum Beispiel `STY 0286`. Dazu geben Sie bitte ein:
 
    A 4008
    4008 STY 0286 
    F

�berzeugen Sie sich davon, da� SMON die Befehle korrekt umgerechnet
hat, indem Sie unser Beispiel disassemblieren (`D 4000`) und
anschlie�end mit `G 4000` starten. Besitzer eines Farbmonitors werden
in helle Begeisterung ausbrechen. Vorsicht ist geboten, wenn Tabellen
oder Text vorhanden sind. SMON wird versuchen, diese als Befehle zu
disassemblieren und gegebenenfalls umzurechnen. Dabei k�nnen
unvorhersehbare Verf�lschungen auftreten. Aus diesem Grunde ist im
Beispiel die Endadresse des zu �ndernden Bereiches auf $4011 und nicht
etwa auf $4023 gelegt worden. Wenn Sie gr��ere Programme zu
verschieben haben, sollten Sie die Kommandos W und V anwenden
beziehungsweise einen Assembler einsetzen (zum Beispiel Hypra-Ass),
der es Ihnen gestattet, beliebige Einf�gungen, Verschiebungen und
sonstige �nderungen vorzunehmen. Das C-Kommando eignet sich in erster
Linie f�r kleinere �nderungen innerhalb eines Programms.

### BASIC-DATA

#### Syntax:

    B (Anfadr Endadr)
    
wandelt das Maschinenprogramm von `ANFADR` bis `ENDADR-1` in
Basic-DATA-Zeilen um.

#### Beispiel:

    B 4000 4020

Unser Testprogramm wird in DATA-Werte umgerechnet und dann mit
Zeilennummer 32000 beginnend im Basic-Speicher abgelegt. Ein im
Speicher befindliches Basic-Programm (zum Beispiel ein Basic-Lader)
mit kleineren Zeilennummern kann dann diese DATA-Zeilen benutzen.

Wenn Sie das Testprogramm wie oben beschrieben umgewandelt haben,
�berzeugen Sie sich mit `LIST` von der Ausf�hrung. Dann k�nnen Sie
folgendes eingeben:

    10 FOR I=16384 TO 16415: READ D:POKE I,D: NEXT
    
In Verbindung mit den oben erzeugten DATA-Zeilen (und RUN!) h�tten Sie
wieder das urspr�ngliche Maschinenprogramm im Speicher. Falls Sie
dieses Beispiel durchf�hren wollen, denken Sie bitte daran, da� Sie
nach Erstellung der DATAs das Originalprogramm zum Beispiel mit OCCUPY
(`O 4000 4020 AA`) �berschreiben, damit Sie die richtige Ausf�hrung
�berpr�fen k�nnen.

Der BRK-Befehl am Ende des Testprogramms bewirkt einen Sprung zum SMON
zur�ck. Wollen Sie ein Maschinenprogramm von Basic aus starten und
auch wieder dorthin zur�ckgelangen, mu� der letzte Befehl ein RTS
sein. Probieren Sie es aus, indem Sie das Basic-Programm um `20 SYS
16384` erweitern.

## KONTROLLE

#### Syntax:

    K (Anfadr Endadr)

listet die ASCII-Zeichen im gew�nschten Bereich. Es werden jeweils 32
Zeichen pro Zeile ausgegeben, so da� man sich einen schnellen
�berblick �ber Texte oder Tabellen verschaffen kann.

#### Beispiel:

    K 4000

listet die ersten 32 Zeichen unseres Programms. Die weitere Ausgabe
ist genau wie beim Disassemblieren durch Druck auf SPACE oder RETURN
m�glich. Auch hier k�nnen Sie wie bei den anderen
Bildschirm-Ausgabebefehlen �nderungen durch einfaches �berschreiben
vornehmen (nat�rlich nicht im ROM und nur mit ASCII-Zeichen!).

Als Beispiel wollen wir einmal im Basic `herumpfuschen`. Das geht
nat�rlich nicht so ohne weiteres, weil das Basic im ROM steht und
damit nicht ver�ndert werden kann. Tippen Sie bitte folgendes ein:

    W A000 C000 A000
    
Auf den ersten Blick eine unsinnige Anweisung; der Speicher soll von A000 bis C000 nach A000 verschoben werden. Dieser Befehl entspricht exakt der Basic-Schleife `FOR I = 40960 TO 49152: POKE I, PEEK (I): NEXT`

Nun ist es aber so, da� beim `PEEK` das ROM gelesen beim `POKE` aber
ins darunterliegende RAM geschrieben wird. Wir erreichen also, da� das
Basic ins RAM kopiert wird. Jetzt m�ssen wir daf�r sorgen, da� das
Betriebssystem sein Basic aus dem RAM und nicht aus dem ROM
holt. Zust�ndig daf�r ist die Speicherstelle 0001. Geben Sie bitte `M
0001` ein und �berschreiben Sie die `37` mit `36`.

Es passiert gar nichts. Jetzt tritt unser K-Kommando in Aktion. Geben Sie ein:

    K A100 A360

Was Sie sehen, sind die Basic-Befehlsw�rter und -Meldungen. Schalten
Sie mit SHIFT/CBM auf Kleinschrift, dann erkennen Sie, da� der jeweils
letzte Buchstabe eines Befehlswortes gro� geschrieben ist
(Endekennung). Jetzt �ndern Sie durch �berschreiben das `LIST` (A100)
in `LUST` und `ERROR` (A360) in `FAELER`. (Bei `FAELER` m�ssen Sie ein
Zeichen vor `ERROR` beginnen, sonst pa�t es nicht.)

Verlassen Sie jetzt SMON mit `X` und geben Sie danach ein:

    POKE 1,54
    
SMON schaltet n�mlich beim `X`-Befehl immer auf das Basic-ROM zur�ck,
daher m�ssen wir wieder auf unser ge�ndertes Basic
umschalten. Schreiben Sie nun einen Basic-Dreizeiler und versuchen
Sie, diesen zu LISTen. Ergebnis? Versuchen Sie es jetzt einmal mit
`LUST`. Ihrer weiteren Phantasie sind keine Grenzen mehr gesetzt...

## FIND

Wie oben angesprochen stellt SMON eine Reihe verschiedener
Suchroutinen zur Verf�gung, die im folgenden an vielen Beispielen
beschrieben werden. Alle diese Befehle bestehen aus zwei Zeichen und
beginnen mit dem Buchstaben `F`.

#### Syntax:

    F  (HEX-WERT(e), Anfadr Endadr)

sucht nach einzelnen HEX-Werten innerhalb eines bestimmten
Bereichs. Das zweite Zeichen (hinter F) ist hier ein Leerzeichen und
darf nicht weggelassen werden! Die Bereichsangabe kann wie bei allen
folgenden Befehlen entfallen, dann wird der gesamte Speicher
durchsucht.

#### Beispiel:

Wir suchen alle Befehle `LDY #01`, also die Werte `A0 01` im Bereich von $2000 bis $6000.

    F A0 01, 2000 6000

(die Leerzeichen zwischen den HexBytes d�rfen nicht weggelassen
werden!). Es erscheinen alle Speicherstellen, die die gesuchten Bytes
enthalten, also zum Beispiel `4000`.

#### Syntax:

    FA (Adresse, Anfadr Endadr)
    
sucht alle Befehle, die eine bestimmte Adresse als Operanden haben (absolut). Die Adresse braucht nicht vollst�ndig angegeben zu werden, es kann das Jokerzeichen `*` benutzt werden.

#### 1. Beispiel:

Wir suchen alle `JSR FFD2`-Befehle im Bereich $2000 bis $6000.

    FAFFD2,2000 6000

Es erscheinen alle Befehle disassembliert, die FFD2 im Operanden
enthalten (also auch `LDA FFD2` oder `STA FFD2,Y`, ...).

#### 2. Beispiel:

Wir suchen alle Befehle, die auf den I/0-Bereich ($D000 bis $DFFF)
zugreifen.

    FAD***,2000 6000

Der Joker kann aber auch zum Beispiel zur Suche im Bereich $D000 bis
$D0FF dienen:

    FAD0**,2000 6000

#### Syntax:

    FR (Adresse, Anfadr Endadr)

sucht nach relativen Sprungzielen. Anders als bei absoluten Spr�ngen
(JMP, JSR) benutzen die Branch-Befehle eine relative Adressierung,
also zum Beispiel "Verzweige 10 vor" oder "37 zur�ck". Solche Spr�nge
lassen sich mit dem `FA`-Kommando nicht finden. Hier wird `FR`
eingesetzt.

#### Beispiel:

Gesucht werden alle Branch-Befehle, die die Adresse $4002 anspringen.

    FR4002,2000 6000 .

Nat�rlich k�nnen solche Befehle nur h�chstens 128 Byte vom Sprungziel
entfernt sein. Die Bereichsangabe ist hier also viel zu gro� gew�hlt
(SMON st�rt dies allerdings nicht). Der Einsatz des Jokers ist hier
ebenfalls wie oben beschrieben m�glich.

#### Syntax:

    FT (Anfadr Endadr)

sucht Tabellen im angegebenen Bereich. SMON behandelt dabei alles, was
sich nicht disassemblieren l��t, als Tabelle.

#### Beispiel:

Wir suchen Tabellen oder Text im Bereich $2000 bis $6000.

    FT 2000 6000

#### Syntax:

    FZ (Adr, Anfadr Endadr)

sucht alle Befehle, die Zeropage-Adressen haben.

#### 1. Beispiel: 

    FZC5,2000 6000 

findet alle Befehle, die C5 adressieren, also zum Beispiel `BIT $C5`,
`LDA(C5),Y`, etc.

#### 2. Beispiel:

    FZF*,2000 6000
    
findet alle Befehle, die den Bereich zwischen $F0 und $FF adressieren.

#### 3. Beispiel:

    FZ**,2000 6000
    
findet s�mtliche Befehle mit Zeropage-Adressierung.

#### Syntax:

    FI (Operand, Anfadr Endadr)

sucht alle Befehle mit unmittelbarer Adressierung (immediate).

#### Beispiel:

Gesucht werden Befehle, die zum Beispiel das Y-Register mit 01 laden.

    FI01,2000 6000

findet `LDY #01` in Adresse $4000. 

Sie sehen, SMON bietet eine F�lle von verschiedensten FIND-Routinen,
mit denen alles gesucht und auch gefunden (!) werden kann.

## Vergleichen von Speicherstellen

#### Syntax:

    = Ad rl Adr2

#### Beispiel:

    = 4000 6000

vergleicht den Speicherinhalt ab $4000 mit dem ab $6000. Das erste
nicht �bereinstimmende Byte wird angezeigt und der Vergleich wird
abgebrochen.

Wenn Sie ein Maschinenprogramm geschrieben und �berarbeitet haben und
Sie wissen nicht mehr, worin eigentlich der Unterschied zwischen
der 76. und der 77. Version besteht, gehen Sie so vor:

1. Laden Sie zuerst Version 76 und verschieben Sie diese mit dem
`W`-Befehl in einen freien Speicherbereich.
2. Laden Sie dann Version 77 und f�hren Sie den `=`-Befehl durch.

Sofort finden Sie den Unterschied und k�nnen mit der Arbeit an Version
78 beginnen ...

## Trace: Schritt f�r Schritt

Wir wollen uns bei der Beschreibung der Trace-Befehle auf
Anwendungsbeispiele konzentrieren. Zum Aufbau der Routine sei nur so
viel gesagt: Gesteuert wird sie mit Hilfe des Prozessor-Interrupts,
weil nur damit ein Eingriff ins laufende Maschinenprogramm m�glich
ist. W�hrend des Trace-Ablaufs wird deswegen der Bildschirm
kurzfristig aus- und eingeschaltet, weil alle anderen
Interruptanforderungen, wie zum Beispiel durch den Video-Chip,
verhindert werden m�ssen. Da die Befehle eines Programms nicht nur
angezeigt, sondern auch wirklich ausgef�hrt werden, ist der
`SEI`-Befehl mit gro�er Vorsicht zu verwenden. Doch dazu sp�ter
mehr. Wir wollen ein neues, besser geeignetes Beispiel verwenden als
bisher. Tippen Sie also das folgende Miniprogramm mit dem Assembler
ein (`A 4000`):

     4000 LDA #30   lade den Akku mit (ASCII-) 0
     4002 JSR FFD2  gib Akku auf dem Bildschirm aus
     4005 CLC
     4006 ADC #01   erh�he Akku um 1
     4008 CMP #39   vergleiche Akku mit (ASCII-) 9
     400A BCC 4002  springe, wenn Akku kleiner, zur�ck
     400C BRK	    springe in SMON zur�ck

Starten Sie das Programm mit `G 4000`. Es mu� die Zahlen von 0 bis 8
auf den Bildschirm schreiben.

### Trace-Stop

    TS (Startadresse Stoppadresse)

Starten Sie nun unser Programm mit `TS 4000 4009`. Die ersten Befehle
werden ausgef�hrt (die Null ausgegeben, der Akku erh�ht etc.), dann
stoppt das Programm bei Adresse $4009 und springt in die
Registeranzeige.

Genau genommen ist `TS` gar kein Trace-Befehl, das Programm l�uft
n�mlich bis zur gew�hlten Stoppadresse in Echtzeit durch. Dort
angekommen, k�nnen Sie die Register pr�fen und gegebenenfalls durch
�berschreiben �ndern. Mit `G`, `TW` oder `TB` (wird sp�ter erkl�rt)
ohne weitere Adresseneingaben k�nnen Sie dann im Programmlauf
fortfahren. SMON merkt sich n�mlich, wo er stehengeblieben ist und
arbeitet ab dieser Adresse weiter, wenn Sie nicht eine neue angeben.

Sinnvoll ist dieser Befehl immer dann, wenn in einem l�ngeren Programm
nur bestimmte Teile "getraced" werden sollen, der Anfang aber
durchlaufen werden mu�, um Variable zu setzen oder Benutzereingaben zu
erfragen. Auch wenn man nicht ganz sicher ist, ob eine bestimmte
Passage �berhaupt jemals durchlaufen wird, kann man das mit `TS`
�berpr�fen.

Zwei Einschr�nkungen gibt es allerdings wegen der Arbeitsweise dieses
Befehls: SMON setzt im Programm an die Stoppadresse einen BRK-Befehl
und merkt sich, welcher Befehl dort stand, um ihn wieder
zur�ckzuschreiben. Deshalb funktioniert `TS` nur im RAM, nicht aber
zum Beispiel im Basic oder im Betriebssystem. Auch darf die
Speicherstelle, in der sich SMON den ausgetauschten Befehl merkt
($02BC) vom Programm nicht ver�ndert werden, sonst ist eine korrekte
Reparatur nicht mehr m�glich.

Der wohl am h�ufigsten und vielseitigsten eingesetzte Trace-Befehl ist
sicherlich `TW`.

### Trace Walk

    TW (Startadresse)

Starten Sie unser Beispiel jetzt mit `TW 4000`

Der erste Befehl (`LDA #30` in Adresse $4000) wird ausgef�hrt, SMON
stoppt und zeigt dann die Inhalte aller Register in der gleichen
Reihenfolge wie beim `R`-Kommando sowie den n�chsten Befehl an. Im
Akku steht jetzt 30, der Programmz�hler zeigt auf $4002. Jetzt dr�cken
Sie eine Taste. Der n�chste Befehl (`JSR FFD2`) wird ausgef�hrt, der
Programmz�hler zeigt auf $FFD2. Achten Sie auf den Stackpointer: Sein
Inhalt hat sich um 2 vermindert, weil der Prozessor auf dem Stack die
Adresse abgelegt hat, an die er nach Beendigung der Subroutine
zur�ckspringen soll. Der n�chste angezeigte Befehl ist ein indirekter
Sprung �ber $0326. Mit dem n�chsten Tastendruck wird er durchgef�hrt.

Und so geht es munter weiter. Verzweifeln Sie nicht, wenn Sie auch
nach den n�chsten zehn Tastendr�cken immer noch irgendwo im
Betriebssystem "herumtracen" und von unserem Beispielprogramm weit und
breit nichts mehr zu sehen ist. Ausnahmsweise ist unser Liebling
einmal nicht im "Land der Tr�ume" verschwunden, sondern tut, was er
soll: Er arbeitet brav einen Befehl nach dem anderen ab, der zur
Routine $FFD2 geh�rt, und das ist reichlich viel. Also bewegen Sie
Ihre Finger, Sie haben's ja nicht anders gewollt. Irgendwann einmal,
nach mehreren hundert gedr�ckten Tasten, befinden Sie sich pl�tzlich
wieder in der Registeranzeige von SMON. Das Programm ist beendet. Nun
werden Sie entt�uscht fragen, was man wohl mit einem Trace-Modus
anfangen soll, der schon bei kleinsten Beispielprogrammen ein v�llig
undurchschaubares Chaos erzeugt? Nur Geduld, die Rettung naht in
Gestalt der Taste *J*.

Falls Ihre Hand noch nicht in Gips liegt, starten Sie das Ganze noch
mal von vorn mit `TW 4000`. Diesmal dr�cken Sie aber jedesmal, wenn
als n�chster Befehl `JSR FFD2` angezeigt wird, auf *J*. Der Effekt
ist, da� die gesamte Subroutine auf einen Schlag abgearbeitet wird und
Sie sofort wieder auf dem n�chsten Befehl unseres Beispiels
landen. Da� wir nicht gemogelt und die Befehle von `JSR FFD2` einfach
unterschlagen haben, sehen Sie daran, da� der Akku tats�chlich auf dem
Bildschirm ausgegeben worden ist (rechts neben `FFD2`). Jetzt k�nnen
Sie unser Beispiel in aller Ruhe bis zum Ende durchgehen und
verfolgen, wie der Akku erh�ht wird, wie der Vergleich das
Statusregister beeinflu�t und wie entsprechend der R�cksprung in die
Schleife erfolgt.

Sie d�rfen die *J*-Taste auch dann benutzen, wenn Sie schon mitten in
der Subroutine sind. Aber hierbei ist �u�erste Vorsicht geboten: Die
R�cksprungadresse mu� unbedingt oben auf dem Stack liegen, wenn Sie
`J` dr�cken. Hat n�mlich der Prozessor Werte auf dem Stack abgelegt
(mit `PHA` oder `PHP`), dann erfolgt der Sprung irgendwo hin, nur
nicht zur�ck ins Programm. Achten Sie deshalb genau auf die Anzeige
des Stackpointers. Wenn dessen Wert genau so gro� ist wie bei Beginn
der Subroutine, kann nichts passieren. Sonst hilft nur noch der
ResetTaster, den Sie ja inzwischen hoffentlich eingebaut haben, oder
eine ruhige Hand, die die B�roklammer an Pin 1 und 3 des User-Ports
h�lt (Kostenpunkt der Reparatur bei Abrutschen liegt bei zirka 100
Mark ... ).

`TW` bricht automatisch mit der Registeranzeige ab, wenn im Programm
ein `BRK`-Befehl auftaucht. Wenn Ihnen das zu lange dauert oder Sie
zwischendurch ein Register �ndern m�chten, k�nnen Sie den Trace-Modus
jederzeit mit der Stopp-Taste verlassen. Anschlie�end k�nnen Sie wie
bei `TS` beschrieben fortfahren.

Im Gegensatz zu `TS` k�nnen Sie mit `TW` auch im ROM herumst�bern; Sie
haben es ja bei der Subroutine $FFD2 bereits getan. Einzige
Einschr�nkung beim `TW`-Befehl: Ihr Programm darf keinen `SEI`
enthalten, da dieser den Interrupt und damit auch den Trace-Modus
lahmlegt. Verlassen Sie in diesem Falle `TW` mit STOP und starten
erneut hinter dem `SEI`-Befehl. Allerdings m�ssen Sie in Kauf nehmen,
da� das Programm normalerweise nicht mehr korrekt arbeitet.

Das n�chste Programm soll als weiteres Beispiel f�r den `TW`-Modus
dienen. Geben Sie es folgenderma�en ein:

     5000 LDA #00   l�dt den Akku mit `0`
     5002 TAX       �bertr�gt den Akku ins X-Register
     5003 .0C       ein mysteri�ses Byte
     5004 LDA #04   l�dt den Akku mit `4`
     5006 TAY       �bertr�gt den Akku ins Y-Register
     5007 BRK       springt in SMON

Wenn wir dieses kleine Programm abarbeiten, m��te das X-Register auf
`0` stehen, w�hrend Akku und Y-Register mit `4` geladen sind. Starten
wir also das Programm mit `G 5000` und schauen uns die Register an.

Seltsamerweise enthalten alle Register eine `0`. Vorsichtig, wie wir
sind, �berschreiben wir die drei Register mit `FF`, um die Ver�nderung
deutlich kontrollieren zu k�nnen.

Dann starten wir mit `G 5000` ein zweites Mal. Gegen alle Gesetze der
Vernunft erscheint wieder das "falsche" Ergebnis - alle drei Register
sind `0`. Hier soll uns jetzt der TW-Modus weiterhelfen, indem er uns
zeigt, was in Wirklichkeit passiert.

Geben wir `TW 5000` ein. Der erste Befehl (`LDA #00`) ist
durchgef�hrt, im Akku erscheint die Null. Jetzt steht der
Programmz�hler auf dem folgenden Befehl `5002 TAX`. Nach Dr�cken einer
Taste wird dieser Befehl ausgef�hrt und es erscheint die Null im
X-Register. Beim folgenden Befehl m�ssen wir feststellen, da� der
Disassembler nicht in der Lage ist, ihn zu interpretieren - er gibt
drei Sternchen aus. Hierbei handelt es sich um unser Byte `0C`.
 
Wieder ein Tastendruck; und dann erkennen wir, da� etwas Merkw�rdiges
passiert ist. Der Prozessor hat augenscheinlich den n�chsten Befehl
(`LDA #04`) �bersprungen und steht schon auf dem folgenden `TAY`. So
also wird unser Programm abgearbeitet. Damit ist auch das "falsche"
Ergebnis erkl�rt. Bleibt nur noch die Frage nach dem Grund f�r dieses
seltsame Verhalten. Und der ist sicherlich in dem mysteri�sen Byte
`OC` zu suchen. Hierbei handelt es sich um ein en der "inoffiziellen"
Opcodes, die aufgrund der Prozessorarchitektur vorhanden sind und in
manchen Programmen ihr Unwesen treiben - wie wir zu unserem Leidwesen
erfahren mu�ten. Das Byte `0C` wirkt wie ein `NOP`, der eine L�nge von
3 Byte hat. Deshalb wird der folgende 2-Byte-Befehl (`LDA #04`)
verschluckt.

Es gibt noch einiges zu entdecken am 6502 und 6510 - `TW` macht's m�glich.

H�ufig ist es nicht sinnvoll, ein Programm von Anfang an im `TW`-Modus
laufenzulassen. Zum anderen sind gerade Schleifen, die per Hand mit
`TW` durchlaufen werden m�ssen, eine erm�dende Angelegenheit. Hier
bietet SMON neben dem bereits beschriebenen `TS` eine weitere
Trace-M�glichkeit an:

### Trace Break

    TB (Adresse Anzahl der Durchl�ufe) 

### Trace Quick

    TQ (Adresse)

Geben Sie als Beispiel folgendes Programm ein:

     6000 LDY #00     Y als Z�hler auf `0`
     6002 LDA 60OE,Y  Werte von $600E ff. sollen geladen werden
     6005 JSR FFD2    Ausgabe der Zeichen auf dem Bildschirm
     6008 INY         der Z�hler wird erh�ht
     6009 CPY #OE     Z�hler schon `14`?
     600B BCC 6000    wenn nein, dann n�chsten Wert holen
     601D BRK

Bei $600E soll nun ein Text stehen, den das Programm ausgibt. Die
einfachste Art, mit SMON Texte in den Speicher zu schreiben, besteht
im `K`-Befehl. Geben Sie

    K 600E

ein (danach nat�rlich Return) und dr�cken Sie die STOP-Taste. Fahren
Sie mit dem Cursor an das erste ausgegebene Zeichen (vermutlich ein
Punkt) und schreiben Sie - ohne Anf�hrungszeichen: `FEHLER BEHOBEN`

Dr�cken Sie dann Return, um die Zeile an den Rechner zu
�bergeben. Wenn Sie das Programm starten, werden Sie wieder einmal
Gelegenheit haben, sich in Ruhe etwas zu trinken zu holen (Prost!),
denn das Programm enth�lt einen dummen Fehler und besch�ftigt den
Computer f�r eine lange, lange Zeit. Genauer gesagt, bis Sie ihn mit
Reset (zum Beispiel durch RUN/STOP-RESTORE) erl�sen.

Nun soll SMON helfen, diesen Fehler zu lokalisieren. Setzen Sie zuerst
einmal einen Breakpoint bei $6002 und begrenzen die Durchl�ufe auf die
maximale Anzahl:

    TB 6002 0E

und starten mit

    TQ 6000

den Quicktrace bei $6000. Das Programm l�uft so lange, bis zum 14. Mal
die Adresse $6002 erreicht wird und springt dann in den TW-Modus. Wenn
Sie sich jetzt die Registerinhalte genau anschauen, m��te Ihnen der
Fehler geradezu ins Auge springen. Wie gro� sollte denn das Y-Register
sein? Welchen Wert sollte der Akku haben? NA?!

## Das "Ged�chtnis" von SMON

Wenn Sie Programme mit SMON untersuchen oder ver�ndern wollen, m�ssen
Sie noch wissen, welche Speicherstellen SMON verwendet. Es soll ja
Monitorprogramme geben, die die Basic-Zeiger als Arbeitsspeicher
benutzen, so da� ein Basic-Programm nach dem R�cksprung aus dem
Monitor gel�scht ist. SMON tut so etwas nicht. Aber nat�rlich braucht
er auch Speicherstellen, um sich Werte merken zu k�nnen. Damit Sie
Konflikten von Anfang an aus dem Wege gehen k�nnen, sind die
wichtigsten hier dargestellt.

In der Zeropage belegt SMON den Bereich von $00A4 bis $00B6. Dort
stehen Systemvariable f�r die Kassettenspeicherung und die
RS232-Schnittstelle. Diese werden nur w�hrend des Betriebs der
Kassette oder von RS232 gebraucht, sind ansonsten aber frei. Au�erdem
werden die Speicherstellen $00FB bis $00FF benutzt, die sowieso zur
freien Verf�gung des Anwenders vorgesehen sind. Alle anderen Zeiger in
der Zeropage, also insbesondere die Speicherverwaltung f�r Basic
bleiben unbeeinflu�t.

Als weiteren Arbeitsspeicher benutzt SMON den Bereich von $02A8 bis
$02C0. Auch dieser Bereich wird vom Betriebssystem nicht benutzt, so
da� keine Konflikte entstehen d�rften. Beim Assemblieren wird
zus�tzlich noch der Kassettenpuffer als Speicher f�r die Label
ben�tigt. Dieser bleibt ansonsten aber auch unver�ndert; das ist
wichtig, wenn Maschinenroutinen dort abgelegt werden sollen.  Alles in
allem ist SMON also recht vertr�glich.

## SMON verschieben? - Mit SMON!

Eine Reihe von Anfragen hat uns erreicht, ob man SMON nicht mit Hilfe
des `W`-, `V`- oder `C`-Kommandos verschieben k�nne. Alle Versuche in
dieser Richtung seien fehlgeschlagen. Einige Leser meinten auch, in
der V-Routine m�sse ein Fehler stecken. Diesmal sind wir jedoch v�llig
schuldlos; es gibt n�mlich einige Befehle in SMON, die keine
Sprungadressen sind und sich trotzdem auf den Bereich ($C000-)
beziehen, in dem SMON steht.

Dazu geh�ren in erster Linie die oben erw�hnten Einsprungadressen,
deren High-Byte nat�rlich ge�ndert werden mu�, wenn SMON in einem
anderen Speicherbereich laufen soll. Es gibt aber auch Befehle, die
eine Adresse im Programm in einem Vektor ablegen
m�ssen. Disassemblieren Sie einmal den Anfang von SMON mit `D C000
C0OB`. Sie erhalten

     LDA #14    Low-Byte der BREAK-Routine von SMON
     STA 0316   im Break-Vektor speichern
     LDA #C2    High-Byte (!) siehe oben
     STA 0317   siehe oben
     BRK

Damit wird der Break-Vektor des Betriebssystems auf den SMON gesetzt
und mit dem anschlie�enden - und jedem weiteren BRK-Befehl - springt
das Programm in SMONs BREAK-Routine. Wenn SMON in einem anderen
Bereich als $C000 laufen soll, dann m�ssen diese Befehle ge�ndert
werden.

Heraussuchen kann man sie mit `FIC*,C000 D000`. Sie wissen doch noch,
was diese Anweisung bedeutet: Suche mir alle Befehle, die ein Register
unmittelbar mit einem Wert laden, der mit $C beginnt. Aber Vorsicht!
Nicht alles, was da angezeigt wird, mu� auch ge�ndert werden! Um Ihnen
weitere Stunden sinnlosen Herumbr�tens zu ersparen, wollen wir als
Beispiel zeigen, wie man SMON in den Bereich $9000 bis $A000 verlegen
kann. Nat�rlich geht das im Prinzip f�r jeden anderen Bereich genauso;
wir selbst haben insgesamt f�nf SMON-Versionen f�r f�nf verschiedene
Speicherbereiche, von denen eine immer pa�t.

1. Wir verschieben zuerst das ganze Programm ohne Umrechnen in den
   neuen Bereich: `W C000 CFFA 9000`.
2. Nun lassen wir alle absoluten (3-Byte-)Befehle umrechnen. Die
   Tabellen am Anfang von SMON bleiben verschont: `V C000 CFFA 9000
   920B 9FD2`.
3. Als n�chstes �ndern wir die High-Bytes der Befehlsadresse. Geben
   Sie `M 902B 906B` ein und �ndern Sie in jedem zweiten Byte das `C`
   durch �berschreiben in `9`. Vergessen Sie nicht, am Ende jeder Zeile
   `RETURN` zu dr�cken, damit Ihre �nderung auch �bernommen wird.
4. Nun sind die Befehle mit Immediate-Adressierung an der Reihe. Sie
   m�ssen so ge�ndert werden, da� sie sich auf den neuen Bereich
   $9... beziehen. Suchen Sie sie mit `FIC*,9000 9FFA` heraus. Sie
   erhalten:

    9005 LDA #C2   �ndern
    9124 CPX #C0   nicht �ndern
    9386 LDY #C0   �ndern
    9441 CMP #C0   nicht �ndern
    987F LDX #C3   nicht �ndern
    988D LDX #Cl   nicht �ndern
    9992 LDA #Cl   nicht �ndern
    9C2C LDA #CC   �ndern
    9C5B LDA #C2   �ndern
    9CF4 LDA #CC   �ndern
    9DA1 LDX #CC   �ndern
    9E03 LDA #CC   �ndern
    9E6C CMP #C0   nicht �ndern
    9F71 LDY #CF   �ndern

Sie sehen, es gibt keine Regel, weiche Befehle zu �ndern sind und
welche nicht. Aus diesem Grunde m�ssen Sie diese �nderungen `von Hand`
vornehmen.

5. Die Adressen im Diskmonitor m�ssen ebenfalls umgestellt
werden. Dazu geben Sie bitte ein: `M 9FD8 9FE4` und �ndern Sie jedes
zweite Byte wie unter Punkt 3 beschrieben.

Vergessen Sie bitte auf keinen Fall, Ihre neue(n) Version(en) unter
neuem Namen zu speichern. Sie lassen sich dann mit `LOAD "Name",8,1`
von Diskette laden und mit dem entsprechenden `SYS` (zum Beispiel
36864 bei SMON $9000) starten. Denken Sie auch daran, nach dem Laden
und vor dem `SYS` ein `NEW` einzugeben, sonst beschwert sich der
B-Befehl mit einem `OUT OF MEMORY ERROR`.

Probieren Sie nun alle Befehle durch. Sie m�ssen genauso arbeiten wie
bisher. Vor allem k�nnen Sie jetzt auch Programme wie `DOS, 5.l` oder
`Turbo Tape` untersuchen, die im $C000-Bereich stehen. Achten Sie
aber, wenn Sie `SMON $9000` von Basic aus benutzen, darauf, da� das
Basic ihn nicht �berschreibt. String-Variable werden n�mlich von $A000
nach unten hin aufgebaut und bis $9E09 ist nicht viel Platz. Sch�tzen
Sie im Zweifelsfalle den Bereich, indem Sie nach dem Laden des SMON
$9000 eingeben: `NEW: POKE 56,144: POKE 55,0`

Damit ist SMON vor �berschreiben gesch�tzt. Das ist nat�rlich bei dem
SMON $C000 nicht n�tig, weil Basic in diesen Bereich nicht
hineinkommt.

## Die Befehle des Disk-Monitors

Da das Arbeiten mit dem Disk-Monitor besondere Aufmerksamkeit verlangt
(nach Murphys Gesetzen f�hren Fehleingaben in der Regel zu unlesbaren
Disketten), wird er mit einem eigenen Kommando eingeschaltet. Leider
waren alle halbwegs sinnvollen Buchstaben (`D` wie Diskette oder `F`
wie Floppy) schon vergeben, deshalb haben wir uns f�r ein schlichtes
`Z` wie Zuversicht entschieden.

### `Z` schaltet den Disk-Monitor ein.

Die Rahmenfarbe �ndert sich auf Gelb, der gewohnte `.` am Anfang einer
Zeile �ndert sich in `*`. Dies alles hat den Zweck, Ihnen deutlich zu
machen, da� es jetzt ernst wird. Intern wird jetzt das Basic
abgeschaltet, weil der Disk-Monitor einen 256 Byte gro�en Puffer
ben�tigt. Dieser liegt von $BF00 bis $C000 im RAM unter dem Basic,
weil er dort am wenigsten st�ren kann.

### READ: `R (Track Sektor)`

Liest einen Block von der Diskette in den Computer. Track und Sektor
m�ssen als Hexzahlen eingegeben werden. Die erste Zeile des Blocks
wird ausgegeben. Da wir dazu normale SMON-Routinen verwenden, steht
als Speicheradresse $BF00. Das `BF` k�nnen Sie vorerst ignorieren. Die
weitere Ausgabe des Hexdump erfolgt anders als gewohnt mit der Taste
`SHIFT`. `STOP` bricht die Ausgabe ab. Sie k�nnen die Hex-Bytes
�berschreiben und damit �ndern. Eine dauerhafte �nderung erfolgt aber
erst beim Zur�ckschreiben auf die Diskette (siehe Befehl `W`). Geben
Sie nur `R` ohne Track und Sektor ein, wird der logisch (!) n�chste
Block eingelesen.

### MEMORY-DUMP: `M`

Zeigt den gerade im Puffer befindlichen Block nochmals auf dem Bildschirm an.

Genau wie beim R-Befehl k�nnen Sie die Ausgabe mit `SHIFT` und `STOP`
steuern und �nderungen vornehmen.

### WRITE: `W (Track Sektor)`

Schreibt einen Block aus dem Puffer auf die Diskette zur�ck. �hnlich
wie bei `R` kann die Angabe von Track und Sektor entfallen. Es wird
dann der Track und Sektor des letzten R-Befehls benutzt. Das ist in
fast allen F�llen auch der richtige.

### ERROR: `@`

Liest den Fehlerkanal aus, gibt ihn aber nur aus, wenn wirklich ein
Fehler vorhanden war (`00,OK,00,00` wird unterdr�ckt).

### EXIT: `X`

Verl��t den Disk-Monitor und springt in den SMON zur�ck. Dabei wird
die Rahmenfarbe auf Blau zur�ckgeschaltet und es erscheint wieder der
`.` am Anfang der Zeile. Das Basic wird wieder eingeschaltet. Wollen
Sie nun mit SMON-Kommandos auf den Puffer zugreifen, m�ssen Sie Basic
wieder abschalten ($36 in Speicherstelle $0001).

Die folgenden Beispiele sollen Ihnen die Arbeit mit dem Disk-Monitor verdeutlichen.

**Achtung! Benutzen Sie unbedingt zum �ben eine Diskette, die Sie nicht mehr brauchen!**
 
Weder wir noch der Verlag haften daf�r, wenn Ihr Lieblingsprogramm
oder die m�hsam erstellte Adre�datei unwiederbringlich dahin sind. Da�
das sehr sehr schnell gehen kann, wissen wir aus eigener Erfahrung ...

Am besten machen Sie von einer Ihrer Diskette eine Kopie, die Sie zum
�ben benutzen k�nnen.

## Reparatur eines gel�schten Files

Sicher ist Ihnen das auch schon passiert: Sie wollen Ihr Programm mit
Namen `Schrott` l�schen, geben als Abk�rzung `S:S*` ein und merken in
dem Moment, in dem Sie `RETURN` dr�cken, da� auf der Diskette auch
alle Versionen von `SMON` waren, au�erdem auch noch "Superbase",
"Soccer" etc. Verzweifeln m�ssen Sie nur, wenn auch diese letzte
SMON-Version mit dem Disk-Monitor dabei war. Ansonsten behalten Sie
die Ruhe und verfahren Sie wie im folgenden beschrieben.

Laden Sie also jetzt SMON, legen Sie Ihre "�bungsdiskette" (!) ins
Laufwerk und l�schen Sie eins der ersten Programme mit dem �blichen
Scratch-Kommando. Nun starten Sie SMON und dr�cken `Z`. Der Bildschirm
�ndert seine Farbe wie beschrieben und am Anfang der Zeile erscheint
der `*`. Jetzt geben Sie ein:

    R 12 00

Auf dem Bildschirm erscheint die erste Zeile der BAM, die bei jeder
Diskette auf Track 18, Sektor 0 abgelegt ist. Die ersten beiden Byte
enthalten `12 01` und geben damit den logisch n�chsten Block an. In
diesem Falle w�re das der erste Block des Directory. Wenn Sie mit
`SHIFT` die Bildschirmausgabe fortsetzen, erkennen Sie etwa in der
Mitte den Diskettennamen. Lassen Sie die Ausgabe durchlaufen, bis
wieder der `*` erscheint. Nun geben Sie `R` ohne weitere Angaben
ein. Damit erhalten Sie den Koppel-Block, also Track 18, Sektor 1, den
ersten Directory-Block. (Nat�rlich h�tten Sie auch gleich `R 12 01`
eintippen k�nnen, aber wir wollen ja zeigen, wie die Befehle
funktionieren.)

In diesem Block stehen die ersten acht Programme Ihrer �bungsdiskette,
auch der Name des soeben gel�schten ist dabei.

## Dateien einfach manipulieren

Trotzdem ist dieses Programm tats�chlich gel�scht und erscheint nicht
mehr, wenn Sie sich das Directory anzeigen lassen. Vergleichen Sie den
Eintrag des gel�schten Programms mit den anderen, f�llt auf, da� 3
Byte vor Beginn des Namens bei allen anderen `82` steht (sofern es
sich um Programmfiles handelt), bei dem gel�schten aber `00`. Die
Reparatur ist nun denkbar einfach: Sie brauchen lediglich die `00` mit
`82` zu �berschreiben. Einen Haken hat die Sache allerdings noch. Beim
SCRATCHEN sind die vom Programm belegten Bl�cke in der BAM als frei
gekennzeichnet worden und jeder neue Eintrag w�rde das als gel�scht
gekennzeichnete File endg�ltig �berschreiben. Um das zu verhindern,
m�ssen Sie nach erfolgter Reparatur die Diskette validieren (von Basic
aus mit Kommando: `OPEN 1, 8,15, "V"`). Dabei wird,die BAM neu erzeugt
und korrigiert.

### Sch�tzen eines Files

Da wir gerade dabei sind, wollen wir unser repariertes gel�schtes File
gleich ein f�r allemal gegen L�schen sch�tzen. Diese M�glichkeit des
Diskettenoperationssystems (DOS) ist zwar nicht im Handbuch
beschrieben, funktioniert aber trotzdem ausgezeichnet. Laden Sie dazu
nochmals die erste Seite des Directory mit

    R 12 01

und �ndern Sie die `82` vor dem Fileeintrag in `C2`. Geben Sie `W`
ein, um die �nderung auf Diskette zu schreiben. Verlassen Sie nun SMON
mit `X` und lassen Sie sich ein Directory anzeigen. Das gesch�tzte
File ist mit einem `>` gekennzeichnet. Versuchen Sie nun, dieses
Programm mit dem Scratch-Kommando zu l�schen. Es geht nicht! Zum
"Entriegeln" brauchen Sie nur das `C2` wieder in `82` zu �ndern. Der
`>` im Directory verschwindet und das File ist nicht mehr gesch�tzt.

### Sch�tzen einer Diskette

Wollen Sie eine ganze Diskette vor versehentlichem L�schen oder
Formatieren sch�tzen, gibt es die M�glichkeit, die L�schschutzkerbe
abzukleben. Es geht jedoch auch anders.

**ACHTUNG! Die im folgenden beschriebene Prozedur l��t sich nicht ohne
weiteres r�ckg�ngig machen, auch nicht mit dem Disk-Monitor!**

Nehmen Sie also eine Diskette, die Sie anschlie�end "hart formatieren"
k�nnen (also mit Eingabe einer ID). Starten Sie nun den Disk-Monitor
und lesen Sie die BAM mit `R 12 00` ein. Das dritte Byte enth�lt
`41`. Diese `41` ist ein Kennzeichen f�r das DOS der 1541- oder
4040-Floppy. Andern Sie diese Byte durch �berschreiben in `45` und
speichern Sie die �nderung mit `W` auf die Diskette zur�ck. Verlassen
Sie nun SMON und versuchen Sie, etwas zu i�schen. Ergebnis siehe
oben. Versuchen Sie auch, die Diskette "weich", also zum Beispiel mit
`OPEN 1,8,15,"N:TEST"` zu formatieren.
 
Auch das ist jetzt nicht mehr m�glich. Aber es kommt noch besser:
Starten Sie noch einmal den Disk-Monitor und versuchen Sie, die
�nderung durch Zur�ckschreiben der `41` an Stelle der `45` r�ckg�ngig
zu machen. Auch das ist nicht mehr m�glich, wir hatten Sie bereits
gewarnt! Es bleibt lediglich die M�glichkeit, die Diskette "hart", zum
Beispiel mit `OPEN 1,8,15,"N:TEST,TE"` zu formatieren. Sollten Sie nun
entgegen allen Warnungen doch Ihre Master-Diskette gegen
Schreibzugriffe gesichert haben, verraten wir Ihnen ausnahmsweise, wie
Sie den Eingriff trotzdem r�ckg�ngig machen k�nnen. Dazu �berlisten
wir das DOS des 1541-La�fwerkes, indem wir ihm vorgaukeln, es h�tte
eine Diskette im Normalformat vor sich. Wir verwenden den
Memory-Write-Befehl, mit dem wir in die Speicherstelle 0101 (Zero-Page
Adresse) des 1541-RAM einfach ein `A` schreiben. Der CHR$-Code des `A`
ist 65, oder in hexadezimaler Schreibweise 41. Erinnern Sie sich?
Dieser Wert stand urspr�nglich im dritten Byte des Tracks 18,
Sektor 0. Mit folgendem kleinen Programm umgehen wir einfach die
DOS-Kennzeichnung und wir k�nnen die Diskette wieder normal
beschreiben. Am sinnvollsten ist es, sofort den SMON zu starten, das
vorher in 45 abge�nderte Byte wieder in 41 zu verwandeln und
abzuspeichern. Die Diskette kann dann wieder zum Lesen und Schreiben
verwendet werden.

Hier nun das kleine Programm:

    10 OPEN 1,8,15
    20 PRINT#1, "M-W"CHR$(1)CHR$(1)CHR$(1)CHR$(65) 
    30 CLOSE1

### �ndern des Diskettennamens oder der ID

Wir haben bereits oben gesehen, da� in Spur 18, Sektor 0 einer
Diskette etwa in der Mitte der Diskettenname gespeichert wird. Dieser
Name kann durch einfaches �berschreiben ge�ndert werden; er darf
bekanntlich bis zu 16 Zeichen enthalten. Hat Ihr neuer Name weniger
Buchstaben als der alte, m�ssen Sie die L�cken mit `A0` und nicht mit
`20` als Leerzeichen ausf�llen. Dies gilt vor allem, wenn Sie mit
dieser Methode Filenamen �ndern wollen. Das geht nat�rlich im Prinzip
genauso wie eben beschrieben. Hinter dem Diskettennamen ist in Spur
18, Sektor 0 die ID abgelegt. Sie wird beim Formatieren vor jeden
Sektor in einen sogenannten Header geschrieben und dient dem DOS zur
Identifikation der Diskette. Zus�tzlich wird sie noch in der BAM
gespeichert, damit sie beim Laden eines Directory mit angezeigt werden
kann. Nun ist es grunds�tzlich nicht m�glich, die ID im Header eines
Sektors ohne Formatieren zu �ndern, wohl aber die Eintragung in der
BAM und damit die ID, die im Directory angezeigt wird. Genau wie beim
Namen ist dies durch einfaches �berschreiben in der BAM m�glich.

### �ndern eines Filetyps

Wenn Sie einmal versucht haben, ein sequentielles File, etwa eine
Datei, mit LOAD zu laden, werden Sie gemerkt haben, da� dies nicht
m�glich ist. Das DOS behauptet einfach, ein solches File existiere
nicht und der Computer meldet `FILE NOT FOUND`. Viele Spiele zum
Beispiel legen die "Hall of Fame" oder Highscore-Liste als
sequentielle Datei ab. Mit dem Disk-Monitor ist es nun aber m�glich,
den Filetyp im Directory zu ver�ndern. Erinnern Sie sich an die `82`,
die im Directory vor jedem Filenamen steht. Bei sequentiellen Files
steht dort `81`. Was zu tun ist, werden Sie sich denken k�nnen. Na
klar, die `81` wird in `82` ge�ndert, und schon ist die Datei ohne
weiteres ladbar, nat�rlich wieder erst nach dem Zur�ckschreiben mit
`W`.

Sinnvoll ist dies nat�rlich nur von SMON aus (mit Eingabe einer
Ladeadresse). Mit `M` oder `K` k�nnen Sie dann die Datei ansehen und
nat�rlich auch �ndern. Vergessen Sie nicht, die ge�nderte Datei nach
dem Zur�ckschreiben wieder in ein sequentielles File zu
verwandeln. Verbl�ffen Sie Ihre Freunde doch mal mit einem auf diese
Weise "errungenen" High-Score. Die Anerkennung Ihrer Umwelt ist Ihnen
sicher!

### �ndern der Startadresse eines Programms

Wir haben uns bisher auf Manipulationen in der BAM oder im Directory
beschr�nkt. Wollen wir in einem Programm selbst �nderungen vornehmen,
m�ssen wir etwas tiefer in die "Geheimnisse der Floppy" eindringen. So
ist es bisweilen interessant, die Startadresse eines
Maschinenprogramms zu kennen oder zu �ndern. Dazu gehen wir
folgenderma�en vor: Zun�chst suchen wir mit `R 12 01` und eventuell
weiteren Folgesektoren (12 04,12 07 .. ) den Fileeintrag im
Directory. Die beiden Byte hinter der `82` direkt vor dem
Programmnamen geben an, auf welcher Spur und in welchem Sektor das
Programm startet. Wenn dort zum Beispiel `0A 04` steht, beginnt das
Programm auf Spur 10, Sektor 4. Lesen Sie nun diesen Block mit `R 0A
04` ein. Die ersten beiden Bytes dieses Blocks zeigen auf den n�chsten
Block des Programms, die beiden n�chsten Bytes enthalten die
Startadresse in der �blichen Low-High-Byte-Reihenfolge. Zum �ndern der
Startadresse �berschreiben Sie die Bytes mit der neuen und speichern
den Block mit `W` auf die Diskette zur�ck.

## Die Zusammenarbeit mit SMON

Mit all diesen Beispielen sind die M�glichkeiten des Disk-Monitors
noch lange nicht ersch�pft. Sie sollten Ihnen als Anregung f�r eigene
Experimente dienen. �ben Sie aber unbedingt so lange, bis Sie alle
Kommandos aus dem `FF` (oder dezimal 255) beherrschen. Sie ersparen
sich damit unn�tigen �rger und durchweinte N�chte. Besonders
interessant ist es, von SMON aus auf den Puffer zuzugreifen und die
SMON-Befehle auf den Puffer anzuwenden. Erw�hnen m�chte ich nur die
M�glichkeit, Programme f�r das DOS direkt zu assemblieren und in einem
bestimmten Sektor ablegen zu k�nnen, die `Find`-Routinen oder das
`K`-Kommando f�r Text�nderungen. Da der Puffer im RAM unter dem Basic
liegt, mu� Basic in solchen F�llen abgeschaltet werden. �ndern Sie
dazu mit dem `M`-Befehl in Speicherstelle 0001 die `37` in `36`.

Haben Sie die Arbeit mit SMON beendet, k�nnen Sie mit `Z` in den
Disk-Monitor schalten und den Pufferbereich mit `W` (Spur, Sektor)
abspeichern.

### Die Ausgabe von Diskettenfehlern

Beim Arbeiten mit dem Disk-Monitor werden s�mtliche Fehler vom
Laufwerk direkt, auch ohne Eingabe von `@`, ausgegeben, zum Beispiel
`ILLEGAL TRACK OR SECTOR`, wenn Sie mit `R` einen Block lesen wollen,
den es gar nicht gibt. Einen Fehler hat das Programm allerdings, den
wir nicht verschweigen wollen. Der letzte Block eines Files enth�lt
als Koppeladresse `00 FF`. Da es einen solchen Block nicht geben kann,
"wei�" das DOS, da� es am Ende angelangt ist. Versuchen Sie aber, den
n�chsten Block (Spur 0, Sektor 255!!) mit `R` zu lesen, erscheint als
Fehlermeldung nicht, wie es sein m��te, `ILLEGAL BLOCK OR SECTOR`,
sondern `SYNTAX ERROR`. Das ist zwar eigentlich unerheblich, sollte
aber erw�hnt werden. Der Fehler liegt in der Routine, die unsere
Zahleneingaben in das richtige Diskettenformat wandelt. Es fehlte
einfach der Platz im Programm f�r eine "korrekte" Umwandlung, wir
mu�ten uns mit einer "Sparroutine" behelfen.

Abschlie�end noch ein SMON-Trick, den wir einem aufmerksamen Leser
verdanken. F�r eine Directory-Ausgabe fehlte der Platz im SMON. Es
geht aber hilfsweise so: Laden Sie das Directory zum Beispiel mit

    L "$" 8000

an einen freien Speicherplatz. Mit `M` oder `K` k�nnen Sie jetzt das
Directory `lesen`. Damit sind alle wichtigen Funktionen f�r den Umgang
mit der Diskette im SMON enthalten.

Zwei Erweiterungen haben wir Ihnen zu Beginn angek�ndigt, die SMON
noch leistungsf�higer machen sollen.

## SMON l�ftet Geheimnisse

Dabei handelt es sich einmal um eine Erweiterung des Disassembiers,
mit dem nun auch die "illegalen" Opcodes des 6502 disassembliert
werden, zum anderen um neue Funktionen beim Diskmonitor, mit denen Sie
in den Innereien Ihrer Floppy herumst�bern k�nnen. Nun ist der
Speicherplatz bis auf 5 Byte ausgesch�pft, und die 4-KByte-Grenze soll
auf keinen Fall �berschritten werden. Wir haben daher andere
Funktionen herausgenommen, und zwar f�r die Disassembler-Erweiterung
den Diskmonitor und f�r die Diskmonitor-Erweiterung den Trace-Modus.

Beide Erweiterungen sind also nicht gleichzeitig einsetzbar; �berhaupt
ist es sinnvoll, eigene Versionen f�r spezielle Anwendungen
zusammenzustellen, eine "normale", eine Spezial-Disk-Version und eine
f�r versch�rftes Disassemblieren.
 
Beginnen wir mit dem letzten: Wie Sie wissen, erscheinen beim
Disassemblieren immer drei Sternchen, wenn SMON auf ein Byte trifft,
das keinen g�ltigen 6510-Opcode darstellt. Nun wissen Sie aber
vielleicht auch, da� es �ber den offiziellen Befehlssatz hinaus noch
einige Befehle gibt, die der Hersteller des Prozessors zwar nicht
dokumentiert hat, die aber nichtsdestotrotz funktionieren und in
einigen Programmen auch ausgenutzt werden. Es w�re nat�rlich sch�n,
wenn SMON auch diese "illegalen" Opcodes anzeigen k�nnte. Unsere
Erweiterung macht's m�glich.

Wir haben Mnemonics f�r eine Reihe dieser Befehle eingesetzt und
lassen diese von SMON mit einem vorangestellten `.` ausgeben. �brig
bleiben noch zehn Befehle, deren Wirkung aber so komplex ist, da� sie
sich beim besten Willen nicht mit einem Mnemonic abk�rzen lassen. Sie
fallen auch aus der Logik der Prozessorstruktur heraus. Im einzelnen
handelt es sich um die Opcodes 0B, 2B, 4B, EB, 8B, 9C, 9E, AB, CB und
EB. Bei diesen Befehlen haben wir keine gemeinsame Struktur entdecken
k�nnen. Die neuen Mnemonics haben folgende Bedeutung:

- `LAX`: Load Akku and X<br>
  Entspricht `LDA` und `LDX`.
- `DCP`: Decrement and ComPare<br>
  Entspricht `DEC` und `CMP`.
- `ISC`: Increment and Subtract<br>
  Entspricht `INC` und `SBC`.
- `RLA`: Rotate Left AND Akku<br>
  Entspricht `ROL` und `AND`.
- `RRA`: Rotate Right and Add with carry<br>
  Entspricht `ROR` und `ADC`.
- `SLO`: Shift Left OR Akku<br>
  Entspricht `ASL` und `ORA`.
- `SRE`: Shift Right and EOR Akku<br>
  Entspricht `LSR` und `EOR`.
- `SAX`: Store Akku AND X<br>
  F�hrt eine UND-Verkn�pfung zwischen Akku und X-Register durch und
  speichert das Ergebnis in der angegebenen Adresse ab.
- `CRA`: CRAsh<br>
  F�hrt zum "Absturz" des Prozessors.
- `NOP`: NO Operation<br>
  Entspricht dem bekannten `NOP`, jedoch kann dieser Befehl auch 2 oder
  3 Byte lang sein. Dies wird durch die angegebene Adresse deutlich, die
  in diesem Fall nat�rlich keinerlei Bedeutung hat.

�ber den Sinn dieser Befehle l��t sich sicher streiten; allerdings
kommen sie bisweilen in Programmen vor, meist um das Lesen dieser
Programme unm�glich zu machen, also als Programmschutz. Von der
Verwendung dieser Befehle in eigenen Programmen raten wir auf jeden
Fall ab. Erstens wird kein Hersteller garantieren, da� die "illegalen"
tats�chlich mit jedem 6510-Prozessor funktionieren, zweitens gibt es
keine Funktion, die nicht auch mit den "normalen" Befehlen ebensogut
erreicht werden k�nnte. Und als Programmschutz taugen die "illegalen"
sp�testens mit der Ver�ffentlichung dieses Artikels ja auch nichts
mehr. Aus diesem Grund haben wir bewu�t auf eine Erweiterung des
Assemblers in dieser Richtung verzichtet. Sie k�nnen also keine
normalen Opcodes durch �berschreiben in "illegale" �ndern, wohl aber
umgekehrt. Es bleibt lediglich die Eingabe als Einzelbyte, was aber
hoffentlich zu umst�ndlich ist.

## Komfortabler Disketten-Monitor f�r SMON

Jetzt folgt unser zweiter Leckerbissen in Form eines kleinen aber
ungemein wertvollen Zusatzprogrammes f�r den SMON. Es handelt sich
dabei um eine Erweiterung des Disketten-Monitors, mit dem jeder auf
einen Schlag die Arbeit von Stunden zunichte machen kann. Geben Sie
das Programm wie beschrieben ein, starten Sie SMON wie gewohnt und
springen mit `Z` in den Disketten-Monitor. Von hier aus erreichen Sie
mit `F` (wie Floppy) die neuen Befehle. Wir haben absichtlich diesen
umst�ndlichen Weg gew�hlt, denn Fehler in diesem Modus wirken noch
dramatischer als sonst. Mit diesem Werkzeug haben Sie unmittelbaren
Zugriff auf die Eingeweide der Floppy. Jetzt k�nnen Sie die folgenden
Befehle mit einer �bungsdiskette (!!!) in aller Ruhe durcharbeiten.

### `M`: Memory-Dump des Disketten-Monitors

Beispiel: `M` (ohne weitere Eingabe) listet den Bereich des Floppy-RAM
von $0000-$00FF. (Es erscheint zun�chst die erste Zeile, weitere
Ausgabe mit der SPACE-Taste.)

In diesem Bereich befinden sich unter anderem die Jobspeicher
($00-$04) f�r die f�nf Puffer 0 bis 4 sowie die wichtigsten Variablen
des DOS.

### `M07`: Memory-Dump ab $0700

Die BAM der Diskette wird nach dem Initialisieren in Puffer 4 ($0700
im Floppy-RAM) eingelesen. Schauen Sie sich also mit `M 07` die
aktuelle BAM an. Sie k�nnten jetzt durch einfaches �berschreiben den
Inhalt der BAM �ndern. (Der Doppelpunkt vor der Zeile wirkt als
"hidden command"). Dann schauen Sie sich Ihre �nderung mit `M 07`
wieder an. Sie sehen, da� inzwischen der Inhalt des Floppy-RAM
ge�ndert wurde. Wenn Sie nun den Jobcode `90` (= Schreibbefehl an den
Floppy-Controller) in Speicherstelle $04 bringen, w�rde die ge�nderte
(falsche!) BAM auf Diskette zur�ckgeschrieben werden!! Es gibt also
genug M�glichkeiten, wie oben angedeutet, die Disketten zu "versauen".
 
F�r das Ausprobieren noch einige wichtige Speicherstellen und
Jobcodes:

     $80   Lesen
     $90   Schreiben
     $C0   `Anschlagen` des Kopfes
     $D0   Maschinenprogramme im Puffer aus f�hren
     $E0   Programm im Puffer ausf�hren mit Hochfahren des Laufwerks

Speicherstellen im Floppy-RAM:
 
     $06/$07   ist Spur- und Sektornummer f�r den Befehl in Puffer 0
     $08/$09   f�r Puffer 1
     $0A/$0B   f�r Puffer 2
     $0C/$0D   f�r Puffer 3
     $0E/$0F   f�r Puffer 4

Jedem Puffer sind zwei Speicherstellen zugeordnet, eine f�r den
Jobcode ($0000 bis $0004) und eine f�r Spur und Sektor. Wenn Sie also
in Puffer 0 (in $0300 gelegen) einen bestimmten Block einlesen wollen,
geben Sie folgende Befehle ein:

`M` liest die Zeropage der Floppy ein - so sehen dann zum Beispiel die
ersten Zeilen aus:

     :0000 01 01 01 FF 03 04 01 34 
     :0008 23 02 04 50 01 03 0A 11

Gehen Sie mit dem Cursor in die erste Zeile und schreiben Sie `80` in
die erste Speicherstelle (anstelle der ersten 01). In Speicherstelle
$06/$07 (die letzten beiden in der ersten Reihe) die Spur- und die
Sektornummer, die gelesen werden soll, zum Beispiel 12 01. Sie sehen
dann

     :0000 80 01 01 FF 03 04 12 01
     :0008 unver�ndert
     
Dr�cken Sie die RETURN-Taste, Mit `M03` kann jetzt der eingelesene
Blgck (hier der erste Directory-Block) eingesehen werden. �nderungen
k�nnen durch einfaches �berschreiben vorgenommen werden. Dauerhaft
wird Ihre �nderung erst durch Zur�ckschreiben (nach Spur $12 und
Sektor $01) mit dem Jobcode `90` in der ersten Speicherstelle. Nach
�nderung der beiden f�r Puffer 0 zust�ndigen Adressen ($06/$07) auch
an jede beliebige andere Stelle. Das ist w�rtlich zu nehmen, denn wir
befinden uns hier `unterhalb` der Controllerebene, die unter anderem
f�r die Pr�fung auf Einhaltung der zul�ssigen Spur und Sektorgrenzen
verantwortlich ist. Es erfolgt also keine Fehlermeldung, wenn Sie
versuchen sollten, mit Ihrer Floppy bis in die des Nachbarn zu
schreiben (zum Beispiel mit der Spur 152).

Entsprechende Lese- und Schreib�bungen k�nnen mit den anderen Puffern
durchgef�hrt werden. Denken Sie daran, erst ist die Spur-
beziehungsweise Sektornummer f�r den entsprechenden Puffer (in der
zweiten Zeile!) einzugeben, bevor Sie in Zeile 1 den Jobcode mit einem
RETURN �bergeben, denn mit Druck auf die RETURN-Taste wird Ihr Befehl
ausgef�hrt. Und noch eins: Qu�len Sie bitte dabei Ihren Schreibkopf
nicht mehr als unbedingt erforderlich, sonst k�nnte er sich mechanisch
verklemmen und nur noch mit einem Eingriff in die Floppymechanik
wieder "befreit" werden.

Falls Sie die Ausgaben 1/85 (Seite 151) und 3/85 (Seite 103 bis 135)
der 64'er besitzen, k�nnen Sie sich dort �ber andere Speicherstellen
der Floppy und die weitere Anwendung der Jobcodes informieren.

Der Befehl @ ohne weitere Angaben fragt den Fehlerkanal ab, ansonsten
dient er zur Befehls�bermittlung an die Floppy.

Beispiel:

- `@`: Fehlerkanal
- `@I`: Initialisierungsbefehl
- `@S:name`: Befehl zum Scratchen

und so weiter.

Bedingt durch die verschiedenen Versionen, springt dieser Befehl
manchmal in den "normalen" Disketten-Monitor zur�ck, erkennbar an dem
`*` am Zeilenanfang. Sie m�ssen dann wieder ein `F` eingeben.

Mit `X` gelangt man wieder in den Disketten-Monitor.

Zum Abschlu� ein sehr hilfreicher Befehl namens `V`, der es erlaubt,
Speicherbereiche aus dem Computer in den Laufwerkspuffer zu
verschieben. Folgende einfache Syntax gilt dabei: V von nach.

Um zum Beispiel ein Maschinenprogramm von $6000 in den Puffer 1 zu
bekommen, geben Sie folgendes ein:

    V 6000 0400
    
Dabei wird immer eine ganze Seite, also 256 Byte, �bertragen. Was das
Programm dort soll, fragen Sie? F�hren Sie es doch einfach aus
(Jobcode $D0 in Speicherstelle $01 schreiben); oder schreiben Sie es
mit dem Jobcode `90` in einen beliebigen Sektor der Diskette.

Wenn Sie dann Ihre Floppy so richtig durcheinandergebracht haben und
nichts l�uft mehr, brauchen Sie nicht zu verzweifeln. Au�er einem
eventuell festh�ngenden Lesekopf passiert der Floppy nichts, nur Ihren
Disketten.

## Hinweise zum Abtippen

Tippen Sie die beiden Erweiterungsprogramme (Listing 2 und 3 mit dem
MSE-Programm ab und speichern Sie die fertigen Programme.

Laden und starten Sie dann Ihren SMON $C000. Geben Sie ein:
`L"NDISASS"`

Damit werden die neuen Befehle automatisch �ber den bisherigen
Disketten-Monitor geladen. Sie m�ssen nun aber noch aktiviert
werden. Geben Sie dazu `G CF0D` ein.

SMON meldet sich sofort mit seiner Registeranzeige wieder. Sie sollten
nun diese Version unbedingt speichern, zum Beispiel mit `S"SMON
NDISASS" C000 CF3D`

Wenn Sie nun das Programm `ILLEGAL-CODE` (Listing 4) laden und mit D
4000 disassemblieren, sehen Sie die "illegalen" Opcodes sch�n geordnet
nacheinander.

Um die neuen Befehle des Disketten-Monitors in SMON einzubinden, gehen
Sie ganz �hnlich vor. Nach dem Abtippen und Speichern des Programms
`FLOPPYMON` mu� nat�rlich SMON C000 geladen und gestartet
werden. Anschlie�end geben Sie ein: L "FLOPPYMON" und aktivieren es
mit `G CDD8`.

Zum Speichern geben Sie `S"SMON-FLOPPY" C000 CFFF` ein.

## SMON erweitern

Die zum Schlu� vorgestellte Erweiterung stellt elf weitere Befehle f�r
den SMON zur Verf�gung. So l��t sich der Monitor zum Beispiel frei im
Speicher verschieben und Sprites oder Zeichens�tze k�nnen sehr einfach
erstellt und ge�ndert werden.

Um die Befehlserweiterung zu initialisieren, geht man folgenderma�en vor:

1. SMON absolut laden und `NEW` eingeben.
2. Den Basic-Lader (Listing 5) eintippen und speichern.
3. Nach dem Start des Laders die Startadresse (dezimal) Ihrer SMON-Version eingeben: zum Beispiel 49152 (= $C000). 
4. Den erweiterten SMON zum Beispiel mit `S "SMONEX" Startadresse
   Endadresse` speichern.Die neuen Routinen werden, genau wie die
   meisten bereits vorhandenen, durch einen Buchstaben, zum Teil
   gefolgt von Adressenangaben, aufgerufen. Bei den ersten drei
   Ausgabebefehlen kann der Speicherinhalt durch �berschreiben der
   Zeile ge�ndert werden.

### `Z 4000 (4100) (Zeichendaten)`

gibt den Speicherinhalt von $4000 (bis $40FF) folgenderma�en aus:
Jeweils ein Byte pro Zeile wird in 8-Bit-Form dargestellt. Dabei ist
ein `*` ein gesetztes, ein `.` dagegen ein nicht gesetztes Bit. Die
beiden Zeichen sind willk�rlich gew�hlt und k�nnen durch �berschreiben
der Speicherzellen $xE65, $xE2D (Bit 1) und $xE69, $xE30 (Bit = 0) in
den Bildschirm-Code (!) der gew�nschten Zeichen ge�ndert werden.

Die Anwendung dieses Befehls liegt beispielsweise in der gezielten und
anschaulichen Beeinflussung bestimmter Steuerbits in VIC, CIA
etc. Andererseits lassen sich - besonders in Verbindung mit dem
Kommando `Q` - Zeichendaten leicht modifizieren.

### `H 4000` (4100)

entspricht dem Befehl `Z` mit dem Unterschied, da� jeweils drei Byte
pro Zeile ausgegeben werden. Das entspricht dem Format f�r
Spritedaten. Auf diese Weise steht mit dem erweiterten SMON ein
kleiner "Sprite-Editor" zur Verf�gung.

### `N 4000` (4100) (Normaldarstellung)

interpretiert den Speicherinhalt von $4000 (bis $40FF) als
Bildschirm-Code und gibt 32 Zeichen pro Zeile aus.

### `U 4000` (4100) (�bersicht)

Wie `N`, jedoch werden in einer Zeile 40 Zeichen
dargestellt. �nderungen sind nur mit `N` m�glich. Dieser Befehl dient
haupts�chlich dazu, im Speicher abgelegte Bildschirminformationen so
auszugeben, wie sie tats�chlich im 40-Zeichen/Zeile-Format aussehen
w�rden. Dieser Befehl ist recht n�tzlich, um professionelle
Videospiele zu analysieren, da hier Spielszenen oft im Bildschirm-Code
gespeichert sind.

### `E 4000` (4100) (Erase)

ist der bereits im 64'er, Ausgabe 2/85 vorgeschlagene Erase-Befehl zum
F�llen des Speicherbereiches von $4000 bis $40FF mit $00.

### `Y 40`

kopiert die vorhandene SMON-Version in nur drei Sekunden nach $4000
bis $4FFF und nimmt dabei alle notwendigen Anpassungen vor. Die
urspr�ngliche Speicherversion des Monitors bleibt unver�ndert. Mit `G
4000` kann man in den neuen SMON springen. Von dem Byte-Wert, der
�bergeben werden mu�, wird nur das obere Nibble ($4) gewertet, so da�
sich theoretisch 16 SMON-Versionen im Speicher unterbringen lassen,
wobei nat�rlich nicht alle M�glichkeiten sinnvoll sind. Auf diese
Weise l��t sich stets die erforderliche Speicherversion herstellen,
ohne da� langwierige �nderungen notwendig sind.

### `Q 2000`

kopiert den Zeichensatz aus dem ROM von $D000 bis $DFFF in das RAM
nach $2000. Dort kann er mit dem Befehl `Z` nach Belieben ge�ndert
werden. M�chte man zum Beispiel das Zeichen `A` in ein `�`
umdefinieren, so ist der Zeichensatz mit `Q 2000` ins RAM zu
kopieren. Anschlie�end kann mit `Z 2000 2015` der Bereich in bin�rer
Form auf dem Bildschirm ausgegeben werden, in dem auch das Zeichen `A`
steht. Dieses kann nun in ein `�` ge�ndert werden, indem man mit dem
Cursor an die zu �ndernde Stelle f�hrt und f�r einen Punkt, der
gesetzt werden soll, ein `*` und f�r einen Punkt der nicht gesetzt
werden soll ein `.` setzt. So, jetzt ist der Zeichensatz umdefiniert,
aber noch nicht aktiviert. Als n�chstes mu� dem Videocontroller die
Startadresse des neuen Zeichensatzes mitgeteilt werden. Dazu ist die
Adresse $D018, in der eine hexadezimale 15 steht, durch eine
hexadezimale 18 zu ersetzen.

### `J` (Wiederholung)

bringt den letzten Ausgabebefehl (K, D, M, Z, H, N, U) auf den
Bildschirm zur�ck. Mit RETURN wird der letzte Befehl noch einmal
ausgef�hrt.

#### Zum Schlu� noch ein Tip:

DATA-Zeilen in Hex-Byte-Darstellung sind wegen ihrer konstanten L�nge
(immer zwei Ziffern pro Wert!) �bersichtlicher als solche mit
dezimalen Zahlen. Da f�r die Ausgabe von Hex-Werten bereits alle
Routinen im SMON integriert sind, kann der `B`-Befehl
(Basic-DATA-Zeilen erzeugen) durch Ver�ndern eines einzigen
Sprungbefehles dahingehend manipuliert werden, da� der Speicherinhalt
k�nftig in Form von Hex-Byte ausgegeben wird:

Disassemblieren Sie dazu den Byte-Ausgabebefehl mit `D x99F` und
ersetzen `JSR BDDl` durch `JSR x32A`. F�r das `x` mu� der
4-KByte-Block, in dem die zu �ndernde SMON-Version steht, eingesetzt
werden. Liegt Ihre SMON-Version bei $C000, so ersetzen Sie das `x`
durch ein `C`.

Die Gesamtl�nge der DATA-Zeile kann au�erdem durch Ver�ndern der
Speicherzelle $x9AE variiert werden. Bei dem Wert $1C werden zum
Beispiel genau acht Hex-Byte pro Zeile ausgegeben. Das
Assembler-Listing zu dieser Erweiterung zeigt Listing 6.

*(Dietrich Weineck/Mark Richters/sk)*

## Befehls�bersicht zum SMON

Alle Eingaben erfolgen in der hexadezimalen Schreibweise. In Klammern
angegebene Adre�eingaben k�nnen entfallen. SMON benutzt dann
sinnvolle, vorgegebene Werte.

Bei allen Ausgabe-Befehlen ist gleichzeitig die Ausgabe auf einem
Drucker m�glich. Dazu werden die Befehle geSHIFTet eingegeben.

- `A 4000` (Assembler)<br>
  symbolischer Assembler (Verarbeitung von Label m�glich) Startadresse $4000
- `B 4000 4200` (Basic-Data)<br>
  erzeugt Basic-DATA-Zellen aus Maschinenprogramm im Bereich von $4000 bis $41FF
- `C 4010 4200 4013 4000 4200` (Convert)<br>
  in ein Programm, das von $4000 bis $4200 im Speicher steht, soll bei
  4010 ein 3-Byte-Befehl eingef�gt werden. Dazu wird das Programm
  ab $4010 bis 4200 auf die neue Adresse $4013 verschoben. Alle
  absoluten Adressen, die innerhalb des Programmbereichs ($4000
  bis $4200) stehen, werden umgerechnet, so da� die Sprungziele
  stimmen.
- `D 4000` (4100) (Disassembler)<br>
  disassembliert den Bereich von $4090 (bis $4100) mit Ausgabe der Hex-Werte. 
  �nderungen sind durch �berschreiben der Befehle m�glich.
- `F` (Find)<br>
  findet Zeichenketten (F), absolute Adressen (FA), relative Spr�nge (FR),
  Tabellen (FT), Zeropageadressen (FZ) und Immediate-Befehle (FI)
- `G 4000` (Go)<br>
  startet ein Maschinenprogramm, das bei $4000 im Speicher beginnt
- `I 01` (I/O-Ger�t)<br>
  stellt die Ger�tenummer f�r Floppy (08 oder 09) oder Datasette (01) ein
- `K A000` (A500) (Kontrolle)<br>
  zum schnellen Durchsuchen des Bereichs von $A000 (bis $A500) nach ASCII-Zeichen 
  (32 Byte pro Zeile). �nderungen sind durch �berschreiben der ASCII-Zeichen m�glich.
- `L` (4000) (Load)<br>
   l�dt ein Maschinenprogramm an die richtige oder eine angegebene Adresse ($4000)
- `M 4000` (4400) (Memory-Dump)<br>
   gibt den Inhalt des Speichers von $4000 (bis $43FF) in Hex-Byte und ASCII-Code aus,
   �nderungen sind durch �berschreiben der Hex-Zahlen m�glich.
- `O 4000 4500 AA` (Occupy)<br>
  f�llt den Speicherbereich von $4000 bis $4500 mit vorgegebenem Byte ($AA) aus
- `P 05` (Printer)<br>
  setzt Ger�teadresse 5 f�r Drucker
- `R` (Register)<br>
  zeigt die Registerinhalte und Flags an. �nderungen sind durch �berschreiben m�glich.
- `S "Test" 4000 5000` (Save)<br>
  speichert ein Programm von $4000 bis $4FFF unter dem Namen `Test` ab
- `TW` (4000) (Trace Walk)<br>
  f�hrt auf Tastendruck den jeweils n�chsten Maschinenbefehl aus und zeigt die 
  Registerinhalte an. Subroutine k�nnen in Echtzeit durchlaufen werden (`J`). Wird keine 
  Startadresse eingegeben, beginnt `TW` bei der letzten mit `R` angezeigten Adresse.
- `TB 4010 05` (Trace Break)<br>
  setzt einen Haltepunkt f�r den Schnellschrittmodus bei $4010. Der Schnelischrittmodus 
  wird unterbrochen, nachdem $4010 zum f�nften Mal erreicht worden ist.
- `TO 4000` (Trace quick)<br>
  Schnellschrittmodus, springt beim Erreichen eines Haltepunktes in den Einzelschrittmodus
- `TS 4000 4020` (Trace stop)<br>
  arbeitet ein Programm ab $4000 in Echtzeit ab und springt beim Erreichen von $4020 in die
  Registeranzeige. Von dort aus kann (nach eventueller �nderung der Register) mit `G` oder
  `TW` fortgefahren werden, `TS` arbeitet nur im RAM-Speicher.
- `V 6000 6200 4000 4100 4200` (Verschieben)<br>
  �ndert in einem Programm von $4100 bis $41FF alle absoluten Adressen, die sich auf den 
  Bereich von $6000 bis $6200 beziehen, auf einen neuen Bereich, der bei $4000 beginnt.
- `W 4000 4300 5000` (Write)<br>
  verschiebt den Speicherinhalt von $4000 bis $42FF nach $5000 
  ohne Umrechnung der Adressen (zum Beispiel Tabellen)
- `X` (Exit)<br>
  springt aus dem Monitor-Programm ins Basic zur�ck 
- `# 49152`<br>
  Dezimalzahl umrechnen 
- `$ 002B`<br>
  4-stellige Hex-Zahl umrechnen
- `% 01101010`<br>
  8-stellige Bin�rzahl umrechnen
- `? 0344 + 5234`<br>
  Addition oder Subtraktion zweier 4stelliger Hex-Zahlen
- `= 4000 5000` (Vergleich)<br>
  vergleicht den Speicherinhalt ab $4000 mit dem ab $5000
- `Z` (Diskmonitor)<br>
   ruft den Diskmonitor auf. 
   Dieser verf�gt �ber folgende Befehle:
    - `R` (12 01) (Read)<br>
      liest Track $12, Sektor $01 von der Diskette in einen Puffer im Speicher. 
      Fehlt die Angabe von Track und Sektor, wird der logisch (!) n�chste Sektor gelesen.
    - `W` (12 01) (Write)<br>
      schreibt den Puffer im Speicher nach Track $12, Sektor $01 auf die Diskette. 
      Ohne Angabe von Track und Sektor werden die letzten Eingaben von `R` benutzt.
    - `M` (Memory-Dump)<br>
      zeigt den Pufferinhalt als Hexdump (wie normales `M`). Weitere Ausgabe mit CBM-Taste, 
      Abbruch mit STOP. Werte k�nnen durch �berschreiben ge�ndert werden.
    - `X` (Exit)<br>
      springt in SMON zur�ck
    - `F`    (weitere Disketten-Befehle initialisieren)<br>
      sind die Befehle initialisiert, gilt:
          - `M (O7)`: Memory-Dump (Floppy-RAM/ROM)
          - `V 6000 0400`: Verschieben eines 256-Byte-Blocks von $6000 in den Laufwerkspuffer 1 
            beziehungsweise in das Fioppy-RAM
          - `@`: normale Disketten-Befehle senden
          - `X`: zur�ck zum normalen Disketten-Monitor

## SMON-Speicherstellen

Folgende Zeropage-Adressen werden benutzt:

    FLAG     $AA    Universalflag
    ADRCODE  $AB    Adressierungscode f�r Assembier/Disassembler
    COMMAND  $AC    SMON-Befehlscode
    BEFCODE  $AD    Befehlscode Ass./Disass.
    LOPER    $AE    Low-Operand f�r Ass./Disass.
    HOPER    $AF    High-Operand f�r Ass./Disass.
    BEFLEN   $B6    Befehlsl�nge Ass./Disass.
    PCL      $FB    SMON-Programmcounter Low-Byte
    PCH      $FC    SMON-Programmcounter High-Byte

Au�erhalb der Zeropage benutzt SMON die Bereiche: 

    PCHSAVE  $02A8 
    PCLSAVE  $02A9
    SRSAVE   $02AA
    AKSAVE   $02AB  dienen der Zwischenspeicherung
    XRSAVE   $02AC  der angegebenen Register
    YRSAVE   $02AD
    SPSAVE   $02AE
    PRINTER  $02AF  Printernummer
    IO.NR    $02B0  Devicenummer
    MEM      $02B1  Buffer bis $02B8
    TRACEBUF $02B8  Buffer f�r Trace-Modus bis $02BF

Dann folgen die von Diskmonitor ben�tigten Adressen:
 
    SAVEX    $02C1  Zwischenspeicherung der X- und Y-Register
    TMPTRCK  $02C2
    TMPSECTO $02C3  Zwischenspeicher f�r Track und Sektor
    DCMDST   $02D0  Diskkommandostring
    TRACK    $02D8
    SECTO    $02DB  Track und Sektornummer
    BUFFER   $033C  Buffer f�r Label, nur f�r Assembler

Einsprungadressen von SMON-Routinen

    ; (TICK)       $CADB
    # (BEFDEC)     $C92E
    $ (BEFHEX)     $C908
    % (BEFBIN)     $C91c
    , (KOMMA)      $C6FC
    : (COLON)      $C41D
    ; (SEMIS)      $C3B6
    = (COMP)       $CAF5
    ? (ADDSUB)     $C89A
    A (ASSMBLER)   $C6D1
    B (BASICDATA)  $C96C
    C (CONVERT)    $CA3D
    D (DISASS.)    $C55D
    F (FIND)       $CB11
    G (GO)         $C3E3
    I (IO.SET)     $C844
    K (KONTROLLE)  $CAB7
    L (LOADSAVE)   $C84E
    M (MEMDUMP)    $C3F9
    O (OCUPPY)     $C9Cl
    P (SETPRINTER) $C83D
    R (REGISTER)   $C386
    S (LOADSAVE)   $C84E
    T (TRACE)      $CBF1
    V (VERSCHIEB)  $CA43
    W (WRITE)      $C9D3
    X (EXIT)       $C36E
    Z (DMON)       $CE09
