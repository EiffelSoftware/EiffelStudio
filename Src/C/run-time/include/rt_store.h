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

#ifdef __cplusplus
extern "C" {
#endif

/* Properties configuring how the storable was made. */
#define STORE_DISCARD_ATTACHMENT_MARKS 0x01
#define STORE_OLD_SPECIAL_SEMANTIC 0x02

/*
 * Utilities
 */
extern void allocate_gen_buffer(void);
extern void buffer_write(const char *data, size_t size);

extern int char_write(char *pointer, int size);

extern rt_uint_ptr get_offset(EIF_TYPE_INDEX o_type, rt_uint_ptr attrib_num);          /* get offset of attrib in object*/

extern void rt_setup_store (struct rt_store_context *a_context);

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

