/*

	Externals for class  CONSOLE

*/

#include "config.h"
#include "portable.h"
#include <stdio.h>

#include "file.h"

#ifdef __WINDOWS_386__
extern void eif_console_putint (long);
extern void eif_console_putreal (double);
extern void eif_console_putdouble (double);
extern void eif_console_putchar (char);
extern void eif_console_pustring (char *, int);
extern long eif_console_readline (char *, int, int);
extern long eif_console_readword (char *, int, int);
extern long eif_console_readstream (char *, int);
#else
extern void eif_console_putint ();
extern void eif_console_putreal ();
extern void eif_console_putdouble ();
extern void eif_console_putchar ();
extern void eif_console_pustring ();
extern long eif_console_readline ();
extern long eif_console_readword ();
extern long eif_console_readstream ();
#endif

extern long eif_console_readint ();
extern char eif_console_readchar ();
extern double eif_console_readdouble ();
extern float eif_console_readreal ();

public EIF_POINTER file_def(file)
int file;
{
	/* Convert the integer `i' into the corresponding
	 * inpout output standard file :
	 *       0 : standard input file descriptor
	 *       1 : standard output file descriptor
	 *       2 : standard error file descriptor
	 *      otherwise : panic
	 */

	switch (file) {
	case 0: return (EIF_POINTER) stdin;
	case 1: return (EIF_POINTER) stdout;
	case 2: return (EIF_POINTER) stderr;
	default: panic("invalid file request");
	}

	/* NOTREACHED */
}

public EIF_POINTER console_def(file)
int file;
{
#ifdef __WINDOWS_386__
	return (EIF_POINTER) NULL;
#else
	return file_def (file);
#endif
}            

public EIF_BOOLEAN console_eof(fp)
FILE *fp;      
{
#ifdef __WINDOWS_386__
	return eif_console_eof();
#else
	return file_feof(fp);
#endif
}            

/*
 * I/O routines (output).
 */

public void console_pi(f, number)
FILE *f;
EIF_INTEGER	number;
{
#ifdef __WINDOWS_386__
		/* `f' will be Void for all the instances of CONSOLE.
		 * If `default_output' is of type PLAIN_TEXT_FILE (set
		 * with `set_file_default'), we want to call the standard
		 * functions. This comment is valid for all the output
		 * functions
		 */
	if (f)
		file_pi (f, number);
	else
		eif_console_putint (number);
#else
	file_pi (f, number);	
#endif
}

public void console_pr(f, number)
FILE *f;
EIF_REAL number;
{
#ifdef __WINDOWS_386__
	if (f)
		file_pr (f, number);
	else
		eif_console_putreal (number);
#else
	file_pr (f, number);	
#endif
}

public void console_ps(f, str, len)
FILE *f;
char *str;
EIF_INTEGER len;
{
#ifdef __WINDOWS_386__
	if (f)
		file_ps (f, str, len);
	else
		eif_console_putstring (str, len);
#else
	file_ps (f, str, len);
#endif
}

public void console_pc(f, c)
FILE *f;
EIF_CHARACTER c;
{
#ifdef __WINDOWS_386__
	if (f)
		file_pc (f, c);
	else
		eif_console_putchar (c);
#else
	file_pc (f, c);
#endif
}

public void console_pd(f, val)
FILE *f;
EIF_DOUBLE val;
{
#ifdef __WINDOWS_386__
	if (f)
		file_pd (f, val);
	else
		eif_console_putdouble (val);
#else
	file_pd (f, val);
#endif
}

public void console_tnwl(f)
FILE *f;
{
		console_pc(f,'\n');
}

/*
 * I/O routines (input).
 */

public void console_next_line(f)
FILE *f;
{
#ifdef __WINDOWS_386__
#else
	file_tnil (f);
#endif
}

public EIF_INTEGER console_readint(f) 
FILE *f;     
{
#ifdef __WINDOWS_386__
	return eif_console_readint();
#else
	return file_gi (f);
#endif             
}

public EIF_REAL console_readreal(f) 
FILE *f;     
{
#ifdef __WINDOWS_386__
	return eif_console_readreal();
#else
	return file_gr (f);
#endif             
}

public EIF_DOUBLE console_readdouble(f) 
FILE *f;     
{
#ifdef __WINDOWS_386__
	return eif_console_readdouble();
#else
	return file_gd(f);
#endif             
}
public EIF_CHARACTER console_readchar(f)
FILE *f;
{
#ifdef __WINDOWS_386__
	return eif_console_readchar();
#else
	return file_gc (f);
#endif
}

public EIF_INTEGER console_readline(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
EIF_INTEGER bound;		/* Size of the target buffer */
EIF_INTEGER start;		/* Amount of characters already held in buffer */
{
#ifdef __WINDOWS_386__
	return eif_console_readline (s, bound, start);
#else
	return file_gs (f, s, bound, start);
#endif
}

public EIF_INTEGER console_readstream(f, s, bound)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
EIF_INTEGER bound;		/* Size of the target buffer */
{
#ifdef __WINDOWS_386__
	return eif_console_readstream (s, bound);
#else
	return file_gss (f, s, bound);
#endif
}

public EIF_INTEGER console_readword(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
EIF_INTEGER bound;		/* Size of the target buffer */
EIF_INTEGER start;		/* Amount of characters already held in buffer */
{
#ifdef __WINDOWS_386__
	return eif_console_readword (s, bound, start);
#else
	return file_gw (f, s, bound, start);
#endif
}

public EIF_CHARACTER console_separator(f)
FILE *f;
{
#ifdef __WINDOWS_386__
	return (EIF_CHARACTER) ' ';
#else
	return file_lh (f);
#endif
}

public void console_file_close (f)
FILE *f;
{
#ifdef __WINDOWS_386__
	if (f) file_close (f);
#else
	file_close (f);
#endif
}
