//------------------------------------------------------------------------------
// ev_c_util.c
//------------------------------------------------------------------------------
// description: "C features of EV_C_UTILS"
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include "ev_c_util.h"
#include "eif_except.h"

EIF_REAL double_array_i_th (double *double_array, int index)
{
	return (EIF_REAL) double_array [index];
}

GtkArg* gtk_args_array_i_th (GtkArg** args_array, int index)
{
	return (GtkArg*)args_array + index;
}

void ev_gtk_log (
	const gchar* log_domain,
	GLogLevelFlags log_level,
	const gchar* message,
	gpointer user_data
) {
	static char buf[1000];
	char* level;
	int fatal = FALSE;
	int a_debug_mode;
	a_debug_mode = (int) user_data;

	if (a_debug_mode > 0)
	{
	// If no debugging is set then everything is left to DBC
	switch (log_level) {
	case G_LOG_LEVEL_ERROR:
		level = "ERROR";
		fatal = TRUE;
		break;
	case G_LOG_LEVEL_CRITICAL:
		level = "CRITICAL";
		fatal = TRUE;
		break;
	case G_LOG_LEVEL_WARNING:
		level = "WARNING";
		break;
	case G_LOG_LEVEL_MESSAGE:
		level = "MESSAGE";
		break;
	case G_LOG_LEVEL_INFO:
		level = "INFO";
		break;
	case G_LOG_LEVEL_DEBUG:
		level = "DEBUG";
	default:
		level = "UNKNOWN";
		fatal = TRUE;
	}
	if ( strlen (log_domain) + strlen (level) + strlen (message) + 2 > 999 ) {
		if ( strlen (log_domain) + strlen (level) > 999 ) {
			sprintf (buf, "%s-%s\n", log_domain, level);
		} else {
			sprintf (buf, "GTK-%s\n", level);
		}
	} else {
		sprintf (buf, "%s-%s %s", log_domain, level, message);
	}
	printf ("%s\n", buf);
	if (fatal && a_debug_mode > 1) {
		eraise (buf, EN_EXT);
	}
	}
}

