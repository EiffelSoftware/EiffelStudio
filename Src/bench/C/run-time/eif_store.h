/*

  ####    #####   ####   #####   ######          #    #
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           ######
      #     #    #    #  #####   #        ###    #    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###    #    #

	Declarations for store mechanism.

*/

#ifndef _eif_store_h_
#define _eif_store_h_

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "eif_globals.h"
#include "eif_malloc.h"				/* For macros HEADER */
#include "eif_garcol.h"				/* For flags manipulation */

#ifdef __cplusplus
extern "C" {
#endif

/* Setting of `eif_is_new_independent_format' */
#define eif_set_new_independent_format(v)	eif_is_new_independent_format = (EIF_BOOLEAN) (v)

/*
 * Eiffel calls
 */
RT_LNK void estore(EIF_INTEGER file_desc, char *object);
RT_LNK void eestore(EIF_INTEGER file_desc, char *object);
RT_LNK void sstore (EIF_INTEGER file_desc, char *object);

RT_LNK EIF_INTEGER stream_estore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_eestore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_sstore (EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);

RT_LNK EIF_POINTER *stream_malloc (EIF_INTEGER stream_size);
RT_LNK void stream_free (EIF_POINTER *stream);

RT_LNK EIF_BOOLEAN eif_is_new_independent_format;	/* Do we use the 4.5 independent
													   storable mechanism? */
#ifdef __cplusplus
}
#endif

#endif
