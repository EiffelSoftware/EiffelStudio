/*

 ######  #####   #####    ####   #####            ####
 #       #    #  #    #  #    #  #    #          #    #
 #####   #    #  #    #  #    #  #    #          #
 #       #####   #####   #    #  #####    ###    #
 #       #   #   #   #   #    #  #   #    ###    #    #
 ######  #    #  #    #   ####   #    #   ###     ####

	System error handling.
*/

#include "config.h"
#include "portable.h"
#include "except.h"

#ifdef I_STRING
#include <string.h>			/* Try to find strerror() there */
#else
#include <strings.h>
#endif

extern int errno;			/* System call error status */

public char *error_tag(code)
{
	/* Returns a pointer to the English description of the system error whose
	 * code is stored in errno, or a null pointer if that description is not
	 * available.
	 */

#ifdef HAS_SYS_ERRLIST
	extern int sys_nerr;			/* Size of sys_errlist[] */
	extern char *sys_errlist[];		/* Maps error code to string */
#endif

	if (code == 0)					/* No error recorded */
		return (char *) 0;			/* No description necessary */

#ifdef HAS_STRERROR
	return (char *) strerror(code);
#else
#ifdef HAS_SYS_ERRLIST
	return strerror(code);			/* Macro defined by Configure */
#else
	return (char *) 0;		/* English description not available */
#endif
#endif
}

public void esys()
{
	/* Raise the 'Operating system error' exception, based on the error code
	 * held in variable errno. The associated tag will be an English description
	 * of that error, if provided by the system.
	 * If errno is zero, the 'External event' exception is generated instead.
	 */

	if (errno == 0)					/* Function did not set errno? */
		xraise(EN_EXT);				/* External event */

	xraise(EN_SYS);					/* Operating system error */
}

public void eio()
{
	/* As a special case, an I/O error is raised when a system call which is
	 * I/O bound fails.
	 */

	xraise(EN_IO);					/* I/O error */
}

public int get_errno()
{
	/* Return the value of errno to Eiffel (waiting for Eiffel external
	 * attributes support)--RAM.
	 */

	return errno;
}

