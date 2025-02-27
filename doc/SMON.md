*Quelle: 64'er Sonderheft 35, S. 132 ff. , 1988 Markt & Technik Verlag AG*

# SMON der Profimonitor
 
Die Stärken dieses Super-Maschinensprache-Monitors sind hauptsächlich
die mächtigen Such- und Trace-Befehle zum Austesten von Programmen in
Maschinensprache. Der SMON enthält auch einen vollständigen
Diskmonitor und einen Disassembler, der auch illegale Opcodes
disassembliert. Ein Programm, mit dem auch Profis gern arbeiten.

Ich kann mich noch gut an unsere ersten Schritte in Maschinensprache
erinnern. Ausgerüstet mit einer Befehlsliste für den 6502-kompatiblen
Prozessor des C64 und einem in Basic geschriebenen "Mini-Monitor"
entstanden Programme, die 3 und 5 addieren und das Ergebnis im
Speicher ablegen konnten. Dazu mußten wir die Befehlscodes aus der
Liste heraussuchen und dann in den Speicher "POKEn". Jeder Sprung
mußte von Hand ausgerechnet werden, jeder falsch herausgesuchte Befehl
führte zum Programmabsturz. Der erste Disassembler - ein Programm zur
Anzeige der Maschinenbefehle in Assemblersprache - war für uns die
Offenbarung. Von nun an konnten wir Maschinenprogramme analysieren und
daraus lernen. Zum Verständnis der Maschinensprache ist es nämlich
noch weit mehr als bei anderen Sprachen wichtig, vorhandene Programme
zu verstehen und sich dabei die wichtigsten Techniken anzueignen.

Mit der Zeit wuchsen unsere Ansprüche, ein Assembler mußte her, um die
neugewonnenen Erkenntnisse auch auszuprobieren. Das war zuerst wieder
ein Basic-Programm, langsam und wenig komfortabel, aber immerhin. Wir
schrieben unsere ersten kleinen Routinen, vor allem, um vorhandene
Maschinenprogramme unseren eigenen Wünschen anzupassen. So entstand im
Laufe eines Jahres SMON. Immer neue Befehle und Routinen kamen hinzu,
bis wir endlich zufrieden waren.

## Was bietet SMON?

Zunächst ist alles enthalten, was zum "Standard" gehört: 

- Memory-Dump, also die Anzeige des Speicherinhalts in Hex-Bytes, mit
Änderungsmöglichkeiten
- ein Disassembler mit Änderungsmöglichkeit sowie Routinen zum Laden,
Speichern und Starten von Maschinenprogrammen.

Darüber hinaus gibt es 

- einen kleinen Direktassembler, der sogar Labels verarbeitet
- Befehle zum Verschieben im Speicher mit und ohne
Umrechnen der Adressen 
- und Routinen zum Umrechnen von Hex-, Dezimal- und Binärzahlen.

Der besondere Clou von SMON liegt aber zweifellos in seinen
leistungsfähigen Suchroutinen und vor allem im Trace-Modus. Damit
lassen sich Maschinenprogramme Schritt für Schritt abarbeiten und
kontrollieren.

Der Monitor benötigt für alle Eingaben die hexadezimale Schreibweise,
das heißt zu den Zahlen 1 bis 9 kommen noch die Buchstaben A (für
dez. 10) bis F (für dez. 15) hinzu.

Bei der Eingabe von Adressen ist folgendes zubeachten: `[ANFADR]`
bedeutet exakt die Startadresse, `[ENDADR]` bedeutet hierbei die erste
Adresse hinter dem gewählten Bereich. Im Normalfall ist die Eingabe
mit und ohne Leerzeichen zulässig. Beim Abweichen von dieser Regel
wird darauf besonders verwiesen. Tippen Sie zuerst das Hauptprogramm
(Listing 1) mit dem MSE ab. Befindet sich SMON auf Ihrer Diskette,
kann er mit `LOAD "SMON $C000",8,1` geladen und mit dem Befehl `SYS
49152` gestartet werden. Geben Sie vor dem SYS-Befehl aber NEW ein, um
einen späteren `OUT OF MEMORY` zu verhindern.

## Assemblieren

#### Syntax:

    A [ANFADR]

Assemblierung beginnt bei der angegebenen Adresse

#### Beispiel:

    A 4000	Beginn bei Startadresse $4000
    
Nach Eingabe von `RETURN` erscheint auf dem Bildschirm die gewählte
Adresse mit einem blinkenden Cursor. Die Befehle werden so eingegeben,
wie sie der Disassembler zeigt: LDY #00 oder LDA 400E,Y und so
weiter. `RETURN` schließt die Eingabe der Zeile ab.

Bei einer fehlerhaften Eingabe springt der Cursor wieder in die
Anfangsposition zurück. Ansonsten wird der Befehl disassembliert und
nach Ausgabe der Hex-Bytes gelistet. Zur Korrektur vorhergehender
Zeilen gehen Sie mit dem Cursor zur Anfangsposition (hinter die
Adresse) zurück, schreiben den Befehl neu und gehen nach `RETURN` mit
dem Cursor wieder in die letzte Zeile. Falls Ihnen bei Sprüngen
(Branch-Befehl, JSR und JMP) die Zieladressen noch nicht bekannt sind,
geben Sie einfach sogenannte "Label" ein.

### Mit Bytes spielen

Ein Label besteht aus dem Buchstaben `M` (für Marke) und einer
zweistelligen Hex-Zahl von 01 bis 30.

#### Beispiel: 

    BCC M01

Wenn Sie die Zieladresse für diesen Sprung erreicht haben, dann
kennzeichnen Sie diese mit eben dieser "Marke".

#### Beispiel: 

    M01 LDY #00

Einzelne Bytes nimmt der Assembler an, indem Sie diese mit einem Punkt
kennzeichnen: beispielsweise `.00` oder `.AB`. In diesem Modus werden die
Eingaben natürlich nicht disassembliert.

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

Drücken Sie anschließend `F`. Ihr Programm wird noch mal
aufgelistet. Starten Sie es nun mit `G 4000`. Es erscheint ein Text
auf dem Bildschirm - lassen Sie sich überraschen.

## Disassemblieren

#### Syntax:

    D [ANFADR,ENDADR]

disassembliert den Bereich von `ANFADR` bis `ENDADR`, wobei `ENDADR`
nicht eingegeben werden muß. Wird keine Endadresse eingegeben,
erscheint zunächst nur eine Zeile:

     ADR   HEXBYTES   BEFEHL
     4000  A0 00      LDY #00

Mit der SPACE-Taste wird der jeweils nächste Befehl in der gleichen
Art und Weise gezeigt. Wünschen Sie eine fortlaufende Ausgabe, drücken
Sie `RETURN`. Die Ausgabe wird dann so lange fortgesetzt, bis eine
weitere Taste gedrückt wird oder bis ENDADR erreicht ist. Mit
`RUN/STOP` springen Sie jederzeit in den Eingabemodus zurück. Das
Komma, das vor der Adresse auf dem Bildschirm erscheint, ist ein
"hidden command" (verstecktes Kommando). Es braucht nicht eingegeben
zu werden, da es automatisch beim Disassemblieren angezeigt wird. So
ermöglicht es ein einfaches Ändern des Programms. Fahren Sie mit dem
Cursor auf den zu ändernden Befehl und überschreiben Sie ihn mit dem
neuen. Wenn Sie jetzt `RETURN` drücken, erkennt SMON das Komma als
Befehl und führt ihn im Speicher aus. Achten Sie aber darauf, daß der
neue Befehl die gleiche Länge (in Byte) hat und füllen Sie
gegebenenfalls mit "NOPs" auf. Zur Kontrolle können Sie den geänderten
Bereich noch einmal disassemblieren.

Lassen Sie als Beispiel einmal das Programm (siehe Befehl `A`) ab 4000
disassemblieren (`D 4000 4011`). Ändern Sie nun den ersten Befehl auf
LDY #0l. Die Änderung zeigt sich daran, daß die HEX-Bytes automatisch
den neuen Wert annehmen. Starten Sie nun das Programm nochmals mit `G
4000`. Jetzt erscheint der Text mit nur einer Zeile Abstand auf dem
Bildschirm.

## Starten eines Maschinenprogramms (Go)

#### Syntax: 

    G [ADRESSE]

startet ein Maschinenprogramm, das bei `ADRESSE` beginnt. Das Programm
muß mit einem BRK-Befehl abgeschlossen werden, damit ein Rücksprung in
SMON erfolgen kann. Wird nach `G` keine Adresse eingegeben, benutzt
SMON die, die mit dem letzten BRK erreicht worden ist und bei der
Register-Ausgabe als PC auftaucht. Mit dem `R`-Befehl (siehe unten)
werden die Register vorher auf gewünschte Werte gesetzt.

## Memory-Dump

#### Syntax: 

    M [ANFADR ENDADR)

gibt die HEX-Werte des Speichers sowie die zugehörigen ASCII-Zeichen
aus. Auch hier kann auf die Eingabe einer Endadresse verzichtet
werden. Die Steuerung der Ausgabe entspricht der beim Disassemblieren.

#### Beispiel:

    M 4000 

gibt die Inhalte der Speicherstellen $4000 bis $4007 aus. Weiter geht
es wie beim Disassemblieren mit SPACE oder RETURN. Die Bytes können
ebenfalls durch Überschreiben geändert werden, allerdings nicht die
ASCII-Zeichen. Verantwortlich dafür ist der Doppelpunkt, der am Anfang
jeder Zeile ausgegeben wird, ein weiterer "hidden command". Wenn Ihre
Änderung nicht durchgeführt werden kann, weil Sie zum Beispiel
versuchen, ins ROM zu schreiben, wird ein `?` als Fehlermeldung
ausgegeben.

## Registeranzeige

#### Syntax:

    R

zeigt den gegenwärtigen Stand der wichtigsten 6510-Register an:
Programmzähler (PC), Status-Register (SR), Akkumulator (AC),
X-Register (XR), Y-Register (YR), Stackpointer (SP). Außerdem werden
die einzelnen Flags des Status-Registers mit 1 für "gesetzt" und 0 für
"nicht gesetzt" angezeigt. Durch Überschreiben werden die Inhalte auf
einen gewünschten Wert gesetzt. Die Flags können allerdings nicht
einzeln verändert werden, sondern nur durch Überschreiben des Wertes
von SR.

## Exit

#### Syntax: 

    X

springt ins Basic zurück. Alle Basic-Pointer bleiben erhalten. Sie
können also zum Beispiel direkt im Programm fortfahren, wenn Sie
zwischendurch mit SMON einige Speicherstellen kontrolliert
haben. Probieren Sie alle bisher beschriebenen Befehle in Ruhe aus und
machen Sie sich mit SMON vertraut. Arbeiten Sie auch parallel den Kurs
über Assembierprogrammierung in dieser Ausgabe durch. Alle Beispiele
dort sind auf SMON abgestimmt.

## I/O-Set

#### Syntax:

    IO 1

legt die Device-Nummer für LOAD und SAVE auf 1 (Kassette). Jedes Laden
und Abspeichern erfolgt jetzt auf das angegebene Gerät. Die
voreingestellte Device-Nummer ist 8 (für die Floppy also: IO 8). Wenn
Sie nur mit der Floppy arbeiten, brauchen Sie diesen Befehl also
nicht.

## LOAD

#### Syntax: 

    L"name"

lädt ein Programm vom angegebenen Gerät (wie oben beschrieben) an die
Originaladresse in den Speicher. Die Basic-Zeiger bleiben bei diesem
Ladevorgang unbeeinflußt, das heißt, sie werden nicht verändert.

#### Beispiel: 

