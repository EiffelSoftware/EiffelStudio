//------------------------------------------------------------------------------
// ev_c_util.h
//------------------------------------------------------------------------------
// description: "C features of EV_C_UTILS" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _EV_C_UTIL_H_INCLUDED_
#define _EV_C_UTIL_H_INCLUDED_
#include <gtk/gtk.h>

EIF_REAL double_array_i_th (double* double_array, int index);
GtkArg* gtk_args_array_i_th (GtkArg** args_array, int index);

void enable_ev_gtk_log (int a_mode);

/* XPM */
static char * information_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 4 1",
/* colors */
"  c None",
"` c #000000",
"a c #292900",
"b c #00FFFF",
/* pixels */
"              ````              ",
"          ````bbbb````          ",
"        ``bbbbbbbbbbbb``        ",
"       `bbbbbbbbbbbbbbbb`       ",
"     ``bbbbbbbbbbbbbbbbbb``     ",
"    `bbbbbbbbbbbbbbbbbbbbbb`    ",
"    `bbbbbbbbbb```bbbbbbbbb`    ",
"   `bbbbbbbbbbb```bbbbbbbbbb`   ",
"  `bbbbbbbbbbbb```bbbbbbbbbbb`  ",
"  `bbbbbbbbbbbbbbbbbbbbbbbbbb`  ",
" `bbbbbbbbbbbbbbbbbbbbbbbbbbbb` ",
" `bbbbbbbbba``````bbbbbbbbbbbb` ",
" `bbbbbbbbba``````bbbbbbbbbbbb` ",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
"`bbbbbbbbbbbbbb```bbbbbbbbbbbbb`",
" `bbbbbbbbbbbbb```bbbbbbbbbbbb` ",
" `bbbbbbbbbbbbb```bbbbbbbbbbbb` ",
" `bbbbbbbba```````````abbbbbbb` ",
"  `bbbbbbba```````````abbbbbb`  ",
"  `bbbbbbbbbbbbbbbbbbbbbbbbbb`  ",
"   `bbbbbbbbbbbbbbbbbbbbbbbb`   ",
"    `bbbbbbbbbbbbbbbbbbbbbb`    ",
"    `bbbbbbbbbbbbbbbbbbbbbb`    ",
"     ``bbbbbbbbbbbbbbbbbb``     ",
"       `bbbbbbbbbbbbbbbb`       ",
"        ``bbbbbbbbbbbb``        ",
"          ````bbbb````          ",
"              ````              "
};


/* XPM */
static char *error_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 17 1",
/* colors */
"  c None",
"` c #000000",
"a c #737300",
"b c #292900",
"c c #7B7B00",
"d c #313100",
"e c #C6C600",
"f c #101000",
"g c #A5A500",
"h c #181800",
"i c #F7F700",
"j c #636300",
"k c #8C8C00",
"l c #424200",
"n c #FFFF00",
"o c #6B6B00",
"p c #DEDE00",
/* pixels */
"              ````              ",
"          ````nnnn````          ",
"        ``nnnnnnnnnnnn``        ",
"       `nnnnnnnnnnnnnnnn`       ",
"     ``nnnnnnnnnnnnnnnnnn``     ",
"    `nnnnnnnnnnnnnnnnnnnnnn`    ",
"    `nnnnnnnnpd`dpnnnnnnnnn`    ",
"   `nnnnnnnnnd```dnnnnnnnnnn`   ",
"  `nnnnnnnnnn`````nnnnnnnnnnn`  ",
"  `nnnnnnnnnnf```hnnnnnnnnnnn`  ",
" `nnnnnnnnnnnb```bnnnnnnnnnnnn` ",
" `nnnnnnnnnnnl```lnnnnnnnnnnnn` ",
" `nnnnnnnnnnnj```jnnnnnnnnnnnn` ",
"`nnnnnnnnnnnna```cnnnnnnnnnnnnn`",
"`nnnnnnnnnnnnk```knnnnnnnnnnnnn`",
"`nnnnnnnnnnnng```gnnnnnnnnnnnnn`",
"`nnnnnnnnnnnne```ennnnnnnnnnnnn`",
"`nnnnnnnnnnnnp```pnnnnnnnnnnnnn`",
"`nnnnnnnnnnnni```innnnnnnnnnnnn`",
" `nnnnnnnnnnnnj`jnnnnnnnnnnnnn` ",
" `nnnnnnnnnnnnnnnnnnnnnnnnnnnn` ",
" `nnnnnnnnnnnnnnnnnnnnnnnnnnnn` ",
"  `nnnnnnnnnnnnnnnnnnnnnnnnnn`  ",
"  `nnnnnnnnnnno`onnnnnnnnnnnn`  ",
"   `nnnnnnnnnn```nnnnnnnnnnn`   ",
"    `nnnnnnnnno`onnnnnnnnnn`    ",
"    `nnnnnnnnnnnnnnnnnnnnnn`    ",
"     ``nnnnnnnnnnnnnnnnnn``     ",
"       `nnnnnnnnnnnnnnnn`       ",
"        ``nnnnnnnnnnnn``        ",
"          ````nnnn````          ",
"              ````              "
};


