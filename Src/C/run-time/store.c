/*
	description: "Eiffel based C storing mechanism."
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

/*
doc:<file name="store.c" header="eif_store.h" version="$Id$" summary="Storing mechanism">
*/

#include "eif_portable.h"
#include "eif_project.h"
#include "rt_macros.h"
#include "rt_malloc.h"
#include "rt_except.h"
#include "rt_store.h"
#include "rt_retrieve.h"
#include "rt_traverse.h"
#include "eif_cecil.h"
#include <stdio.h>
#include "rt_struct.h"
#include "rt_run_idr.h"
#include "rt_error.h"
#include "eif_main.h"
#include "rt_compress.h"
#include "rt_lmalloc.h"
#include "rt_gen_types.h"
#include "rt_gen_conf.h"
#ifdef VXWORKS
#include <unistd.h>	/* For write () */
#endif
#include "rt_globals_access.h"
#include "rt_assert.h"

#ifdef RECOVERABLE_DEBUG
#ifndef EIF_THREADS
/*
doc:	<attribute name="object_count" return_type="long" export="private">
doc:		<summary>Number of stored objects so far. Only used in debug mode.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private long object_count;
#endif
#endif

#ifdef EIF_WINDOWS
#include <io.h>
#endif

#include <string.h>				/* For strlen() */

/*#define DEBUG 1 */	/**/

/* compression */
#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE
#define EIF_BUFFER_ALLOCATED_SIZE EIF_DCMPS_OUT_SIZE
#define EIF_CMPS_BUFFER_ALLOCATED_SIZE EIF_CMPS_OUT_SIZE

/* Convenience for backward compatibility, merged flags and dtype into a 32-bit integer. */
#define Merged_flags_dtype(flags,dtype)	((((uint32) flags) << 16) | (uint32) dtype)

#ifndef EIF_THREADS
/*
doc:	<attribute name="info_tag" return_type="char [TAG_SIZE]" export="shared">
doc:		<summary>Buffer in which we write the reason of a store failure.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char info_tag[TAG_SIZE];

/*
doc:	<attribute name="cmps_general_buffer" return_type="char *" export="shared">
doc:		<summary>Buffer in which result of compression in `store_write' is stored. Apply only for basic and general store.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char* cmps_general_buffer = NULL;

/*
doc:	<attribute name="general_buffer" return_type="char *" export="shared">
doc:		<summary>Buffer in which stored data is temporary stored before being really stored to medium. Apply only for basic and general store.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char *general_buffer = NULL;

/*
doc:	<attribute name="current_position" return_type="size_t" export="shared">
doc:		<summary>Position of next insertion in `general_buffer'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared size_t current_position = 0;

/*
doc:	<attribute name="buffer_size" return_type="size_t" export="shared">
doc:		<summary>Size of various buffers (general_buffer, run_idr buffer)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared size_t buffer_size = 0;

/*
doc:	<attribute name="cmp_buffer_size" return_type="size_t" export="shared">
doc:		<summary>Size of compression buffer `cmps_general_buffer', computed from `buffer_size'</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared size_t cmp_buffer_size = 0;

/*
doc:	<attribute name="s_fides" return_type="int" export="private">
doc:		<summary>File descriptor used during storing process</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int s_fides;
#endif /* EIF_THREADS */

/*
 * Function declarations
 */
rt_private void internal_store(struct rt_store_context *a_context, char *object, char store_type);
rt_private void st_store(struct rt_store_context *a_context, char *object);				/* Second pass of the store */
rt_public void rmake_header(struct rt_store_context *a_context);
rt_private void object_write (char *object, uint16, EIF_TYPE_INDEX);
rt_private void flush_st_buffer (void);
rt_private void store_write(size_t cmps_in_size);
rt_private void ist_write(EIF_REFERENCE object, int has_transient_attributes);
rt_private void st_write(EIF_REFERENCE object, int has_transient_attributes);
rt_private void st_write_cid (EIF_TYPE_INDEX);
rt_private void ist_write_cid (EIF_TYPE_INDEX);
rt_public void allocate_gen_buffer(void);
rt_shared void buffer_write(const char *data, size_t size);

rt_private struct cecil_info * cecil_info_for_dynamic_type (EIF_TYPE_INDEX dtype);

#ifndef EIF_THREADS
/*
doc:	<attribute name="store_write_func" return_type="void (*)(size_t)" export="private">
doc:		<summary>Action called when `general_buffer' is full.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*store_write_func)(size_t);

/*
doc:	<attribute name="char_write_func" return_type="int (*)(char *, int)" export="shared">
doc:		<summary>Action called to write a sequence of characters of a given length to disk. It returns number of bytes written. Only used by `run_idr' which explains why it is `shared' and not `private' to current C module.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared int (*char_write_func)(char *, int);

/*
doc:	<attribute name="account" return_type="struct rt_traversal_info *" export="shared">
doc:		<summary>Array of traversed dynamic types during accounting.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>Dynamic type</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared struct rt_traversal_info *account = NULL;
rt_shared size_t account_count = 0;

/* Declarations to work with streams */
/*
doc:	<attribute name="store_stream_buffer" return_type="char *" export="private">
doc:		<summary>Buffer used to store output of a storable made on stream.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private char *store_stream_buffer;

/*
doc:	<attribute name="store_stream_buffer_position" return_type="size_t" export="private">
doc:		<summary>Position in `store_stream_buffer' where next insertion of data will happen.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t store_stream_buffer_position;

/*
doc:	<attribute name="store_stream_buffer_size" return_type="size_t" export="private">
doc:		<summary>Size of `store_stream_buffer'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t store_stream_buffer_size;
#endif

/* Functions to write on the specified IO_MEDIUM */
rt_public  int char_write (char *, int);
rt_private int stream_write (char *, int);


/* Convenience functions */

/* Set the default buffer_size to a certain value */
rt_public void set_buffer_size (EIF_INTEGER new_size)
{
	RT_GET_CONTEXT
	buffer_size = new_size;
}

#ifdef EIF_THREADS
rt_shared void eif_store_thread_init (void)
	/* Initialize private data of `store.c' in multithreaded environment. */
	/* Data is already zeroed, so only variables that needs something different
	 * than the default value will be initialized. */
{
	RT_GET_CONTEXT;
	eif_is_discarding_attachment_marks = EIF_FALSE;
}
#endif