Unser Monitor soll an seiner Originaladresse ($C000) im Speicher
stehen. Also brauchen Sie ihn nur mit `L"SMON"` zu laden, damit er
dort erscheint. Wenn Sie einmal ein Programm an eine andere als die
Originaladresse laden wollen, dann bietet Ihnen SMON dazu folgende
Möglichkeit: `L"name" ADRESSE` lädt ein Programm an die angegebene
Adresse. Nehmen Sie doch bitte noch einmal unser letztes Test-Programm
und geben es mit dem Assembler ab Adresse $4000 ein. Speichern Sie es
mit `S"SUPERTEST" 4000 4023` ab und laden es dann

1. an die Originaladresse (`L"SUPERTEST"`) und
2. an eine andereAdresse (mit `L"SUPERTEST" 5000` zum Beispiel nach $5000).

Schauen Sie sich danach mit dem Disassembier-Befehl beide Routinen
einmal an. Sie werden feststellen, daß beide Programme zwar bis auf
die BRANCH-Befehle gleich aussehen, daß das Programm in $5000 aber
nicht funktionieren kann, da es eine falsche Adresse verwendet (5002
LDA 40OE,Y). 

Ein anderes Beispiel dazu: Ein Autostart-Programm beginnt bei $0120,
läßt sich aber in diesem Bereich nicht untersuchen, da dort der
Prozessor-STACK (im Bereich von $0100 bis$01FF) liegt, der vom
Prozessor selbständig verändert wird. Wenn Sie nun `L"name" 4120`
eingeben, befindet sich das Programm anschließend bei $4120 (nicht an
der Originaladresse $0120) und Sie können es ohne Einschränkungen -
von den falschen AbsolutAdressen abgesehen - disassemblieren.

## SAVE

#### Syntax:

    S"name", ANFADR ENDADR

speichert ein Programm von `ANFADR` bis `ENDADR-1` unter `name` auf
die Floppy ab, da diese - wie wir ja inzwischen wissen - das
voreingestellte Gerät ist. Wenn Sie auf Kassette abspeichern wollen,
setzen Sie vorher mit `IO 1` die Device-Nummer auf 1.

#### Beispiel: 

    S " SUPERTEST" 4000 4020
    
speichert das Programm mit dem Namen `SUPERTEST` (es steht im Speicher
von $4000 bis $401F) auf Diskette ab. Bitte beachten Sie auch bei
diesem Befehl, daß die Endadresse auf das nächste Byte hinter dem
Programm gesetzt wird.

## Printer-Set

#### Syntax:

    P 02

setzt die Primäradresse für den Drucker auf 2. Voreingestellt ist hier
die 4 als Gerätenummer (zum Beispiel für
Commodore-Drucker). Vielleicht haben Sie es ja schon bemerkt: Bei
allen Ausgabe-Befehlen (wie `D`, `M` etc.) können Sie auch den Drucker
ansprechen, wenn Sie das Kommando geshiftet eingeben. Die Ausgabe
erfolgt dann gleichzeitig auf Bildschirm und Drucker. (Beachten Sie
bitte die Änderung für die Druckerausgabe am Schluß des Artikels.)

## Ein bißchen Rechnerei

Die folgende Befehlsgruppe enthält Befehle zur Zahlenumrechnung. Sie
wissen ja: Der Mensch mit seinen zehn Fingern neigt eher zur dezimalen
Rechenweise, aber der Computer bevorzugt das Binärsystem, weil er nur
zwei Finger hat (siehe Netzstecker). Ein Kompromiß ist das
Hexadezimalsystem, denn das versteht keiner von beiden. Um
Verständnisschwierigkeiten mit Ihrem Liebling aus dem Weg zu gehen,
haben Sie aber SMON.

### Umrechnung Dez-Hex

#### Syntax:

    # (Dezimalzahl)

rechnet die Dezimalzahl in die entsprechende Hexadezimalzahl
um. Hierbei können Sie die Eingabe in beliebiger Weise vornehmen, da
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
Eingabe muß hierbei zweistellig beziehungsweise vierstellig
erfolgen. Ist diese Zahl kleiner als $100 (=255), wird zusätzlich auch
der Binärwert ausgegeben.
 
#### Beispiel: 

    $12
    $0012
    $0D
    $FFD2
    
etc. In den ersten drei Beispielen erfolgt die Anzeige auch in binärer
 Form.

### Umrechnung Binär-Hex,Dez

#### Syntax:

    % (Binärzahl (achtstellig))

rechnet die Binärzahl in die entsprechenden Hexa- und Dezimalzahlen
um. Bei diesem Befehl müssen Sie genau acht Binärzahlen
eingeben. Falls Sie einmal versehentlich mehr eingeben sollten, werden
nur die ersten acht zur Umrechnung herangezogen. 

#### Beispiel:

    %00011111
    %10101011

### Add-Sub

Syntax:

    ? 2340+156D 

berechnet die Summe der beiden vier (!)-stelligen Hex-Zahlen. Neben
der Addition ist auch Subtraktion möglich.


## Programme auf dem Rangierbahnhof

### Occupy (Besetzen)

#### Syntax:

    O (ANFADR ENDADR HEX-Wert)

belegt den angegebenen Bereich mit dem vorgegebenen HEX-Wert. 

#### Beispiel:

    O 5000 8000 00 

füllt den Bereich von $5000 bis $7FFF mit Nullen. Man kann mit
`OCCUPY` aber nicht nur Speicherbereiche löschen, sondern auch mit
beliebigen Werten belegen. Häufig hat man das Problem, festzustellen,
welcher Speicherplatz von einem Programm wirklich benutzt wird. Wir
füllen den in Frage kommenden Bereich dann zuerst zum Beispiel mit
`AA` und laden dann unser Programm. Probieren Sie bitte das folgende

Beispiel: Füllen Sie den Speicherbereich von $3000 bis $6000 mit $AA
und laden Sie dann unser SUPERTEST-Programm. Beim Disassemblieren
können Sie erkennen, daß unser kleines Programm exakt zwischen vielen
`AA` eingebettet ist.

### Write

#### Syntax: 

    W (ANFADRalt ENDADRalt ANFADRneu)

verschiebt den Speicherbereich von ANFADRalt bis ENDADRalt nach
ANFADRneu ohne Umrechnung der Adressen! Unser kleines Testprogramm
möge noch einmal als Beispiel dienen:

    W 4000 4020 6000 
    
verschiebt das oben angesprochene Programm von $4000 nach
$6000. Hierbei werden weder die absoluten Adressen umgerechnet noch
die Tabellen geändert. Letzteres ist sicherlich erwünscht, aber denken
Sie daran, daß das verschobene Programm nun nicht mehr lauffähig ist,
da die absoluten Adressen nicht mehr stimmen (zum Beispiel bei dem
Befehl `LDA 40OEY`). Falls Sie jetzt `G6000` eingeben, um das Programm
zu starten, werden Sie sich sicherlich wundern, daß es dennoch
läuft. Doch löschen Sie einmal das Programm in $4000 (mit `04000 4100
AA`) und starten das Programm in $6000 noch einmal! Seltsam, nicht?
Abhilfe schafft der nächste Befehl.

### Variation

#### Syntax:

    V (ANFADRalt ENDADRalt ANFADRneu ANFADR ENDADR)
    
rechnet alle absoluten Adressen im Bereich von `ANFADR` bis `ENDADR`,
die sich auf `ANFADRalt` bis `ENDADRalt` beziehen, auf `ANFADRneu`
um. Kompliziert? Nicht, wenn Sie sich klarmachen, daß die ersten drei
Adressen exakt den Eingaben beim `W`-Befehl entsprechen. Neu hinzu
kommen nur die beiden Adressen für den Bereich, in dem die Änderung
tatsächlich erfolgt.

Um unser mit `W` schon verschobenes Programm auch wieder lauffähig zu machen, geben Sie folgendes ein:

    V 4000 4020 6000 6000 600E
    
Damit werden alle Absolutadressen, die im Bereich von $6000 bis
$600E - dahinter steht die Tabelle - liegen und sich bisher auf $4000
bis $4020 bezogen haben, auf den neuen Bereich umgerechnet. Probieren
geht wie immer über kapieren. Eine Zusammenfassung dieser beiden
Befehle ermöglicht:

### Convertieren (Verschieben eines Programmes mit Adreßumrechnung.)

#### Syntax:

    C (ANFADRalt ENDADRalt ANFADRneu ANFADRges ENDADRges)

verschiebt das Programm von `ANFADRalt` bis `ENDADRalt` zur
`ANFADRneu`, und zwar mit Umrechnung der Adressen zwischen ANFADRges
und ENDADRges. An unserem kleinen Testprogramm läßt sich wieder einmal
demonstrieren, wie der Befehl eingesetzt wird. Laden Sie es also mit
`L"SUPERTEST"` und schauen es mit `D 4000` an. Jetzt wollen wir an der
Adresse $4008 einen 3-Byte-Befehl einfügen: `C 4008 4020 400B 4000
4011` verschiebt das Programm von $4008 bis $4020 zur neuen
Anfangsadresse $400B. Dabei werden im Bereich von $4000 bis $4011
(neue Endadresse des `aktiven` Programmes!) die Sprungadressen
umgerechnet. Nun können Sie ab Adresse $4008 einen 3-Byte-Befehl
einfügen, zum Beispiel `STY 0286`. Dazu geben Sie bitte ein:
 
    A 4008
    4008 STY 0286 
    F

Überzeugen Sie sich davon, daß SMON die Befehle korrekt umgerechnet
hat, indem Sie unser Beispiel disassemblieren (`D 4000`) und
anschließend mit `G 4000` starten. Besitzer eines Farbmonitors werden
in helle Begeisterung ausbrechen. Vorsicht ist geboten, wenn Tabellen
oder Text vorhanden sind. SMON wird versuchen, diese als Befehle zu
disassemblieren und gegebenenfalls umzurechnen. Dabei können
unvorhersehbare Verfälschungen auftreten. Aus diesem Grunde ist im
Beispiel die Endadresse des zu ändernden Bereiches auf $4011 und nicht
etwa auf $4023 gelegt worden. Wenn Sie größere Programme zu
verschieben haben, sollten Sie die Kommandos W und V anwenden
beziehungsweise einen Assembler einsetzen (zum Beispiel Hypra-Ass),
der es Ihnen gestattet, beliebige Einfügungen, Verschiebungen und
sonstige Änderungen vorzunehmen. Das C-Kommando eignet sich in erster
Linie für kleinere Änderungen innerhalb eines Programms.

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
überzeugen Sie sich mit `LIST` von der Ausführung. Dann können Sie
folgendes eingeben:

    10 FOR I=16384 TO 16415: READ D:POKE I,D: NEXT
    
In Verbindung mit den oben erzeugten DATA-Zeilen (und RUN!) hätten Sie
wieder das ursprüngliche Maschinenprogramm im Speicher. Falls Sie
dieses Beispiel durchführen wollen, denken Sie bitte daran, daß Sie
nach Erstellung der DATAs das Originalprogramm zum Beispiel mit OCCUPY
(`O 4000 4020 AA`) überschreiben, damit Sie die richtige Ausführung
überprüfen können.

Der BRK-Befehl am Ende des Testprogramms bewirkt einen Sprung zum SMON
zurück. Wollen Sie ein Maschinenprogramm von Basic aus starten und
auch wieder dorthin zurückgelangen, muß der letzte Befehl ein RTS
sein. Probieren Sie es aus, indem Sie das Basic-Programm um `20 SYS
16384` erweitern.

## KONTROLLE

#### Syntax:

    K (Anfadr Endadr)

listet die ASCII-Zeichen im gewünschten Bereich. Es werden jeweils 32
Zeichen pro Zeile ausgegeben, so daß man sich einen schnellen
Überblick über Texte oder Tabellen verschaffen kann.

#### Beispiel:

    K 4000

