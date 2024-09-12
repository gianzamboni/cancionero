#import "theme/project.typ": *;

#pagebreak()
== Notas
#v(2em)
#align(center)[
#table(
  columns: 2, 
  rows: auto,
  table.header([Inglés], [Latino]))[A][La][B][Si][C][Do][D][Re][E][Mi][F][Fa][G][Sol]
]

#image("assets/notas-guitarra.png")

#pagebreak()
== Acordes
#v(2em)
#set align(center)
#grid(columns: (1fr, 1fr, 1fr),
gutter: 2em,
..chordsData.keys().map(drawChord)
)