/* XPM */
static char *question_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 24 1",
/* colors */
"  c None",
"` c #000000",
"a c #737300",
"b c #525200",
"c c #080800",
"d c #7B7B00",
"e c #313100",
"f c #C6C600",
"g c #101000",
"h c #EFEF00",
"i c #393900",
"j c #A5A500",
"k c #CECE00",
"l c #181800",
"m c #F7F700",
"n c #ADAD00",
"o c #D6D600",
"p c #8C8C00",
"q c #424200",
"s c #FFFF00",
"t c #B5B500",
"u c #6B6B00",
"v c #212100",
"w c #949400",
/* pixels */
"              ````              ",
"          ````ssss````          ",
"        ``ssssssssssss``        ",
"       `ssssssssssssssss`       ",
"     ``ssssssssssssssssss``     ",
"    `ssssssssssssssssssssss`    ",
"    `ssssssssssssssssssssss`    ",
"   `sssssssodec`cipmssssssss`   ",
"  `ssssssfq````````vossssssss`  ",
"  `ssssss```````````lhsssssss`  ",
" `sssssss```dfmshwc``assssssss` ",
" `sssssss```ssssssn``vssssssss` ",
" `sssssssu`usssssss```ssssssss` ",
"`ssssssssssssssssst``csssssssss`",
"`ssssssssssssssssjc``bsssssssss`",
"`ssssssssssssshpv```cksssssssss`",
"`sssssssssssssc````lfssssssssss`",
"`sssssssssssss```cahsssssssssss`",
"`sssssssssssssc`chsssssssssssss`",
" `ssssssssssssd`dsssssssssssss` ",
" `ssssssssssssssssssssssssssss` ",
" `ssssssssssssssssssssssssssss` ",
"  `ssssssssssssssssssssssssss`  ",
"  `sssssssssspg`gpsssssssssss`  ",
"   `sssssssssc```cssssssssss`   ",
"    `sssssssspg`gpsssssssss`    ",
"    `ssssssssssssssssssssss`    ",
"     ``ssssssssssssssssss``     ",
"       `ssssssssssssssss`       ",
"        ``ssssssssssss``        ",
"          ````ssss````          ",
"              ````              "
};


