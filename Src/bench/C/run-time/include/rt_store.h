/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
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
RT_LNK void allocate_gen_buffer(void);
RT_LNK void buffer_write(char *data, size_t size);


extern int char_write(char *pointer, int size);

extern long get_offset(uint32 o_type, uint32 attrib_num);          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
#ifndef EIF_THREADS
extern unsigned int **sorted_attributes;
#endif
extern void sort_attributes(int dtype);
extern void free_sorted_attributes(void);


RT_LNK void internal_store(char *object);

#ifndef EIF_THREADS
RT_LNK char * general_buffer;
RT_LNK size_t current_position;
extern size_t buffer_size;
RT_LNK size_t cmp_buffer_size;
#endif

/* compression */
#ifndef EIF_THREADS
RT_LNK char * cmps_general_buffer;
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

