/*

  ####    ####   #    #   ####    ####   #       ######          #    #
 #    #  #    #  ##   #  #       #    #  #       #               #    #
 #       #    #  # #  #   ####   #    #  #       #####           ######
 #       #    #  #  # #       #  #    #  #       #        ###    #    #
 #    #  #    #  #   ##  #    #  #    #  #       #        ###    #    #
  ####    ####   #    #   ####    ####   ######  ######   ###    #    #

	Externals for class CONSOLE

*/

#ifndef _console_h_
#define _console_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"
#include "portable.h"  

#include "file.h"

#ifdef EIF_WINDOWS
#include "eif_cons.h"	/* extra/mswin/console or extra/win32/console */
#endif

#ifdef EIF_WIN32
extern void eif_console_next_line(void);	/* extra/win32/console/econsole.c */
extern void eif_console_putstring(char *s, long len);	/* extra/win32/console/econsole.c , should be (BYTE, long) */
#else
extern void eif_console_next_line(void);
#endif

extern EIF_POINTER console_def(int file);
extern EIF_BOOLEAN console_eof(FILE *fp);
extern EIF_CHARACTER console_separator(FILE *f);
extern void console_ps(FILE *f, char *str, EIF_INTEGER len);
extern void console_pr(FILE *f, EIF_REAL number);
extern void console_pc(FILE *f, EIF_CHARACTER c);
extern void console_pd(FILE *f, EIF_DOUBLE val);
extern void console_pi(FILE *f, EIF_INTEGER number);
extern void console_tnwl(FILE *f);
extern EIF_CHARACTER console_readchar(FILE *f);
extern EIF_REAL console_readreal(FILE *f);
extern EIF_INTEGER console_readint(FILE *f);
extern EIF_DOUBLE console_readdouble(FILE *f);
extern EIF_INTEGER console_readword(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
extern EIF_INTEGER console_readline(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
extern void console_next_line(FILE *f);
extern EIF_INTEGER console_readstream(FILE *f, char *s, EIF_INTEGER bound);
extern void console_file_close (FILE *f);

#ifdef __cplusplus
}
#endif

#endif