/* XPM */
static char *warning_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 17 1",
/* colors */
"  c None",
"` c #000000",
"a c #A50000",
"b c #DE0000",
"c c #630000",
"d c #F70000",
"e c #100000",
"f c #6B0000",
"g c #C60000",
"h c #FF0000",
"i c #180000",
"j c #290000",
"k c #730000",
"m c #310000",
"n c #420000",
"o c #7B0000",
"p c #8C0000",
/* pixels */
"              ````              ",
"          ````hhhh````          ",
"        ``hhhhhhhhhhhh``        ",
"       `hhhhhhhhhhhhhhhh`       ",
"     ``hhhhhhhhhhhhhhhhhh``     ",
"    `hhhhhhhhhhhhhhhhhhhhhh`    ",
"    `hhhhhhhhbm`mbhhhhhhhhh`    ",
"   `hhhhhhhhhm```mhhhhhhhhhh`   ",
"  `hhhhhhhhhh`````hhhhhhhhhhh`  ",
"  `hhhhhhhhhhe```ihhhhhhhhhhh`  ",
" `hhhhhhhhhhhj```jhhhhhhhhhhhh` ",
" `hhhhhhhhhhhn```nhhhhhhhhhhhh` ",
" `hhhhhhhhhhhc```chhhhhhhhhhhh` ",
"`hhhhhhhhhhhhk```ohhhhhhhhhhhhh`",
"`hhhhhhhhhhhhp```phhhhhhhhhhhhh`",
"`hhhhhhhhhhhha```ahhhhhhhhhhhhh`",
"`hhhhhhhhhhhhg```ghhhhhhhhhhhhh`",
"`hhhhhhhhhhhhb```bhhhhhhhhhhhhh`",
"`hhhhhhhhhhhhd```dhhhhhhhhhhhhh`",
" `hhhhhhhhhhhhc`chhhhhhhhhhhhh` ",
" `hhhhhhhhhhhhhhhhhhhhhhhhhhhh` ",
" `hhhhhhhhhhhhhhhhhhhhhhhhhhhh` ",
"  `hhhhhhhhhhhhhhhhhhhhhhhhhh`  ",
"  `hhhhhhhhhhhf`fhhhhhhhhhhhh`  ",
"   `hhhhhhhhhh```hhhhhhhhhhh`   ",
"    `hhhhhhhhhf`fhhhhhhhhhh`    ",
"    `hhhhhhhhhhhhhhhhhhhhhh`    ",
"     ``hhhhhhhhhhhhhhhhhh``     ",
"       `hhhhhhhhhhhhhhhh`       ",
"        ``hhhhhhhhhhhh``        ",
"          ````hhhh````          ",
"              ````              "
};

/* XPM */
static char *no_collate_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"66 32 3 1",
/* colors */
"  c None",
"` c #000000",
"a c #FFFFFF",
/* pixels */
"                                                                  ",
"             ``````````````````                `````````````````` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
" ``````````````````aaaaaaaaaaa`    ``````````````````aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaa``aaaa`    `aaaaaaaaaaaaaaaa`aaaaa``aaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaa`aa`aaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaaaaa`aaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaaaa`aaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaaa`aaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaa`aaaaaa` ",
" `aaaaaaaaaa``aaaa`aaaaaa`aaaa`    `aaaaaaaaaa``aaaa`aaaa````aaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaa`aa`aaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaaa`aaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaa`aaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaa`aaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`````````````    `aaaaaaaaa`aaaaaa````````````` ",
" `aaaaaaaaaaa`aaaa`                `aaaaaaaaa````aaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" ``````````````````                ``````````````````             ",
"                                                                  "
};

/* XPM */
static char *collate_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"66 32 3 1",
/* colors */
"  c None",
"` c #000000",
"a c #FFFFFF",
/* pixels */
"                                                                  ",
"             ``````````````````                `````````````````` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
"             `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa` ",
" ``````````````````aaaaaaaaaaa`    ``````````````````aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaaaaaa`    `aaaaaaaaaaaaaaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaa``aaaa`    `aaaaaaaaaaaaaaaa`aaaaa``aaaa` ",
" `aaaaaaaaaaaaaaaa`aaaa`aa`aaa`    `aaaaaaaaaaaaaaaa`aaaa`aa`aaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaaa`aaa`    `aaaaaaaaaaaaaaaa`aaaaaaa`aaa` ",
" `aaaaaaaaaaaaaaaa`aaaaaa`aaaa`    `aaaaaaaaaaaaaaaa`aaaaaa`aaaa` ",
" `aaaaaaaaaaaaaaaa`aaaaa`aaaaa`    `aaaaaaaaaaaaaaaa`aaaaa`aaaaa` ",
" `aaaaaaaaaaaaaaaa`aaaa`aaaaaa`    `aaaaaaaaaaaaaaaa`aaaa`aaaaaa` ",
" `aaaaaaaaaa``aaaa`aaaa````aaa`    `aaaaaaaaaa``aaaa`aaaa````aaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaa`aaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaa`aaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaa`aaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`aaaaaaaaaaa`    `aaaaaaaaaaa`aaaa`aaaaaaaaaaa` ",
" `aaaaaaaaaaa`aaaa`````````````    `aaaaaaaaaaa`aaaa````````````` ",
" `aaaaaaaaaaa`aaaa`                `aaaaaaaaaaa`aaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" `aaaaaaaaaaaaaaaa`                `aaaaaaaaaaaaaaaa`             ",
" ``````````````````                ``````````````````             ",
"                                                                  "
};

