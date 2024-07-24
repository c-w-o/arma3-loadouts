# donesnal

## Features
Für die Spieler:
- Loadout Auswahl über ACE Menu
- Auswahl von verschiedenen Tarnfarben (Fleck/Wald, Multi/Gras, Tropen/Sand, Schnee)
- Auswahl von regulärer und verdeckter Operation (verdeckt ist mit Schalldämpfer und Nachtsichausrüstung)

Für den Verwalter:
- Alle Loadouts basieren auf einer einheitlichen Basis - was alle betrifft kann mit einer Zeile geändert werden.
- Waffensets (mit/ohne Tarnungen und mit/ohne verdeckter Option) können angelegt werden.

## Konzept

Das Loadout File besteht aus vier Abschnitten.
1. Waffensets - weil diese mit ihren Tarnungen, Attachments und Munition recht komplex sind
2. Standard Loadout - Legt Uniform, Brille, Weste, Rucksack, Waffen, Tools und Ausrüstungsgegenstände fest
3. Eine Liste von Funktionen um jede Klasse extra anpassen zu können, z.B. in dem man einem Sani eine Uniform mit einem rotem Kreuz gibt. So eine Funktion ist Pflicht, selbst wenn man nichts anpasst.
4. Das Festlegen des ACE Menübaums.

Das Grundkonzept ist, dass alles was an einem Loadout gleich ist so wenig wie möglich angelegt
werden muss. Das Gegenteil von diesem Konzept ist das  der Loadouts mit den exportiertierten
Inhaltes des Arsenals:

Das bisherige Vorgehen war das Management der Loadouts über einzelne Files der Klassen. Dabei
wurden über das Arsenal die Loadouts erzeugt und als File seiner Klasse abgespeichert. Jede
Anpassung musste im schlimmsten Fall in jedem einzelnen File gemacht werden. Bei 25 Loadouts und
je einer Spezialvariante waren dies bereits 50 Files. Würde man noch die 4 Tarnungen mitnehmen,
die hier möglich sind, wären es 200 Files. Das ist händisch fast unmöglich zu machen.

Dieses Loadout Script ist praktisch das Gegenteil vom bisherigen Vorgehen: Alles was gleich ist,
was mehr als eine Klasse betrifft oder wiederverwendet werden kann, wird herausgezogen, einmalig
angelegt und dann nur noch darauf verwiesen.

Als Beispiel das "erzeugen" eines Sanitäters und eines Funkers - als Konzept, nicht im Script (das
sind leider zwei Dinge):
```
                                                                   
                             ┌─────┐                               
                             │ G38 ├────┐                          
                             └─────┘    │                          
                                      ┌─▼───────┐                  
                                      │ default │                  
                                      │ loadout │                  
                                      └───┬──┬──┘                  
                                          │  │                     
                    ┌──────┐              │  │                     
                    │ G38C ├────┐  ┌──────┘  └────────┐            
                    └──────┘    │  │                  │             
                                │  │                  │            
                             ┌──▼──▼─────┐      ┌─────▼─────┐      
                             │  Leichte  │      │ Infantrie │      
                             │ Infantrie │      │           │      
                             └────┬──────┘      └───────────┘      
  ┌───────────┐                   │                                
  │  Rucksack │        ┌──────────┴─────┐           ┌───────────┐  
  │ mit Medic ├─────┐  │                │  ┌────────┤ Funkgerät │  
  └───────────┘     │  │                │  │        └───────────┘  
                 ┌──▼──▼─────┐      ┌───▼──▼─┐                     
                 │ Sanitäter │      │ Funker │                     
                 │           │      │        │                     
                 └───────────┘      └────────┘                     
```
Wir nehmen an, dass sich eine "Leichte Infantrie" nur durch die Kompaktversion des G38 auszeichnet,
also ersetzen wir für "Leichte Infantrie" die Primärwaffe "G38" mit der "G38C". Ein Sanitäter
gehört für uns zur "Leichten Infantrie" und hat aus Gewichtsgründen ein G38C. Weiterhin
unterscheidet er sich von allen anderen durch einen Rucksack in dem sich sehr viel medizinisches
Material befindet - also tauschen wir den "Inhalt" des Rucksacks. Beim Funker ist es ähnlich dem
Medic, nur dass wir statt dem Inhalt des Rucksacks, den Rucksack selbst gegen ein Funkgerät
tauschen.

## Minimalwissen Scripting

