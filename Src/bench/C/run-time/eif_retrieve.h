/*

 #####   ######  #####  #####    #   ######  #    #  ######          #    #
 #    #  #         #    #    #   #   #       #    #  #               #    #
 #    #  #####     #    #    #   #   #####   #    #  #####           ######
 #####   #         #    #####    #   #       #    #  #        ###    #    #
 #   #   #         #    #   #    #   #        #  #   #        ###    #    #
 #    #  ######    #    #    #   #   ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _eif_retrieve_h_
#define _eif_retrieve_h_

#include <stdio.h>
#include "eif_globals.h"
#include "eif_cecil.h"

#ifdef __cplusplus
extern "C" {
#endif
 
/* Internal representation of the different kinds of storage */
#define BASIC_STORE '\0'
#define GENERAL_STORE '\01'
#define INDEPENDENT_STORE '\02'
/* TODO: Should this be used instead of INDEPENDENT_STORE? */
#define RECOVERABLE_STORE '\03'

/* Setting of `eif_discard_pointer_values' */
#define eif_set_discard_pointer_values(v)	eif_discard_pointer_values = (EIF_BOOLEAN) (v)

/*
 * Eiffel calls
 */
RT_LNK char *eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
RT_LNK EIF_REFERENCE stream_eretrieve(EIF_POINTER *, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER *);	/* Retrieve object store in stream */
RT_LNK char *portable_retrieve(int (*char_read_function)(char *, int));


/*
 * Utilities
 */

RT_LNK EIF_BOOLEAN eif_discard_pointer_values;	/* Do we need to store pointers or not? */

#ifdef __cplusplus
}
#endif

#endif