/*
doc:	<routine name="eif_store_object" export="public">
doc:		<summary>Store object `object' using `char_write' to write data using storable type `store_type'.</summary>
doc:		<param name="char_write" type="int(*)(char *, int)">Function used to write data.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object to store.</param>
doc:		<param name="store_type" type="char">Type of storable used. It can be either of BASIC_STORE, GENERAL_STORE or INDEPENDENT_STORE.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public void eif_store_object(int(*char_write)(char *, int), EIF_REFERENCE object, char store_type)
{
	struct rt_store_context store_context;
	memset(&store_context, 0, sizeof(struct rt_store_context));
	store_context.write_function = char_write;
	rt_store_object (&store_context, object, store_type);
}

/*
doc:	<routine name="rt_store_object" export="shared">
doc:		<summary>Store object `object' using `a_context' and storable type `store_type'.</summary>
doc:		<param name="a_context" type="struct rt_store_context *a_context">Context used to perform the store operation.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object to store.</param>
doc:		<param name="store_type" type="char">Type of storable used. It can be either of BASIC_STORE, GENERAL_STORE or INDEPENDENT_STORE.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_shared void rt_store_object(struct rt_store_context *a_context, EIF_REFERENCE object, char store_type)
{
	RT_GET_CONTEXT

	REQUIRE("Has write_function", a_context->write_function);

	rt_setup_store (a_context, store_type);

	buffer_size = EIF_BUFFER_SIZE;

	if ((store_type == BASIC_STORE) || (store_type == GENERAL_STORE)) {
		allocate_gen_buffer();
	} else if (store_type == INDEPENDENT_STORE) {
			/* Initialize serialization streams for writting (1 stands for write).
			 * Memory is freed in `internal_store'. */
		run_idr_init (buffer_size, 1);
		idr_temp_buf = (char *) eif_rt_xmalloc (48, C_T, GC_OFF);
		if (!idr_temp_buf) {
			xraise (EN_MEM);
		}
	}

	internal_store(a_context, object, store_type);

}
rt_shared void rt_setup_store (struct rt_store_context *a_context, char store_type)
{
	RT_GET_CONTEXT
	if (store_type == INDEPENDENT_STORE) {
		a_context->traversal_context.accounting = TR_STORE_ACCOUNT;
		a_context->write_buffer_function = NULL;
		a_context->flush_buffer_function = idr_flush;
		a_context->object_write_function = ist_write;
		a_context->header_function = rmake_header;
	} else {
			/* If callers did not set up the write buffer function, we use the default `store_write'. */
		if (!a_context->write_buffer_function) {
			a_context->write_buffer_function = store_write;
		}
		a_context->flush_buffer_function = flush_st_buffer;
		a_context->object_write_function = st_write;
		a_context->header_function = NULL;
	}
	a_context->traversal_context.is_for_persistence = 1;
	a_context->traversal_context.is_unmarking = 0;

	store_write_func = a_context->write_buffer_function;
	char_write_func = a_context->write_function;
}

/* Functions definitions */

/* Basic store */
/* Store object hierarchy of root `object' without header. */
rt_public void estore(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	s_fides = (int) file_desc;
	eif_store_object (char_write, object, BASIC_STORE);
}

rt_public EIF_INTEGER stream_estore(EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT

	store_stream_buffer = *buffer;
	store_stream_buffer_size = size;
	store_stream_buffer_position = 0;

	eif_store_object (stream_write, object, BASIC_STORE);

	*buffer = store_stream_buffer;
	*real_size = (EIF_INTEGER) store_stream_buffer_position;
	CHECK("not too big", store_stream_buffer_size <= 0x7FFFFFFF);
	return (EIF_INTEGER) store_stream_buffer_size;
}

/* General store. Obsolete, it will internally use independent store. */
rt_public void eestore(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	sstore(file_desc, object);
}

rt_public EIF_INTEGER stream_eestore(EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	return stream_sstore(buffer, size, object, real_size);
}

#ifndef EIF_THREADS
/*
doc:	<attribute name="eif_is_discarding_attachment_marks" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Does `independent_store' discard the attachment marks if found during store operation? Default False?</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private EIF_BOOLEAN eif_is_discarding_attachment_marks = EIF_FALSE;
#endif

rt_public EIF_BOOLEAN eif_is_discarding_attachment_marks_active (void)
{
	RT_GET_CONTEXT
	return eif_is_discarding_attachment_marks;
}

rt_public void eif_set_is_discarding_attachment_marks (EIF_BOOLEAN state)
{
	RT_GET_CONTEXT
	eif_is_discarding_attachment_marks = state;
}

/* Independent store */
/* Use file decscriptor so sockets and files can be used for storage
 * Store object hierarchy of root `object' and produce a header
 * so it can be retrieved by other systems. */
rt_public void sstore (EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	s_fides = (int) file_desc;
	eif_store_object (char_write, object, INDEPENDENT_STORE);
}

rt_public EIF_INTEGER stream_sstore (EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT

	store_stream_buffer = *buffer;
	store_stream_buffer_size = size;
	store_stream_buffer_position = 0;

	eif_store_object (stream_write, object, INDEPENDENT_STORE);

	*buffer = store_stream_buffer;
	*real_size = (EIF_INTEGER) store_stream_buffer_position;
	CHECK("not too big", store_stream_buffer_size <= 0x7FFFFFFF);
	return (EIF_INTEGER) store_stream_buffer_size;
}

/* Stream allocation */
rt_public EIF_POINTER *stream_malloc (EIF_INTEGER stream_size)	/*08/04/98*/
{
	char *buffer;
	EIF_POINTER *real_buffer = NULL;

	buffer = (char *) eif_malloc(stream_size);
	if (buffer == (char *) 0)
		xraise(EN_MEM);
	else {
		real_buffer = (EIF_POINTER *) eif_malloc (sizeof (char *));
		if (!real_buffer) {
				/* We could not allocate `real_buffer' so we have to free `buffer' before
				 * raising the exception. */
			eif_free (buffer);
			xraise(EN_MEM);
		} else {
			*real_buffer = buffer;
		}
	}
	return real_buffer;
}

/* Stream deallocation */
rt_public void stream_free (EIF_POINTER *real_buffer)	/*08/04/98*/
{
	eif_free(*real_buffer);
	eif_free(real_buffer);
}

rt_public void allocate_gen_buffer (void)
{
	RT_GET_CONTEXT
	if (general_buffer == (char *) 0) {
		general_buffer = (char *) eif_rt_xmalloc (buffer_size * sizeof (char), C_T, GC_OFF);
		if (general_buffer == (char *) 0)
			eraise ("Out of memory for general_buffer creation", EN_PROG);

			/* compression */
		{
		  		/* Compute size of a compression block. It has to be the size of
				 * what we want to compress plus 6 bytes for the header and 1 bit
				 * for every 8 bytes. */
			size_t length = buffer_size * sizeof(char);
			cmp_buffer_size = (length * 9) / 8 + 1 + EIF_CMPS_HEAD_SIZE;
			cmps_general_buffer = (char *) eif_rt_xmalloc (cmp_buffer_size, C_T, GC_OFF);
			if (cmps_general_buffer == (char *) 0)
				eraise ("out of memory for cmps_general_buffer creation", EN_PROG);
		}
	}

	current_position = 0;
	end_of_buffer = 0;
}