Die ArmA Scripting Language (ASL) hat zwei Datentypen, die sich für dieses Loadout Script besonders
gut eignen: Arrays und Hashmaps. Arrays sind relativ bekannt, sie sind im Wesentlichen eine
Aneinanderreihung von anderen Datentypen, auf die mit einem Index zugeriffen werden kann. In ASL
sieht da so aus:
```
private _my_array=["Abc", 1, "def"];
private _value=_my_array select 2;  // speichert "def" in _value;
```
Wichtig sind hier drei Punkte: 
1. Ein Array wird immer von "[ ]" (eckigen Klammern) umschlossen.
2. Die Elemente des Arrays werden immer durch "," (Komma) getrennt.
3. Nach dem letzen Element darf __kein__ Komma mehr kommen.

Der zweite Datentype ist die Hashmap (in Python würde man es Dictionary nennen) - im Prinzip ein
ganz spezielles Array mit genau zwei Elementen. Das erste Element ist ein String, ein Bezeichner
und das zweite Element ist irgendetwas, zum Beispiel wieder ein Array - also beliebig verschachtelt.

Beispiel des Waffensets "_handgun_P12":

```
private _handgun_P12=createHashMapFromArray [                                       
  ["special",     createHashMapFromArray [                        
    ["type",     "BWA3_P12"],                                     
    ["attachments", [ "BWA3_acc_LLMPI_irlaser", "BWA3_muzzle_snds_Impuls_IIA" ]],
    ["ammo",   [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]                  
  ]],
  ["regular",     createHashMapFromArray [                        
    ["type",     "BWA3_P12"],                                     
    ["attachments", [ "BWA3_acc_LLMPI_irlaser" ]],                
    ["ammo",   [ [3, "BWA3_12Rnd_45ACP_P12"] ]]                   
  ]]
];

```
Im Einzelnen:
1. der Variable "_handgun_P12" wird eine Hashmap aus dem Array '[ ["special", \<irgendwas\>], ["regular", \<irgendwas\>]]' erzeugt.
2. jedes \<irgendwas\> besteht wieder aus einer Hashmap '[ ["type", \<Waffenname\>], ["attachments", \<array_von_attachments\>], ["ammo", \<array_von_ammo\>]]'
3. das \<array_von_attachments\> ist dann eine Auflistung aller angebauten Attachments
4. das \<array_von_ammo\> ist wiederrum ein Array, welches die Anzahl der Magazine und deren Typ bezeichnet.
5. 
Kurz: eine Verschachtelung von eckigen Klammern und manchmal dem Wort "createHashMapFromArray". Wann was
genau anzuwenden ist, ist vom Script festgelegt, denn es muss es an dieser Stelle auch interpretieren können.


## Das Loadout

### 1. Waffensets

#### Aufbau
Das minimale Waffenset besteht aus drei Elementen: Waffentyp, Attachments (kann leer sein) und
der Munition.

Minimal:
```
private _handgun_p12=createHashMapFromArray [
    ["type", "BWA3_P12" ],
    ["attachments", [] ],
    ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
];

```
Waffe P12, keine Anbauten und 3 Standardmagazine. Keine unterschiedlichen Tarnfarben, keine
Spezialvariante.

Mit Laserpointer Attachment:
```
private _handgun_p12=createHashMapFromArray [
    ["type", "BWA3_P12" ],
    ["attachments", ["BWA3_acc_LLMPI_irlaser"] ],
    ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
];

```
Waffe P12, Laserpointer und 3 Standardmagazine. Keine unterschiedlichen Tarnfarben, keine
Spezialvariante.

Mit Laserpointer Attachment:
```
private _handgun_p12=createHashMapFromArray [
    ["type", "BWA3_P12" ],
    ["attachments", ["BWA3_acc_LLMPI_irlaser"] ],
    ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
];

```
Waffe P12, Laserpointer und 3 Standardmagazine. Keine unterschiedlichen Tarnfarben, keine
Spezialvariante.

Mit Laserpointer Attachment in 4 Tarnungen (Achtung, diese Items gibt es nicht wirklich, ist nur
zur Demonstration):
```
private _handgun_p12=createHashMapFromArray [
    ["type", "BWA3_P12" ],
    ["attachments", [ [ "BWA3_acc_LLMPI_irlaser",
                        "BWA3_acc_LLMPI_irlaser_multi",
                        "BWA3_acc_LLMPI_irlaser_tan",
                        "BWA3_acc_LLMPI_irlaser_snow"] ] ],
    ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
];

```
Waffe P12, Laserpointer in 4 Tarnungen und 3 Standardmagazine. Keine unterschiedlichen Tarnfarben
für die Waffe, keine Spezialvariante. Bitte beachten, aus dem String ' "BWA3_acc_LLMPI_irlaser" '
wird ein Array ' [ "", "", "", "" ] '


