/*
	added c features
*/

#include <unistd.h>
#include "portable.h"

#ifndef MAXHOSTNAMELEN      /* added for dgux and other platforms maybe */
#define MAXHOSTNAMELEN 128
#endif


EIF_REFERENCE c_get_hostname()
	/*x get host name in dotted format */
{
    static char hostname[MAXHOSTNAMELEN + 1];

    if (gethostname (hostname, sizeof(hostname)) == -1)
        hostname[0] = '\0';

	return (EIF_REFERENCE) makestr (hostname, strlen(hostname));
}
