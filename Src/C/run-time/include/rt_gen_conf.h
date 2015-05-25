/*
	description: "Private externals for generic conformance."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_gen_conf.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize module */
extern void eif_gen_conf_init (EIF_TYPE_INDEX);

/* Clean up module. */
extern void eif_gen_conf_cleanup (void);

extern EIF_TYPE rt_compound_id_with_context (struct rt_id_of_context *a_context, EIF_TYPE_INDEX current_dftype, const EIF_TYPE_INDEX *types);

/* Is current tuple made of basic types? */
extern int eif_tuple_is_atomic (EIF_REFERENCE tuple);

/* Type of ARRAY [type] */
extern EIF_TYPE_INDEX eif_typeof_array_of (EIF_TYPE type);

/* Type of TYPE [dftype] */
extern EIF_TYPE_INDEX rt_typeof_type_of (EIF_TYPE type);

/* CID which creates a given type */
extern EIF_TYPE_INDEX *eif_gen_cid (EIF_TYPE dftype, int use_old_annotations);

/* Generic id list from external sources (retrieve) */
extern  EIF_TYPE_INDEX eif_gen_id_from_cid (EIF_TYPE_INDEX *, EIF_TYPE_INDEX *, int);

/* Parent tables */
extern struct eif_par_types **eif_par_table;
extern EIF_TYPE_INDEX eif_par_table_size;

/* Auxiliary parent tables (dynamic extension) */
extern struct eif_par_types **eif_par_table2;
extern EIF_TYPE_INDEX eif_par_table2_size;

/* Current maximum number of types. */
extern EIF_TYPE_INDEX eif_next_gen_id;

#ifndef EIF_THREADS
extern struct rt_id_of_context rt_context;
#endif

#ifdef EIF_THREADS
extern EIF_CS_TYPE *eif_gen_mutex;
#endif
extern void eif_gen_conf_thread_init (void);
extern void eif_gen_conf_thread_cleanup (void);

rt_shared EIF_TYPE_INDEX rt_merged_annotation (EIF_TYPE_INDEX first_annotation, EIF_TYPE_INDEX second_annotation);

/* Maximum nr. of entries in a compound typeid array */
#define MAX_CID_SIZE    2048

#ifdef __cplusplus
}
#endif

#endif
