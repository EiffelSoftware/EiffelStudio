/*
	Externals for class  CONSOLE
*/

#include "eif_portable.h"
#include <stdio.h>
#include "eif_file.h"
#include "rt_main.h"
#include "eif_console.h"
#include "rt_assert.h"

rt_public EIF_POINTER console_def (EIF_INTEGER file)
{
	/* Convert the integer `i' into the corresponding
	 * inpout output standard file :
	 *       0 : standard input file descriptor
	 *       1 : standard output file descriptor
	 *       2 : standard error file descriptor
	 */

	switch (file) {
	case 0:
	  	return (EIF_POINTER) stdin;
	case 1:
			/* Output is set to only have line buffered. Meaning that
			 * each displayed %N will flush the buffer. */
	  	setvbuf(stdout, NULL, _IOLBF, 0);
		return (EIF_POINTER) stdout;
	case 2:
		return (EIF_POINTER) stderr;
	default:
		CHECK ("Invalid File Request", EIF_FALSE);
		return NULL;
	}
}            

rt_public EIF_BOOLEAN console_eof(FILE *fp)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_feof(fp);
}            

/*
 * I/O routines (output).
 */

rt_public void console_pi(FILE *f, EIF_INTEGER number)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_pi (f, number);	
}

rt_public void console_pr(FILE *f, EIF_REAL number)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_pr (f, number);	
}

rt_public void console_ps(FILE *f, char *str, EIF_INTEGER len)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_ps (f, str, len);
}

rt_public void console_pc(FILE *f, EIF_CHARACTER c)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_pc (f, c);
}

rt_public void console_pd(FILE *f, EIF_DOUBLE val)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_pd (f, val);
}

rt_public void console_tnwl(FILE *f)
{
	console_pc(f,'\n');
}

/*
 * I/O routines (input).
 */

rt_public void console_next_line(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_tnil (f);
}

rt_public EIF_INTEGER console_readint(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gi (f);
}

rt_public EIF_REAL console_readreal(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gr (f);
}

rt_public EIF_DOUBLE console_readdouble(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gd(f);
}
rt_public EIF_CHARACTER console_readchar(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gc (f);
}

rt_public EIF_INTEGER console_readline(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gs (f, s, bound, start);
}

rt_public EIF_INTEGER console_readstream(FILE *f, char *s, EIF_INTEGER bound)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gss (f, s, bound);
}

rt_public EIF_INTEGER console_readword(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_gw (f, s, bound, start);
}

rt_public EIF_CHARACTER console_separator(FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	return file_lh (f);
}

rt_public void console_file_close (FILE *f)
{
#ifdef EIF_WIN32
	eif_show_console ();
#endif
	file_close (f);
}
