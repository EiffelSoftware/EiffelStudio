/*
	description: "Routines for interacting with the console."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="console.c" header="eif_console.h" version="$Id$" summary="Externals for CONSOLE class">
*/

#include "eif_portable.h"
#include <stdio.h>
#include "eif_file.h"
#include "rt_main.h"
#include "eif_console.h"
#include "rt_error.h"
#include "rt_assert.h"

rt_public EIF_POINTER console_def (EIF_INTEGER file)
{
#ifdef EIF_WINDOWS
	eif_show_console();
#endif

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
#ifdef EIF_VMS
		/*  On VMS, stdout is unbuffered by default when bound to a
		**  terminal device (CRTL Reference, setvbuf). Setting it to
		**  line buffered causes a problem with prompts: with stdout
		**  line buffered, a prompt without a newline is not written to
		**  the terminal until after the response is entered).
		**  Strictly speaking, programs should flush output after
		**  writing prompt and before reading input, but many do not.
		**  Further, VMS does the "right thing" by default."
		*/
#else
			/* Ideally we wanted to use _IOLBF but on Windows it is not
			 * supported. So to ensure we have the same behavior, we do
			 * not buffer `stdout'. */
	  	setvbuf(stdout, NULL, _IONBF, 0);
#endif
		return (EIF_POINTER) stdout;

	case 2:
#ifdef EIF_VMS
		/*  On VMS, stderr is (line) buffered. If set to unbuffered,
		**  each distinct write I/O call will create a separate record
		**  when stderr is bound to a file.
		*/
#else
		setvbuf (stderr, NULL, _IONBF, 0);
#endif
		return (EIF_POINTER) stderr;

	default:
		CHECK ("Invalid File Request", EIF_FALSE);
		return NULL;
	}
}            

rt_public EIF_BOOLEAN console_eof(FILE *fp)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_feof(fp);
}            

/*
 * I/O routines (output).
 */

rt_public void console_pi(FILE *f, EIF_INTEGER number)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_pi (f, number);
}

rt_public void console_pr(FILE *f, EIF_REAL_32 number)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_pr (f, number);	
}

rt_public void console_ps(FILE *f, char *str, EIF_INTEGER len)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_ps (f, str, len);
}

rt_public void console_pc(FILE *f, EIF_CHARACTER_8 c)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_pc (f, c);
}

rt_public void console_pd(FILE *f, EIF_REAL_64 val)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_pd (f, val);
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
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_tnil (f);
}

rt_public EIF_INTEGER console_readint(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gi (f);
}

rt_public EIF_REAL_32 console_readreal(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gr (f);
}

rt_public EIF_REAL_64 console_readdouble(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gd(f);
}
rt_public EIF_CHARACTER_8 console_readchar(FILE *f)
{
	int c;

#ifdef EIF_WINDOWS
	eif_show_console ();
#endif

		/* The code of `eif_file_gc' is duplicated here because of the special
		 * handling for Solaris. */
	errno = 0;
	c = getc(f);
#if EIF_OS == EIF_OS_SUNOS
		/* On Solaris trying to read from stdout or stderr does not generate an error
		 * when it does on other platforms. So if we read EOF and the file descriptor
		 * is one of them we raise an exception. This fixes eweasel test#except035. */
	if ((c == EOF) && ((f == stdout) || (f == stdin))) {
		eise_io("FILE: unable to read CHARACTER value.");
	}
#else
	if (c == EOF && ferror(f)) {
		eise_io("FILE: unable to read CHARACTER value.");
	}
#endif

	return (EIF_CHARACTER_8) c;
}

rt_public EIF_INTEGER console_readline(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gs (f, s, bound, start);
}

rt_public EIF_INTEGER console_readstream(FILE *f, char *s, EIF_INTEGER bound)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gss (f, s, bound);
}

rt_public EIF_INTEGER console_readword(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_gw (f, s, bound, start);
}

rt_public EIF_CHARACTER_8 console_separator(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return eif_file_lh (f);
}

rt_public void console_file_close (FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	eif_file_close (f);
}

/*
doc:</file>
*/
