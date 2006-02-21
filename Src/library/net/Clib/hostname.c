/*
	added c features
*/

#include "eif_portable.h"
#include "eif_macros.h"

#if defined EIF_WINDOWS || defined EIF_OS2
	/* unistd.h doesn't exist */
#else
#include <unistd.h>
#endif

#ifdef VXWORKS
#include <hostLib.h>
#endif

#ifdef EIF_WINDOWS
#include <winsock.h>
extern void do_init (void);
#endif

void c_get_hostname(char * buffer, size_t buffer_count)
	/*x get host name in dotted format */
{
#if defined EIF_WINDOWS || defined EIF_OS2
	do_init ();
#endif

	if (gethostname (buffer, buffer_count) == -1) {
		buffer[0] = '\0';
	}
}
