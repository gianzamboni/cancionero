#import "@preview/cetz:0.2.1"
#import "@preview/chordx:0.4.0": *

#let docFontSize = 12pt

#let chart-chord = chart-chord.with(size: 2em, design: "round")
#let chord = single-chord.with(
  font: "Arial", 
  size: 10pt, 
  weight: "semibold", 
  background: color.silver)

#let headNumber(loc) = {
  let levels = counter(heading).at(loc)
  levels.map(str).join(".") 
}

#let headFormatter(it) = {
locate(loc => {    
    set text(font: "Rancho")
    if(it.level == 1){
      pagebreak(weak: true)
      if(it == "Índice") {
        set text(size: 32pt)
        it.body
      } else {
        align(center + horizon)[
          #text(font: "Rancho", weight: 700, 72pt, it.body)
        ]
        pagebreak()
      }
    } else if(it.level == 2) {
      set text(size: 22pt)
      it.body
      v(-1.125em)
      line(length: 100%, stroke: 1pt)
    } else if(it.level == 3) {
      set text(size: 12pt)
      v(-0.75em)
      align(right)[#it.body]
      v(-0.75em)
    } else {
      set text(size: 12pt)
      v(-0.75em)
      it.body
    }
  })
}


#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.

  set document(
    author: authors, 
    title: title
  )

  set page(paper: "a4", margin: (
    x: 2cm,
    y: 1.5cm
  ))

  set text(size: docFontSize, font: "Arial")
  show strong: set text(font: "Rancho")
  set table(
    fill: (x, y) =>
      if y == 0 {
        gray.lighten(40%)
      },
    align: right,
  )

  show table.cell.where(y: 0): strong


  show heading: headFormatter
  // Title row.
  align(center + horizon)[
    #text(font: "Rancho", weight: 700, 72pt, title)
  ]
  // Main body.
  show par: set block(spacing: 3em)
  set par(first-line-indent: 0em, leading: 1.75em)
  body
}

#let newVerse = v(1em)

#let write(coord, text) = {
  import cetz.draw: *

  content(coord, [
    #set align(center)
    #text
  ])
}

#let centerBox(body) = [
  #set align(center)
  #body
]

#let parseSongBodyWithoutChords(body) = {
  let parsed = body.children.map((element) => {
      if element == [ ] {
        linebreak()
      } else {
        element
      }
    })
  parsed.remove(0)
  return parsed
}

#let nonChordSong(body) = [
  #let parsed = parseSongBodyWithoutChords(body)
  #columns(2, gutter: 1em)[
    #parsed.join("")
  ]
]

#let parseSongBodyWithChords(body) = {
  let verses = body.children.split(parbreak())
  let parsed = ()
  parsed.push(verses.at(0))
  
  let counter = 1
  while counter < verses.len() {
    let verse = verses.at(counter)
    let shouldAddSpace = verse
      .filter(elem => elem != [ ])
      .filter(elem => elem.fields() == (:)).len() == 0

    parsed.push(linebreak())
    if(shouldAddSpace and verse.at(0) != [stanza]) {
      parsed.push(v(-1em))
    }

    if(verse.at(0) != [stanza]) {
      parsed.push(verse)
    } else {
      parsed.push(v(-2em))
    }

    counter = counter + 1
  }
  parsed = parsed.flatten()
  parsed.remove(0)
  return parsed
}

#let chordSong(body) = [
  #set par(leading: 0.5em)
  #let parsed = parseSongBodyWithChords(body) 
  #columns(2, gutter: 1em)[
    #parsed.join("")
  ]
]

#let cancion(title, artist, withCords: false, body) = [
  #set par(first-line-indent: 0pt)
  == #title
  === #artist
  #if withCords {
    chordSong(body)
  } else {
    nonChordSong(body)
  }
  
  #pagebreak()
]

#let seccion(name) = text(size: 10pt, weight: "bold", font: "Arial", fill: rgb(255, 0, 0))[*\[#name\]*]

#let new-stanza = "stanza"

#let chordText(body) = [
  #set text(size: 16pt)
  #body
]

#let create-cord(tabs, fingers, body) = chart-chord(tabs: tabs, fingers: fingers)[
  #chordText[#body]
]

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
  create-cord(data.tabs, data.fingers, name)
}

#let tipoRasgeos = (
  p: text(size: 13pt, baseline: -2.5pt)[#sym.arrow.b],
  r: text(size: 16pt)[#sym.arrow.b.triple]
)

#let rasgeo(..rasgeos) = {
  let parsed = rasgeos.pos().map((rasgeo) => {
    tipoRasgeos.at(rasgeo)
  })
  [*Rasgeo* #parsed.join("")]
}

#let seconds(tuple) = tuple.at(1)

#let niveles(..notas) = {
  let levels = notas.pos().map(seconds)
  let spacing = 1 / calc.max(..levels)

  let parsed = notas.pos().map((nota) => {
    let altura = (-1 - nota.at(1)*spacing)*1em
    overline(offset: altura )[#nota.at(0)]
  })
  parsed.join("-")
}