rt_private void internal_store(struct rt_store_context *a_context, char *object, char store_type)
{
	EIF_GET_CONTEXT
	RT_GET_CONTEXT
	/* Store object hierarchy of root `object' in file `file_ptr' and
	 * produce header if `accounting'.
	 */
	char c;
	char l_store_properties = 0;
	jmp_buf exenv;
	int l_failure;
	int volatile is_locked = 0;
	RTXDR;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
			/* If we locked the EO_STORE_MUTEX, then we need to unmark objects
			 * and unlock it. */
		if (is_locked) {
				/* We are only concerned abount unmarking objects, so we do not perform any
				 * accounting. This won't prevent `rt_store_objects' from feeing `account' if 
				 * it was allocated. */
			a_context->traversal_context.accounting = 0;
				/* First we mark again all objects. */
			a_context->traversal_context.is_unmarking = 0;
			traversal(&a_context->traversal_context, object);
				/* Then we unmark them. */
			a_context->traversal_context.is_unmarking = 1;
			traversal(&a_context->traversal_context, object);
				/* Now we can unlock our mutex. */
			EIF_EO_STORE_UNLOCK;
		}

			/* Free allocated memory. */
		if (a_context->traversal_context.account) {
			eif_rt_xfree(a_context->traversal_context.account);
			a_context->traversal_context.account = NULL;
			a_context->traversal_context.account_count = 0;
		}

		if (store_type == INDEPENDENT_STORE) {
			run_idr_destroy ();
			eif_rt_xfree (idr_temp_buf);
			idr_temp_buf = NULL;
		}

		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	if (a_context->traversal_context.accounting) {		/* Prepare character array */
		a_context->traversal_context.account_count = eif_next_gen_id;
		a_context->traversal_context.account = (struct rt_traversal_info *) eif_rt_xmalloc(a_context->traversal_context.account_count * sizeof(struct rt_traversal_info), C_T, GC_OFF);
		if (!a_context->traversal_context.account) {
			xraise(EN_MEM);
		}
		memset (a_context->traversal_context.account, 0, a_context->traversal_context.account_count * sizeof(struct rt_traversal_info));
			/* To help a better transition for the storable changes in 6.6, if the code is compiled
			 * in compatible mode, then we use the old storable format which does not store the version
			 * of the class. */
		if (egc_has_old_special_semantic) {
				/* As in version 6.5 and 6.4, when we are in compatible mode,
				 * we generate the previous, format. */
			c = INDEPENDENT_STORE_6_3;
		} else {
			c = INDEPENDENT_STORE_6_6;
		}
		rt_kind_version = c;
	} else {
		c = BASIC_STORE_6_6;
	}

	if (eif_is_discarding_attachment_marks) {
		l_store_properties |= STORE_DISCARD_ATTACHMENT_MARKS;
	}
	if (egc_has_old_special_semantic) {
		l_store_properties |= STORE_OLD_SPECIAL_SEMANTIC;
	}

	/* Write the kind of store */
	l_failure = (a_context->write_function(&c, sizeof(char)) < 0);
	if ((c != INDEPENDENT_STORE_6_3) && (!l_failure)) {
			/* Then write the storable properties. */
		l_failure = (a_context->write_function(&l_store_properties, sizeof(char)) < 0);
	}
	if (l_failure) {
		eise_io("Store: unable to write the kind of storable.");
	} else {
		EIF_EO_STORE_LOCK;
		is_locked = 1;
		a_context->traversal_context.obj_nb = 0;
		a_context->traversal_context.is_unmarking = 0;
		traversal(&a_context->traversal_context, object);

		if (a_context->traversal_context.account) {
			a_context->header_function (a_context);			/* Make header */
			eif_rt_xfree(a_context->traversal_context.account);			/* Free accouting character array */
			a_context->traversal_context.account = NULL;
			a_context->traversal_context.account_count = 0;
		}
			/* Write the count of stored objects */
		if (a_context->traversal_context.accounting) {
			widr_multi_uint32 (&a_context->traversal_context.obj_nb, 1);
		} else {
			buffer_write((char *)(&a_context->traversal_context.obj_nb), sizeof(uint32));
		}

#if DEBUG & 3
			printf (" %x", a_context->traversal_context.obj_nb);
#endif

		st_store(a_context, object);		/* Write objects to be stored */

		a_context->flush_buffer_function ();	/* flush the buffer */

		EIF_EO_STORE_UNLOCK;
		is_locked = 0;
#if DEBUG & 3
		printf ("\n");
#endif
#ifdef RECOVERABLE_DEBUG
		fflush (stdout);
#endif
		expop(&eif_stack);
	}

		/* Free allocated memory. */
	if (store_type == INDEPENDENT_STORE) {
		run_idr_destroy ();
		eif_rt_xfree (idr_temp_buf);
		idr_temp_buf = NULL;
	}
}

rt_private void st_store(struct rt_store_context *a_context, EIF_REFERENCE object)
{
	/* Second pass of the store mecahnism: writing on the disk. */
	EIF_REFERENCE o_ref;
	EIF_REFERENCE o_ptr;
	long i, nb_references;
	union overhead *zone = HEADER(object);
	uint16 flags;
	int is_expanded, has_transient_attributes = 0;

	flags = zone->ov_flags;
	is_expanded = eif_is_nested_expanded(flags);
	if (!(is_expanded || (flags & EO_STORE)))
		return;		/* Unmarked means already stored */

	zone->ov_flags = flags & ~EO_STORE;		/* Unmark it */

	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)) {			/* Special of simple types */
		} else {
			EIF_INTEGER count, elem_size;
			EIF_REFERENCE ref;

			count = RT_SPECIAL_COUNT(object);
			if (flags & EO_TUPLE) {
				EIF_TYPED_VALUE *l_item = (EIF_TYPED_VALUE *) object;
					/* Don't forget that first element of TUPLE is the BOOLEAN
					 * `object_comparison' attribute. */
				l_item++;
				count--;
				for (; count > 0; count--, l_item++) {
					if (eif_is_reference_tuple_item(l_item)) {
						o_ref = eif_reference_tuple_item(l_item);
						if (o_ref) {
							st_store(a_context, o_ref);
						}
					}
				}
			} else if (!(flags & EO_COMP)) {		/* Special of references */
				for (ref = object; count > 0; count--,
						ref = (EIF_REFERENCE) ((EIF_REFERENCE *) ref + 1)) {
					o_ref = *(EIF_REFERENCE *) ref;
					if (o_ref != (EIF_REFERENCE) 0)
						st_store(a_context, o_ref);
				}
			} else {						/* Special of composites */
				elem_size = RT_SPECIAL_ELEM_SIZE(object);
				for (ref = object + OVERHEAD; count > 0;
					count --, ref += elem_size) {
					st_store(a_context, ref);
				}
			}
		}
	} else {								/* Normal object */
		nb_references = References(zone->ov_dtype);

		/* Traversal of references of `object' */
		for (
			o_ptr = object, i = 0;
			i < nb_references;
			i++, o_ptr = (EIF_REFERENCE) (((EIF_REFERENCE *) o_ptr) +1)
		) {
			o_ref = *(EIF_REFERENCE *)o_ptr;
			if (o_ref) {
				if (!EIF_IS_TRANSIENT_ATTRIBUTE(System(zone->ov_dtype), i)) {
					st_store(a_context, o_ref);
				} else {
					has_transient_attributes = 1;
				}
			}
		}
	}

	if (!is_expanded) {
		a_context->object_write_function (object, has_transient_attributes);		/* write the object */
	}
}

