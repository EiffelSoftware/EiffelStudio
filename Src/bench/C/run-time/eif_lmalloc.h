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

#ifdef __cplusplus
extern "C" {
#endif

extern Malloc_t eif_malloc (register unsigned int nbytes);
extern Malloc_t eif_calloc (unsigned int nelem, unsigned int elsize) ;
extern Malloc_t eif_realloc (void *ptr, unsigned int nbytes) ;
extern void eif_free (void *ptr) ;

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
