### Geometry Dash

Dit project omvat een spel dat specifiek is ontwikkeld voor de Basys 3, geïmplementeerd met behulp van de VHDL-taal. Het maakt gebruik van invoer van knoppen (voor spelbesturing) of een toetsenbord en schakelaar (reset) op de Basys 3, en toont de gegevens op zowel de 7-Segment Display als op een monitor die de VGA-standaard ondersteunt.

In dit spel heeft de gebruiker de controle over een bewegend object dat verticaal opereert, terwijl horizontaal bewegende balken moeten worden ontweken. De bediening van het object gebeurt via knoppen op de Basys 3 of via het toetsenbord. Zodra een van de knoppen wordt ingedrukt, beweegt het object met een constante snelheid omhoog of omlaag. Het object blijft in beweging, waardoor de gebruiker actief de controle moet behouden. Naarmate de tijd verstrijkt, stijgt de score van de gebruiker. Het spel eindigt wanneer het object een van de balken raakt of wanneer het de bovenste of onderste delen van het scherm bereikt. Op dat moment verschijnt er een melding op de monitor die het einde van het spel aankondigt. De score stopt ook met toenemen, zodat de gebruiker zijn eindscore kan zien.

Het spel is opgebouwd uit vijf modules: één voor de VGA-bediening, één voor de Button Debouncer, één voor de weergave met 7-segmenten op de Basys 3, een topmodule voor het toetsenbord, en één topmodule die tevens de spelmechanica omvat.


#### Basys 3 Board
- Family: Artix-7
- Package: cpg236
- Speed grade: -1
- Part number: xc7a35tcpg236-1
- Config flash part number: S25FL032
 