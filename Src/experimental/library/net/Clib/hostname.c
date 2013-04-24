/*
indexing
	description: "EiffelNet: library of reusable components for networking."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_portable.h"
#include "eif_macros.h"

#ifdef EIF_WINDOWS
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
#ifdef EIF_WINDOWS
	do_init ();
#endif

	if (gethostname (buffer, (int) buffer_count) == -1) {
		buffer[0] = '\0';
	} else {
			/* Clear error flag. */
		errno = 0;
	}
}
