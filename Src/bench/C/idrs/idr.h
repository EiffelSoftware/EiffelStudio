/*

    #    #####   #####           #    #
    #    #    #  #    #          #    #
    #    #    #  #    #          ######
    #    #    #  #####    ###    #    #
    #    #    #  #   #    ###    #    #
    #    #####   #    #   ###    #    #

	This header file needs to be included by all IDR modules. However, clients
	never need to see this, but need to include <idrs.h> for declarations.
	In this respect, this file is "private".
*/

#ifndef _idr_h_
#define _idr_h_

#include "eif_config.h"
#include <sys/types.h>

#ifdef I_NETINET_IN
#include <netinet/in.h>		/* For ntohs and friends */
#else
#ifdef I_SYS_IN
#include <sys/in.h>			/* This may be needed instead of netinet */
#endif
#endif

#include "eif_portable.h"
		/* Included after standard include files to avoid
		 * redefinition of macros. */
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifdef EIF_WIN32
#include "io.h"
#else
#include "unistd.h"
#endif

#include "idrs.h"

/* Make sure the buffer can hold 'x' bytes, return false if this is not
 * possible. When serializing, this makes sure we'll have enough room for the
 * current type (especially simple types). When deserializing, it helps keeping
 * the consistency (trying to deserialize a longer structure).
 */
#define CHK_SIZE(i, x) { \
	if (((i)->i_ptr + (x)) > ((i)->i_buf + (i)->i_size)) \
		return FALSE; \
	}

#endif