/* XPM */
static char *landscape_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"21 21 3 1",
/* colors */
"  c None",
"` c #000000",
"a c #FFFFFF",
/* pixels */
"                     ",
"                     ",
"                     ",
"                     ",
" ````````````````    ",
" `aaaaaaaaaaaaaa``   ",
" `aaaaaaaaaaaaaa`a`  ",
" `aaaaaaaaaaaaaa```` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" `aaaaaaaaaaaaaaaaa` ",
" ``````````````````` ",
"                     ",
"                     ",
"                     ",
"                     "
};

/* XPM */
static char *portrait_pixmap_xpm[] = {
/* width height ncolors chars_per_pixel */
"21 21 3 1",
/* colors */
"  c None",
"` c #000000",
"a c #FFFFFF",
/* pixels */
"                     ",
"    ``````````       ",
"    `aaaaaaaa``      ",
"    `aaaaaaaa`a`     ",
"    `aaaaaaaa````    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `aaaaaaaaaaa`    ",
"    `````````````    ",
"                     "
};

/* XPM */
static char *busy_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"bbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`baaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b``baaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b```baaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b````baaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`````baaaaaaaaaaaaaaaaaaaaaaaaa",
"b``````baaaaaaaaaaaaaaaaaaaaaaaa",
"b```````baaaaaaaaaaaaaaaaaaaaaaa",
"b````````baaaaaaaaaaaaaaaaaaaaaa",
"b`````bbbbbaaaaaaaaaaaaaaaaaaaaa",
"b``b``baaaaaaaaaaaaaaaaaaaaaaaaa",
"b`bab``baaaaaaaaaaaaaaaaaaaaaaaa",
"bbaab``baaaaaaaaaaaaaaaaaaaaaaaa",
"baaaab``baaaabbbbbbbbbaaaaaaaaaa",
"aaaaab``baaab`````````baaaaaaaaa",
"aaaaaab``baaab```````baaaaaaaaaa",
"aaaaaab``baaab`bbbbb`baaaaaaaaaa",
"aaaaaaabbaaaab`bbbbb`baaaaaaaaaa",
"aaaaaaaaaaaaab`bbbbb`baaaaaaaaaa",
"aaaaaaaaaaaaaab`bbb`baaaaaaaaaaa",
"aaaaaaaaaaaaaaab`b`baaaaaaaaaaaa",
"aaaaaaaaaaaaaaab`b`baaaaaaaaaaaa",
"aaaaaaaaaaaaaab`bbb`baaaaaaaaaaa",
"aaaaaaaaaaaaab`bb`bb`baaaaaaaaaa",
"aaaaaaaaaaaaab`b`b`b`baaaaaaaaaa",
"aaaaaaaaaaaaab``b`b``baaaaaaaaaa",
"aaaaaaaaaaaaab```````baaaaaaaaaa",
"aaaaaaaaaaaab`````````baaaaaaaaa",
"aaaaaaaaaaaaabbbbbbbbbaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *crosshair_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaabbaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aabbbbbbbbbbbb``bbbbbbbbbbbbaaaa",
"ab``````````````````````````baaa",
"ab``````````````````````````baaa",
"aabbbbbbbbbbbb``bbbbbbbbbbbbaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaabbaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *help_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"bbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`baaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b``baaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b```baaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b````baaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`````baaaaaaaaaaaaaaaaaaaaaaaaa",
"b``````baaaaaaaaaaaaaaaaaaaaaaaa",
"b```````baaaaaaaaaaaaaaaaaaaaaaa",
"b````````baaaaaaaaaaaaaaaaaaaaaa",
"b`````bbbbbaaaaaaaaaaaaaaaaaaaaa",
"b``b``baaaaaaaaaaaaaaaaaaaaaaaaa",
"b`bab``baaaaaaaaaaaaaaaaaaaaaaaa",
"bbaab``baaaaaaaaaaaaaaaaaaaaaaaa",
"baaaab``baaaaaaaabbbbbaaaaaaaaaa",
"aaaaab``baaaaaaab`````baaaaaaaaa",
"aaaaaab``baaaaab```````baaaaaaaa",
"aaaaaab``baaaab```bbb```baaaaaaa",
"aaaaaaabbaaaaab``baaab``baaaaaaa",
"aaaaaaaaaaaaaaabbaaaab``baaaaaaa",
"aaaaaaaaaaaaaaaaaaaab``baaaaaaaa",
"aaaaaaaaaaaaaaaaaaab```baaaaaaaa",
"aaaaaaaaaaaaaaaaaab```baaaaaaaaa",
"aaaaaaaaaaaaaaaaab```baaaaaaaaaa",
"aaaaaaaaaaaaaaaaab``baaaaaaaaaaa",
"aaaaaaaaaaaaaaaaab``baaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaabbaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaab``baaaaaaaaaaa",
"aaaaaaaaaaaaaaaaab``baaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaabbaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *ibeam_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aabbbbaabbbbaaaaaaaaaaaaaaaaaaaa",
"ab````bb````baaaaaaaaaaaaaaaaaaa",
"ab``````````baaaaaaaaaaaaaaaaaaa",
"aabbb````bbbaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aabbb````bbbaaaaaaaaaaaaaaaaaaaa",
"ab``````````baaaaaaaaaaaaaaaaaaa",
"ab````bb````baaaaaaaaaaaaaaaaaaa",
"aabbbbaabbbbaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *no_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaaaaaaabbbbbbbbaaaaaaaaaaaa",
"aaaaaaaaabbb````````bbbaaaaaaaaa",
"aaaaaaabb``````````````bbaaaaaaa",
"aaaaaab`````bbbbbbbb`````baaaaaa",
"aaaaab````bbbbbbbbbbbb````baaaaa",
"aaaab```bbbbbbbbbbbbbbbb```baaaa",
"aaab```bbbbbb``````bbbbbb```baaa",
"aab```bbbbb``````````bbbbb```baa",
"aab``bbbbbb```bbbbb````bbbb``baa",
"ab```bbbbbbb```baaabb```bbb```ba",
"ab``bbbb`bbbb```baaaab``bbbb``ba",
"ab``bbb```bbbb```baaaab``bbb``ba",
"b``bbbb````bbbb```baaab``bbbb``b",
"b``bbb``b```bbbb```baaab``bbb``b",
"b``bbb``bb```bbbb```baab``bbb``b",
"b``bbb``bab```bbbb```bab``bbb``b",
"b``bbb``baab```bbbb```bb``bbb``b",
"b``bbb``baaab```bbbb```b``bbb``b",
"b``bbb``baaaab```bbbb`````bbb``b",
"b``bbbb``baaaab```bbbb```bbbb``b",
"ab``bbb``baaaaab```bbbb``bbb``ba",
"ab``bbbb``baaaaab```bbbbbbbb``ba",
"ab```bbb```bbaaaab```bbbbbb```ba",
"aab``bbbb````bbbbbb```bbbbb``baa",
"aab```bbbbb``````````bbbbb```baa",
"aaab```bbbbbb``````bbbbbb```baaa",
"aaaab```bbbbbbbbbbbbbbbb```baaaa",
"aaaaab````bbbbbbbbbbbb````baaaaa",
"aaaaaab`````bbbbbbbb`````baaaaaa",
"aaaaaaabb``````````````bbaaaaaaa",
"aaaaaaaaabbb````````bbbaaaaaaaaa",
"aaaaaaaaaaaabbbbbbbbaaaaaaaaaaaa"
};

