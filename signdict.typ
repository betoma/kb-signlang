#import "../../../tools-and-related-work/typst-hamnosys/hamnosys.typ": *

#let sign(
    image_file,
    sign_name,
    part_of_speech,
    hamnosys_sign,
    ..defs,
    image_width: 5em,
    height_adjust: 1em,
    total_indent: 3em,
    num_indent: 2em,
) = {
    stack(
        dir: ltr,
        box(width: 7em, align(center,[#v(1em)#image(image_file, width:image_width)])),
        h(2em),
        box(width: 1fr, [*#sign_name* #sym.dot.c #emph(part_of_speech) #h(2em) #hamnosys(size: 1.7em)[#hamnosys_sign]
        #if defs.pos().len() == 1 {
            pad(left:total_indent)[#defs.pos().first()]
        } else {
            enum(indent:num_indent, body-indent: (total_indent - num_indent), ..defs)
        }
        ]
        )
)
}