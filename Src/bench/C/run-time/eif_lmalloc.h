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

extern int is_in_lm (void *ptr);
extern void eif_lm_display ();
extern Malloc_t eif_malloc (register unsigned int nbytes);
extern Malloc_t eif_calloc (unsigned int nelem, unsigned int elsize) ;
extern Malloc_t eif_realloc (void *ptr, unsigned int nbytes) ;
extern void eif_free (void *ptr) ;

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