rt_private void st_write(EIF_REFERENCE object, int has_transient_attributes)
{
	/* Write an object'.
	 * Use for basic and general (before 3.3) store
	 */

	union overhead *zone;
	rt_uint_ptr i, count, elem_size;
	rt_uint_ptr attrib_offset;
	uint16 flags;
	EIF_TYPE_INDEX dtype;
	rt_uint_ptr nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	dtype = zone->ov_dtype;

	/* Write address */

	buffer_write((char *)(&object), sizeof(char *));
	buffer_write((char *)(&flags), sizeof(uint16));
	buffer_write((char *)(&dtype), sizeof(uint16));
	st_write_cid (Dftype(object));

#if DEBUG & 2
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
			/* We have to send the complete special information. */
		uint32 l_uint32;
		nb_char = RT_SPECIAL_COUNT(object);
		l_uint32 = (uint32) nb_char;
		buffer_write((char *)(&l_uint32), sizeof(uint32));
		elem_size = RT_SPECIAL_ELEM_SIZE(object);
		l_uint32 = (uint32) elem_size;
		buffer_write((char *)(&l_uint32), sizeof(uint32));
		l_uint32 = (uint32) RT_SPECIAL_CAPACITY(object);
		buffer_write((char *)(&l_uint32), sizeof(uint32));
			/* Compute actual number of bytes we need to store. */
		nb_char = nb_char * (rt_uint_ptr) elem_size;
		if (nb_char > 0) {
				/* Write the body of the object */
			buffer_write(object, (sizeof(char) * nb_char));
		}
	} else {
		/* Evaluation of the size of a normal object */
		nb_char = EIF_Size(dtype);
		if (nb_char > 0) {
				/* To speed up retrieval we store if the object has some transient attribute. */
			char l_transient = (char) has_transient_attributes;
			buffer_write(&l_transient, sizeof(char));
			if (!has_transient_attributes) {
					/* No transient attribute, we write the complete memory of the object. */
				buffer_write(object, (sizeof(char) * nb_char));
			} else {
					/* Normal object */
				count = System(dtype).cn_nbattr;

				for (i = 0; i < count; i++) {
					attrib_offset = get_offset(dtype, i);
					if (!EIF_IS_TRANSIENT_ATTRIBUTE(System(dtype), i)) {
						switch (*(System(dtype).cn_types + i) & SK_HEAD) {
							case SK_UINT8: elem_size = sizeof(EIF_NATURAL_8); break;
							case SK_UINT16: elem_size = sizeof(EIF_NATURAL_16); break;
							case SK_UINT32: elem_size = sizeof(EIF_NATURAL_32); break;
							case SK_UINT64: elem_size = sizeof(EIF_NATURAL_64); break;
							case SK_INT8: elem_size = sizeof(EIF_INTEGER_8); break;
							case SK_INT16: elem_size = sizeof(EIF_INTEGER_16); break;
							case SK_INT32: elem_size = sizeof(EIF_INTEGER_32); break;
							case SK_INT64: elem_size = sizeof(EIF_INTEGER_64); break;
							case SK_CHAR32: elem_size = sizeof(EIF_CHARACTER_32); break;
							case SK_BOOL: elem_size = sizeof(EIF_BOOLEAN); break;
							case SK_CHAR8: elem_size = sizeof(EIF_CHARACTER_8); break;
							case SK_REAL32: elem_size = sizeof(EIF_REAL_32); break;
							case SK_REAL64: elem_size = sizeof(EIF_REAL_64); break;
							case SK_REF:
							case SK_POINTER: elem_size = sizeof(EIF_REFERENCE); break;
							case SK_EXP:
									elem_size = HEADER(object + attrib_offset)->ov_size & B_SIZE;
								break;
							default:
								elem_size = 0;
								eise_io("Basic store: not an Eiffel object.");
						}
						buffer_write (object + attrib_offset, elem_size);
					}
				}
			}
		}
	}

#if DEBUG & 2
{
	int i;
	for (i = 0; i < nb_char ; i++) {
		printf (" %x", *(object + i));
		if (!(i % 40))
			printf ("\n");
	}
}
#endif

}

rt_private void ist_write(EIF_REFERENCE object, int has_transient_attributes)
{
	/* Write an object.
	 * used for independent store
	 */

	union overhead *zone;
	uint32 store_flags;
	uint16 flags;

#ifdef RECOVERABLE_DEBUG
	printf ("%2ld: %s [%p]\n", ++object_count, eif_typename (Dftype(object)), object);
#endif

	zone = HEADER(object);
	flags = zone->ov_flags;

	/* Write address */
	widr_multi_any ((char *)(&object), 1);
	store_flags = Merged_flags_dtype(flags,zone->ov_dtype);
	widr_norm_int (&store_flags);
	ist_write_cid (Dftype(object));

#if DEBUG & 1
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
#ifdef EIF_ASSERTIONS
		RT_GET_CONTEXT
#endif
		uint32 count, l_extra_data;
		count = (uint32) RT_SPECIAL_COUNT(object);
		if (egc_has_old_special_semantic) {
				/* We do not care about element size since it is computed on retrieval. */
			CHECK("Proper version", rt_kind_version < INDEPENDENT_STORE_6_4);
			l_extra_data = (uint32)(RT_SPECIAL_ELEM_SIZE(object));
		} else {
				/* We need to write the capacity with the new semantic. */
			l_extra_data = (uint32)(RT_SPECIAL_CAPACITY(object));
		}
		widr_norm_int(&count);
		widr_norm_int(&l_extra_data);
	}
	/* Write the body of the object */
	object_write(object, flags, Dftype(object));

}

rt_shared rt_uint_ptr get_offset(EIF_TYPE_INDEX dtype, rt_uint_ptr attrib_num)
{
#ifndef WORKBENCH
	return (System(dtype).cn_offsets[attrib_num]);
#else
	int32 rout_id;				/* Attribute routine id */
	uint32 offset;

	rout_id = System(dtype).cn_attr[attrib_num];
	offset = wattr(rout_id,dtype);
	return offset;
#endif
}

