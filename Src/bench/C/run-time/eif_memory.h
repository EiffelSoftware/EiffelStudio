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

extern void mem_free(char *object);	/* Unconditionally free object */
extern void mem_speed(void);
extern void mem_slow(void);
extern void mem_tiny(void);
extern int mem_largest(void);
extern void mem_coalesc(void);
extern long mem_tget(void);
extern void mem_tset(long int value);
extern long mem_pget(void);
extern void mem_pset(long int value);
extern void mem_stat(long int type);
extern long mem_info(long int field);
extern void gc_mon(char flag);
extern void gc_stat(long int type);	/* Initialize the GC statistics buffer */
extern long gc_info(long int field);
extern double gc_infod(long int field);
extern char gc_ison(void);
extern void eif_set_max_mem(EIF_INTEGER); /* Set max memory RT can allocate */
extern EIF_INTEGER eif_get_max_mem(void); /* Return max_mem */
extern EIF_INTEGER eif_get_chunk_size(void); /* Return chunk_size */
extern void eif_set_chunk_size(EIF_INTEGER); /* Set the size of memory chunks */
#ifdef __cplusplus
}
#endif

#endif
