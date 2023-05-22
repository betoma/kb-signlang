// This function takes the whole document as its "body" and formats it as a book.
#let project(
// Title.
title: "",

short_title: none,

subtitle: "",

// List of authors
authors: (),

// The paper size to use.
paper: "a4",

// A dedication to display on the third page.
dedication: none,

// Details about the book's publisher that are
// display on the second page.
publishing-info: none,

// The book's content.
body,
) = {
// Set the document's metadata.
let meta_title = if short_title != none {short_title} else {title}
set document(title: meta_title, author: authors)

// Set the body font.
set text(font: "Linux Libertine")

// Configure the page properties.
set page(
    paper: paper,
    margin: (bottom: 2.5cm, top: 3cm, left: 3cm, right:3cm),
)

// The first page.
page(align(center + horizon)[
    #text(5em)[*#title*]
    #v(1em, weak:true)
    #text(1.6em)[*#subtitle*]
    #v(2em, weak: true)
    #text(1.2em, authors.join(", ", last:" and "))
])

// Display publisher info at the bottom of the second page.
if publishing-info != none {
    align(center + bottom, text(0.8em, publishing-info))
}

pagebreak()

// Display the dedication at the top of the third page.
if dedication != none {
    v(15%)
    align(center, emph(dedication))
}

// Books like their empty pages.
pagebreak()
pagebreak()

// Configure paragraph properties.
set par(leading: 0.78em, justify: true)
show par: set block(spacing: 0.78em)

// Start with a chapter outline.
outline(title: [Table of Contents])

// Configure page properties.
set page(
    numbering: "1",

    // The header always contains the book title on odd pages and
    // the chapter title on even pages, unless the page is one
    // the starts a chapter (the chapter title is obvious then).
    header: locate(loc => {
    let this-page = loc.page()
    if this-page == 1 {
        [] // don't display anything at the top in the first page
    } else {
        let chapter-after = query(heading.where(level:2).after(loc), loc)
        let this-chapter = if chapter-after.len() > 0 {
            chapter-after.first()
        } else {
            none
        }
        if calc.even(this-page) {
            if this-chapter == none or this-chapter.location().page() != this-page {
                text(0.95em, smallcaps(title) + ": " + smallcaps(subtitle))
            } else {
                []
            }
        } else { // odd page
            if this-chapter == none or this-chapter.location().page() != this-page {
                let headings-before = query(selector(heading).before(loc), loc)
                let this-heading = if headings-before.len() > 0 {
                    headings-before.last()
                } else {
                    none
                }
                if this-heading != none {
                    align(right, text(0.95em, smallcaps(this-heading.body)))
                } else {
                    []
                }
            } else {
                []
            }
        }
    }
    }),
)

//Configure part headings
show heading.where(level: 1): it => {
    // Create part "title page"
    //Always start on odd pages
    locate(loc => {
        let i = counter(page).at(loc).first()
        if calc.even(i) {
            page(header:none)[#h(1em)]
            pagebreak()
        } else {
            pagebreak()
        }
    page(header: none, numbering:none, align(horizon)[
        #let number = if it.numbering != none {
        counter(heading).display(it.numbering)
        }
        #pad(left: 4em, text(3em)[*#number#h(.25em) #it.body*])])
    page(header:none)[#h(1em)]
})}

// Configure chapter headings.
show heading.where(level: 2): it => {
    locate(loc => {
        let parts-before = query(heading.where(level:1).before(loc), loc)
            let this-part = if parts-before.len() > 0 {
                parts-before.last()
            } else {
                none
            }
        let i = counter(page).at(loc).first()
        if this-part.location().page() not in (i - 3, i - 2, i - 1, i) {
            pagebreak(weak: true)
        }
    // Create the heading numbering.
    let number = if it.numbering != none {
    counter(heading).display(it.numbering)
    h(7pt, weak: true)
    }

    v(5%)
    text(2em, weight: 700, block([#number #it.body]))
    v(1.25em)
})}
show heading: set text(11pt, weight: 400)

set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
        numbering("I.", ..n)
    } else if n.len() > 1 {
        numbering("1.", ..n.slice(1))
    }
}
)

body
}
