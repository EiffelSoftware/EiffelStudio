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

#ifdef __cplusplus
extern "C" {
#endif

extern Malloc_t eif_malloc(register unsigned int nbytes);

#ifdef __cplusplus
}
#endif

#endif /* _lmalloc_h_ */
