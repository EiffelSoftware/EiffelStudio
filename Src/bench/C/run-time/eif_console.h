/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Externals for class CONSOLE
*/

#ifndef _eif_console_h_
#define _eif_console_h_

#include "eif_portable.h"  

#include "eif_file.h"

#ifdef __cplusplus
extern "C" {
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

RT_LNK int compiler_need_flush;

#ifdef __cplusplus
}
#endif

#endif