listet die ersten 32 Zeichen unseres Programms. Die weitere Ausgabe
ist genau wie beim Disassemblieren durch Druck auf SPACE oder RETURN
möglich. Auch hier können Sie wie bei den anderen
Bildschirm-Ausgabebefehlen Änderungen durch einfaches Überschreiben
vornehmen (natürlich nicht im ROM und nur mit ASCII-Zeichen!).

Als Beispiel wollen wir einmal im Basic `herumpfuschen`. Das geht
natürlich nicht so ohne weiteres, weil das Basic im ROM steht und
damit nicht verändert werden kann. Tippen Sie bitte folgendes ein:

    W A000 C000 A000
    
Auf den ersten Blick eine unsinnige Anweisung; der Speicher soll von A000 bis C000 nach A000 verschoben werden. Dieser Befehl entspricht exakt der Basic-Schleife `FOR I = 40960 TO 49152: POKE I, PEEK (I): NEXT`

Nun ist es aber so, daß beim `PEEK` das ROM gelesen beim `POKE` aber
ins darunterliegende RAM geschrieben wird. Wir erreichen also, daß das
Basic ins RAM kopiert wird. Jetzt müssen wir dafür sorgen, daß das
Betriebssystem sein Basic aus dem RAM und nicht aus dem ROM
holt. Zuständig dafür ist die Speicherstelle 0001. Geben Sie bitte `M
0001` ein und überschreiben Sie die `37` mit `36`.

Es passiert gar nichts. Jetzt tritt unser K-Kommando in Aktion. Geben Sie ein:

    K A100 A360

Was Sie sehen, sind die Basic-Befehlswörter und -Meldungen. Schalten
Sie mit SHIFT/CBM auf Kleinschrift, dann erkennen Sie, daß der jeweils
letzte Buchstabe eines Befehlswortes groß geschrieben ist
(Endekennung). Jetzt ändern Sie durch Überschreiben das `LIST` (A100)
in `LUST` und `ERROR` (A360) in `FAELER`. (Bei `FAELER` müssen Sie ein
Zeichen vor `ERROR` beginnen, sonst paßt es nicht.)

Verlassen Sie jetzt SMON mit `X` und geben Sie danach ein:

    POKE 1,54
    
SMON schaltet nämlich beim `X`-Befehl immer auf das Basic-ROM zurück,
daher müssen wir wieder auf unser geändertes Basic
umschalten. Schreiben Sie nun einen Basic-Dreizeiler und versuchen
Sie, diesen zu LISTen. Ergebnis? Versuchen Sie es jetzt einmal mit
`LUST`. Ihrer weiteren Phantasie sind keine Grenzen mehr gesetzt...

## FIND

Wie oben angesprochen stellt SMON eine Reihe verschiedener
Suchroutinen zur Verfügung, die im folgenden an vielen Beispielen
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

(die Leerzeichen zwischen den HexBytes dürfen nicht weggelassen
werden!). Es erscheinen alle Speicherstellen, die die gesuchten Bytes
enthalten, also zum Beispiel `4000`.

#### Syntax:

    FA (Adresse, Anfadr Endadr)
    
sucht alle Befehle, die eine bestimmte Adresse als Operanden haben (absolut). Die Adresse braucht nicht vollständig angegeben zu werden, es kann das Jokerzeichen `*` benutzt werden.

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

sucht nach relativen Sprungzielen. Anders als bei absoluten Sprüngen
(JMP, JSR) benutzen die Branch-Befehle eine relative Adressierung,
also zum Beispiel "Verzweige 10 vor" oder "37 zurück". Solche Sprünge
lassen sich mit dem `FA`-Kommando nicht finden. Hier wird `FR`
eingesetzt.

#### Beispiel:

Gesucht werden alle Branch-Befehle, die die Adresse $4002 anspringen.

    FR4002,2000 6000 .

Natürlich können solche Befehle nur höchstens 128 Byte vom Sprungziel
entfernt sein. Die Bereichsangabe ist hier also viel zu groß gewählt
(SMON stört dies allerdings nicht). Der Einsatz des Jokers ist hier
ebenfalls wie oben beschrieben möglich.

#### Syntax:

    FT (Anfadr Endadr)

sucht Tabellen im angegebenen Bereich. SMON behandelt dabei alles, was
sich nicht disassemblieren läßt, als Tabelle.

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
    
findet sämtliche Befehle mit Zeropage-Adressierung.

#### Syntax:

    FI (Operand, Anfadr Endadr)

sucht alle Befehle mit unmittelbarer Adressierung (immediate).

#### Beispiel:

Gesucht werden Befehle, die zum Beispiel das Y-Register mit 01 laden.

    FI01,2000 6000

findet `LDY #01` in Adresse $4000. 

Sie sehen, SMON bietet eine Fülle von verschiedensten FIND-Routinen,
mit denen alles gesucht und auch gefunden (!) werden kann.

## Vergleichen von Speicherstellen

#### Syntax:

    = Ad rl Adr2

#### Beispiel:

    = 4000 6000

vergleicht den Speicherinhalt ab $4000 mit dem ab $6000. Das erste
nicht übereinstimmende Byte wird angezeigt und der Vergleich wird
abgebrochen.

Wenn Sie ein Maschinenprogramm geschrieben und überarbeitet haben und
Sie wissen nicht mehr, worin eigentlich der Unterschied zwischen
der 76. und der 77. Version besteht, gehen Sie so vor:

1. Laden Sie zuerst Version 76 und verschieben Sie diese mit dem
`W`-Befehl in einen freien Speicherbereich.
2. Laden Sie dann Version 77 und führen Sie den `=`-Befehl durch.

Sofort finden Sie den Unterschied und können mit der Arbeit an Version
78 beginnen ...

## Trace: Schritt für Schritt

Wir wollen uns bei der Beschreibung der Trace-Befehle auf
Anwendungsbeispiele konzentrieren. Zum Aufbau der Routine sei nur so
viel gesagt: Gesteuert wird sie mit Hilfe des Prozessor-Interrupts,
weil nur damit ein Eingriff ins laufende Maschinenprogramm möglich
ist. Während des Trace-Ablaufs wird deswegen der Bildschirm
kurzfristig aus- und eingeschaltet, weil alle anderen
Interruptanforderungen, wie zum Beispiel durch den Video-Chip,
verhindert werden müssen. Da die Befehle eines Programms nicht nur
angezeigt, sondern auch wirklich ausgeführt werden, ist der
`SEI`-Befehl mit großer Vorsicht zu verwenden. Doch dazu später
mehr. Wir wollen ein neues, besser geeignetes Beispiel verwenden als
bisher. Tippen Sie also das folgende Miniprogramm mit dem Assembler
ein (`A 4000`):

     4000 LDA #30   lade den Akku mit (ASCII-) 0
     4002 JSR FFD2  gib Akku auf dem Bildschirm aus
     4005 CLC
     4006 ADC #01   erhöhe Akku um 1
     4008 CMP #39   vergleiche Akku mit (ASCII-) 9
     400A BCC 4002  springe, wenn Akku kleiner, zurück
     400C BRK	    springe in SMON zurück

Starten Sie das Programm mit `G 4000`. Es muß die Zahlen von 0 bis 8
auf den Bildschirm schreiben.

### Trace-Stop

    TS (Startadresse Stoppadresse)

Starten Sie nun unser Programm mit `TS 4000 4009`. Die ersten Befehle
werden ausgeführt (die Null ausgegeben, der Akku erhöht etc.), dann
stoppt das Programm bei Adresse $4009 und springt in die
Registeranzeige.

Genau genommen ist `TS` gar kein Trace-Befehl, das Programm läuft
nämlich bis zur gewählten Stoppadresse in Echtzeit durch. Dort
angekommen, können Sie die Register prüfen und gegebenenfalls durch
Überschreiben ändern. Mit `G`, `TW` oder `TB` (wird später erklärt)
ohne weitere Adresseneingaben können Sie dann im Programmlauf
fortfahren. SMON merkt sich nämlich, wo er stehengeblieben ist und
arbeitet ab dieser Adresse weiter, wenn Sie nicht eine neue angeben.

Sinnvoll ist dieser Befehl immer dann, wenn in einem längeren Programm
nur bestimmte Teile "getraced" werden sollen, der Anfang aber
durchlaufen werden muß, um Variable zu setzen oder Benutzereingaben zu
erfragen. Auch wenn man nicht ganz sicher ist, ob eine bestimmte
Passage überhaupt jemals durchlaufen wird, kann man das mit `TS`
überprüfen.

Zwei Einschränkungen gibt es allerdings wegen der Arbeitsweise dieses
Befehls: SMON setzt im Programm an die Stoppadresse einen BRK-Befehl
und merkt sich, welcher Befehl dort stand, um ihn wieder
zurückzuschreiben. Deshalb funktioniert `TS` nur im RAM, nicht aber
zum Beispiel im Basic oder im Betriebssystem. Auch darf die
Speicherstelle, in der sich SMON den ausgetauschten Befehl merkt
($02BC) vom Programm nicht verändert werden, sonst ist eine korrekte
Reparatur nicht mehr möglich.

Der wohl am häufigsten und vielseitigsten eingesetzte Trace-Befehl ist
sicherlich `TW`.

### Trace Walk

    TW (Startadresse)

Starten Sie unser Beispiel jetzt mit `TW 4000`

Der erste Befehl (`LDA #30` in Adresse $4000) wird ausgeführt, SMON
stoppt und zeigt dann die Inhalte aller Register in der gleichen
Reihenfolge wie beim `R`-Kommando sowie den nächsten Befehl an. Im
Akku steht jetzt 30, der Programmzähler zeigt auf $4002. Jetzt drücken
Sie eine Taste. Der nächste Befehl (`JSR FFD2`) wird ausgeführt, der
Programmzähler zeigt auf $FFD2. Achten Sie auf den Stackpointer: Sein
Inhalt hat sich um 2 vermindert, weil der Prozessor auf dem Stack die
Adresse abgelegt hat, an die er nach Beendigung der Subroutine
zurückspringen soll. Der nächste angezeigte Befehl ist ein indirekter
Sprung über $0326. Mit dem nächsten Tastendruck wird er durchgeführt.

Und so geht es munter weiter. Verzweifeln Sie nicht, wenn Sie auch
nach den nächsten zehn Tastendrücken immer noch irgendwo im
Betriebssystem "herumtracen" und von unserem Beispielprogramm weit und
breit nichts mehr zu sehen ist. Ausnahmsweise ist unser Liebling
einmal nicht im "Land der Träume" verschwunden, sondern tut, was er
soll: Er arbeitet brav einen Befehl nach dem anderen ab, der zur
Routine $FFD2 gehört, und das ist reichlich viel. Also bewegen Sie
Ihre Finger, Sie haben's ja nicht anders gewollt. Irgendwann einmal,
nach mehreren hundert gedrückten Tasten, befinden Sie sich plötzlich
wieder in der Registeranzeige von SMON. Das Programm ist beendet. Nun
werden Sie enttäuscht fragen, was man wohl mit einem Trace-Modus
anfangen soll, der schon bei kleinsten Beispielprogrammen ein völlig
undurchschaubares Chaos erzeugt? Nur Geduld, die Rettung naht in
Gestalt der Taste *J*.

Falls Ihre Hand noch nicht in Gips liegt, starten Sie das Ganze noch
mal von vorn mit `TW 4000`. Diesmal drücken Sie aber jedesmal, wenn
als nächster Befehl `JSR FFD2` angezeigt wird, auf *J*. Der Effekt
ist, daß die gesamte Subroutine auf einen Schlag abgearbeitet wird und
Sie sofort wieder auf dem nächsten Befehl unseres Beispiels
landen. Daß wir nicht gemogelt und die Befehle von `JSR FFD2` einfach
unterschlagen haben, sehen Sie daran, daß der Akku tatsächlich auf dem
Bildschirm ausgegeben worden ist (rechts neben `FFD2`). Jetzt können
Sie unser Beispiel in aller Ruhe bis zum Ende durchgehen und
verfolgen, wie der Akku erhöht wird, wie der Vergleich das
Statusregister beeinflußt und wie entsprechend der Rücksprung in die
Schleife erfolgt.

