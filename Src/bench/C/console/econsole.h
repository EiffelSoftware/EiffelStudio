/*
	EIF_CONS.H - a console for Win32.

*/

#include "eiffel.h"

extern void eif_console_next_line(void);
extern void eif_console_putint(EIF_INTEGER);
extern void eif_console_putreal(EIF_DOUBLE);
extern void eif_console_putdouble(EIF_DOUBLE);
extern void eif_console_putchar(EIF_CHARACTER);
extern void eif_console_pustring(EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER eif_console_readline(EIF_POINTER, EIF_INTEGER, EIF_INTEGER);
extern EIF_REAL eif_console_readreal();
extern EIF_DOUBLE eif_console_readdouble();
extern EIF_CHARACTER eif_console_readchar();
extern EIF_INTEGER eif_console_readint();
extern EIF_INTEGER eif_console_readword(EIF_POINTER, EIF_INTEGER, EIF_INTEGER);
extern EIF_INTEGER eif_console_readstream(EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN eif_console_eof();
#