void enable_ev_gtk_log (int a_mode)
{
	g_log_set_handler ("Gtk", G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
		G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
		G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
    g_log_set_handler ("Gdk", G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
		G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
	g_log_set_handler ("GLib",  G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
        G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
    g_log_set_handler (NULL,  G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
        G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
}

/* XPM */
char * information_pixmap_data[] = {
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

char *information_pixmap_xpm (void) {
        return (char *) information_pixmap_data;
}

/* XPM */
char *error_pixmap_data[] = {
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


char *error_pixmap_xpm (void) {
        return (char *) error_pixmap_data;
}

/* XPM */
char *question_pixmap_data[] = {
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

char *question_pixmap_xpm (void) {
        return (char *) question_pixmap_data;
}

/* XPM */
char *warning_pixmap_data[] = {
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

char *warning_pixmap_xpm (void) {
        return (char *) warning_pixmap_data;
}

/* XPM */
char *no_collate_pixmap_data[] = {
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

char *no_collate_pixmap_xpm (void) {
        return (char *) no_collate_pixmap_data;
}

/* XPM */
char *collate_pixmap_data[] = {
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

char *collate_pixmap_xpm (void) {
        return (char *) collate_pixmap_data;
}

/* XPM */
char *landscape_pixmap_data[] = {
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

char *landscape_pixmap_xpm (void) {
        return (char *) landscape_pixmap_data;
}

/* XPM */
char *portrait_pixmap_data[] = {
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

char *portrait_pixmap_xpm (void) {
        return (char *) portrait_pixmap_data;
}

/* XPM */
char *busy_cursor_data[] = {
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
"aaaaaaaaaaaaab```````baaaaaaaaaa",
"aaaaaaaaaaaaab`bbbbb`baaaaaaaaaa",
"aaaaaaaaaaaaab`bbbbb`baaaaaaaaaa",
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

char *busy_cursor_xpm (void) {
        return (char *) busy_cursor_data;
}

/* XPM */
char *crosshair_cursor_data[] = {
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
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaabbaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaaaaaaaaab``baaaaaaaaaaaaaaa",
"aaaaaabbbbbbbb``bbbbbbbbaaaaaaaa",
"aaaaab``````````````````baaaaaaa",
"aaaaab``````````````````baaaaaaa",
"aaaaaabbbbbbbb``bbbbbbbbaaaaaaaa",
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
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *crosshair_cursor_xpm (void) {
        return (char *) crosshair_cursor_data;
}

/* XPM */
char *help_cursor_data[] = {
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
"aaaaaabbbbaaaaab```````baaaaaaaa",
"aaaaaaaaaaaaaab```bbb```baaaaaaa",
"aaaaaaaaaaaaaab``baaab``baaaaaaa",
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

char *help_cursor_xpm (void) {
        return (char *) help_cursor_data;
}

/* XPM */
char *ibeam_cursor_data[] = {
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
"aabbb````bbbaaaaaaaaaaaaaaaaaaaa",
"ab``````````baaaaaaaaaaaaaaaaaaa",
"ab````bb````baaaaaaaaaaaaaaaaaaa",
"aabbbbaabbbbaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *ibeam_cursor_xpm (void) {
        return (char *) ibeam_cursor_data;
}

/* XPM */
char * no_cursor_data[] = {
"32 32 3 1",
"       c None",
".      c #000000",
"+      c #FFFFFF",
"                                ",
"      ++++++                    ",
"     +......+                   ",
"    +..++++..+                  ",
"   +..+    +..+                 ",
"  +..+      +..+                ",
" +....+      +..+               ",
" +.++..+      +..+              ",
" +.+ +..+      +.+              ",
" +.+  +..+     +.+              ",
" +.+   +..+    +.+              ",
" +.+    +..+   +.+              ",
" +.+     +..+  +.+              ",
" +..+     +..++.+               ",
"  +..+     +....+               ",
"   +..+     +..+                ",
"    +..+++++..+                 ",
"     +......++                  ",
"      ++++++                    ",
"                                ",
"                                ",
"                                ", 
"                                ", 
"                                ", 
"                                ", 
"                                ", 
"                                ", 
"                                ",
"                                ", 
"                                ", 
"                                ", 
"                                " 
};

char *no_cursor_xpm (void) {
        return (char *) no_cursor_data;
}

/* XPM */
char *sizeall_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
/* pixels */
"aaaaaaaaaa``aaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaaaaaaa`bbbb`aaaaaaaaaaaaaaaaaa",
"aaaaaaa```bb```aaaaaaaaaaaaaaaaa",
"aaaaaaaaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaaaa`aaa`bb`aaa`aaaaaaaaaaaaaaa",
"aaaa``aaa`bb`aaa``aaaaaaaaaaaaaa",
"aaa`b`````bb`````b`aaaaaaaaaaaaa",
"aa`bbbbbbbbbbbbbbbb`aaaaaaaaaaaa",
"aa`bbbbbbbbbbbbbbbb`aaaaaaaaaaaa",
"aaa`b`````bb`````b`aaaaaaaaaaaaa",
"aaaa``aaa`bb`aaa``aaaaaaaaaaaaaa",
"aaaaa`aaa`bb`aaa`aaaaaaaaaaaaaaa",
"aaaaaaaaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaaaaaa```bb```aaaaaaaaaaaaaaaaa",
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
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *sizeall_cursor_xpm (void) {
        return (char *) sizeall_cursor_data;
}

/* XPM */
char *sizenesw_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
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

char *sizenesw_cursor_xpm (void) {
        return (char *) sizenesw_cursor_data;
}

/* XPM */
char *sizens_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
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
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *sizens_cursor_xpm (void) {
        return (char *) sizens_cursor_data;
}

/* XPM */
char *sizenwse_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
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

char *sizenwse_cursor_xpm (void) {
        return (char *) sizenwse_cursor_data;
}
/* XPM */
char *sizewe_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
/* pixels */
"aaaa``aaa``aaaaaaaaaaaaaaaaaaaaa",
"aaa`b`aaa`b`aaaaaaaaaaaaaaaaaaaa",
"aa`bb`aaa`bb`aaaaaaaaaaaaaaaaaaa",
"a`bbb`````bbb`aaaaaaaaaaaaaaaaaa",
"`bbbbbbbbbbbbb`aaaaaaaaaaaaaaaaa",
"`bbbbbbbbbbbbb`aaaaaaaaaaaaaaaaa",
"a`bbb`````bbb`aaaaaaaaaaaaaaaaaa",
"aa`bb`aaa`bb`aaaaaaaaaaaaaaaaaaa",
"aaa`b`aaa`b`aaaaaaaaaaaaaaaaaaaa",
"aaaa``aaa``aaaaaaaaaaaaaaaaaaaaa",
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

char *sizewe_cursor_xpm (void) {
        return (char *) sizewe_cursor_data;
}

/* XPM */
char *standard_cursor_data[] = {
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
"aaaaaabbaaaaaaaaaaaaaaaaaaaaaaaa",
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

char *standard_cursor_xpm (void) {
        return (char *) standard_cursor_data;
}

/* XPM */
char *uparrow_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
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
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *uparrow_cursor_xpm (void) {
        return (char *) uparrow_cursor_data;
}
/* XPM */
char *wait_cursor_data[] = {
/* width height ncolors chars_per_pixel */
"32 32 3 1",
/* colors */
"` c #FFFFFF",
"a c None",
"b c #000000",
/* pixels */
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaabbbbbbbbbbbbbaaaaaaaaa",
"aaaaaaaaabbbbbbbbbbbbbbbaaaaaaaa",
"aaaaaaaaabbbbbbbbbbbbbbbaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaaaabb`b`b`b`bbaaaaaaaaaa",
"aaaaaaaaaaaabb`b`b`bbaaaaaaaaaaa",
"aaaaaaaaaaaaabb`b`bbaaaaaaaaaaaa",
"aaaaaaaaaaaaaab`b`baaaaaaaaaaaaa",
"aaaaaaaaaaaaaab`b`baaaaaaaaaaaaa",
"aaaaaaaaaaaaabbbbbbbaaaaaaaaaaaa",
"aaaaaaaaaaaabbbb`bbbbaaaaaaaaaaa",
"aaaaaaaaaaabbbb`b`bbbbaaaaaaaaaa",
"aaaaaaaaaabbbb`b`b`bbbbaaaaaaaaa",
"aaaaaaaaaabbb`b`b`b`bbbaaaaaaaaa",
"aaaaaaaaaabb`b`b`b`b`bbaaaaaaaaa",
"aaaaaaaaaabbb`b`b`b`bbbaaaaaaaaa",
"aaaaaaaaaabb`````````bbaaaaaaaaa",
"aaaaaaaaabbbbbbbbbbbbbbbaaaaaaaa",
"aaaaaaaaabbbbbbbbbbbbbbbaaaaaaaa",
"aaaaaaaaaabbbbbbbbbbbbbaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
};

char *wait_cursor_xpm (void) {
        return (char *) wait_cursor_data;
}


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
// Revision 1.16  2001/11/06 00:17:13  king
// Added public functions to private xpm data
//
// Revision 1.15  2001/10/18 20:20:17  king
// Tidied up cursors
//
// Revision 1.14  2001/10/16 17:29:36  king
// Shortened the default cursor tail to be equal to that of the default X one
//
// Revision 1.13  2001/10/15 23:35:20  king
// Removed static declaration on xpms
//
// Revision 1.12  2001/10/15 23:04:14  manus
// Updated cursors
//
// Revision 1.11  2001/10/15 22:30:27  manus
// Moved pixmap definitions from header to c file
//
// Revision 1.10  2001/08/30 19:17:09  king
// Made log message buffer static
//
// Revision 1.9  2001/08/24 20:50:08  king
// Removed unused external
//
// Revision 1.8  2001/08/03 18:41:26  king
// Removed no longer needed externals
//
// Revision 1.7  2001/07/24 19:00:30  king
// Corrected debugging output, slight optimization of logging
//
// Revision 1.6  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.5.2.9  2001/06/05 17:32:09  king
// Including all gtk message logging domains
//
// Revision 1.5.2.8  2001/06/05 01:29:55  king
// Updated message logging modes
//
// Revision 1.5.2.7  2001/06/04 20:05:01  king
// Updated enable_ev_gtk_log to include debig signature
//
// Revision 1.5.2.6  2001/06/04 19:05:19  king
// Removed printing of error messages for later debug mechanism
//
// Revision 1.5.2.5  2000/11/29 00:40:42  king
// Implemented gtk_args_array_i_th
//
// Revision 1.5.2.4  2000/10/12 16:20:49  king
// Removed set_pixmap_and_mask
//
// Revision 1.5.2.3  2000/10/02 23:14:10  king
// Added test set_pixmap_and_mask
//
// Revision 1.5.2.2  2000/07/20 18:38:33  king
// Added double_array_i_th
//
// Revision 1.5.2.1  2000/05/03 19:08:33  oconnor
// mergred from HEAD
//
// Revision 1.5  2000/04/18 21:43:23  king
// Moved string_pointer_deref definition from header to source
//
// Revision 1.4  2000/04/18 17:58:01  oconnor
// Renamed get_pointer_from_array_by_index -> pointer_array_i_th
// Added string_pointer_deref (pointer: POINTER): POINTER
//
// Revision 1.3  2000/02/17 22:40:58  oconnor
// modified eraise call to not need snprintf, NOt avalible on Solaris.
//
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.2.4  2000/02/11 04:53:18  oconnor
// tweaked log
//
// Revision 1.1.2.3  2000/02/11 04:48:50  oconnor
// attached GTK+ exception system to Eiffel
//
// Revision 1.1.2.2  2000/01/17 17:58:35  brendel
// Removed strange CVS log.
//
// Revision 1.1.2.1  2000/01/14 22:17:14  brendel
// Initial.
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
