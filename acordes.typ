#import "theme/music.typ": *;
#set align(center)

== Notas musicales
=== Guitarra
#grid(columns: (1fr, 2.5fr), inset: 0.75em)[
  #table(
    columns: 2, 
    rows: auto,
    table.header([Inglés], [Latino]))[A][La][B][Si][C][Do][D][Re][E][Mi][F][Fa][G][Sol]
][
#image("assets/notas-guitarra.png")
]

== Acordes
=== Guitarra
#grid(columns: (1fr, 1fr, 1fr), 
 row-gutter: 1em,
 ..chordsData.keys().map(drawChord)
)

#pagebreak()
=== Ejercicios
#set align(left)
#v(2em)
#beatDiagram((("G", 4), ("Am", 4), ("D7", 4), ("G", 4)))

#beatDiagram((("G", 4), ("Am", 2), ("D7", 2)))