Sie dürfen die *J*-Taste auch dann benutzen, wenn Sie schon mitten in
der Subroutine sind. Aber hierbei ist äußerste Vorsicht geboten: Die
Rücksprungadresse muß unbedingt oben auf dem Stack liegen, wenn Sie
`J` drücken. Hat nämlich der Prozessor Werte auf dem Stack abgelegt
(mit `PHA` oder `PHP`), dann erfolgt der Sprung irgendwo hin, nur
nicht zurück ins Programm. Achten Sie deshalb genau auf die Anzeige
des Stackpointers. Wenn dessen Wert genau so groß ist wie bei Beginn
der Subroutine, kann nichts passieren. Sonst hilft nur noch der
ResetTaster, den Sie ja inzwischen hoffentlich eingebaut haben, oder
eine ruhige Hand, die die Büroklammer an Pin 1 und 3 des User-Ports
hält (Kostenpunkt der Reparatur bei Abrutschen liegt bei zirka 100
Mark ... ).

`TW` bricht automatisch mit der Registeranzeige ab, wenn im Programm
ein `BRK`-Befehl auftaucht. Wenn Ihnen das zu lange dauert oder Sie
zwischendurch ein Register ändern möchten, können Sie den Trace-Modus
jederzeit mit der Stopp-Taste verlassen. Anschließend können Sie wie
bei `TS` beschrieben fortfahren.

Im Gegensatz zu `TS` können Sie mit `TW` auch im ROM herumstöbern; Sie
haben es ja bei der Subroutine $FFD2 bereits getan. Einzige
Einschränkung beim `TW`-Befehl: Ihr Programm darf keinen `SEI`
enthalten, da dieser den Interrupt und damit auch den Trace-Modus
lahmlegt. Verlassen Sie in diesem Falle `TW` mit STOP und starten
erneut hinter dem `SEI`-Befehl. Allerdings müssen Sie in Kauf nehmen,
daß das Programm normalerweise nicht mehr korrekt arbeitet.

Das nächste Programm soll als weiteres Beispiel für den `TW`-Modus
dienen. Geben Sie es folgendermaßen ein:

     5000 LDA #00   lädt den Akku mit `0`
     5002 TAX       überträgt den Akku ins X-Register
     5003 .0C       ein mysteriöses Byte
     5004 LDA #04   lädt den Akku mit `4`
     5006 TAY       überträgt den Akku ins Y-Register
     5007 BRK       springt in SMON

Wenn wir dieses kleine Programm abarbeiten, müßte das X-Register auf
`0` stehen, während Akku und Y-Register mit `4` geladen sind. Starten
wir also das Programm mit `G 5000` und schauen uns die Register an.

Seltsamerweise enthalten alle Register eine `0`. Vorsichtig, wie wir
sind, überschreiben wir die drei Register mit `FF`, um die Veränderung
deutlich kontrollieren zu können.

Dann starten wir mit `G 5000` ein zweites Mal. Gegen alle Gesetze der
Vernunft erscheint wieder das "falsche" Ergebnis - alle drei Register
sind `0`. Hier soll uns jetzt der TW-Modus weiterhelfen, indem er uns
zeigt, was in Wirklichkeit passiert.

Geben wir `TW 5000` ein. Der erste Befehl (`LDA #00`) ist
durchgeführt, im Akku erscheint die Null. Jetzt steht der
Programmzähler auf dem folgenden Befehl `5002 TAX`. Nach Drücken einer
Taste wird dieser Befehl ausgeführt und es erscheint die Null im
X-Register. Beim folgenden Befehl müssen wir feststellen, daß der
Disassembler nicht in der Lage ist, ihn zu interpretieren - er gibt
drei Sternchen aus. Hierbei handelt es sich um unser Byte `0C`.
 
Wieder ein Tastendruck; und dann erkennen wir, daß etwas Merkwürdiges
passiert ist. Der Prozessor hat augenscheinlich den nächsten Befehl
(`LDA #04`) übersprungen und steht schon auf dem folgenden `TAY`. So
also wird unser Programm abgearbeitet. Damit ist auch das "falsche"
Ergebnis erklärt. Bleibt nur noch die Frage nach dem Grund für dieses
seltsame Verhalten. Und der ist sicherlich in dem mysteriösen Byte
`OC` zu suchen. Hierbei handelt es sich um ein en der "inoffiziellen"
Opcodes, die aufgrund der Prozessorarchitektur vorhanden sind und in
manchen Programmen ihr Unwesen treiben - wie wir zu unserem Leidwesen
erfahren mußten. Das Byte `0C` wirkt wie ein `NOP`, der eine Länge von
3 Byte hat. Deshalb wird der folgende 2-Byte-Befehl (`LDA #04`)
verschluckt.

Es gibt noch einiges zu entdecken am 6502 und 6510 - `TW` macht's möglich.

Häufig ist es nicht sinnvoll, ein Programm von Anfang an im `TW`-Modus
laufenzulassen. Zum anderen sind gerade Schleifen, die per Hand mit
`TW` durchlaufen werden müssen, eine ermüdende Angelegenheit. Hier
bietet SMON neben dem bereits beschriebenen `TS` eine weitere
Trace-Möglichkeit an:

### Trace Break

    TB (Adresse Anzahl der Durchläufe) 

### Trace Quick

    TQ (Adresse)

Geben Sie als Beispiel folgendes Programm ein:

     6000 LDY #00     Y als Zähler auf `0`
     6002 LDA 60OE,Y  Werte von $600E ff. sollen geladen werden
     6005 JSR FFD2    Ausgabe der Zeichen auf dem Bildschirm
     6008 INY         der Zähler wird erhöht
     6009 CPY #OE     Zähler schon `14`?
     600B BCC 6000    wenn nein, dann nächsten Wert holen
     601D BRK

Bei $600E soll nun ein Text stehen, den das Programm ausgibt. Die
einfachste Art, mit SMON Texte in den Speicher zu schreiben, besteht
im `K`-Befehl. Geben Sie

    K 600E

ein (danach natürlich Return) und drücken Sie die STOP-Taste. Fahren
Sie mit dem Cursor an das erste ausgegebene Zeichen (vermutlich ein
Punkt) und schreiben Sie - ohne Anführungszeichen: `FEHLER BEHOBEN`

Drücken Sie dann Return, um die Zeile an den Rechner zu
übergeben. Wenn Sie das Programm starten, werden Sie wieder einmal
Gelegenheit haben, sich in Ruhe etwas zu trinken zu holen (Prost!),
denn das Programm enthält einen dummen Fehler und beschäftigt den
Computer für eine lange, lange Zeit. Genauer gesagt, bis Sie ihn mit
Reset (zum Beispiel durch RUN/STOP-RESTORE) erlösen.

Nun soll SMON helfen, diesen Fehler zu lokalisieren. Setzen Sie zuerst
einmal einen Breakpoint bei $6002 und begrenzen die Durchläufe auf die
maximale Anzahl:

    TB 6002 0E

und starten mit

    TQ 6000

den Quicktrace bei $6000. Das Programm läuft so lange, bis zum 14. Mal
die Adresse $6002 erreicht wird und springt dann in den TW-Modus. Wenn
Sie sich jetzt die Registerinhalte genau anschauen, müßte Ihnen der
Fehler geradezu ins Auge springen. Wie groß sollte denn das Y-Register
sein? Welchen Wert sollte der Akku haben? NA?!

## Das "Gedächtnis" von SMON

Wenn Sie Programme mit SMON untersuchen oder verändern wollen, müssen
Sie noch wissen, welche Speicherstellen SMON verwendet. Es soll ja
Monitorprogramme geben, die die Basic-Zeiger als Arbeitsspeicher
benutzen, so daß ein Basic-Programm nach dem Rücksprung aus dem
Monitor gelöscht ist. SMON tut so etwas nicht. Aber natürlich braucht
er auch Speicherstellen, um sich Werte merken zu können. Damit Sie
Konflikten von Anfang an aus dem Wege gehen können, sind die
wichtigsten hier dargestellt.

In der Zeropage belegt SMON den Bereich von $00A4 bis $00B6. Dort
stehen Systemvariable für die Kassettenspeicherung und die
RS232-Schnittstelle. Diese werden nur während des Betriebs der
Kassette oder von RS232 gebraucht, sind ansonsten aber frei. Außerdem
werden die Speicherstellen $00FB bis $00FF benutzt, die sowieso zur
freien Verfügung des Anwenders vorgesehen sind. Alle anderen Zeiger in
der Zeropage, also insbesondere die Speicherverwaltung für Basic
bleiben unbeeinflußt.

Als weiteren Arbeitsspeicher benutzt SMON den Bereich von $02A8 bis
$02C0. Auch dieser Bereich wird vom Betriebssystem nicht benutzt, so
daß keine Konflikte entstehen dürften. Beim Assemblieren wird
zusätzlich noch der Kassettenpuffer als Speicher für die Label
benötigt. Dieser bleibt ansonsten aber auch unverändert; das ist
wichtig, wenn Maschinenroutinen dort abgelegt werden sollen.  Alles in
allem ist SMON also recht verträglich.

## SMON verschieben? - Mit SMON!

Eine Reihe von Anfragen hat uns erreicht, ob man SMON nicht mit Hilfe
des `W`-, `V`- oder `C`-Kommandos verschieben könne. Alle Versuche in
dieser Richtung seien fehlgeschlagen. Einige Leser meinten auch, in
der V-Routine müsse ein Fehler stecken. Diesmal sind wir jedoch völlig
schuldlos; es gibt nämlich einige Befehle in SMON, die keine
Sprungadressen sind und sich trotzdem auf den Bereich ($C000-)
beziehen, in dem SMON steht.

Dazu gehören in erster Linie die oben erwähnten Einsprungadressen,
deren High-Byte natürlich geändert werden muß, wenn SMON in einem
anderen Speicherbereich laufen soll. Es gibt aber auch Befehle, die
eine Adresse im Programm in einem Vektor ablegen
müssen. Disassemblieren Sie einmal den Anfang von SMON mit `D C000
C0OB`. Sie erhalten

     LDA #14    Low-Byte der BREAK-Routine von SMON
     STA 0316   im Break-Vektor speichern
     LDA #C2    High-Byte (!) siehe oben
     STA 0317   siehe oben
     BRK

Damit wird der Break-Vektor des Betriebssystems auf den SMON gesetzt
und mit dem anschließenden - und jedem weiteren BRK-Befehl - springt
das Programm in SMONs BREAK-Routine. Wenn SMON in einem anderen
Bereich als $C000 laufen soll, dann müssen diese Befehle geändert
werden.

Heraussuchen kann man sie mit `FIC*,C000 D000`. Sie wissen doch noch,
was diese Anweisung bedeutet: Suche mir alle Befehle, die ein Register
unmittelbar mit einem Wert laden, der mit $C beginnt. Aber Vorsicht!
Nicht alles, was da angezeigt wird, muß auch geändert werden! Um Ihnen
weitere Stunden sinnlosen Herumbrütens zu ersparen, wollen wir als
Beispiel zeigen, wie man SMON in den Bereich $9000 bis $A000 verlegen
kann. Natürlich geht das im Prinzip für jeden anderen Bereich genauso;
wir selbst haben insgesamt fünf SMON-Versionen für fünf verschiedene
Speicherbereiche, von denen eine immer paßt.

1. Wir verschieben zuerst das ganze Programm ohne Umrechnen in den
   neuen Bereich: `W C000 CFFA 9000`.
2. Nun lassen wir alle absoluten (3-Byte-)Befehle umrechnen. Die
   Tabellen am Anfang von SMON bleiben verschont: `V C000 CFFA 9000
   920B 9FD2`.
