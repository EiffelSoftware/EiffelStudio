/*
	description: "Include file for signal handling."
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

#ifndef _eif_signal_h_
#define _eif_signal_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void initsig(void);			/* Initialize the Eiffel handling of signals */

/* Eiffel interface with class UNIX_SIGNALS */
RT_LNK long esigmap(long int idx);		/* Mapping between constants and signal numbers */
RT_LNK char *esigname(long int sig);	/* Signal description */
RT_LNK long esignum(EIF_CONTEXT_NOARG);		/* Signal number */
RT_LNK void esigcatch(long int sig);	/* Catch signal */
RT_LNK void esigignore(long int sig);	/* Ignore signal */
RT_LNK char esigiscaught(long int sig);	/* Is signal caught? */
RT_LNK char esigdefined(long int sig);	/* Is signal defined? */
RT_LNK void esigresall(void);	/* Reset all signal to their default handling */
RT_LNK void esigresdef(long int sig);	/* Reset a signal to its default handling */

#ifdef EIF_VMS 
/* CECIL calls to control signal handling */
RT_LNK void esig_cecil_register(struct ex_vect*);   /* enable CECIL control of signal handling */
RT_LNK void esig_cecil_enter(void);	/* increment signal handling call counter */
RT_LNK void esig_cecil_exit(void);	/* decrement signal handling call counter */
#endif /* EIF_VMS */

#ifdef __cplusplus
}
#endif

#endif

