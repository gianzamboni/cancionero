#import "theme.typ": *;

#show: project.with(
  title: "Cancionero",
  authors: (
    "Gian",
  ),
  date: "October 8, 2023",
)

#linebreak()

#outline(title:[Índice #linebreak()], depth: 2  , indent: 10pt)

#pagebreak()


#include "canciones/cuentamedusa.typ"
#include "canciones/el-tango-de-la-muerte.typ"
#include "canciones/entre-oraculos.typ"
#include "canciones/the-lobster-quadrille.typ"
// #include "canciones/whisper.typ"
// #include "canciones/while-the-whole-world-ends.typ"
// #include "canciones/evil-like-me.typ"
// #include "canciones/actos-fallidos.typ"