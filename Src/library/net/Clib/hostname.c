/*
	added c features
*/

#include "eif_portable.h"
#include "eif_macros.h"

#if defined EIF_WIN32 || defined EIF_OS2
	/* unistd.h doesn't exist */
#else
#include <unistd.h>
#endif

#ifdef EIF_WIN32
#include <winsock.h>
#endif

#ifndef MAXHOSTNAMELEN      /* added for dgux and other platforms maybe */
#define MAXHOSTNAMELEN 128
#endif


EIF_REFERENCE c_get_hostname()
	/*x get host name in dotted format */
{
	static char hostname[MAXHOSTNAMELEN + 1];

	if (gethostname (hostname, sizeof(hostname)) == -1)
		hostname[0] = '\0';

	return (EIF_REFERENCE) RTMS (hostname);
}
