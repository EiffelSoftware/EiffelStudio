/*

 ######  #####   #####    ####   #####            ####
 #       #    #  #    #  #    #  #    #          #    #
 #####   #    #  #    #  #    #  #    #          #
 #       #####   #####   #    #  #####    ###    #
 #       #   #   #   #   #    #  #   #    ###    #    #
 ######  #    #  #    #   ####   #    #   ###     ####

	System error handling.
*/

#include "eif_portable.h"
#include "eif_except.h"
#include "eif_error.h"

#include <string.h>			/* Try to find strerror() there */

rt_public char *error_tag(int code)
{
	/* Returns a pointer to the English description of the system error whose
	 * code is stored in errno, or a null pointer if that description is not
	 * available.
	 */

	if (code == 0)					/* No error recorded */
		return (char *) 0;			/* No description necessary */

#if defined HAS_STRERROR || defined HAS_SYS_ERRLIST
	return (char *) Strerror(code);			/* Macro defined by Configure */
#else
	return (char *) 0;		/* English description not available */
#endif
}

rt_public void esys(void)
{
	/* Raise the 'Operating system error' exception, based on the error code
	 * held in variable errno. The associated tag will be an English description
	 * of that error, if provided by the system.
	 * If errno is zero, the 'External event' exception is generated instead.
	 */

#ifdef EIF_VMS
	int err = errno;
#endif
	if (errno == 0)					/* Function did not set errno? */
		xraise(EN_EXT);				/* External event */

	xraise(EN_SYS);					/* Operating system error */
}

rt_public void eio (void)
	/* As a special case, an I/O error is raised when a system call which is
	 * I/O bound fails.  */
{
	xraise (EN_IO);
}

rt_public void eise_io(char *tag)
{
	/* As a special case, an I/O error is raised when a system call which is
	 * I/O bound fails.  */

	eraise(tag, EN_ISE_IO);					/* I/O error */
}