3. Als nächstes ändern wir die High-Bytes der Befehlsadresse. Geben
   Sie `M 902B 906B` ein und ändern Sie in jedem zweiten Byte das `C`
   durch Überschreiben in `9`. Vergessen Sie nicht, am Ende jeder Zeile
   `RETURN` zu drücken, damit Ihre Änderung auch übernommen wird.
4. Nun sind die Befehle mit Immediate-Adressierung an der Reihe. Sie
   müssen so geändert werden, daß sie sich auf den neuen Bereich
   $9... beziehen. Suchen Sie sie mit `FIC*,9000 9FFA` heraus. Sie
   erhalten:

    9005 LDA #C2   ändern
    9124 CPX #C0   nicht ändern
    9386 LDY #C0   ändern
    9441 CMP #C0   nicht ändern
    987F LDX #C3   nicht ändern
    988D LDX #Cl   nicht ändern
    9992 LDA #Cl   nicht ändern
    9C2C LDA #CC   ändern
    9C5B LDA #C2   ändern
    9CF4 LDA #CC   ändern
    9DA1 LDX #CC   ändern
    9E03 LDA #CC   ändern
    9E6C CMP #C0   nicht ändern
    9F71 LDY #CF   ändern

Sie sehen, es gibt keine Regel, weiche Befehle zu ändern sind und
welche nicht. Aus diesem Grunde müssen Sie diese Änderungen `von Hand`
vornehmen.

5. Die Adressen im Diskmonitor müssen ebenfalls umgestellt
werden. Dazu geben Sie bitte ein: `M 9FD8 9FE4` und ändern Sie jedes
zweite Byte wie unter Punkt 3 beschrieben.

Vergessen Sie bitte auf keinen Fall, Ihre neue(n) Version(en) unter
neuem Namen zu speichern. Sie lassen sich dann mit `LOAD "Name",8,1`
von Diskette laden und mit dem entsprechenden `SYS` (zum Beispiel
36864 bei SMON $9000) starten. Denken Sie auch daran, nach dem Laden
und vor dem `SYS` ein `NEW` einzugeben, sonst beschwert sich der
B-Befehl mit einem `OUT OF MEMORY ERROR`.

Probieren Sie nun alle Befehle durch. Sie müssen genauso arbeiten wie
bisher. Vor allem können Sie jetzt auch Programme wie `DOS, 5.l` oder
`Turbo Tape` untersuchen, die im $C000-Bereich stehen. Achten Sie
aber, wenn Sie `SMON $9000` von Basic aus benutzen, darauf, daß das
Basic ihn nicht überschreibt. String-Variable werden nämlich von $A000
nach unten hin aufgebaut und bis $9E09 ist nicht viel Platz. Schützen
Sie im Zweifelsfalle den Bereich, indem Sie nach dem Laden des SMON
$9000 eingeben: `NEW: POKE 56,144: POKE 55,0`

Damit ist SMON vor Überschreiben geschützt. Das ist natürlich bei dem
SMON $C000 nicht nötig, weil Basic in diesen Bereich nicht
hineinkommt.

## Die Befehle des Disk-Monitors

Da das Arbeiten mit dem Disk-Monitor besondere Aufmerksamkeit verlangt
(nach Murphys Gesetzen führen Fehleingaben in der Regel zu unlesbaren
Disketten), wird er mit einem eigenen Kommando eingeschaltet. Leider
waren alle halbwegs sinnvollen Buchstaben (`D` wie Diskette oder `F`
wie Floppy) schon vergeben, deshalb haben wir uns für ein schlichtes
`Z` wie Zuversicht entschieden.

### `Z` schaltet den Disk-Monitor ein.

Die Rahmenfarbe ändert sich auf Gelb, der gewohnte `.` am Anfang einer
Zeile ändert sich in `*`. Dies alles hat den Zweck, Ihnen deutlich zu
machen, daß es jetzt ernst wird. Intern wird jetzt das Basic
abgeschaltet, weil der Disk-Monitor einen 256 Byte großen Puffer
benötigt. Dieser liegt von $BF00 bis $C000 im RAM unter dem Basic,
weil er dort am wenigsten stören kann.

### READ: `R (Track Sektor)`

Liest einen Block von der Diskette in den Computer. Track und Sektor
müssen als Hexzahlen eingegeben werden. Die erste Zeile des Blocks
wird ausgegeben. Da wir dazu normale SMON-Routinen verwenden, steht
als Speicheradresse $BF00. Das `BF` können Sie vorerst ignorieren. Die
weitere Ausgabe des Hexdump erfolgt anders als gewohnt mit der Taste
`SHIFT`. `STOP` bricht die Ausgabe ab. Sie können die Hex-Bytes
überschreiben und damit ändern. Eine dauerhafte Änderung erfolgt aber
erst beim Zurückschreiben auf die Diskette (siehe Befehl `W`). Geben
Sie nur `R` ohne Track und Sektor ein, wird der logisch (!) nächste
Block eingelesen.

### MEMORY-DUMP: `M`

Zeigt den gerade im Puffer befindlichen Block nochmals auf dem Bildschirm an.

Genau wie beim R-Befehl können Sie die Ausgabe mit `SHIFT` und `STOP`
steuern und Änderungen vornehmen.

### WRITE: `W (Track Sektor)`

Schreibt einen Block aus dem Puffer auf die Diskette zurück. Ähnlich
wie bei `R` kann die Angabe von Track und Sektor entfallen. Es wird
dann der Track und Sektor des letzten R-Befehls benutzt. Das ist in
fast allen Fällen auch der richtige.

### ERROR: `@`

Liest den Fehlerkanal aus, gibt ihn aber nur aus, wenn wirklich ein
Fehler vorhanden war (`00,OK,00,00` wird unterdrückt).

### EXIT: `X`

Verläßt den Disk-Monitor und springt in den SMON zurück. Dabei wird
die Rahmenfarbe auf Blau zurückgeschaltet und es erscheint wieder der
`.` am Anfang der Zeile. Das Basic wird wieder eingeschaltet. Wollen
Sie nun mit SMON-Kommandos auf den Puffer zugreifen, müssen Sie Basic
wieder abschalten ($36 in Speicherstelle $0001).

Die folgenden Beispiele sollen Ihnen die Arbeit mit dem Disk-Monitor verdeutlichen.

**Achtung! Benutzen Sie unbedingt zum Üben eine Diskette, die Sie nicht mehr brauchen!**
 
Weder wir noch der Verlag haften dafür, wenn Ihr Lieblingsprogramm
oder die mühsam erstellte Adreßdatei unwiederbringlich dahin sind. Daß
das sehr sehr schnell gehen kann, wissen wir aus eigener Erfahrung ...

Am besten machen Sie von einer Ihrer Diskette eine Kopie, die Sie zum
Üben benutzen können.

## Reparatur eines gelöschten Files

Sicher ist Ihnen das auch schon passiert: Sie wollen Ihr Programm mit
Namen `Schrott` löschen, geben als Abkürzung `S:S*` ein und merken in
dem Moment, in dem Sie `RETURN` drücken, daß auf der Diskette auch
alle Versionen von `SMON` waren, außerdem auch noch "Superbase",
"Soccer" etc. Verzweifeln müssen Sie nur, wenn auch diese letzte
SMON-Version mit dem Disk-Monitor dabei war. Ansonsten behalten Sie
die Ruhe und verfahren Sie wie im folgenden beschrieben.

Laden Sie also jetzt SMON, legen Sie Ihre "Übungsdiskette" (!) ins
Laufwerk und löschen Sie eins der ersten Programme mit dem üblichen
Scratch-Kommando. Nun starten Sie SMON und drücken `Z`. Der Bildschirm
ändert seine Farbe wie beschrieben und am Anfang der Zeile erscheint
der `*`. Jetzt geben Sie ein:

    R 12 00

Auf dem Bildschirm erscheint die erste Zeile der BAM, die bei jeder
Diskette auf Track 18, Sektor 0 abgelegt ist. Die ersten beiden Byte
enthalten `12 01` und geben damit den logisch nächsten Block an. In
diesem Falle wäre das der erste Block des Directory. Wenn Sie mit
`SHIFT` die Bildschirmausgabe fortsetzen, erkennen Sie etwa in der
Mitte den Diskettennamen. Lassen Sie die Ausgabe durchlaufen, bis
wieder der `*` erscheint. Nun geben Sie `R` ohne weitere Angaben
ein. Damit erhalten Sie den Koppel-Block, also Track 18, Sektor 1, den
ersten Directory-Block. (Natürlich hätten Sie auch gleich `R 12 01`
eintippen können, aber wir wollen ja zeigen, wie die Befehle
funktionieren.)

In diesem Block stehen die ersten acht Programme Ihrer Übungsdiskette,
auch der Name des soeben gelöschten ist dabei.

## Dateien einfach manipulieren

Trotzdem ist dieses Programm tatsächlich gelöscht und erscheint nicht
mehr, wenn Sie sich das Directory anzeigen lassen. Vergleichen Sie den
Eintrag des gelöschten Programms mit den anderen, fällt auf, daß 3
Byte vor Beginn des Namens bei allen anderen `82` steht (sofern es
sich um Programmfiles handelt), bei dem gelöschten aber `00`. Die
Reparatur ist nun denkbar einfach: Sie brauchen lediglich die `00` mit
`82` zu überschreiben. Einen Haken hat die Sache allerdings noch. Beim
SCRATCHEN sind die vom Programm belegten Blöcke in der BAM als frei
gekennzeichnet worden und jeder neue Eintrag würde das als gelöscht
gekennzeichnete File endgültig überschreiben. Um das zu verhindern,
müssen Sie nach erfolgter Reparatur die Diskette validieren (von Basic
aus mit Kommando: `OPEN 1, 8,15, "V"`). Dabei wird,die BAM neu erzeugt
und korrigiert.

### Schützen eines Files

Da wir gerade dabei sind, wollen wir unser repariertes gelöschtes File
gleich ein für allemal gegen Löschen schützen. Diese Möglichkeit des
Diskettenoperationssystems (DOS) ist zwar nicht im Handbuch
beschrieben, funktioniert aber trotzdem ausgezeichnet. Laden Sie dazu
nochmals die erste Seite des Directory mit

    R 12 01

und ändern Sie die `82` vor dem Fileeintrag in `C2`. Geben Sie `W`
ein, um die Änderung auf Diskette zu schreiben. Verlassen Sie nun SMON
mit `X` und lassen Sie sich ein Directory anzeigen. Das geschützte
File ist mit einem `>` gekennzeichnet. Versuchen Sie nun, dieses
Programm mit dem Scratch-Kommando zu löschen. Es geht nicht! Zum
"Entriegeln" brauchen Sie nur das `C2` wieder in `82` zu ändern. Der
`>` im Directory verschwindet und das File ist nicht mehr geschützt.

### Schützen einer Diskette

Wollen Sie eine ganze Diskette vor versehentlichem Löschen oder
Formatieren schützen, gibt es die Möglichkeit, die Löschschutzkerbe
abzukleben. Es geht jedoch auch anders.

**ACHTUNG! Die im folgenden beschriebene Prozedur läßt sich nicht ohne
weiteres rückgängig machen, auch nicht mit dem Disk-Monitor!**

Nehmen Sie also eine Diskette, die Sie anschließend "hart formatieren"
können (also mit Eingabe einer ID). Starten Sie nun den Disk-Monitor
und lesen Sie die BAM mit `R 12 00` ein. Das dritte Byte enthält
`41`. Diese `41` ist ein Kennzeichen für das DOS der 1541- oder
4040-Floppy. Andern Sie diese Byte durch Überschreiben in `45` und
speichern Sie die Änderung mit `W` auf die Diskette zurück. Verlassen
Sie nun SMON und versuchen Sie, etwas zu iöschen. Ergebnis siehe
oben. Versuchen Sie auch, die Diskette "weich", also zum Beispiel mit
`OPEN 1,8,15,"N:TEST"` zu formatieren.
 