rt_private void object_tuple_write (EIF_REFERENCE object)
	/* Storing TUPLE. Version for independent store */
{
	EIF_TYPED_VALUE * l_item = (EIF_TYPED_VALUE *) object;
	unsigned int count = RT_SPECIAL_COUNT(object);
	EIF_CHARACTER_8 l_type;

	REQUIRE ("TUPLE object", HEADER(object)->ov_flags & EO_TUPLE);

		/* Don't forget that first element of TUPLE is the BOOLEAN
		 * `object_comparison' attribute. */
	for (; count > 0; count--, l_item++) {
			/* For each tuple element we store its type first, and then the associated value */
		switch (eif_tuple_item_sk_type(l_item)) {
			case SK_BOOL:    l_type = EIF_BOOLEAN_CODE; break;
			case SK_CHAR8:    l_type = EIF_CHARACTER_8_CODE; break;
			case SK_CHAR32:   l_type = EIF_CHARACTER_32_CODE; break;
			case SK_INT8:    l_type = EIF_INTEGER_8_CODE; break;
			case SK_INT16:   l_type = EIF_INTEGER_16_CODE; break;
			case SK_INT32:   l_type = EIF_INTEGER_32_CODE; break;
			case SK_INT64:   l_type = EIF_INTEGER_64_CODE; break;
			case SK_UINT8:   l_type = EIF_NATURAL_8_CODE; break;
			case SK_UINT16:  l_type = EIF_NATURAL_16_CODE; break;
			case SK_UINT32:  l_type = EIF_NATURAL_32_CODE; break;
			case SK_UINT64:  l_type = EIF_NATURAL_64_CODE; break;
			case SK_REAL32:  l_type = EIF_REAL_32_CODE; break;
			case SK_REAL64:  l_type = EIF_REAL_64_CODE; break;
			case SK_REF:     l_type = EIF_REFERENCE_CODE; break;
			case SK_POINTER: l_type = EIF_POINTER_CODE; break;
			default:
				eise_io("Independent store: unexpected tuple element type");
		}
		widr_multi_char (&l_type, 1);
		switch (l_type) {
			case EIF_REFERENCE_CODE: widr_multi_any ((char*) &eif_reference_tuple_item(l_item), 1); break;
			case EIF_BOOLEAN_CODE: widr_multi_char (&eif_boolean_tuple_item(l_item), 1); break;
			case EIF_CHARACTER_8_CODE: widr_multi_char (&eif_character_tuple_item(l_item), 1); break;
			case EIF_REAL_64_CODE: widr_multi_double (&eif_real_64_tuple_item(l_item), 1); break;
			case EIF_REAL_32_CODE: widr_multi_float (&eif_real_32_tuple_item(l_item), 1); break;
			case EIF_NATURAL_8_CODE: widr_multi_uint8 (&eif_natural_8_tuple_item(l_item), 1); break;
			case EIF_NATURAL_16_CODE: widr_multi_uint16 (&eif_natural_16_tuple_item(l_item), 1); break;
			case EIF_NATURAL_32_CODE: widr_multi_uint32 (&eif_natural_32_tuple_item(l_item), 1); break;
			case EIF_NATURAL_64_CODE: widr_multi_uint64 (&eif_natural_64_tuple_item(l_item), 1); break;
			case EIF_INTEGER_8_CODE: widr_multi_int8 (&eif_integer_8_tuple_item(l_item), 1); break;
			case EIF_INTEGER_16_CODE: widr_multi_int16 (&eif_integer_16_tuple_item(l_item), 1); break;
			case EIF_INTEGER_32_CODE: widr_multi_int32 (&eif_integer_32_tuple_item(l_item), 1); break;
			case EIF_INTEGER_64_CODE: widr_multi_int64 (&eif_integer_64_tuple_item(l_item), 1); break;
			case EIF_POINTER_CODE: widr_multi_ptr ((char *) &eif_pointer_tuple_item(l_item), 1); break;
			case EIF_CHARACTER_32_CODE: widr_multi_uint32 (&eif_wide_character_tuple_item(l_item), 1); break;
			default:
				eise_io("Independent store: unexpected tuple element type");
		}
	}
}

/*
doc:	<routine name="object_write" export="private">
doc:		<summary>Store object using platform independent format.</summary>
doc:		<param name="object" type="char *">Pointer to the object being stored. It is a `char *' and not an `EIF_REFERENCE' because some time `object' may not have an object header (case of an expanded without references in a SPECIAL instance.</param>
doc:		<param name="flags" type="uint16">Flags associated to the type of object pointed by `object'.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Full dynamic type of `object'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_eo_store_mutex</synchronization>
doc:	</routine>
*/

