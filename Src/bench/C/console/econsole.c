#include <stdio.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

static char eif_console_buffer [127];
static char transfer_buffer [30];
static count = 0;

static int eif_console_eof_value = 0;


extern HANDLE eif_coninfile, eif_conoutfile;

long eif_console_readint()
{
	long lastint;

	ReadConsole(eif_coninfile,eif_console_buffer, 127, &count, NULL);
	if (0 > sscanf (eif_console_buffer, "%i", &lastint))
		eio();

	return lastint;
}

float eif_console_readreal()
{
	float lastreal;

	ReadConsole(eif_coninfile,eif_console_buffer, 127, &count, NULL);
	if (0 > sscanf (eif_console_buffer, "%f", &lastreal))
		eio();

	return lastreal;
}

char eif_console_readchar()
	{
	char c;

	if (!ReadConsole (eif_coninfile, &c, 1, &count, NULL) || count == 0)
		c = EOF;
	return c;
	}

double eif_console_readdouble()
	{
	double lastdouble;
		
	ReadConsole(eif_coninfile,eif_console_buffer, 127, &count, NULL);
	if (0 > sscanf (eif_console_buffer, "%lf", &lastdouble))
		eio();

	return lastdouble;
	}

long eif_console_readline(char *s,long bound,long start)
	{
	long amount, read;
	static char *c = NULL;
	static BOOL done = FALSE;
	BOOL result;
	
	read = 0;

	if (!done)
		{	
		c = NULL;
		done = TRUE;
		}
	if (c == NULL)	
		{
		__try
			{
			result = ReadConsole(eif_coninfile, eif_console_buffer, 127, &count, NULL);
			}
		__except (EXCEPTION_EXECUTE_HANDLER)
			{
			eio();
			}
		c = eif_console_buffer;
		}

	if (count == 0)
		{
		eif_console_eof_value = 1;
		return 0;
		}

	amount = bound - start;
	s += start;
	
	while (amount-- > 0) 
		{
		if (*c == '\n')
			break;
		if (*c != '\r')
			{
			*s++ = *c++;
			read ++;
			}
		else
			c++;
		}

	if (*c == '\n')
		{
		c = NULL;
		return read;
		}

	if (amount == -1)
		return (read + 1);

	return bound - start + 1;
	}

long eif_console_readstream(char *s, long bound)
	{
	long amount;
	char *c;
	BOOL result;

	result = ReadConsole(eif_coninfile,eif_console_buffer, 127, &amount, NULL);
	
	if (!result)
		 {
		 eif_console_eof_value = 1;
		 return bound - amount - 1;
		 }

	c = eif_console_buffer;
	amount = bound;
	
	while (amount-- > 0) 
		*s++ = *c++;

	return bound - amount - 1;
	}


long eif_console_readword(char *s, long bound, long start)
/*
s		target buffer
bound	target buffer size
start	number of characters already in target buffer
*/
	{
		/* Get a word and fill it into `s' (at most `bound' characters),
		 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters. Any leading
	 * spaces are skipped.
	 */

	long amount;	/* Amount of bytes to be read */
	static int c;	/* Last char read */

	amount = bound - start; 	/* Characters to be read */
	s += start;					/* Where read characters are written */

	if (start == 0) {			/* First call */
		while ((c = eif_console_readchar()) != EOF)
			if (!isspace(c))
				break;
		if (c == EOF)
			{
			eif_console_eof_value = 1;
			return 0;				/* Reached EOF before word */
			}
	}

	while (amount-- > 0) {
		*s++ = c;
		c = eif_console_readchar();
		if (c != EOF && isspace(c)) {
			break;
		}
	}
	
	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */
	
	if (c == EOF || isspace(c))
		return bound - start - amount;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
	}

void eif_console_putint (long l)
	{
	int t = 0;

	t = sprintf (transfer_buffer, "%i", l);
	WriteConsole(eif_conoutfile,transfer_buffer, t, &count, NULL);
	}

void eif_console_putchar (char c)
	{
	transfer_buffer[0] = c;
	WriteConsole(eif_conoutfile,transfer_buffer,1, &count, NULL);
	}

void eif_console_putstring (BYTE *s, long length)
	{
	WriteConsole(eif_conoutfile,s, length, &count, NULL);
	}

void eif_console_putreal (double r)
	{
	int t = 0;

	t = sprintf (transfer_buffer, "%g", (float) r);
	WriteConsole(eif_conoutfile,transfer_buffer, t, &count, NULL);
	}

void eif_console_putdouble (double d)
	{
	int t = 0;

	t = sprintf (transfer_buffer, "%.17g", d);
	WriteConsole(eif_conoutfile,transfer_buffer, t, &count, NULL);
	}


char eif_console_eof ()
{
	return (eif_console_eof_value == 1 ? '\01' : '\00');
}

void eif_console_next_line()
{
	char c;
	BOOL res;

	while ((res = ReadConsole (eif_coninfile, &c, 1, &count, NULL)) && count != 0 && c != '\x0a')
		;
	if (!res || count == 0)
		eio();
}
