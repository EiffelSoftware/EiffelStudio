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

#ifdef __cplusplus
}
#endif

#endif