Auch das ist jetzt nicht mehr möglich. Aber es kommt noch besser:
Starten Sie noch einmal den Disk-Monitor und versuchen Sie, die
Änderung durch Zurückschreiben der `41` an Stelle der `45` rückgängig
zu machen. Auch das ist nicht mehr möglich, wir hatten Sie bereits
gewarnt! Es bleibt lediglich die Möglichkeit, die Diskette "hart", zum
Beispiel mit `OPEN 1,8,15,"N:TEST,TE"` zu formatieren. Sollten Sie nun
entgegen allen Warnungen doch Ihre Master-Diskette gegen
Schreibzugriffe gesichert haben, verraten wir Ihnen ausnahmsweise, wie
Sie den Eingriff trotzdem rückgängig machen können. Dazu überlisten
wir das DOS des 1541-Laüfwerkes, indem wir ihm vorgaukeln, es hätte
eine Diskette im Normalformat vor sich. Wir verwenden den
Memory-Write-Befehl, mit dem wir in die Speicherstelle 0101 (Zero-Page
Adresse) des 1541-RAM einfach ein `A` schreiben. Der CHR$-Code des `A`
ist 65, oder in hexadezimaler Schreibweise 41. Erinnern Sie sich?
Dieser Wert stand ursprünglich im dritten Byte des Tracks 18,
Sektor 0. Mit folgendem kleinen Programm umgehen wir einfach die
DOS-Kennzeichnung und wir können die Diskette wieder normal
beschreiben. Am sinnvollsten ist es, sofort den SMON zu starten, das
vorher in 45 abgeänderte Byte wieder in 41 zu verwandeln und
abzuspeichern. Die Diskette kann dann wieder zum Lesen und Schreiben
verwendet werden.

Hier nun das kleine Programm:

    10 OPEN 1,8,15
    20 PRINT#1, "M-W"CHR$(1)CHR$(1)CHR$(1)CHR$(65) 
    30 CLOSE1

### Ändern des Diskettennamens oder der ID

Wir haben bereits oben gesehen, daß in Spur 18, Sektor 0 einer
Diskette etwa in der Mitte der Diskettenname gespeichert wird. Dieser
Name kann durch einfaches Überschreiben geändert werden; er darf
bekanntlich bis zu 16 Zeichen enthalten. Hat Ihr neuer Name weniger
Buchstaben als der alte, müssen Sie die Lücken mit `A0` und nicht mit
`20` als Leerzeichen ausfüllen. Dies gilt vor allem, wenn Sie mit
dieser Methode Filenamen ändern wollen. Das geht natürlich im Prinzip
genauso wie eben beschrieben. Hinter dem Diskettennamen ist in Spur
18, Sektor 0 die ID abgelegt. Sie wird beim Formatieren vor jeden
Sektor in einen sogenannten Header geschrieben und dient dem DOS zur
Identifikation der Diskette. Zusätzlich wird sie noch in der BAM
gespeichert, damit sie beim Laden eines Directory mit angezeigt werden
kann. Nun ist es grundsätzlich nicht möglich, die ID im Header eines
Sektors ohne Formatieren zu ändern, wohl aber die Eintragung in der
BAM und damit die ID, die im Directory angezeigt wird. Genau wie beim
Namen ist dies durch einfaches Überschreiben in der BAM möglich.

### Ändern eines Filetyps

Wenn Sie einmal versucht haben, ein sequentielles File, etwa eine
Datei, mit LOAD zu laden, werden Sie gemerkt haben, daß dies nicht
möglich ist. Das DOS behauptet einfach, ein solches File existiere
nicht und der Computer meldet `FILE NOT FOUND`. Viele Spiele zum
Beispiel legen die "Hall of Fame" oder Highscore-Liste als
sequentielle Datei ab. Mit dem Disk-Monitor ist es nun aber möglich,
den Filetyp im Directory zu verändern. Erinnern Sie sich an die `82`,
die im Directory vor jedem Filenamen steht. Bei sequentiellen Files
steht dort `81`. Was zu tun ist, werden Sie sich denken können. Na
klar, die `81` wird in `82` geändert, und schon ist die Datei ohne
weiteres ladbar, natürlich wieder erst nach dem Zurückschreiben mit
`W`.

Sinnvoll ist dies natürlich nur von SMON aus (mit Eingabe einer
Ladeadresse). Mit `M` oder `K` können Sie dann die Datei ansehen und
natürlich auch ändern. Vergessen Sie nicht, die geänderte Datei nach
dem Zurückschreiben wieder in ein sequentielles File zu
verwandeln. Verblüffen Sie Ihre Freunde doch mal mit einem auf diese
Weise "errungenen" High-Score. Die Anerkennung Ihrer Umwelt ist Ihnen
sicher!

### Ändern der Startadresse eines Programms

Wir haben uns bisher auf Manipulationen in der BAM oder im Directory
beschränkt. Wollen wir in einem Programm selbst Änderungen vornehmen,
müssen wir etwas tiefer in die "Geheimnisse der Floppy" eindringen. So
ist es bisweilen interessant, die Startadresse eines
Maschinenprogramms zu kennen oder zu ändern. Dazu gehen wir
folgendermaßen vor: Zunächst suchen wir mit `R 12 01` und eventuell
weiteren Folgesektoren (12 04,12 07 .. ) den Fileeintrag im
Directory. Die beiden Byte hinter der `82` direkt vor dem
Programmnamen geben an, auf welcher Spur und in welchem Sektor das
Programm startet. Wenn dort zum Beispiel `0A 04` steht, beginnt das
Programm auf Spur 10, Sektor 4. Lesen Sie nun diesen Block mit `R 0A
04` ein. Die ersten beiden Bytes dieses Blocks zeigen auf den nächsten
Block des Programms, die beiden nächsten Bytes enthalten die
Startadresse in der üblichen Low-High-Byte-Reihenfolge. Zum Ändern der
Startadresse überschreiben Sie die Bytes mit der neuen und speichern
den Block mit `W` auf die Diskette zurück.

## Die Zusammenarbeit mit SMON

Mit all diesen Beispielen sind die Möglichkeiten des Disk-Monitors
noch lange nicht erschöpft. Sie sollten Ihnen als Anregung für eigene
Experimente dienen. Üben Sie aber unbedingt so lange, bis Sie alle
Kommandos aus dem `FF` (oder dezimal 255) beherrschen. Sie ersparen
sich damit unnötigen Ärger und durchweinte Nächte. Besonders
interessant ist es, von SMON aus auf den Puffer zuzugreifen und die
SMON-Befehle auf den Puffer anzuwenden. Erwähnen möchte ich nur die
Möglichkeit, Programme für das DOS direkt zu assemblieren und in einem
bestimmten Sektor ablegen zu können, die `Find`-Routinen oder das
`K`-Kommando für Textänderungen. Da der Puffer im RAM unter dem Basic
liegt, muß Basic in solchen Fällen abgeschaltet werden. Ändern Sie
dazu mit dem `M`-Befehl in Speicherstelle 0001 die `37` in `36`.

Haben Sie die Arbeit mit SMON beendet, können Sie mit `Z` in den
Disk-Monitor schalten und den Pufferbereich mit `W` (Spur, Sektor)
abspeichern.

### Die Ausgabe von Diskettenfehlern

Beim Arbeiten mit dem Disk-Monitor werden sämtliche Fehler vom
Laufwerk direkt, auch ohne Eingabe von `@`, ausgegeben, zum Beispiel
`ILLEGAL TRACK OR SECTOR`, wenn Sie mit `R` einen Block lesen wollen,
den es gar nicht gibt. Einen Fehler hat das Programm allerdings, den
wir nicht verschweigen wollen. Der letzte Block eines Files enthält
als Koppeladresse `00 FF`. Da es einen solchen Block nicht geben kann,
"weiß" das DOS, daß es am Ende angelangt ist. Versuchen Sie aber, den
nächsten Block (Spur 0, Sektor 255!!) mit `R` zu lesen, erscheint als
Fehlermeldung nicht, wie es sein müßte, `ILLEGAL BLOCK OR SECTOR`,
sondern `SYNTAX ERROR`. Das ist zwar eigentlich unerheblich, sollte
aber erwähnt werden. Der Fehler liegt in der Routine, die unsere
Zahleneingaben in das richtige Diskettenformat wandelt. Es fehlte
einfach der Platz im Programm für eine "korrekte" Umwandlung, wir
mußten uns mit einer "Sparroutine" behelfen.

Abschließend noch ein SMON-Trick, den wir einem aufmerksamen Leser
verdanken. Für eine Directory-Ausgabe fehlte der Platz im SMON. Es
geht aber hilfsweise so: Laden Sie das Directory zum Beispiel mit

    L "$" 8000

an einen freien Speicherplatz. Mit `M` oder `K` können Sie jetzt das
Directory `lesen`. Damit sind alle wichtigen Funktionen für den Umgang
mit der Diskette im SMON enthalten.

Zwei Erweiterungen haben wir Ihnen zu Beginn angekündigt, die SMON
noch leistungsfähiger machen sollen.

## SMON lüftet Geheimnisse

Dabei handelt es sich einmal um eine Erweiterung des Disassembiers,
mit dem nun auch die "illegalen" Opcodes des 6502 disassembliert
werden, zum anderen um neue Funktionen beim Diskmonitor, mit denen Sie
in den Innereien Ihrer Floppy herumstöbern können. Nun ist der
Speicherplatz bis auf 5 Byte ausgeschöpft, und die 4-KByte-Grenze soll
auf keinen Fall überschritten werden. Wir haben daher andere
Funktionen herausgenommen, und zwar für die Disassembler-Erweiterung
den Diskmonitor und für die Diskmonitor-Erweiterung den Trace-Modus.

Beide Erweiterungen sind also nicht gleichzeitig einsetzbar; überhaupt
ist es sinnvoll, eigene Versionen für spezielle Anwendungen
zusammenzustellen, eine "normale", eine Spezial-Disk-Version und eine
für verschärftes Disassemblieren.
 
Beginnen wir mit dem letzten: Wie Sie wissen, erscheinen beim
Disassemblieren immer drei Sternchen, wenn SMON auf ein Byte trifft,
das keinen gültigen 6510-Opcode darstellt. Nun wissen Sie aber
vielleicht auch, daß es über den offiziellen Befehlssatz hinaus noch
einige Befehle gibt, die der Hersteller des Prozessors zwar nicht
dokumentiert hat, die aber nichtsdestotrotz funktionieren und in
einigen Programmen auch ausgenutzt werden. Es wäre natürlich schön,
wenn SMON auch diese "illegalen" Opcodes anzeigen könnte. Unsere
Erweiterung macht's möglich.

Wir haben Mnemonics für eine Reihe dieser Befehle eingesetzt und
lassen diese von SMON mit einem vorangestellten `.` ausgeben. Übrig
bleiben noch zehn Befehle, deren Wirkung aber so komplex ist, daß sie
sich beim besten Willen nicht mit einem Mnemonic abkürzen lassen. Sie
fallen auch aus der Logik der Prozessorstruktur heraus. Im einzelnen
handelt es sich um die Opcodes 0B, 2B, 4B, EB, 8B, 9C, 9E, AB, CB und
EB. Bei diesen Befehlen haben wir keine gemeinsame Struktur entdecken
können. Die neuen Mnemonics haben folgende Bedeutung:

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
  Führt eine UND-Verknüpfung zwischen Akku und X-Register durch und
  speichert das Ergebnis in der angegebenen Adresse ab.
- `CRA`: CRAsh<br>
  Führt zum "Absturz" des Prozessors.
- `NOP`: NO Operation<br>
  Entspricht dem bekannten `NOP`, jedoch kann dieser Befehl auch 2 oder
  3 Byte lang sein. Dies wird durch die angegebene Adresse deutlich, die
  in diesem Fall natürlich keinerlei Bedeutung hat.

