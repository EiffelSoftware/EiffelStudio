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

extern Malloc_t eif_malloc(register unsigned int nbytes);

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
