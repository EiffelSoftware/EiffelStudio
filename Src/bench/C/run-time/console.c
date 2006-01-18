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

/*
doc:	<attribute name="compiler_need_flush" return_type="int" export="public">
doc:		<summary>When activated all outputs will be flushed immediately. This is needed to run `eweasel' on Windows otherwise read/write would block until buffer is filled.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:	</attribute>
*/
rt_public int compiler_need_flush = 0;

/*
doc:	<routine name="flush_buffer" return_type="void" export="private">
doc:		<summary>Flush all data held in `fp' if `compiler_need_flush'.</summary>
doc:		<param name="fp" type="FILE *">File to flush.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:	</routine>
*/

rt_private void flush_buffer (FILE *fp)
{
	if (compiler_need_flush) {
		file_flush(fp);
	}
}

rt_public EIF_BOOLEAN console_eof(FILE *fp)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_feof(fp);
}            

/*
 * I/O routines (output).
 */

rt_public void console_pi(FILE *f, EIF_INTEGER number)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_pi (f, number);
	flush_buffer(f);
}

rt_public void console_pr(FILE *f, EIF_REAL_32 number)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_pr (f, number);	
	flush_buffer(f);
}

rt_public void console_ps(FILE *f, char *str, EIF_INTEGER len)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_ps (f, str, len);
	flush_buffer(f);
}

rt_public void console_pc(FILE *f, EIF_CHARACTER c)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_pc (f, c);
}

rt_public void console_pd(FILE *f, EIF_REAL_64 val)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_pd (f, val);
	flush_buffer(f);
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
	file_tnil (f);
	flush_buffer(f);
}

rt_public EIF_INTEGER console_readint(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_gi (f);
}

rt_public EIF_REAL_32 console_readreal(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_gr (f);
}

rt_public EIF_REAL_64 console_readdouble(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_gd(f);
}
rt_public EIF_CHARACTER console_readchar(FILE *f)
{
#ifdef EIF_WINDOWS
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
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_gs (f, s, bound, start);
}

rt_public EIF_INTEGER console_readstream(FILE *f, char *s, EIF_INTEGER bound)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
{
#ifdef EIF_WINDOWS
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
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_gw (f, s, bound, start);
}

rt_public EIF_CHARACTER console_separator(FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	return file_lh (f);
}

rt_public void console_file_close (FILE *f)
{
#ifdef EIF_WINDOWS
	eif_show_console ();
#endif
	file_close (f);
}

/*
doc:</file>
*/
