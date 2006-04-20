/*
	description: "Externals for class CONSOLE."
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
RT_LNK void console_pr(FILE *f, EIF_REAL_32 number);
RT_LNK void console_pc(FILE *f, EIF_CHARACTER c);
RT_LNK void console_pd(FILE *f, EIF_REAL_64 val);
RT_LNK void console_pi(FILE *f, EIF_INTEGER number);
RT_LNK void console_tnwl(FILE *f);
RT_LNK EIF_CHARACTER console_readchar(FILE *f);
RT_LNK EIF_REAL_32 console_readreal(FILE *f);
RT_LNK EIF_INTEGER console_readint(FILE *f);
RT_LNK EIF_REAL_64 console_readdouble(FILE *f);
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

