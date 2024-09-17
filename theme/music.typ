#import "@preview/chordx:0.4.0": *
#import "@preview/cetz:0.2.2": *

#let chart-chord = chart-chord.with(size: 2em, design: "round")

#let chordsData = (
  Am: ( fingers: "nn231nnn", tabs: "xo231o"),
  A: ( fingers: "nn23nnn", tabs: "oo23oo"),
  E: ( fingers: "n231nnn", tabs: "o231oo"),
  Dm: ( fingers: "nnn231", tabs: "xxo231"),
  D7: ( fingers: "nnn213", tabs: "xxo213"),
  G: ( fingers: "21nn34", tabs: "32oo33") 
)

#let drawChord(name) = {
  let data = chordsData.at(name)
  chart-chord(..data, name)
}

#let drawCompass = place(left, [
  $4$\
  $4$  
])

#let tickSeparation = 1.75em

#let chartLine(position, width: 1pt) =  place(left + top, {
  line(start: (position, -0.125em), end: (position, 70%), stroke: width)
})

#let drawTicks(tickNumber) = {
  return range(0, tickNumber).map(tick => {
    let distance = tick*tickSeparation + 1.5em
    place(left + top, dx: distance, dy: 1.5em, [
      #set text(size: 0.75em)
      #(calc.rem(tick, 4) + 1)
    ])
  }).join()
}

#let drawCompassDivisions(spaces) = {
  return range(0, calc.floor(spaces/4)-1).map(division => [
    #let xStart = (division + 1)*tickSeparation*4 + tickSeparation*0.5
    #place(left + top, {
     chartLine(xStart)
    })
  ]).join([])
}

#let drawFinalBar(spaces) = {
  let xDistance = spaces*tickSeparation + 1em
  place(left + top, dx: xDistance, dy: 12.5%, [
    #circle(radius: 0.125em, fill: color.black)
    #v(-0.5em)
    #circle(radius: 0.125em, fill: color.black)
  ])
  chartLine(xDistance + 0.5em, width: 2pt)
  chartLine(xDistance + 0.75em, width: 2pt)
}

#let drawNotes(notes) = {
  let noteDisplacement = state("noteDisplacement", 1.5)
  let notesRender = notes.fold((1.25em, []), (value, tuple) => {
    let newDisplacement = value.at(0) + tuple.at(1)*tickSeparation
    let newContent = value.at(1) + [
      #place(left + top, dx: value.at(0), [
        #text(size: 1em, tuple.at(0))
      ])
    ]
    return (newDisplacement, newContent)
  })

  return notesRender.at(1)
}

#let beatDiagram(notes) = {
  let spaces = notes.map(note => note.at(1)).sum()
  assert(calc.rem(spaces, 4) == 0)
  
  box(height: 3em, width: 100%)[

    #drawCompass
    #drawTicks(spaces)
    #drawCompassDivisions(spaces)
    #drawFinalBar(spaces)
    #drawNotes(notes)
  ]
  v(2em)
}

