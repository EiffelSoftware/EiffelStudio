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
	Private externals for generic conformance
*/

#ifndef _rt_gen_conf_h_
#define _rt_gen_conf_h_

#include "eif_gen_conf.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize module */
extern void eif_gen_conf_init (int);

/* Clean up module. */
extern void eif_gen_conf_cleanup (void);

/* Is current tuple made of basic types? */
extern int eif_tuple_is_atomic (EIF_REFERENCE tuple);

/* Register a bit type of size `size' */
extern int16 eif_register_bit_type (long size);

/* Type of ARRAY [type] */
extern int16 eif_typeof_array_of (int16 type);

/* CID which creates a given type */
extern int16 *eif_gen_cid (int16 dftype);

/* Generic id list from external sources (retrieve) */
extern int16 eif_gen_id_from_cid (int16 *, int *);

/* Parent tables */
extern struct eif_par_types **eif_par_table;
extern int eif_par_table_size;

/* Auxiliary parent tables (dynamic extension) */
extern struct eif_par_types **eif_par_table2;
extern int eif_par_table2_size;

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_gen_mutex;
#endif
extern void eif_gen_conf_thread_init (void);
extern void eif_gen_conf_thread_cleanup (void);

/* Maximum nr. of entries in a compound typeid array */
#define MAX_CID_SIZE    2048

#ifdef __cplusplus
}
#endif

#endif