Mit verdeckter Option, Laserpointer Attachment in 4 Tarnungen (Achtung, diese Items gibt es nicht
wirklich, ist nur zur Demonstration):
```
private _handgun_p12=createHashMapFromArray [
    ["regular",     createHashMapFromArray [
        ["type", "BWA3_P12" ],
        ["attachments", [ "BWA3_acc_LLMPI_irlaser",
                          "BWA3_acc_LLMPI_irlaser_multi",
                          "BWA3_acc_LLMPI_irlaser_tan",
                          "BWA3_acc_LLMPI_irlaser_snow"] ],
        ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
    ],[
        ["type", "BWA3_P12" ],
        ["attachments", [ "BWA3_muzzle_snds_Impuls_IIA",
                          [ "BWA3_acc_LLMPI_irlaser",
                            "BWA3_acc_LLMPI_irlaser_multi",
                            "BWA3_acc_LLMPI_irlaser_tan",
                            "BWA3_acc_LLMPI_irlaser_snow"] ]
        ],
        ["ammo", [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]
    ]
];

```
Waffe P12, Laserpointer in 4 Tarnungen und 3 Standardmagazine. Keine unterschiedlichen Tarnfarben
für die Waffe, Spezialversion hat nur Schalldämpfer ohne Tarnungen.

> Merke: Bei "type" und "attachment" kommt immer nur ein String oder ein Array aus 4 Elementen 
> rein. Array aus 4 Elementen sind die 4 Tarnungen. Es gibt keine Pflicht, dass bei der Regulären- 
> und der Sepzialvariante die gleiche Waffe drin stehen muss. Es gibt auch keine Pflicht, dass die 
> 4 Waffen bei den Tarnungen gleich sein müssen. Aber die Attachments und Munition muss immer
> jeweils kompatibel sein.


#### Woher kommen diese Infos?
Wenn es um einzelne Items geht, dann sieht man im Arsenal als Mouse-hover Effekt meist die interne
Spielbezeichnung (wie BWA3_P12 für die P12). Ansonsten ein Loadout exportieren und sich die Werte
heraus kopieren.

```
hier Beispiel einfügen
```

### 2. Standard Loadout

Das Standard Loadout legt fest was alle Klassen gemeinsam haben sollen (oder zumindest der großteil
der Klassen). Jedes Element kann einzeln erweitert, überschrieben werden oder gelöscht werden. Aber
wenn man nichts macht, hat man zumindest immer das gleiche Loadout schon mal zur Verfügung.

```
// wenn etwas weggelassen werden soll, einfach "nil" eintragen.
private _default_loadout=createHashMapFromArray [
    [ "goggles",            "" ],   // Brillen, ein String oder ein Array mit den Tarnungen
    [ "helmet",             "" ],   // Helm, ein String oder ein Array mit den Tarnungen
    [ "uniform",            "" ],   // Uniform, ein String oder ein Array mit den Tarnungen
    [ "vest",               "" ],   // Weste, ein String oder ein Array mit den Tarnungen
    [ "backpack",           "" ],   // Rucksack, ein String oder ein Array mit den Tarnungen
    [ "nightvision",        nil ],   // Nachtsicht, nur ein String!

    [ "handgun",            [] ],   // Pistole, siehe Waffenset. Kann auch eine Variable sein.
    [ "primary",            [] ],   // Primärwaffe (Gewehr), Waffenset, kann eine Variable sein.
    [ "secondary",          [] ],   // Sekundärwaffe (zb. Panzerfaust), siehe Waffenset.
    [ "binoculars",         "" ],   // Fernglas, nur ein String!
    [ "tools",              [] ],   // Tools wie Karte, Kompass, etc. Immer ein Array!

    [ "uniform_content",    [] ],   // ein Array von 2-Elementen Arrays für Anzahl und Typ
    [ "vest_content",       [] ],   // ein Array von 2-Elementen Arrays für Anzahl und Typ
    [ "backpack_conten",    [] ]    // ein Array von 2-Elementen Arrays für Anzahl und Typ
];

```

