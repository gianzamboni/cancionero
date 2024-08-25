#import "theme/project.typ": *;

#pagebreak()
== Acordes
=== Guitarra
#set align(center)
#let Am-Chord = chart-chord(tabs:"xo231o", fingers:"nn231nn")[
  #chordText[Am #v(0.01em) Lam]
]

#let A-Chord = chart-chord(tabs:"oo23oo", fingers:"nn23nnn")[#text(size: 16pt)[A / La]]
#let E-Chord = chart-chord(tabs:"o231oo", fingers:"n231nnn")[E / Mi]
#let Dm-Chord = chart-chord(tabs:"xxo231", fingers:"nnn231")[Dm]

// Do re mi fa sol la si
#grid(columns: (1fr, 1fr, 1fr),
gutter: 2em,
  [#Am-Chord],
  [#A-Chord],
  [#E-Chord],
  [#Dm-Chord],
)