#import "theme.typ": *;

= Acordes

#let Am-Chord = chart-chord(tabs:"xo231o", fingers:"nn231nn")[
  A_m #v(0.01em) Lam
]
#let E-Chord = chart-chord(tabs:"o231oo", fingers:"n231nnn")[E]
#let Dm-Chord = chart-chord(tabs:"xxo231", fingers:"nnn231")[Dm]

// Do re mi fa sol la si
#table(columns: (1fr, 2fr, 3fr),
  inset: 1em,
  align: horizon,
  table.header([*Acorde*], [*Nombre inglés*], [*Guitarra*]),
)