Beispiel für den Inhalt der Uniform - Die Munition wird separat über das Waffenset gesteuert. Hier
sind die Ohrstöpsel, die Banane, etwas Medizinisches Zeug und anderes.
```
private _default_uniform_content=[
    [ 1, "ACE_EarPlugs" ],
    [ 1, "ACE_Banana" ], 
    [ 1, "acex_intelitems_notepad"],
    [ 1, "ACE_Flashlight_KSF1" ],
    [ 3, "ACE_CableTie" ],
    [ 2, "ACE_morphine" ],
    [ 1, "ACE_tourniquet" ],
    [ 2, "ACE_morphine" ],
    [15, "ACE_fieldDressing" ]
];
```

### 3. Klassenspezifische Funktion

Für __jede__ Klasse muss eine Funktion existieren, welche Detailanpassungen ermöglicht. Es ist
(theoretisch) möglich, für verschiedene Klassen die gleiche Funktion zu verwenden - sofern es Sinn
macht. Beispielsweise aus RP Gründen könnte ein Truppenführer und ein Gruppenführer das exakt
identische Loadout haben - dann nimmt man die gleiche Funktion. Aber wenn der Gruppenführer nur
eine coolere Brille als einzigen Unterschied hätte, dann kann die Funktion des Gruppenführers die
Funktion des Truppführers aufrufen, sich dessen Loadout holen und nur noch die Brille ändern.

Tatsächlich ist es aktuell so ähnlich umgesetzt, der Truppführer ändert die Primärwaffe auf die
G38C, ersetzt die Tools mit einem anderen Funkgerät, dem Tablet und einer Uhr, fügt ein Fernglas
hinzu und tauscht die Brille aus. In den Rucksack kommt noch zusätzlich ein HunterIR Monitor und
die Weste ersetzen wir mit "Leader" Version. Alles andere ist noch mit dem _default_loadout
identisch.
```
fcn_Truppfueher={
  params ["_in_loadout"];
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G38C ];                   /* Mit der Kompaktversion ersetzen */
  _loadout set ["tools", [  "ItemMap", "ItemCompass",
                            "ItemWatch", "TFAR_anprc152", 
                            "ItemAndroid"]];                  /* leicht andere Tools */  
  _loadout set ["binocular", "ACE_Vector"];                   /* VectorIV Fernglas */
  _loadout set ["goggles", ["G_Tactical_Clear",
                            "G_Tactical_Clear",
                            "G_Tactical_Black",
                            "G_Balaclava_Tropentarn"]];
   
  private _bp=_loadout get "backpack_content";                /* ok, Nerd-Variante: Wir holen uns
                                                                 das Array des Rucksackinhalts*/
  _bp append [[ 1, "ACE_HuntIR_monitor"]];                    /* dann hängen das HunterIR an */
  _loadout set ["backpack_content", _bp];                     /* und schreiben es zurück. */
  
  _loadout set [ "vest", [  "BWA3_Vest_JPC_Leader_Fleck",
                            "BWA3_Vest_JPC_Leader_Multi",
                            "BWA3_Vest_JPC_Leader_Tropen",
                            "TBW_Weste_Schnee"]];             /* wir ersetzen mit die Weste JPC
                                                                 Leader in den vier Tarnungen */

  _loadout;  /* Rückgabe des Loadouts */
};

```

Für die Truppenführer-Klasse mit dem Langstrecken-Funkgerät nehmen wir uns den normalen
Truppenführer als Basis und tauschen nur den Rucksack (nicht dessen Inhalt) aus:
```
fcn_TruppfueherFunk={
  params ["_in_loadout"];
  
  private _loadout = [_in_loadout] call fcn_Truppfueher;      /* ist erstmal das gleiche wie
                                                                 der Truppführer */
  _loadout set ["backpack", [ "TFAR_rt1523g_bwmod",
                              "TFAR_rt1523g_bwmod",
                              "TFAR_rt1523g",
                              "TFAR_rt1523g" ]];              /* Rucksack durch Langstrecken-Funk
                                                                 tauschen (4 Tarnungen) */

  _loadout;  /* Rückgabe des Loadouts */
};
```

Für die Gruppenführer und Gruppenführer mit Langstrecken-Funk nehmen wir tatsächlich genau diese
Trupp-Versionen als Basis, bis uns mal einfällt was da anders sein könnte:
```
fcn_Gruppenfueher={
  params ["_in_loadout"];

  /* ist erstmal das gleiche wie der Truppführer */
  private _loadout = [_in_loadout] call fcn_Truppfueher; 

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_GruppenfueherFunk={
  params ["_in_loadout"];

  /* ist erstmal das gleiche wie der TruppführerFunk */
  private _loadout = [_in_loadout] call fcn_TruppfueherFunk; 

  _loadout;  /* Rückgabe des Loadouts */
};

```

