/*

 #       #    #    ##    #       #        ####    ####           #    #
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               ######
 #       #    #  ######  #       #       #    #  #        ###    #    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###    #    #

*/

#ifndef _eif_lmalloc_h_
#define _eif_lmalloc_h_

#include "eif_config.h"
#include "eif_portable.h"


#ifdef LMALLOC_DEBUG
#include <stdio.h>
#define eif_malloc(x) (fprintf (stderr, "%s:%d\t|", __FILE__, __LINE__), eiffel_malloc (x))
#define eif_calloc(x,y) (fprintf (stderr, "%s:%d\t|", __FILE__, __LINE__), eiffel_realloc (x, y))
#define eif_realloc(x,y) (fprintf (stderr, "%s:%d\t|", __FILE__, __LINE__), eiffel_realloc (x, y))
#define eif_free(x) (fprintf (stderr, "%s:%d\t|", __FILE__, __LINE__), eiffel_free (x))
#else
#define eif_malloc(x) eiffel_malloc (x)
#define eif_calloc(x,y) eiffel_calloc (x,y)
#define eif_realloc(x,y) eiffel_realloc (x,y)
#define eif_free(x) eiffel_free (x)
#endif	/* LMALLOC_DEBUG */

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK int is_in_lm (void *ptr);
RT_LNK void eif_lm_display ();
RT_LNK int eif_lm_free ();
RT_LNK Malloc_t eiffel_malloc (register unsigned int nbytes);
RT_LNK Malloc_t eiffel_calloc (unsigned int nelem, unsigned int elsize) ;
RT_LNK Malloc_t eiffel_realloc (void *ptr, unsigned int nbytes);
RT_LNK void eiffel_free (void *ptr) ;

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