Über den Sinn dieser Befehle läßt sich sicher streiten; allerdings
kommen sie bisweilen in Programmen vor, meist um das Lesen dieser
Programme unmöglich zu machen, also als Programmschutz. Von der
Verwendung dieser Befehle in eigenen Programmen raten wir auf jeden
Fall ab. Erstens wird kein Hersteller garantieren, daß die "illegalen"
tatsächlich mit jedem 6510-Prozessor funktionieren, zweitens gibt es
keine Funktion, die nicht auch mit den "normalen" Befehlen ebensogut
erreicht werden könnte. Und als Programmschutz taugen die "illegalen"
spätestens mit der Veröffentlichung dieses Artikels ja auch nichts
mehr. Aus diesem Grund haben wir bewußt auf eine Erweiterung des
Assemblers in dieser Richtung verzichtet. Sie können also keine
normalen Opcodes durch Überschreiben in "illegale" ändern, wohl aber
umgekehrt. Es bleibt lediglich die Eingabe als Einzelbyte, was aber
hoffentlich zu umständlich ist.

## Komfortabler Disketten-Monitor für SMON

Jetzt folgt unser zweiter Leckerbissen in Form eines kleinen aber
ungemein wertvollen Zusatzprogrammes für den SMON. Es handelt sich
dabei um eine Erweiterung des Disketten-Monitors, mit dem jeder auf
einen Schlag die Arbeit von Stunden zunichte machen kann. Geben Sie
das Programm wie beschrieben ein, starten Sie SMON wie gewohnt und
springen mit `Z` in den Disketten-Monitor. Von hier aus erreichen Sie
mit `F` (wie Floppy) die neuen Befehle. Wir haben absichtlich diesen
umständlichen Weg gewählt, denn Fehler in diesem Modus wirken noch
dramatischer als sonst. Mit diesem Werkzeug haben Sie unmittelbaren
Zugriff auf die Eingeweide der Floppy. Jetzt können Sie die folgenden
Befehle mit einer Übungsdiskette (!!!) in aller Ruhe durcharbeiten.

### `M`: Memory-Dump des Disketten-Monitors

Beispiel: `M` (ohne weitere Eingabe) listet den Bereich des Floppy-RAM
von $0000-$00FF. (Es erscheint zunächst die erste Zeile, weitere
Ausgabe mit der SPACE-Taste.)

In diesem Bereich befinden sich unter anderem die Jobspeicher
($00-$04) für die fünf Puffer 0 bis 4 sowie die wichtigsten Variablen
des DOS.

### `M07`: Memory-Dump ab $0700

Die BAM der Diskette wird nach dem Initialisieren in Puffer 4 ($0700
im Floppy-RAM) eingelesen. Schauen Sie sich also mit `M 07` die
aktuelle BAM an. Sie könnten jetzt durch einfaches Überschreiben den
Inhalt der BAM ändern. (Der Doppelpunkt vor der Zeile wirkt als
"hidden command"). Dann schauen Sie sich Ihre Änderung mit `M 07`
wieder an. Sie sehen, daß inzwischen der Inhalt des Floppy-RAM
geändert wurde. Wenn Sie nun den Jobcode `90` (= Schreibbefehl an den
Floppy-Controller) in Speicherstelle $04 bringen, würde die geänderte
(falsche!) BAM auf Diskette zurückgeschrieben werden!! Es gibt also
genug Möglichkeiten, wie oben angedeutet, die Disketten zu "versauen".
 
Für das Ausprobieren noch einige wichtige Speicherstellen und
Jobcodes:

     $80   Lesen
     $90   Schreiben
     $C0   `Anschlagen` des Kopfes
     $D0   Maschinenprogramme im Puffer aus führen
     $E0   Programm im Puffer ausführen mit Hochfahren des Laufwerks

Speicherstellen im Floppy-RAM:
 
     $06/$07   ist Spur- und Sektornummer für den Befehl in Puffer 0
     $08/$09   für Puffer 1
     $0A/$0B   für Puffer 2
     $0C/$0D   für Puffer 3
     $0E/$0F   für Puffer 4

Jedem Puffer sind zwei Speicherstellen zugeordnet, eine für den
Jobcode ($0000 bis $0004) und eine für Spur und Sektor. Wenn Sie also
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
     :0008 unverändert
     
Drücken Sie die RETURN-Taste, Mit `M03` kann jetzt der eingelesene
Blgck (hier der erste Directory-Block) eingesehen werden. Änderungen
können durch einfaches Überschreiben vorgenommen werden. Dauerhaft
wird Ihre Änderung erst durch Zurückschreiben (nach Spur $12 und
Sektor $01) mit dem Jobcode `90` in der ersten Speicherstelle. Nach
Änderung der beiden für Puffer 0 zuständigen Adressen ($06/$07) auch
an jede beliebige andere Stelle. Das ist wörtlich zu nehmen, denn wir
befinden uns hier `unterhalb` der Controllerebene, die unter anderem
für die Prüfung auf Einhaltung der zulässigen Spur und Sektorgrenzen
verantwortlich ist. Es erfolgt also keine Fehlermeldung, wenn Sie
versuchen sollten, mit Ihrer Floppy bis in die des Nachbarn zu
schreiben (zum Beispiel mit der Spur 152).

Entsprechende Lese- und Schreibübungen können mit den anderen Puffern
durchgeführt werden. Denken Sie daran, erst ist die Spur-
beziehungsweise Sektornummer für den entsprechenden Puffer (in der
zweiten Zeile!) einzugeben, bevor Sie in Zeile 1 den Jobcode mit einem
RETURN übergeben, denn mit Druck auf die RETURN-Taste wird Ihr Befehl
ausgeführt. Und noch eins: Quälen Sie bitte dabei Ihren Schreibkopf
nicht mehr als unbedingt erforderlich, sonst könnte er sich mechanisch
verklemmen und nur noch mit einem Eingriff in die Floppymechanik
wieder "befreit" werden.

Falls Sie die Ausgaben 1/85 (Seite 151) und 3/85 (Seite 103 bis 135)
der 64'er besitzen, können Sie sich dort über andere Speicherstellen
der Floppy und die weitere Anwendung der Jobcodes informieren.

Der Befehl @ ohne weitere Angaben fragt den Fehlerkanal ab, ansonsten
dient er zur Befehlsübermittlung an die Floppy.

Beispiel:

- `@`: Fehlerkanal
- `@I`: Initialisierungsbefehl
- `@S:name`: Befehl zum Scratchen

und so weiter.

Bedingt durch die verschiedenen Versionen, springt dieser Befehl
manchmal in den "normalen" Disketten-Monitor zurück, erkennbar an dem
`*` am Zeilenanfang. Sie müssen dann wieder ein `F` eingeben.

Mit `X` gelangt man wieder in den Disketten-Monitor.

Zum Abschluß ein sehr hilfreicher Befehl namens `V`, der es erlaubt,
Speicherbereiche aus dem Computer in den Laufwerkspuffer zu
verschieben. Folgende einfache Syntax gilt dabei: V von nach.

Um zum Beispiel ein Maschinenprogramm von $6000 in den Puffer 1 zu
bekommen, geben Sie folgendes ein:

    V 6000 0400
    
Dabei wird immer eine ganze Seite, also 256 Byte, übertragen. Was das
Programm dort soll, fragen Sie? Führen Sie es doch einfach aus
(Jobcode $D0 in Speicherstelle $01 schreiben); oder schreiben Sie es
mit dem Jobcode `90` in einen beliebigen Sektor der Diskette.

Wenn Sie dann Ihre Floppy so richtig durcheinandergebracht haben und
nichts läuft mehr, brauchen Sie nicht zu verzweifeln. Außer einem
eventuell festhängenden Lesekopf passiert der Floppy nichts, nur Ihren
Disketten.

## Hinweise zum Abtippen

