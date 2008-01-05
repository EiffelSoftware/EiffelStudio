/*
	description: "Private externals for generic conformance."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_gen_conf_h_
#define _rt_gen_conf_h_

#include "eif_gen_conf.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize module */
extern void eif_gen_conf_init (EIF_TYPE_INDEX);

/* Clean up module. */
extern void eif_gen_conf_cleanup (void);

/* Is current tuple made of basic types? */
extern int eif_tuple_is_atomic (EIF_REFERENCE tuple);

/* Register a bit type of size `size' */
extern EIF_TYPE_INDEX eif_register_bit_type (uint16 size);

/* Type of ARRAY [type] */
extern EIF_TYPE_INDEX eif_typeof_array_of (EIF_TYPE_INDEX type);

/* CID which creates a given type */
extern EIF_TYPE_INDEX *eif_gen_cid (EIF_TYPE_INDEX dftype);

/* Generic id list from external sources (retrieve) */
extern  EIF_TYPE_INDEX eif_gen_id_from_cid (EIF_TYPE_INDEX *, EIF_TYPE_INDEX *);

/* Parent tables */
extern struct eif_par_types **eif_par_table;
extern EIF_TYPE_INDEX eif_par_table_size;

/* Auxiliary parent tables (dynamic extension) */
extern struct eif_par_types **eif_par_table2;
extern EIF_TYPE_INDEX eif_par_table2_size;

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
