/* ...C/platform/names.c */
/* $Id$ */

#ifdef EIF_WIN32
#include <windows.h>
#endif

#include "eif_eiffel.h"
#include "eif_misc.h"

rt_public EIF_REFERENCE eif_timeout_msg (void)
{
	/* Message displayed when estudio is unable to launch
	 * the system (because of a timeout).
	 */

	char *eif_timeout;
	extern char *getenv(const char *);				/* Get environment variable value */

	char s[512];

	strcpy(s, "Could not launch system in allotted time.\n");
	strcat(s, "Try restarting estudio after setting ");
#ifdef EIF_VMS
	strcat(s, "the logical name \n");
#else
	strcat(s, "the environment\nvariable ");
#endif
	strcat(s, "ISE_TIMEOUT to a value larger than\n");

	eif_timeout = getenv("ISE_TIMEOUT");
	if (eif_timeout != (char *) 0) {	/* Environment variable set */
		strcat(s, "current value ");
		strcat(s, eif_timeout);
	} else {
		strcat(s, "the default 120");
	}
	strcat(s, " seconds.\n");
	return RTMS (s);
}
