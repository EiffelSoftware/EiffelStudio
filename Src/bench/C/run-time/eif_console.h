/*

  ####    ####   #    #   ####    ####   #       ######          #    #
 #    #  #    #  ##   #  #       #    #  #       #               #    #
 #       #    #  # #  #   ####   #    #  #       #####           ######
 #       #    #  #  # #       #  #    #  #       #        ###    #    #
 #    #  #    #  #   ##  #    #  #    #  #       #        ###    #    #
  ####    ####   #    #   ####    ####   ######  ######   ###    #    #

	Externals for class CONSOLE

*/

#ifndef _eif_console_h_
#define _eif_console_h_

#include "eif_portable.h"  

#include "eif_file.h"

#ifdef EIF_WIN32
#include "eif_econsole.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_WIN32
extern void eif_console_next_line(void);
#endif

RT_LNK EIF_POINTER console_def (EIF_INTEGER file);
RT_LNK EIF_BOOLEAN console_eof (FILE *fp);
RT_LNK EIF_CHARACTER console_separator(FILE *f);
RT_LNK void console_ps(FILE *f, char *str, EIF_INTEGER len);
RT_LNK void console_pr(FILE *f, EIF_REAL number);
RT_LNK void console_pc(FILE *f, EIF_CHARACTER c);
RT_LNK void console_pd(FILE *f, EIF_DOUBLE val);
RT_LNK void console_pi(FILE *f, EIF_INTEGER number);
RT_LNK void console_tnwl(FILE *f);
RT_LNK EIF_CHARACTER console_readchar(FILE *f);
RT_LNK EIF_REAL console_readreal(FILE *f);
RT_LNK EIF_INTEGER console_readint(FILE *f);
RT_LNK EIF_DOUBLE console_readdouble(FILE *f);
RT_LNK EIF_INTEGER console_readword(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK EIF_INTEGER console_readline(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK void console_next_line(FILE *f);
RT_LNK EIF_INTEGER console_readstream(FILE *f, char *s, EIF_INTEGER bound);
RT_LNK void console_file_close (FILE *f);

#ifdef __cplusplus
}
#endif

#endif