Für einen einfachen ("leichten") Schützen können wir die Weste tauschen (da es eine extra für
Schützen gibt) und packen in den Rucksack etwas extra Munition und ein paar Wasserflaschen zum 
ühlen des Gewehrs:
```
fcn_Schuetze_Leicht={
  params ["_in_loadout"];
  private _loadout = _in_loadout;
  _loadout set ["vest", [ "BWA3_Vest_Rifleman_Fleck", 
                          "BWA3_Vest_Rifleman_Multi",
                          "BWA3_Vest_Rifleman_Tropen",
                          "TBW_Weste_Schnee"]];         /* Weste tauschen */
  
  private _bp=_loadout get "backpack_content";          /* default Rucksack Inhalt holen */
  _bp append [[ 12, "__extra_primary_ammo" ],           /* die default Munition hinzufügen
                                                           (Spezialvariable von mir, wenn man das
                                                           Waffenset tauscht muss man nix machen) */
        [ 3, "ACE_WaterBottle"]                         /* 3 Wasserflaschen zum Kühlen des Laufs */
        ];
  _loadout set ["backpack_content", _bp];               /* default Rucksack Inhalt überschreiben */

  _loadout;  /* Rückgabe des Loadouts */
};
```
Die absolute minimal-Funktion, die für eine jede Klasse existieren muss - selbst wenn man
nichts verändern möchte, sieht so aus:
```
fcn_minimal_funktion={
  params ["_in_loadout"];
  private _loadout = _in_loadout;
  _loadout;  /* Rückgabe des Loadouts */
};
```
Diese Minimalfunktion muss einen Parameter namens "_in_loadout" erwarten, da dieser vom Script
übergeben werden will. Die "Umbenennung" der Variable von "_in_loadout" zu "_loadout" kann man
theoretisch weg lassen und ohne diese Zeile direkt "_in_loadout;" zurück geben. Aber wenn man 
Anpassunge vornimmt, finde ich es übersichtlicher, wenn diese beiden Variablen unterschiedlich
benamnt sind. Bei größeren Anpassungen möchte man vielleicht die Variable kopieren (was in ASL mit
einem "private _loadout = __+__ _in_loadout;" erfolgt.) und man so für alle Funktionen eine
einheitliche Optik erhält.


### 4. ACE Menübaum
Auch hier komen die Arrays und Hashmaps wieder zum Einsatz: Sofern man mehr als einen einzigen
Menüeintrag hinzufügen will, wird als erstes eine Hashmap angelegt. Alle Namen (Identifier, Keys)
der Hashmap werden zu einem Menüpunkt, die Aktion kommt aus dem zweiten Teil.
1. Wenn es eine Funktion ist, muss es eine für das spezialisieren der Klasse sein.
2. Wenn es eine Hashmap ist, wird ein Untermenü angelegt.
3. Für Sonderfälle kann es ein Array mit einer Funktion und einem Parameter sein. Wird z.B. für die Tarnfarbe oder den Operationsmodus verwendet.

Beispiel: 
```
private _unit_classes=createHashMapFromArray [          /* root element */
    [ "Leichte Infantrie", createHashMapFromArray [     /* erster Level */
        ["Truppführer", createHashMapFromArray [        /* zweiter Level */
            [ "Rucksack", fcn_Truppfueher],             /* dritter Level, wird tatsächlich die
                                                           Loadout Funktion ausführen */
            [ "Langstreckenfunk", fcn_TruppfueherFunk]  /* dritter Level, wird tatsächlich die
                                                           Loadout Funktion ausführen */
        ]],
        ["Gruppenführer", createHashMapFromArray [      /* zweiter Level */
            [ "Rucksack", fcn_Gruppenfueher],           /* dritter Level, wird tatsächlich die
                                                           Loadout Funktion ausführen */
            [ "Langstreckenfunk", fcn_GruppenfueherFunk]  /* dritter Level, wird tatsächlich die
                                                             Loadout Funktion ausführen */
        ]],
        ["Sanitäter", fcn_Sanitaeter],                  /* zweiter Level, wird tatsächlich die
                                                           Loadout Funktion ausführen */
        ["Funker", fcn_Funker]                          /* zweiter Level, wird tatsächlich die
                                                           Loadout Funktion ausführen */
 ]];
];
```
