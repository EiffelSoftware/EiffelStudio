/*

  ####   ######  #####   #    #  ######  #####            ####
 #       #       #    #  #    #  #       #    #          #    #
  ####   #####   #    #  #    #  #####   #    #          #
      #  #       #####   #    #  #       #####    ###    #
 #    #  #       #   #    #  #   #       #   #    ###    #    #
  ####   ######  #    #    ##    ######  #    #   ###     ####

	Network handling of debugging requests, when application is stopped.
*/

#include "config.h"
#include "portable.h"
#include "proto.h"
#include "hector.h"
#include "local.h"			/* For epop() */
#include "out.h"			/* For build_out() */
#include "debug.h"

extern int ised;			/* Socket used to talk with daemon */

shared void dserver()
{
	/* This routine is called by the debugger once the program context has
	 * been solved. The application enters in a server mode, after having
	 * sent a stop notification to the remote workbench.
	 */

	stop_rqst(ised);		/* Notify workbench we stopped */
	wide_listen();			/* Listen on the socket, waiting for requests */

	/* Exiting from this routine resumes control to the debugger */
}

shared char *dview(root)
char *root;
{
	/* Compute the tagged out form for object 'root' and return a pointer to
	 * the location of the C buffer holding the string. Note that the
	 * build_out() run-time routine expects an EIF_OBJ pointer.
	 */

	EIF_OBJ object;				/* The hector pointer */
	char *out;					/* Where out form is stored */

	object = hrecord(root);		/* Protect object against GC effects */
	out = build_out(object);	/* Build `tagged_out' (I hate that name--RAM) */
	epop(&hec_stack);			/* Release object from hector stack */

	return out;		/* To-be-freed pointer to the tagged out representation */
}

