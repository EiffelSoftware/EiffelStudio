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

#ifndef _eif_store_h_
#define _eif_store_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "eif_globals.h"
#include "eif_malloc.h"				/* For macros HEADER */
#include "eif_garcol.h"				/* For flags manipulation */
#include "eif_traverse.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Different kinds of storage */
#define BASIC_STORE_3_1			0x00
#define BASIC_STORE_3_2			0x02
#define BASIC_STORE_4_0			0x06
#define GENERAL_STORE_3_1		0x01
#define GENERAL_STORE_3_2		0x03
#define GENERAL_STORE_3_3		0x05
#define GENERAL_STORE_4_0		0x07
#define INDEPENDENT_STORE_3_2	0x04
#define INDEPENDENT_STORE_4_0	0x08
#define INDEPENDENT_STORE_4_3	0x09
#define INDEPENDENT_STORE_4_4	0x0A
#define INDEPENDENT_STORE_5_0	0x0B
#define RECOVERABLE_STORE_5_3	0x0C
#define INTERMEDIATE_STORE_5_5	0x0D
#define INDEPENDENT_STORE_5_5	0x0E
#define INDEPENDENT_STORE_6_0	0x0F
#define INDEPENDENT_STORE_6_3	0x10
#define GENERAL_STORE_6_4		0x11
#define INDEPENDENT_STORE_6_4	0x12
#define BASIC_STORE_6_6			0x13
#define GENERAL_STORE_6_6		0x14
#define INDEPENDENT_STORE_6_6	0x15
#define INDEPENDENT_STORE_14_11	0x16
	/* SED_STORE is a reserved value so that from C we use the SED mechanisms to store/retrieve objects. */
#define SED_STORE				0x17

RT_LNK void eif_set_is_discarding_attachment_marks (EIF_BOOLEAN);
RT_LNK void eif_set_is_discarding_qat (EIF_BOOLEAN);

/*
 * Eiffel calls
 */
RT_LNK void estore(EIF_INTEGER file_desc, char *object);
RT_LNK void eestore(EIF_INTEGER file_desc, char *object);
RT_LNK void sstore (EIF_INTEGER file_desc, char *object);

RT_LNK EIF_INTEGER stream_estore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_eestore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_sstore (EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);

RT_LNK void set_buffer_size (EIF_INTEGER);

RT_LNK EIF_POINTER *stream_malloc (EIF_INTEGER stream_size);
RT_LNK void stream_free (EIF_POINTER *stream);

/* Features needed for EiffelNet or any other libraries that wants to use some storable compatible storage. */

/*
doc:	<struct name="rt_store_context" export="public">
doc:		<summary>Context used to configure how objects are stored.</summary>
doc:		<field name="write_function" type="int (*)(char *, int)">Function used to actually write data on medium. Used for initializing `char_write_func'.</field>
doc:		<field name="write_buffer_function" type="void (*)(size_t)">Function used to actually write the buffered data on medium (normally using `write_function'). In basic store, the buffer is compressed before being written. Used for initializing `store_write_func'.</field>
doc:		<field name="flush_buffer_function" type="void (*)(void)">Function used to flush any data left in buffer at the end of the store operation. Used for initializing `flush_buffer_func'.</field>
doc:		<field name="object_write_function" type="void (*)(EIF_REFERENCE, int)">Function used to store an Eiffel object. Used for initializing `st_write_func'.</field>
doc:		<field name="header_function" type="void (*)(struct rt_traversal_context *)">Function used to write a header to the storable data. Only used for recoverable storable to store some metadata about the types included in the storable. Used for initializing `make_header_func'.</field>
doc:	</struct>
*/
struct rt_store_context {
	int (*write_function)(char *, int);
	void (*write_buffer_function) (size_t);
	void (*flush_buffer_function) (void);
	void (*object_write_function) (EIF_REFERENCE, int);
	void (*header_function) (struct rt_traversal_context *);
};
RT_LNK void eif_store_object(
	struct rt_store_context *a_context,
	EIF_REFERENCE object,
	char store_type);
RT_LNK void flush_st_buffer(void);
RT_LNK void st_write(EIF_REFERENCE object, int);		/* Write an object in file */
RT_LNK void ist_write(EIF_REFERENCE object, int);
RT_LNK void store_write(size_t);
RT_LNK void rmake_header(struct rt_traversal_context *);				/* Make header */

#ifdef __cplusplus
}
#endif

#endif
