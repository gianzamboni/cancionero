#let dontFontSize = 12pt

#let cover(body) = {
  align(center + horizon)[
    #text(font: "Rancho", weight: 700, 72pt, body)
  ]
  pagebreak()
}
#let project(title: "", authors: (), body) = {
  // Set the document's basic properties.

  set document(
    author: authors,
    title: title
  )

  set page(paper: "a4", margin: (
    x: 2cm,
    y: 1.5cm
  ))

  cover(title)

  body
}