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

#ifndef _eif_memory_h_
#define _eif_memory_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void mem_free(EIF_REFERENCE object);	/* Unconditionally free object */
RT_LNK void mem_speed(void);
RT_LNK void mem_slow(void);
RT_LNK void mem_tiny(void);
RT_LNK EIF_INTEGER mem_largest(void);
RT_LNK void mem_coalesc(void);
RT_LNK EIF_INTEGER mem_tget(void);
RT_LNK void mem_tset(long int value);
RT_LNK long mem_pget(void);
RT_LNK void mem_pset(long int value);
RT_LNK void mem_stat(EIF_POINTER item, EIF_INTEGER type);
RT_LNK void gc_mon(char flag);
RT_LNK void gc_stat(EIF_POINTER item, EIF_INTEGER type);	/* Initialize the GC statistics buffer */
RT_LNK char gc_ison(void);
RT_LNK void eif_set_max_mem(EIF_INTEGER); /* Set max memory RT can allocate */
RT_LNK EIF_INTEGER eif_tenure (void);		/* Return maximum tenuring age. */
RT_LNK EIF_INTEGER eif_coalesce_period (void); /* Return full coalesce period. */
RT_LNK EIF_INTEGER eif_scavenge_zone_size (void); /* Return size of GSZ. */
RT_LNK EIF_INTEGER eif_generation_object_limit (void);
			/* Return maximum size of object in generational scavenge zone. */
RT_LNK void eif_set_coalesce_period (EIF_INTEGER p); /* Set clsc_per */
RT_LNK EIF_INTEGER eif_get_max_mem(void); /* Return max_mem */
RT_LNK EIF_INTEGER eif_get_chunk_size(void); /* Return chunk_size */
RT_LNK EIF_BOOLEAN eif_is_in_final_collect;	/* Are we performing the final collection? */

#ifdef __cplusplus
}
#endif

#endif
