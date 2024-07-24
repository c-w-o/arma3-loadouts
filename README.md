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
3. Eine Liste von Funktionen um jede Klasse extra anpassen zu können, z.B. in dem man einem Sani eine Uniform mit einem rotem Kreuz gibt.
4. Das Festlegen des ACE Menübaums.

Das Grundkonzept ist, dass alles was an einem Loadout gleich ist so wenig wie möglich angelegt werden muss. Das Gegenteil
von diesem Konzept ist das Management der Loadouts mit den exportiertierten Inhaltes des Arsenals:

Das bisherige Vorgehen war das Management der Loadouts über einzelne Files der Klassen. Dabei wurden über das Arsenal
die Loadouts erzeugt und als File seiner Klasse abgespeichert. Jede Anpassung musste im schlimmsten Fall in jedem
einzelnen File gemacht werden. Bei 25 Loadouts und je einer Spezialvariante waren dies bereits 50 Files. Würde man
noch die 4 Tarnungen mitnehmen, die hier möglich sind, wären es 200 Files. Das ist händisch fast unmöglich zu machen.

Dieses Loadout Script ist praktisch das Gegenteil vom bisherigen Vorgehen: Alles was gleich ist, was mehr als eine
Klasse betrifft oder wiederverwendet werden kann, wird herausgezogen, einmalig angelegt und dann nur noch darauf
verwiesen.

Als Beispiel das "erzeugen" eines Sanitäters und eines Funkers - als Konzept, nicht im Script (das sind leider zwei Dinge):
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
Wir nehmen an, dass sich eine "Leichte Infantrie" nur durch die Kompaktversion des G38 auszeichnet, also ersetzen wir
für "Leichte Infantrie" die Primärwaffe "G38" mit der "G38C".
Ein Sanitäter gehört für uns zur "Leichten Infantrie" und hat aus Gewichtsgründen ein G38C. Weiterhin unterscheidet er
sich von allen anderen durch einen Rucksack in dem sich sehr viel medizinisches Material befindet - also tauschen wir
den "Inhalt" des Rucksacks. Beim Funker ist es ähnlich dem Medic, nur dass wir statt dem Inhalt des Rucksacks, den
Rucksack selbst gegen ein Funkgerät tauschen.