/* XPM */
static char *sizeall_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaaaaa``aaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbb`aaaaaaaaaaaaaaaaaa",
"aaaaaaa`bbbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaa`bbbbbbbb`aaaaaaaaaaaaaaaa",
"aaaaaa````bb````aaaaaaaaaaaaaaaa",
"aaaa``aaa`bb`aaa``aaaaaaaaaaaaaa",
"aaa`b`aaa`bb`aaa`b`aaaaaaaaaaaaa",
"aa`bb`aaa`bb`aaa`bb`aaaaaaaaaaaa",
"a`bbb`````bb`````bbb`aaaaaaaaaaa",
"`bbbbbbbbbbbbbbbbbbbb`aaaaaaaaaa",
"`bbbbbbbbbbbbbbbbbbbb`aaaaaaaaaa",
"a`bbb`````bb`````bbb`aaaaaaaaaaa",
"aa`bb`aaa`bb`aaa`bb`aaaaaaaaaaaa",
"aaa`b`aaa`bb`aaa`b`aaaaaaaaaaaaa",
"aaaa``aaa`bb`aaa``aaaaaaaaaaaaaa",
"aaaaaa````bb````aaaaaaaaaaaaaaaa",
"aaaaaa`bbbbbbbb`aaaaaaaaaaaaaaaa",
"aaaaaaa`bbbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbb`aaaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaa``aaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *sizenesw_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaa````````aaaaaaaaaaaaaaaaa",
"aaaaaaa`bbbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaa`bbb`bb`aaaaaaaaaaaaaaaaa",
"aaaaaa`bbb`a`b`aaaaaaaaaaaaaaaaa",
"``aaa`bbb`aaa``aaaaaaaaaaaaaaaaa",
"`b`a`bbb`aaaaaaaaaaaaaaaaaaaaaaa",
"`bb`bbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbb`aaaaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"````````aaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *sizens_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaa``aaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aa`bbbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"a`bbbbbb`aaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbbbbb`aaaaaaaaaaaaaaaaaaaaaa",
"````bb````aaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"````bb````aaaaaaaaaaaaaaaaaaaaaa",
"`bbbbbbbb`aaaaaaaaaaaaaaaaaaaaaa",
"a`bbbbbb`aaaaaaaaaaaaaaaaaaaaaaa",
"aa`bbbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaa``aaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *sizenwse_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"````````aaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbb`aaaaaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"`bb`bbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"`b`a`bbb`aaaaaaaaaaaaaaaaaaaaaaa",
"``aaa`bbb`aaa``aaaaaaaaaaaaaaaaa",
"aaaaaa`bbb`a`b`aaaaaaaaaaaaaaaaa",
"aaaaaaa`bbb`bb`aaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaa`bbbbbb`aaaaaaaaaaaaaaaaa",
"aaaaaaa````````aaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *sizewe_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaa``aaaaaaa``aaaaaaaaaaaaaaaaa",
"aaa`b`aaaaaaa`b`aaaaaaaaaaaaaaaa",
"aa`bb`aaaaaaa`bb`aaaaaaaaaaaaaaa",
"a`bbb`````````bbb`aaaaaaaaaaaaaa",
"`bbbbbbbbbbbbbbbbb`aaaaaaaaaaaaa",
"`bbbbbbbbbbbbbbbbb`aaaaaaaaaaaaa",
"a`bbb`````````bbb`aaaaaaaaaaaaaa",
"aa`bb`aaaaaaa`bb`aaaaaaaaaaaaaaa",
"aaa`b`aaaaaaa`b`aaaaaaaaaaaaaaaa",
"aaaa``aaaaaaa``aaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *standard_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"bbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`baaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b``baaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b```baaaaaaaaaaaaaaaaaaaaaaaaaaa",
"b````baaaaaaaaaaaaaaaaaaaaaaaaaa",
"b`````baaaaaaaaaaaaaaaaaaaaaaaaa",
"b``````baaaaaaaaaaaaaaaaaaaaaaaa",
"b```````baaaaaaaaaaaaaaaaaaaaaaa",
"b````````baaaaaaaaaaaaaaaaaaaaaa",
"b`````bbbbbaaaaaaaaaaaaaaaaaaaaa",
"b``b``baaaaaaaaaaaaaaaaaaaaaaaaa",
"b`bab``baaaaaaaaaaaaaaaaaaaaaaaa",
"bbaab``baaaaaaaaaaaaaaaaaaaaaaaa",
"baaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaab``baaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaab``baaaaaaaaaaaaaaaaaaaaaa",
"aaaaaab``baaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaabbbaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *uparrow_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaa``aaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aa`bbbb`aaaaaaaaaaaaaaaaaaaaaaaa",
"a`bbbbbb`aaaaaaaaaaaaaaaaaaaaaaa",
"`bbbbbbbb`aaaaaaaaaaaaaaaaaaaaaa",
"````bb````aaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa`bb`aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaa````aaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