Tippen Sie die beiden Erweiterungsprogramme (Listing 2 und 3 mit dem
MSE-Programm ab und speichern Sie die fertigen Programme.

Laden und starten Sie dann Ihren SMON $C000. Geben Sie ein:
`L"NDISASS"`

Damit werden die neuen Befehle automatisch über den bisherigen
Disketten-Monitor geladen. Sie müssen nun aber noch aktiviert
werden. Geben Sie dazu `G CF0D` ein.

SMON meldet sich sofort mit seiner Registeranzeige wieder. Sie sollten
nun diese Version unbedingt speichern, zum Beispiel mit `S"SMON
NDISASS" C000 CF3D`

Wenn Sie nun das Programm `ILLEGAL-CODE` (Listing 4) laden und mit D
4000 disassemblieren, sehen Sie die "illegalen" Opcodes schön geordnet
nacheinander.

Um die neuen Befehle des Disketten-Monitors in SMON einzubinden, gehen
Sie ganz ähnlich vor. Nach dem Abtippen und Speichern des Programms
`FLOPPYMON` muß natürlich SMON C000 geladen und gestartet
werden. Anschließend geben Sie ein: L "FLOPPYMON" und aktivieren es
mit `G CDD8`.

Zum Speichern geben Sie `S"SMON-FLOPPY" C000 CFFF` ein.

## SMON erweitern

Die zum Schluß vorgestellte Erweiterung stellt elf weitere Befehle für
den SMON zur Verfügung. So läßt sich der Monitor zum Beispiel frei im
Speicher verschieben und Sprites oder Zeichensätze können sehr einfach
erstellt und geändert werden.

Um die Befehlserweiterung zu initialisieren, geht man folgendermaßen vor:

1. SMON absolut laden und `NEW` eingeben.
2. Den Basic-Lader (Listing 5) eintippen und speichern.
3. Nach dem Start des Laders die Startadresse (dezimal) Ihrer SMON-Version eingeben: zum Beispiel 49152 (= $C000). 
4. Den erweiterten SMON zum Beispiel mit `S "SMONEX" Startadresse
   Endadresse` speichern.Die neuen Routinen werden, genau wie die
   meisten bereits vorhandenen, durch einen Buchstaben, zum Teil
   gefolgt von Adressenangaben, aufgerufen. Bei den ersten drei
   Ausgabebefehlen kann der Speicherinhalt durch Überschreiben der
   Zeile geändert werden.

### `Z 4000 (4100) (Zeichendaten)`

gibt den Speicherinhalt von $4000 (bis $40FF) folgendermaßen aus:
Jeweils ein Byte pro Zeile wird in 8-Bit-Form dargestellt. Dabei ist
ein `*` ein gesetztes, ein `.` dagegen ein nicht gesetztes Bit. Die
beiden Zeichen sind willkürlich gewählt und können durch Überschreiben
der Speicherzellen $xE65, $xE2D (Bit 1) und $xE69, $xE30 (Bit = 0) in
den Bildschirm-Code (!) der gewünschten Zeichen geändert werden.

Die Anwendung dieses Befehls liegt beispielsweise in der gezielten und
anschaulichen Beeinflussung bestimmter Steuerbits in VIC, CIA
etc. Andererseits lassen sich - besonders in Verbindung mit dem
Kommando `Q` - Zeichendaten leicht modifizieren.

### `H 4000` (4100)

entspricht dem Befehl `Z` mit dem Unterschied, daß jeweils drei Byte
pro Zeile ausgegeben werden. Das entspricht dem Format für
Spritedaten. Auf diese Weise steht mit dem erweiterten SMON ein
kleiner "Sprite-Editor" zur Verfügung.

### `N 4000` (4100) (Normaldarstellung)

interpretiert den Speicherinhalt von $4000 (bis $40FF) als
Bildschirm-Code und gibt 32 Zeichen pro Zeile aus.

### `U 4000` (4100) (Übersicht)

Wie `N`, jedoch werden in einer Zeile 40 Zeichen
dargestellt. Änderungen sind nur mit `N` möglich. Dieser Befehl dient
hauptsächlich dazu, im Speicher abgelegte Bildschirminformationen so
auszugeben, wie sie tatsächlich im 40-Zeichen/Zeile-Format aussehen
würden. Dieser Befehl ist recht nützlich, um professionelle
Videospiele zu analysieren, da hier Spielszenen oft im Bildschirm-Code
gespeichert sind.

### `E 4000` (4100) (Erase)

ist der bereits im 64'er, Ausgabe 2/85 vorgeschlagene Erase-Befehl zum
Füllen des Speicherbereiches von $4000 bis $40FF mit $00.

### `Y 40`

kopiert die vorhandene SMON-Version in nur drei Sekunden nach $4000
bis $4FFF und nimmt dabei alle notwendigen Anpassungen vor. Die
ursprüngliche Speicherversion des Monitors bleibt unverändert. Mit `G
4000` kann man in den neuen SMON springen. Von dem Byte-Wert, der
übergeben werden muß, wird nur das obere Nibble ($4) gewertet, so daß
sich theoretisch 16 SMON-Versionen im Speicher unterbringen lassen,
wobei natürlich nicht alle Möglichkeiten sinnvoll sind. Auf diese
Weise läßt sich stets die erforderliche Speicherversion herstellen,
ohne daß langwierige Änderungen notwendig sind.

### `Q 2000`

kopiert den Zeichensatz aus dem ROM von $D000 bis $DFFF in das RAM
nach $2000. Dort kann er mit dem Befehl `Z` nach Belieben geändert
werden. Möchte man zum Beispiel das Zeichen `A` in ein `Ä`
umdefinieren, so ist der Zeichensatz mit `Q 2000` ins RAM zu
kopieren. Anschließend kann mit `Z 2000 2015` der Bereich in binärer
Form auf dem Bildschirm ausgegeben werden, in dem auch das Zeichen `A`
steht. Dieses kann nun in ein `Ä` geändert werden, indem man mit dem
Cursor an die zu ändernde Stelle fährt und für einen Punkt, der
gesetzt werden soll, ein `*` und für einen Punkt der nicht gesetzt
werden soll ein `.` setzt. So, jetzt ist der Zeichensatz umdefiniert,
aber noch nicht aktiviert. Als nächstes muß dem Videocontroller die
Startadresse des neuen Zeichensatzes mitgeteilt werden. Dazu ist die
Adresse $D018, in der eine hexadezimale 15 steht, durch eine
hexadezimale 18 zu ersetzen.

### `J` (Wiederholung)

bringt den letzten Ausgabebefehl (K, D, M, Z, H, N, U) auf den
Bildschirm zurück. Mit RETURN wird der letzte Befehl noch einmal
ausgeführt.

#### Zum Schluß noch ein Tip:

DATA-Zeilen in Hex-Byte-Darstellung sind wegen ihrer konstanten Länge
(immer zwei Ziffern pro Wert!) übersichtlicher als solche mit
dezimalen Zahlen. Da für die Ausgabe von Hex-Werten bereits alle
Routinen im SMON integriert sind, kann der `B`-Befehl
(Basic-DATA-Zeilen erzeugen) durch Verändern eines einzigen
Sprungbefehles dahingehend manipuliert werden, daß der Speicherinhalt
künftig in Form von Hex-Byte ausgegeben wird:

Disassemblieren Sie dazu den Byte-Ausgabebefehl mit `D x99F` und
ersetzen `JSR BDDl` durch `JSR x32A`. Für das `x` muß der
4-KByte-Block, in dem die zu ändernde SMON-Version steht, eingesetzt
werden. Liegt Ihre SMON-Version bei $C000, so ersetzen Sie das `x`
durch ein `C`.

Die Gesamtlänge der DATA-Zeile kann außerdem durch Verändern der
Speicherzelle $x9AE variiert werden. Bei dem Wert $1C werden zum
Beispiel genau acht Hex-Byte pro Zeile ausgegeben. Das
Assembler-Listing zu dieser Erweiterung zeigt Listing 6.

*(Dietrich Weineck/Mark Richters/sk)*

## Befehlsübersicht zum SMON

Alle Eingaben erfolgen in der hexadezimalen Schreibweise. In Klammern
angegebene Adreßeingaben können entfallen. SMON benutzt dann
sinnvolle, vorgegebene Werte.

Bei allen Ausgabe-Befehlen ist gleichzeitig die Ausgabe auf einem
Drucker möglich. Dazu werden die Befehle geSHIFTet eingegeben.

- `A 4000` (Assembler)<br>
  symbolischer Assembler (Verarbeitung von Label möglich) Startadresse $4000
- `B 4000 4200` (Basic-Data)<br>
  erzeugt Basic-DATA-Zellen aus Maschinenprogramm im Bereich von $4000 bis $41FF
- `C 4010 4200 4013 4000 4200` (Convert)<br>
  in ein Programm, das von $4000 bis $4200 im Speicher steht, soll bei
  4010 ein 3-Byte-Befehl eingefügt werden. Dazu wird das Programm
  ab $4010 bis 4200 auf die neue Adresse $4013 verschoben. Alle
  absoluten Adressen, die innerhalb des Programmbereichs ($4000
  bis $4200) stehen, werden umgerechnet, so daß die Sprungziele
  stimmen.
- `D 4000` (4100) (Disassembler)<br>
  disassembliert den Bereich von $4090 (bis $4100) mit Ausgabe der Hex-Werte. 
  Änderungen sind durch Überschreiben der Befehle möglich.
- `F` (Find)<br>
  findet Zeichenketten (F), absolute Adressen (FA), relative Sprünge (FR),
  Tabellen (FT), Zeropageadressen (FZ) und Immediate-Befehle (FI)
- `G 4000` (Go)<br>
  startet ein Maschinenprogramm, das bei $4000 im Speicher beginnt
- `I 01` (I/O-Gerät)<br>
  stellt die Gerätenummer für Floppy (08 oder 09) oder Datasette (01) ein
- `K A000` (A500) (Kontrolle)<br>
  zum schnellen Durchsuchen des Bereichs von $A000 (bis $A500) nach ASCII-Zeichen 
  (32 Byte pro Zeile). Änderungen sind durch Überschreiben der ASCII-Zeichen möglich.
- `L` (4000) (Load)<br>
   lädt ein Maschinenprogramm an die richtige oder eine angegebene Adresse ($4000)
- `M 4000` (4400) (Memory-Dump)<br>
   gibt den Inhalt des Speichers von $4000 (bis $43FF) in Hex-Byte und ASCII-Code aus,
   Änderungen sind durch Überschreiben der Hex-Zahlen möglich.
- `O 4000 4500 AA` (Occupy)<br>
  füllt den Speicherbereich von $4000 bis $4500 mit vorgegebenem Byte ($AA) aus
- `P 05` (Printer)<br>
  setzt Geräteadresse 5 für Drucker
- `R` (Register)<br>
  zeigt die Registerinhalte und Flags an. Änderungen sind durch Überschreiben möglich.
- `S "Test" 4000 5000` (Save)<br>
  speichert ein Programm von $4000 bis $4FFF unter dem Namen `Test` ab
- `TW` (4000) (Trace Walk)<br>
  führt auf Tastendruck den jeweils nächsten Maschinenbefehl aus und zeigt die 
  Registerinhalte an. Subroutine können in Echtzeit durchlaufen werden (`J`). Wird keine 
  Startadresse eingegeben, beginnt `TW` bei der letzten mit `R` angezeigten Adresse.
- `TB 4010 05` (Trace Break)<br>
  setzt einen Haltepunkt für den Schnellschrittmodus bei $4010. Der Schnelischrittmodus 
  wird unterbrochen, nachdem $4010 zum fünften Mal erreicht worden ist.
- `TO 4000` (Trace quick)<br>
  Schnellschrittmodus, springt beim Erreichen eines Haltepunktes in den Einzelschrittmodus
- `TS 4000 4020` (Trace stop)<br>
  arbeitet ein Programm ab $4000 in Echtzeit ab und springt beim Erreichen von $4020 in die
  Registeranzeige. Von dort aus kann (nach eventueller Änderung der Register) mit `G` oder
  `TW` fortgefahren werden, `TS` arbeitet nur im RAM-Speicher.
- `V 6000 6200 4000 4100 4200` (Verschieben)<br>
  ändert in einem Programm von $4100 bis $41FF alle absoluten Adressen, die sich auf den 
  Bereich von $6000 bis $6200 beziehen, auf einen neuen Bereich, der bei $4000 beginnt.
- `W 4000 4300 5000` (Write)<br>
  verschiebt den Speicherinhalt von $4000 bis $42FF nach $5000 
  ohne Umrechnung der Adressen (zum Beispiel Tabellen)
- `X` (Exit)<br>
  springt aus dem Monitor-Programm ins Basic zurück 
- `# 49152`<br>
  Dezimalzahl umrechnen 
- `$ 002B`<br>
  4-stellige Hex-Zahl umrechnen
- `% 01101010`<br>
  8-stellige Binärzahl umrechnen
- `? 0344 + 5234`<br>
  Addition oder Subtraktion zweier 4stelliger Hex-Zahlen
- `= 4000 5000` (Vergleich)<br>
  vergleicht den Speicherinhalt ab $4000 mit dem ab $5000
- `Z` (Diskmonitor)<br>
   ruft den Diskmonitor auf. 
   Dieser verfügt über folgende Befehle:
    - `R` (12 01) (Read)<br>
      liest Track $12, Sektor $01 von der Diskette in einen Puffer im Speicher. 
      Fehlt die Angabe von Track und Sektor, wird der logisch (!) nächste Sektor gelesen.
    - `W` (12 01) (Write)<br>
      schreibt den Puffer im Speicher nach Track $12, Sektor $01 auf die Diskette. 
      Ohne Angabe von Track und Sektor werden die letzten Eingaben von `R` benutzt.
    - `M` (Memory-Dump)<br>
      zeigt den Pufferinhalt als Hexdump (wie normales `M`). Weitere Ausgabe mit CBM-Taste, 
      Abbruch mit STOP. Werte können durch Überschreiben geändert werden.
    - `X` (Exit)<br>
      springt in SMON zurück
    - `F`    (weitere Disketten-Befehle initialisieren)<br>
      sind die Befehle initialisiert, gilt:
          - `M (O7)`: Memory-Dump (Floppy-RAM/ROM)
          - `V 6000 0400`: Verschieben eines 256-Byte-Blocks von $6000 in den Laufwerkspuffer 1 
            beziehungsweise in das Fioppy-RAM
          - `@`: normale Disketten-Befehle senden
          - `X`: zurück zum normalen Disketten-Monitor

## SMON-Speicherstellen

Folgende Zeropage-Adressen werden benutzt:

    FLAG     $AA    Universalflag
    ADRCODE  $AB    Adressierungscode für Assembier/Disassembler
    COMMAND  $AC    SMON-Befehlscode
    BEFCODE  $AD    Befehlscode Ass./Disass.
    LOPER    $AE    Low-Operand für Ass./Disass.
    HOPER    $AF    High-Operand für Ass./Disass.
    BEFLEN   $B6    Befehlslänge Ass./Disass.
    PCL      $FB    SMON-Programmcounter Low-Byte
    PCH      $FC    SMON-Programmcounter High-Byte

Außerhalb der Zeropage benutzt SMON die Bereiche: 

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
    TRACEBUF $02B8  Buffer für Trace-Modus bis $02BF

Dann folgen die von Diskmonitor benötigten Adressen:
 
    SAVEX    $02C1  Zwischenspeicherung der X- und Y-Register
    TMPTRCK  $02C2
    TMPSECTO $02C3  Zwischenspeicher für Track und Sektor
    DCMDST   $02D0  Diskkommandostring
    TRACK    $02D8
    SECTO    $02DB  Track und Sektornummer
    BUFFER   $033C  Buffer für Label, nur für Assembler

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
