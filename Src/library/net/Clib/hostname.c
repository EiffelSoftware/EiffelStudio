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

static char hostname[MAXHOSTNAMELEN + 1];

EIF_POINTER c_get_hostname()
	/*x get host name in dotted format */
{
	if (gethostname (hostname, sizeof(hostname)) == -1)
		hostname[0] = '\0';

	return hostname;
}
