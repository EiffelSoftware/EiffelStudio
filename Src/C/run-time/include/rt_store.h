/*
	description: "Declarations for store mechanism."
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

#ifndef _rt_store_h_
#define _rt_store_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_store.h"
#include "rt_traverse.h"

#ifdef __cplusplus
extern "C" {
#endif

	
/* Properties configuring how the storable was made. */
	/* Are we storing attachment marks in storable? */
#define STORE_DISCARD_ATTACHMENT_MARKS	0x01
	/* Are we storing a system compiled in compatible mode
	 * where `capacity == count' for SPECIAL? */
#define STORE_OLD_SPECIAL_SEMANTIC		0x02

/*
doc:	<struct name="rt_store_context" export="public">
doc:		<summary>Context used to configure how objects are stored.</summary>
doc:		<field name="write_function" type="int (*)(char *, int)">Function used to actually write data on medium. Used for initializing `char_write_func'.</field>
doc:		<field name="write_buffer_function" type="void (*)(size_t)">Function used to actually write the buffered data on medium (normally using `write_function'). In basic store, the buffer is compressed before being written. Used for initializing `store_write_func'.</field>
doc:		<field name="flush_buffer_function" type="void (*)(void)">Function used to flush any data left in buffer at the end of the store operation.</field>
doc:		<field name="object_write_function" type="void (*)(EIF_REFERENCE, int)">Function used to store an Eiffel object.</field>
doc:		<field name="header_function" type="void (*)(struct rt_traversal_context *)">Function used to write a header to the storable data. Only used for recoverable storable to store some metadata about the types included in the storable.</field>
doc:	</struct>
*/
struct rt_store_context {
	int (*write_function)(char *, int);
	void (*write_buffer_function) (size_t);
		/* The members below are private and should only be used in the Eiffel runtime only. */
	void (*flush_buffer_function) (void);
	void (*object_write_function) (EIF_REFERENCE, int);
	void (*header_function) (struct rt_store_context *);
	struct rt_traversal_context traversal_context;
};

/*
 * Utilities
 */
extern void allocate_gen_buffer(void);
extern void buffer_write(const char *data, size_t size);

extern int char_write(char *pointer, int size);

extern rt_uint_ptr get_offset(EIF_TYPE_INDEX o_type, rt_uint_ptr attrib_num);          /* get offset of attrib in object*/

extern void rt_store_object(struct rt_store_context *a_context, EIF_REFERENCE object, char store_type);
extern void rt_setup_store (struct rt_store_context *a_context, char store_type);

extern const EIF_TYPE_INDEX *rt_canonical_types (const EIF_TYPE_INDEX *gtypes, int is_discarding_attachment_marks, int16 *num_gtypes);

#ifndef EIF_THREADS
extern char * general_buffer;
extern size_t current_position;
extern size_t buffer_size;
extern size_t cmp_buffer_size;

/* compression */
extern char * cmps_general_buffer;

/* Actions */
extern int (*char_write_func)(char *, int);
#endif

#ifdef EIF_THREADS
rt_shared void eif_store_thread_init (void);
#endif

#ifdef __cplusplus
}
#endif

#endif

