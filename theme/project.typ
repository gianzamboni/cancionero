
#let docFontSize = 16pt

#let titleTest(size: 1.75em) = (font: "Rancho", size: size, weight: 700)

#let makeFullPageTitle(it) = {
  set text(..titleTest())
  if(it.body == [Índice]) {
    it.body
    linebreak()
    v(0pt)
   } else {
    set text(size: 1.5em)
    pagebreak(weak: true)
    align(center + horizon, it.body)
    pagebreak()
  }
}

#let sectionTitle(it) = {
  set align(left)
  set text(..titleTest())
  it.body
  v(-0.5em)
}

#let subsection(it) = {
  set text(..titleTest(size: 1.25em))
  line(length: 100%, stroke: 1pt)
  v(-1em)
  align(right, it.body)
}

#let project(title: "", authors: (), date: none, body) = {
  set document(
    author: authors,
    title: title
  )

  set enum(numbering: "1)")
  set page(paper: "a4", margin: (
    x: 2cm,
    y: 1.5cm
  ))

  set text(size: docFontSize, font: "Arial")

  show heading.where(level: 1): makeFullPageTitle
  show heading.where(level: 2): sectionTitle
  show heading.where(level: 3): subsection

  show strong: set text(font: "Rancho")

  set table(
    fill: (x, y) =>
      if y == 0 {
        gray.lighten(40%)
      },
    align: right,
  )
  show table.cell.where(y: 0): strong


  makeFullPageTitle((body: title))
  outline(title:[Índice], depth: 2  , indent: 10pt)
  body
}