rt_private void object_write(char *object, uint16 flags, EIF_TYPE_INDEX dftype)
{
	rt_uint_ptr attrib_offset;
	EIF_TYPE_INDEX dtype = To_dtype(dftype);
	EIF_TYPE_INDEX exp_dftype;
	rt_uint_ptr num_attrib;
	uint32 store_flags;

	num_attrib = System(dtype).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			attrib_offset = get_offset(dtype, --num_attrib);
			if (!EIF_IS_TRANSIENT_ATTRIBUTE(System(dtype), num_attrib)) {
				switch (*(System(dtype).cn_types + num_attrib) & SK_HEAD) {
						/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
						 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
						 * unsigned SK_UINTXX too. */
					case SK_UINT8: widr_multi_uint8 ((EIF_NATURAL_8 *)(object + attrib_offset), 1); break;
					case SK_UINT16: widr_multi_uint16 ((EIF_NATURAL_16 *)(object + attrib_offset), 1); break;
					case SK_UINT32: widr_multi_uint32 ((EIF_NATURAL_32 *)(object + attrib_offset), 1); break;
					case SK_UINT64: widr_multi_uint64 ((EIF_NATURAL_64 *)(object + attrib_offset), 1); break;
					case SK_INT8: widr_multi_int8 ((EIF_INTEGER_8 *)(object + attrib_offset), 1); break;
					case SK_INT16: widr_multi_int16 ((EIF_INTEGER_16 *)(object + attrib_offset), 1); break;
					case SK_INT32: widr_multi_int32 ((EIF_INTEGER_32 *)(object + attrib_offset), 1); break;
					case SK_INT64: widr_multi_int64 ((EIF_INTEGER_64 *)(object + attrib_offset), 1); break;
					case SK_BOOL: widr_multi_char ((EIF_BOOLEAN *) (object + attrib_offset), 1); break;
					case SK_CHAR8: widr_multi_char ((EIF_CHARACTER_8 *) (object + attrib_offset), 1); break;
					case SK_CHAR32: widr_multi_uint32 ((EIF_CHARACTER_32 *) (object + attrib_offset), 1); break;
					case SK_REAL32: widr_multi_float ((EIF_REAL_32 *)(object + attrib_offset), 1); break;
					case SK_REAL64: widr_multi_double ((EIF_REAL_64 *)(object + attrib_offset), 1); break;
					case SK_EXP:
							/* Independent store does not need a value for the second argument since
							 * we do a field by field store. */
						ist_write (object + attrib_offset, 0);
						break;
					case SK_REF: widr_multi_any (object + attrib_offset, 1); break;
					case SK_POINTER: widr_multi_ptr (object + attrib_offset, 1); break;
					default:
						eise_io("Independent store: not an Eiffel object.");
				}
			}
		}
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			EIF_REFERENCE ref;
			EIF_INTEGER count, elem_size;

			count = RT_SPECIAL_COUNT(object);

			if (flags & EO_TUPLE) {
				object_tuple_write (object);
			} else {
				uint32 dgen;
				EIF_TYPE_INDEX *dynamic_types;
				uint32 *patterns;
				uint16 nb_gen;
				struct cecil_info *info;

				info = cecil_info_for_dynamic_type (dtype);
				CHECK ("Must be a generic type", (info != NULL) && (info->nb_param > 0));

				/* Generic type, write in file:
				 *	"dtype visible_name size nb_generics {meta_type}+"
				 */
				dynamic_types = info->dynamic_types;
				nb_gen = info->nb_param;

				for (;;) {
						/* FIXME: Change code generation so that last entries in `dynamic_types' array
						 * is INVALID_DTYPE and thus one can write:
						 * CHECK("Not invalid", *dynamic_types != INVALID_DTYPE);
						 */
					if ((*dynamic_types++) == dtype)
						break;
				}
				dynamic_types--;
				patterns = info->patterns + nb_gen * (dynamic_types - info->dynamic_types);
				dgen = *patterns;

				if (!(flags & EO_REF)) {		/* Special of simple types */
					switch (dgen & SK_HEAD) {
							/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
							 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
							 * unsigned SK_UINTXX too. */
						case SK_UINT8: widr_multi_uint8 ((EIF_NATURAL_8 *)object, count); break;
						case SK_UINT16: widr_multi_uint16 ((EIF_NATURAL_16 *)object, count); break;
						case SK_UINT32: widr_multi_uint32 ((EIF_NATURAL_32 *)object, count); break;
						case SK_UINT64: widr_multi_uint64 ((EIF_NATURAL_64 *)object, count); break;
						case SK_INT8: widr_multi_int8 (((EIF_INTEGER_8 *)object), count); break;
						case SK_INT16: widr_multi_int16 (((EIF_INTEGER_16 *)object), count); break;
						case SK_INT32: widr_multi_int32 (((EIF_INTEGER_32 *)object), count); break;
						case SK_INT64: widr_multi_int64 (((EIF_INTEGER_64 *)object), count); break;
						case SK_POINTER: widr_multi_ptr (object, count); break;
						case SK_CHAR32: widr_multi_uint32 ((EIF_CHARACTER_32 *) object, count); break;
						case SK_REAL32: widr_multi_float ((EIF_REAL_32 *)object, count); break;
						case SK_REAL64: widr_multi_double ((EIF_REAL_64 *)object, count); break;
						case SK_BOOL: widr_multi_char ((EIF_BOOLEAN *) object, count); break;
						case SK_CHAR8: widr_multi_char ((EIF_CHARACTER_8 *) object, count); break;
						case SK_EXP:
							elem_size = RT_SPECIAL_ELEM_SIZE(object);
							exp_dftype = eif_gen_param(dftype, 1).id;
							store_flags = Merged_flags_dtype(EO_EXP,To_dtype(exp_dftype));
							widr_norm_int(&store_flags);
							ist_write_cid (exp_dftype);
#ifdef WORKBENCH
							ref = object + OVERHEAD;
#else
								/* In finalized mode, there is no header in a special which
								 * does not have the EO_REF flag. */
							ref = object;
#endif
							for (; count > 0; count --, ref += elem_size) {
								object_write(ref, EO_EXP, exp_dftype);
							}
							break;
						default:
							eise_io("Basic store: not an Eiffel object.");
							break;
					}
				} else {
					if (!(flags & EO_COMP)) {	/* Special of references */
						widr_multi_any (object, count);
					} else {			/* Special of composites */
						elem_size = RT_SPECIAL_ELEM_SIZE(object);
						exp_dftype = eif_gen_param(dftype, 1).id;
						store_flags = Merged_flags_dtype(EO_EXP,To_dtype(exp_dftype));
						widr_norm_int(&store_flags);
						ist_write_cid (exp_dftype);
						for (ref = object + OVERHEAD; count > 0; count --, ref += elem_size) {
							object_write(ref, EO_EXP, exp_dftype);
						}
					}
				}
			}
		}
	}
}

/*
doc:	<routine name="cecil_info_for_dynamic_type" export="private">
doc:		<summary>Find CECIL information about a class given by its dynamic type.</summary>
doc:		<param name="dtype" type="uint32">Dynamic type of the class we are looking for.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>GC mutex</synchronization>
doc:	</routine>
*/

rt_private struct cecil_info * cecil_info_for_dynamic_type (EIF_TYPE_INDEX dtype)
{
	struct cecil_info *result;
	struct cnode node = System(dtype);

	if (EIF_IS_EXPANDED_TYPE(node)) {
		result = (struct cecil_info *) ct_value(&egc_ce_exp_type, node.cn_generator);
	} else {
		result = (struct cecil_info *) ct_value(&egc_ce_type, node.cn_generator);
	}

	return result;
}

/*
doc:	<routine name="rt_canonical_types" return_type="const EIF_TYPE_INDEX *" export="private">
doc:		<summary>Given a types array `gtypes' filter it to compute how many entries will be actually needed to get just what we need and reconstruct the type properly. This is mostly used to remove attachment marks and qualified anchored type qualification.</summary>
doc:		<param name="gtypes" type="const EIF_TYPE_INDEX *">Types array containing the type description.</param>
doc:		<param name="is_discarding_attachment_marks" type="int">Are we ignoring attachment marks?</param>
doc:		<param name="num_gtypes" type="int16 *">Number of entries that will be effectively in use in the returned types array.</param>
doc:		<return>NULL if it cannot produce a types array (case where it involves some formal generic parameter), otherwise a types array that is either `gtypes' or a new one (case where it involved some qualified anchored type).</return>
doc:		<thread_safety>Safe</thread_safety>
doc:	</routine>
*/
rt_shared const EIF_TYPE_INDEX *rt_canonical_types (const EIF_TYPE_INDEX *gtypes, int is_discarding_attachment_marks, int16 *num_gtypes)
{
	int l_done = 0;
	int16 l_num_gtypes;
	size_t i;
	EIF_TYPE_INDEX gtype;
	EIF_TYPE l_attr_type;
	struct rt_id_of_context gen_conf_context;

	while (!l_done) {
			/* We assume we will be done in one iteration. Unless we meet some
			 * qualified anchored types. */
		l_done = 1;
		l_num_gtypes = 0;
		for (i = 0; gtypes[i] != TERMINATOR; i++) {
			gtype = gtypes[i];
				/* If we are storing for INDEPENDENT_STORE_6_6 then we
				 * should remove all attachment marks. */
			if (is_discarding_attachment_marks) {
				while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY(gtype)) {
					i++;
					gtype = gtypes [i];
				}
			}
			switch (gtype) {
				case TUPLE_TYPE:
					i += TUPLE_OFFSET - 1;
					l_num_gtypes += TUPLE_OFFSET;
					break;
				case FORMAL_TYPE:
						/* Formal + position */
					l_num_gtypes += 2;
					i += 1;
					break;
				case QUALIFIED_FEATURE_TYPE:
					gen_conf_context.has_no_context = 1;
					gen_conf_context.is_invalid = 0;
					gen_conf_context.next_address_requested = 1;
					l_attr_type = rt_compound_id_with_context (&gen_conf_context, 0, &gtypes[i]);
						/* If resolution of the type of the qualified anchored type uses
						 * a formal or a type that is not accounted for, we cannot process
						 * the type. */
					if (gen_conf_context.is_invalid) {
						return NULL;
					} else {
							/* We have to repeat the whole thing, but this time we
							 * will be using the decoded type. */
						l_done = 0;
						i += (gen_conf_context.next_address - &gtypes[i]) - 1;
					}
					gen_conf_context.next_address_requested = 0;
					break;
				default:
						/* No need to handle special type since they should not appear in an object type.
						 * This can be attachment marks or actual types. */
					CHECK("No special type",
						(gtype != LIKE_CURRENT_TYPE) &&
						(gtype != LIKE_ARG_TYPE) &&
						(gtype != LIKE_FEATURE_TYPE));

					l_num_gtypes++;
			}
		}
		if (!l_done) {
				/* We had some qualified anchored type that did not depend on the
				 * dynamic type (i.e. they had no formal. So we repeat the above
				 * but this time we remove the qualified anchored type and resolve
				 * the attribute type into a type array sequence. */
			l_attr_type = eif_compound_id (0, gtypes);
			gtypes = eif_gen_cid (l_attr_type, 0);
				/* In the above array, the first entry contains the count. */
			gtypes++;
		} else if (num_gtypes) {
				/* We are done, so let's update `num_gtypes'. */
			*num_gtypes = l_num_gtypes;
		}
	}
	return gtypes;
}