/* XPM */
static char *wait_cursor_xpm[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #000000",
"a c None",
"b c #FFFFFF",
/* pixels */
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaabbbbbbbbbbbbbaaaaaaaaa",
"aaaaaaaaab`````````````baaaaaaaa",
"aaaaaaaaab``bbb`b``````baaaaaaaa",
"aaaaaaaaaab```````````baaaaaaaaa",
"aaaaaaaaaab`bbbbbbbbb`baaaaaaaaa",
"aaaaaaaaaab`bbbbbbbbb`baaaaaaaaa",
"aaaaaaaaaab`bbbbbbbbb`baaaaaaaaa",
"aaaaaaaaaab`bbbbbbbbb`baaaaaaaaa",
"aaaaaaaaaaab`bbbbbbb`baaaaaaaaaa",
"aaaaaaaaaaaab`bbbbb`baaaaaaaaaaa",
"aaaaaaaaaaaaab`bbb`baaaaaaaaaaaa",
"aaaaaaaaaaaaaab`b`baaaaaaaaaaaaa",
"aaaaaaaaaaaaaab`b`baaaaaaaaaaaaa",
"aaaaaaaaaaaaab`bbb`baaaaaaaaaaaa",
"aaaaaaaaaaaab`bb`bb`baaaaaaaaaaa",
"aaaaaaaaaaab`bb`b`bb`baaaaaaaaaa",
"aaaaaaaaaab`bb`b`b`bb`baaaaaaaaa",
"aaaaaaaaaab`b`b`b`b`b`baaaaaaaaa",
"aaaaaaaaaab``b`b`b`b``baaaaaaaaa",
"aaaaaaaaaab`b`b`b`b`b`baaaaaaaaa",
"aaaaaaaaaab```````````baaaaaaaaa",
"aaaaaaaaab``bbb`b``````baaaaaaaa",
"aaaaaaaaab`````````````baaaaaaaa",
"aaaaaaaaaabbbbbbbbbbbbbaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

#endif

//------------------------------------------------------------------------------
// EiffelVision2: library of reusable components for ISE Eiffel.
// Copyright (C) 1986-1999 Interactive Software Engineering Inc.
// All rights reserved. Duplication and distribution prohibited.
// May be used only with ISE Eiffel, under terms of user license.
// Contact ISE for any other use.
//
// Interactive Software Engineering Inc.
// ISE Building, 2nd floor
// 270 Storke Road, Goleta, CA 93117 USA
// Telephone 805-685-1006, Fax 805-685-6869
// Electronic mail <info@eiffel.com>
// Customer support e-mail <support@eiffel.com>
// For latest info see award-winning pages: http://www.eiffel.com
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// CVS log
//------------------------------------------------------------------------------
//
// $Log$
// Revision 1.9  2001/10/10 18:00:23  king
// Reinstated None for transparent colors
//
// Revision 1.8  2001/08/24 20:50:08  king
// Removed unused external
//
// Revision 1.7  2001/08/03 18:41:26  king
// Removed no longer needed externals
//
// Revision 1.6  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.4.2.12  2001/06/04 20:08:51  king
// Updated enable_ev_gtk_log signature for debug mode
//
// Revision 1.4.2.11  2000/11/29 20:11:46  king
// Now include gtk.h
//
// Revision 1.4.2.10  2000/11/29 00:40:42  king
// Implemented gtk_args_array_i_th
//
// Revision 1.4.2.9  2000/11/27 19:16:23  andrew
// Added stock cursors and set background of icons to grey - until alpha channel is implemented
//
// Revision 1.4.2.8  2000/10/12 16:21:07  king
// Removed set_pixmap_and_mask
//
// Revision 1.4.2.7  2000/10/06 17:58:21  andrew
// Added print dialog images
//
// Revision 1.4.2.6  2000/10/02 23:14:46  king
// Added prototype for set_pixmap_and_mask
//
// Revision 1.4.2.5  2000/09/23 00:04:51  andrew
// Made transparent characters blank
//
// Revision 1.4.2.4  2000/09/21 21:44:00  andrew
// Added default pixmaps
//
// Revision 1.4.2.3  2000/07/20 18:38:50  king
// Added double_array_i_thimplementation/gtk/Clib/ev_c_util.h
//
// Revision 1.4.2.2  2000/05/03 22:00:48  king
// merged from HEAD
//
// Revision 1.5  2000/05/03 21:34:23  king
// Added temp default_pixmap
//
// Revision 1.4  2000/04/18 21:43:23  king
// Moved string_pointer_deref definition from header to source
//
// Revision 1.3  2000/04/18 17:57:53  oconnor
// Renamed get_pointer_from_array_by_index -> pointer_array_i_th
// Added string_pointer_deref (pointer: POINTER): POINTER
//
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.2.2  2000/02/11 04:48:50  oconnor
// attached GTK+ exception system to Eiffel
//
// Revision 1.1.2.1  2000/01/14 22:17:14  brendel
// Initial.
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
