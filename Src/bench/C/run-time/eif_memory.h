/*

 #    #  ######  #    #   ####   #####    #   #          #    #
 ##  ##  #       ##  ##  #    #  #    #    # #           #    #
 # ## #  #####   # ## #  #    #  #    #     #            ######
 #    #  #       #    #  #    #  #####      #     ###    #    #
 #    #  #       #    #  #    #  #   #      #     ###    #    #
 #    #  ######  #    #   ####   #    #     #     ###    #    #

*/

#ifndef _eif_memory_h_
#define _eif_memory_h_

#ifdef __cplusplus
extern "C" {
#endif
#include "eif_eiffel.h"
#include "eif_constants.h"

RT_LNK void mem_free(char *object);	/* Unconditionally free object */
RT_LNK void mem_speed(void);
RT_LNK void mem_slow(void);
RT_LNK void mem_tiny(void);
RT_LNK int mem_largest(void);
RT_LNK void mem_coalesc(void);
RT_LNK long mem_tget(void);
RT_LNK void mem_tset(long int value);
RT_LNK long mem_pget(void);
RT_LNK void mem_pset(long int value);
RT_LNK void mem_stat(long int type);
RT_LNK long mem_info(long int field);
RT_LNK void gc_mon(char flag);
RT_LNK void gc_stat(long int type);	/* Initialize the GC statistics buffer */
RT_LNK long gc_info(long int field);
RT_LNK double gc_infod(long int field);
RT_LNK char gc_ison(void);
RT_LNK void eif_set_max_mem(EIF_INTEGER); /* Set max memory RT can allocate */
RT_LNK EIF_INTEGER eif_coalesc_period (void); /* Return clsc_per */
RT_LNK void eif_set_coalesc_period (EIF_INTEGER p); /* Set clsc_per */
RT_LNK EIF_INTEGER eif_get_max_mem(void); /* Return max_mem */
RT_LNK EIF_INTEGER eif_get_chunk_size(void); /* Return chunk_size */
RT_LNK void eif_set_chunk_size(EIF_INTEGER); /* Set the size of memory chunks */
#ifdef __cplusplus
}
#endif

#endif
