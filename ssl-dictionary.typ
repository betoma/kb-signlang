#import "style.typ": *
#import "signdict.typ": *
#import "../../../tools-and-related-work/typst-hamnosys/hamnosys.typ": *
#import "../../../tools-and-related-work/typst-leipzig-glossing/leipzig-gloss.typ": *

#show: project.with(
  title: [SSL],
  subtitle: [Documentation of our "Secret" Sign Language],
  short_title: "7a7a-FaM",
  authors: ("Bethany E. Toma", "Kim Korsæth"),
  dedication: [to Percy \& Kiki],
  publishing-info: [
    // #link("https://example.co.uk/")
    
    #sym.copyright 2023 Bethany E. Toma \& Kim Korsæth. All rights reserved.

    This version last updated on 29. April 2023.
  ],
)

= Grammar


== Test
#lorem(1300)

== Double Test

#lorem(1000)

= Dictionary

#sign(
  "sign-images/baby.png",
  "BABY",
  "subs.",
  "",
  [baby, infant, newborn]
)

#sign(
  "sign-images/coffe.png",
  "COFFEE",
  "subs.",
  "",
  [coffee]
)