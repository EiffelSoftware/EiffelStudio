/*
	EIF_CONS.H - a console for Win32.

*/

#ifndef _eif_econsole_h_
#define _eif_econsole_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void get_argcargv (int *argc, char ***argv);
RT_LNK void free_argv (char ***argv);
RT_LNK HANDLE ghInstance;
RT_LNK HINSTANCE eif_hInstance;
RT_LNK HINSTANCE eif_hPrevInstance;
RT_LNK LPSTR eif_lpCmdLine;
RT_LNK int eif_nCmdShow;

extern void eif_console_cleanup (EIF_BOOLEAN);
extern void eif_console_next_line(void);
extern void eif_console_putint(EIF_INTEGER);
extern void eif_console_putreal(EIF_REAL);
extern void eif_console_putdouble(EIF_DOUBLE);
extern void eif_console_putchar(EIF_CHARACTER);
extern void eif_console_putstring(EIF_CHARACTER *, EIF_INTEGER);
extern EIF_INTEGER eif_console_readline(EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER);
extern EIF_REAL eif_console_readreal(void);
extern EIF_DOUBLE eif_console_readdouble(void);
extern EIF_CHARACTER eif_console_readchar(void);
extern EIF_INTEGER eif_console_readint(void);
extern EIF_INTEGER eif_console_readword(EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER);
extern EIF_INTEGER eif_console_readstream(EIF_CHARACTER *, EIF_INTEGER);
extern EIF_BOOLEAN eif_console_eof(void);

#ifdef __cplusplus
}
#endif

#endif /* eif_econsole_h_ */