rt_private void widr_type_attribute (int16 dtype, int16 attrib_index)
{
	RT_GET_CONTEXT
	const char *attr_name = System (dtype).cn_names[attrib_index];
	int16 attr_name_length = (int16) strlen (attr_name);
	const EIF_TYPE_INDEX *gtypes = System (dtype).cn_gtypes[attrib_index];
	int16 num_gtypes;
	size_t i;
	unsigned char basic_type;
	EIF_TYPE_INDEX gtype;

	REQUIRE("valid name_length", (size_t) attr_name_length == strlen (attr_name));

		/* Old INDEPENDENT_STORE_6_6 format. */

		/* Compute the actual type of the attribute and then extract its decomposition
		 * which will we store.
		 * We cannot store its original typearr because it may involve qualified
		 * anchored types (see test#store040).
		 */
	gtypes = rt_canonical_types (gtypes, eif_is_discarding_attachment_marks, &num_gtypes);
	if (gtypes) {
			/* Write attribute name information: "attr_name_length attr_name" */
		widr_multi_int16 (&attr_name_length, 1);
		widr_multi_char ((EIF_CHARACTER_8 *) attr_name, strlen (attr_name));
		basic_type = (unsigned char) (((System(dtype).cn_types[attrib_index] & SK_HEAD) >> 24) & 0x000000FF);
		widr_multi_char (&basic_type, 1);

			/* Write type information: "num_gtypes attribute_type {gen_types}*" */
		widr_multi_int16 (&num_gtypes, 1);

			/* Write type array for INDEPENDENT_STORE_6_6 format */
		for (i=0; gtypes[i] != TERMINATOR; i++) {
			gtype = gtypes[i];
			if (eif_is_discarding_attachment_marks) {
				while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY (gtype)) {
					i++;
					gtype = gtypes [i];
				}
			} else {
				while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY (gtype)) {
						/* Write annotation mark. */
					widr_multi_uint16 (&gtype, 1);
					i++;
					gtype = gtypes [i];
				}
			}
			if (gtype == TUPLE_TYPE) {
					/* Write TUPLE_TYPE, nb generic parames */
				widr_multi_uint16 (gtypes + i, TUPLE_OFFSET);
				i += TUPLE_OFFSET;
				gtype = gtypes [i];
			}
			if (gtype == FORMAL_TYPE) {
					/* Write FORMAL_TYPE and formal position */
				widr_multi_uint16 (gtypes + i, 2);
				i += 1;
			} else {
					/* No need to handle special type since they should not appear in an object type. */
				CHECK("No special type",
					(gtype != LIKE_CURRENT_TYPE) &&
					(gtype != LIKE_ARG_TYPE) &&
					(gtype != LIKE_FEATURE_TYPE) &&
					(gtype != QUALIFIED_FEATURE_TYPE));

				widr_multi_uint16 (&gtype, 1);
			}
		}
	} else {
		info_tag[0]= (char) 0;
			/* Buffer should be large enough, the manifest string is 116 characters plus
			 * 100 for attribute name and class name. */
		CHECK("info_tag large enough", sizeof(info_tag) >= 256);
		sprintf(info_tag, "Not supported: Attribute `{%.50s}.%.50s' involves a qualified anchored type referring to a formal generic parameter",
			System(dtype).cn_generator, attr_name);
		eise_io(info_tag);
	}
}

rt_private void widr_type_attributes (EIF_TYPE_INDEX dtype)
{
	int16 num_attrib = (int16) System(dtype).cn_nbattr;
	int16 persistent_num_attrib = (int16) System(dtype).cn_persistent_nbattr;
	int16 i;
#ifdef RECOVERABLE_DEBUG
	printf ("    %d attribute%s\n", num_attrib, num_attrib != 1 ? "s" : "");
#endif
	widr_multi_int16 (&persistent_num_attrib, 1);
	for (i=0; i<num_attrib; i++) {
		if (!EIF_IS_TRANSIENT_ATTRIBUTE(System(dtype),i)) {
			widr_type_attribute (dtype, i);
		}
	}
}

rt_private void widr_type_generics (EIF_TYPE_INDEX dtype)
{
	/* Write generic information: "nb_generics {meta_type}*" */
	struct cecil_info *info;

	info = cecil_info_for_dynamic_type (dtype);
	if ((info == NULL) || (info->nb_param == 0)) {
			/* Non-generic case */
		int16 zero = 0;
		widr_multi_int16 (&zero, 1);
	} else {
			/* Generic case */
		EIF_TYPE_INDEX *dynamic_types = info->dynamic_types;
		uint32 *patterns;
		uint16 nb_gen = info->nb_param;
		int32 i;

		widr_multi_uint16 (&nb_gen, 1);
		for (i = 0 ;; i++) {
			if (dynamic_types[i] == dtype) {
				patterns = info->patterns + (i * nb_gen);
#ifdef RECOVERABLE_DEBUG
				{
					rt_shared void print_generic_names (struct cecil_info *info, int type);
					printf (" ");
					print_generic_names (info, dynamic_types[i]);
				}
#endif
				widr_multi_uint32 (patterns, nb_gen);
				break;	/* Jump out of loop */
			}
		}
	}
}

