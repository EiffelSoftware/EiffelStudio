/*

	Externals for class  CONSOLE

*/

#include "config.h"
#include "portable.h"
#include <stdio.h>

#include "file.h"

public char *console_def(file)
int file;
{
#ifdef __WATCOMC__
	return NULL;
#else
	return file_def (file);
#endif
}            

public char console_eof(fp)
FILE *fp;      
{
#ifdef __WATCOMC__
	return eif_console_eof();
#else
	return file_feof (fp);
#endif
}            

/*
 * I/O routines (output).
 */

public void console_pi(f, number)
FILE *f;
int	number;
{
#ifdef __WATCOMC__
	eif_console_putint (number);
#else
	file_pi (f, number);	
#endif
}

public void console_pr(f, number)
FILE *f;
float number;
{
#ifdef __WATCOMC__
	eif_console_putreal (number);
#else
	file_pr (f, number);	
#endif
}

public void console_ps(f, str, len)
FILE *f;
char *str;
int len;
{
#ifdef __WATCOMC__
	eif_console_putstring (str, len);
#else
	file_ps (f, str, len);
#endif
}

public void console_pc(f, c)
FILE *f;
char c;
{
#ifdef __WATCOMC__
	eif_console_putchar (c);
#else
	file_pc (f, c);
#endif
}

public void console_pd(f, val)
FILE *f;
double val;
{
#ifdef __WATCOMC__
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
#ifdef __WATCOMC__
#else
	file_tnil (f);
#endif
}

public long console_readint(f) 
FILE *f;     
{
#ifdef __WATCOMC__
	return eif_console_readint();
#else
	return file_gi (f);
#endif             
}

public float console_readreal(f) 
FILE *f;     
{
#ifdef __WATCOMC__
	return eif_console_readreal();
#else
	return file_gr (f);
#endif             
}

public double console_readdouble(f) 
FILE *f;     
{
#ifdef __WATCOMC__
	return eif_console_readdouble();
#else
	return file_gd(f);
#endif             
}
public char	console_readchar(f)
FILE *f;
{
#ifdef __WATCOMC__
	return eif_console_readchar();
#else
	return file_gc (f);
#endif
}

public long console_readline(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
long start;		/* Amount of characters already held in buffer */
{
#ifdef __WATCOMC__
	return eif_console_readline (s, bound, start);
#else
	return file_gs (f, s, bound, start);
#endif
}

public long console_readstream(f, s, bound)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
{
#ifdef __WATCOMC__
	return eif_console_readstream (s, bound);
#else
	return file_gss (f, s, bound);
#endif
}

public long console_readword(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
long start;		/* Amount of characters already held in buffer */
{
#ifdef __WATCOMC__
	return eif_console_readword (s, bound, start);
#else
	return file_gw (f, s, bound, start);
#endif
}

public char console_separator(f)
FILE *f;
{
#ifdef __WATCOMC__
	return ' '
#else
	return file_lh (f);
#endif
}

