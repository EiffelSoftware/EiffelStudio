/*

  ####    #####   ####   #####   ######          #    #
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           ######
      #     #    #    #  #####   #        ###    #    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###    #    #

	Declarations for store mechanism.

*/

#ifndef _rt_store_h_
#define _rt_store_h_

#include "eif_store.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Utilities
 */
#ifndef EIF_THREADS
extern char *account;			/* Array of traversed dyn types */
#endif
extern long get_alpha_offset(uint32 o_type, uint32 attrib_num);
extern void allocate_gen_buffer(void);
extern void buffer_write(register char *data, int size);


extern int char_write(char *pointer, int size);

extern long get_offset(uint32 o_type, uint32 attrib_num);          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
#ifndef EIF_THREADS
extern unsigned int **sorted_attributes;
#endif
extern void sort_attributes(int dtype);
extern void free_sorted_attributes(void);


extern void internal_store(char *object);

#ifndef EIF_THREADS
extern char * general_buffer;
extern int current_position;
extern long buffer_size;
extern long cmp_buffer_size;
#endif

/* compression */
#ifndef EIF_THREADS
extern char * cmps_general_buffer;
#endif

/* Actions */
#ifndef EIF_THREADS
extern int (*char_write_func)(char *, int);
#endif

#ifdef EIF_THREADS
rt_shared void eif_store_thread_init (void);
#endif

#ifdef __cplusplus
}
#endif

#endif