rt_private void widr_type (int16 dtype, int is_version_required)
{
	const char *class_name = System (dtype).cn_generator;
	const char *l_storable_version = System (dtype).cn_version;
	int16 name_length = (int16) strlen (class_name);
	uint32 l_length;
	int32 flags = (int32) System(dtype).cn_flags;

	CHECK("valid name_length", (size_t) name_length == strlen (class_name));

	/* Write type information: "name_length name flags dynamic_type" */
	widr_multi_int16 (&name_length, 1);
	widr_multi_char ((EIF_CHARACTER_8 *) class_name, name_length);
	widr_multi_int32 (&flags, 1);
	widr_multi_int16 (&dtype, 1);

	/* Write storable version if any and requested. */
	if (is_version_required) {
		if (l_storable_version) {
			l_length = (uint32) strlen(l_storable_version);
			REQUIRE("valid l_length", (size_t) l_length == strlen (l_storable_version));
			widr_multi_uint32 (&l_length, 1);
			widr_multi_char ((EIF_CHARACTER_8 *) l_storable_version, l_length);
		} else {
			l_length = 0;
			widr_multi_uint32 (&l_length, 1);
		}
	}

	widr_type_generics (dtype);
#ifdef RECOVERABLE_DEBUG
	printf ("\n");
#endif
	widr_type_attributes (dtype);
}

rt_public void rmake_header(struct rt_store_context *a_context)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	RT_GET_CONTEXT
	int16 ohead = OVERHEAD;
	int16 max_types = scount;	/* Here there is a problem if `scount' is more than 2^16.*/
	int16 type_count;
	int16 i;
	int l_is_version_required = rt_kind_version >= INDEPENDENT_STORE_6_6;

	/* count number of types actually present in objects to be stored */
	for (type_count=0, i=0; i<scount; i++) {
		if (a_context->traversal_context.account[i].processed)
			type_count++;
	}

#ifdef RECOVERABLE_DEBUG
	printf ("-- Storing header\n");
	printf ("Overhead: %u bytes\n", ohead);
	printf ("Number of dynamic types: %u\n", max_types);
	printf ("Recorded types: %u\n", type_count);
#endif
	/* Write file-level information: "overhead_size max_types type_count" */
	widr_multi_int16 (&ohead, 1);
	widr_multi_int16 (&max_types, 1);
	widr_multi_int16 (&type_count, 1);

	for (i=0; i<scount; i++) {
		if (a_context->traversal_context.account[i].processed)
			widr_type (i, l_is_version_required);
	}
}

rt_shared void buffer_write(const char *data, size_t size)
{
	RT_GET_CONTEXT
	size_t l_cur_pos = current_position;
	size_t l_buffer_upper = buffer_size - 1;

	REQUIRE("data_not_null", data);
	REQUIRE("size_positive", size > 0);
	REQUIRE("buffer_size_positive", buffer_size > 0);

	while (size > 0) {
		if (l_cur_pos + size - 1 > l_buffer_upper) {
			size_t l_padding;
			if (l_cur_pos <= l_buffer_upper) {
				l_padding = l_buffer_upper - l_cur_pos + 1;
				memcpy (general_buffer + l_cur_pos, data, l_padding);
				size -= l_padding;
				data += l_padding;
			} else {
				l_padding = 0;
			}
			store_write_func(l_cur_pos + l_padding);
			l_cur_pos = 0;
		} else {
			memcpy (general_buffer + l_cur_pos, data, size);
			l_cur_pos += size;
			break;
		}
	}
	current_position = l_cur_pos;
}

rt_private void flush_st_buffer (void)
{
	RT_GET_CONTEXT
	size_t l_pos = current_position;

	if (l_pos > 0) {
		store_write_func(l_pos);
		current_position = 0;
	}
}

rt_public int char_write(char *pointer, int size)
{
	RT_GET_CONTEXT
	return write(s_fides, pointer, size);
}

rt_private int stream_write (char *pointer, int size)
{
	RT_GET_CONTEXT
	if (store_stream_buffer_size < store_stream_buffer_position + (size_t) size) {
		store_stream_buffer_size += buffer_size;
		store_stream_buffer = (char *) eif_realloc (store_stream_buffer, store_stream_buffer_size);
		if (!store_stream_buffer) {
			xraise(EN_MEM);
		}
	}

	memcpy ((store_stream_buffer + store_stream_buffer_position), pointer, size);
	store_stream_buffer_position += size;
	return size;
}

rt_private void store_write(size_t cmps_in_size)
{
	RT_GET_CONTEXT
	char* cmps_in_ptr = general_buffer;
	char* cmps_out_ptr = cmps_general_buffer;
	unsigned long cmps_out_size = (unsigned long) cmp_buffer_size;
	int number_left;
	int number_written;

	REQUIRE("cmp_buffer_size not too big", cmp_buffer_size < 0x7FFFFFFF);

	eif_compress ((unsigned char*)cmps_in_ptr,
					(unsigned long)cmps_in_size,
					(unsigned char*)cmps_out_ptr,
					(unsigned long*)&cmps_out_size);

	CHECK("not too big", (cmps_out_size + EIF_CMPS_HEAD_SIZE) < 0x7FFFFFFF);
	number_left = (int) (cmps_out_size + EIF_CMPS_HEAD_SIZE);

	while (number_left > 0) {
		number_written = char_write_func (cmps_out_ptr, number_left);
		if (number_written <= 0) {
			eise_io("Store: Unable to write data.");
		} else {
			number_left -= number_written;
			cmps_out_ptr += number_written;
		}
	}

	if (((size_t) (cmps_out_ptr - cmps_general_buffer)) != cmps_out_size + EIF_CMPS_HEAD_SIZE) {
		eise_io("Store: incorrect compression size.");
	}
}

rt_private void st_write_cid (EIF_TYPE_INDEX dftype)

{
	EIF_TYPE_INDEX *l_cidarr, count;
	EIF_TYPE l_dftype;
	
	l_dftype.id = dftype;
	l_dftype.annotations = 0;

	l_cidarr = eif_gen_cid (l_dftype, 0);
	count  = *l_cidarr;

	buffer_write ((char *) (&count), sizeof (EIF_TYPE_INDEX));

	/* If count = 1 then we don't need to write more data */

	if (count > 1)
		buffer_write ((char *) (l_cidarr+1), count * sizeof (EIF_TYPE_INDEX));
}

rt_private void ist_write_cid (EIF_TYPE_INDEX dftype)

{
	RT_GET_CONTEXT
	EIF_TYPE_INDEX *l_cidarr;
	uint32 count, i, val;
	int is_discarding = eif_is_discarding_attachment_marks;
	EIF_TYPE l_dftype;
	
	l_dftype.id = dftype;
	l_dftype.annotations = 0;
	l_cidarr = eif_gen_cid (l_dftype, 1);
	count = *l_cidarr;
	++l_cidarr;

	if (is_discarding) {
		val = 0;
		for (i=0; i < count; i++) {
			while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY (l_cidarr[i])) {
				i++;
			}
			val++;
		}
			/* Update `count' without taking into account any attachments. */
		count = val;
	}

	widr_norm_int (&count);

		/* If count = 1 then we don't need to write more data */
	if (count > 1) {
		for (i = 0; i < count; ++i, ++l_cidarr) {
			val = *l_cidarr;
			if (is_discarding) {
				while (RT_CONF_HAS_ANNOTATION_TYPE_IN_ARRAY(val)) {
					++l_cidarr;
					val = *l_cidarr;
				}
			}
			widr_norm_int (&val);
		}
	}

}

/*
doc:</file>
*/
