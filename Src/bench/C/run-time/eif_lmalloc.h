/*

 #       #    #    ##    #       #        ####    ####           #    #
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               ######
 #       #    #  ######  #       #       #    #  #        ###    #    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###    #    #

*/

#ifndef _lmalloc_h_
#define _lmalloc_h_

#ifndef EIF_THREADS

#ifdef __cplusplus
extern "C" {
#endif

extern Malloc_t eiffel_malloc(register unsigned int nbytes);

#ifdef __cplusplus
}
#endif

#endif /* EIF_THREADS */
#endif /* _lmalloc_h_ */
