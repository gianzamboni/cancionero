#import "@preview/cetz:0.2.1"
#import "@preview/chordx:0.4.0": *

#let docFontSize = 12pt

#let chart-chord = chart-chord.with(scale: 2)
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
      set text(size: 32pt)
      it.body 
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

#let parseSongBodyWithChords(body) = {
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

#let chordSong(body) = [
 #let parsed = parseSongBodyWithChords(body)
 #parsed
  #columns(2, gutter: 1em)[
  #parsed.join("")
]
]
#let cancion(title, artist, withCords: false, body) = [
  == #title 
  === #artist
  #if withCords {
    chordSong(body)
  } else {
    nonChordSong(body)
  }
  #pagebreak()
]

#let seccion(name) = [
  #set text(size: 10pt, weight: "bold", font: "Arial", fill: rgb(255, 0, 0))
  *\[#name\]*
]

#let new-stanza = "stanza"