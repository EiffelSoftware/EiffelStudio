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
#include "rt_assert.h"

#ifdef DARREN		/* for doing in-editor compilation for errors */
# define RECOVERABLE_DEBUG
# undef RTXD
# define RTXD ;
# undef RTXSC
# define RTXSC ;
# define lint
#endif
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

/*#define DEBUG_GENERAL_STORE */	/**/

/*#define DEBUG 1 */	/**/

/* compression */
#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE
#define EIF_BUFFER_ALLOCATED_SIZE EIF_DCMPS_OUT_SIZE
#define EIF_CMPS_BUFFER_ALLOCATED_SIZE EIF_CMPS_OUT_SIZE

/* Convenience for backward compatibility, merged flags and dtype into a 32-bit integer. */
#define Merged_flags_dtype(flags,dtype)	((((uint32) flags) << 16) | (uint32) dtype)

#ifndef EIF_THREADS
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
doc:	<attribute name="old_store_buffer_size" return_type="size_t" export="private">
doc:		<summary>Store default version of `buffer_size'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t old_store_buffer_size = 0;

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
rt_shared void internal_store(char *object);
rt_private void st_store(char *object);				/* Second pass of the store */
rt_public void make_header(void);				/* Make header */
rt_public void rmake_header(void);
rt_private void object_write (char *object, uint16, EIF_TYPE_INDEX);
rt_private void gen_object_write (char *object, uint16, EIF_TYPE_INDEX);
rt_private void st_write_cid (EIF_TYPE_INDEX);
rt_private void ist_write_cid (EIF_TYPE_INDEX);
rt_public void free_sorted_attributes(void);
rt_public void allocate_gen_buffer(void);
rt_shared void buffer_write(char *data, size_t size);

rt_public void rt_reset_store (void);

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
doc:	<attribute name="flush_buffer_func" return_type="void (*)()" export="private">
doc:		<summary>Action called at the end of a store to flush remaining in-memory data.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*flush_buffer_func)(void);

/*
doc:	<attribute name="st_write_func" return_type="void (*)(EIF_REFERENCE, int)" export="private">
doc:		<summary>Action called to store an Eiffel object.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*st_write_func)(EIF_REFERENCE, int);

/*
doc:	<attribute name="make_header_func" return_type="void (*)(void)" export="private">
doc:		<summary>Action called to write storable header.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*make_header_func)(void);

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
doc:	<attribute name="old_store_write_func" return_type="void (*)(size_t)" export="private">
doc:		<summary>Store default version of `store_write_func'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*old_store_write_func)(size_t);

/*
doc:	<attribute name="old_char_write_func" return_type="int (*)(char *, int)" export="private">
doc:		<summary>Store default version of `char_write_func'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int (*old_char_write_func)(char *, int);

/*
doc:	<attribute name="old_flush_buffer_func" return_type="void (*)()" export="private">
doc:		<summary>Store default version of `buffer_write_func'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*old_flush_buffer_func)(void);

/*
doc:	<attribute name="old_st_write_func" return_type="void (*)(EIF_REFERENCE, int)" export="private">
doc:		<summary>Store default version of `st_write_func'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*old_st_write_func)(EIF_REFERENCE, int);

/*
doc:	<attribute name="old_make_header_func" return_type="void (*)()" export="private">
doc:		<summary>Store default version of `make_header_func'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private void (*old_make_header_func)(void);

/*
doc:	<attribute name="accounting" return_type="int" export="private">
doc:		<summary>Do we account for something while traversing first set of objects to be stored? If so, its value tells us what to do (See `eif_traverse.h' for explanation of possible values)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int accounting = 0;

/*
doc:	<attribute name="old_accounting" return_type="int" export="private">
doc:		<summary>Store default version of `accounting'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int old_accounting = 0;

/*
doc:	<attribute name="account" return_type="char *" export="shared">
doc:		<summary>Array of traversed dynamic types during accounting.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>Dynamic type</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char *account = NULL;

/*
doc:	<attribute name="sorted_attributes" return_type="unsigned int **" export="shared">
doc:		<summary>Array of sorted attributes</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[Dynamic type, attribute number]</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared unsigned int **sorted_attributes = NULL;

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

/* Initialize store function pointers and globals */
/* reset buffer size if argument is non null */
rt_public void rt_init_store(
	void (*store_function) (size_t),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (EIF_REFERENCE, int),
	void (*make_header_function) (void),
	int accounting_type)
{
	RT_GET_CONTEXT
	old_store_write_func = store_write_func;
	old_char_write_func = char_write_func;
	old_flush_buffer_func = flush_buffer_func;
	old_st_write_func = st_write_func;
	old_make_header_func = make_header_func;
	old_accounting = accounting;
	old_store_buffer_size = buffer_size;

	store_write_func = store_function;
	char_write_func = char_write_function;
	flush_buffer_func = flush_buffer_function;
	st_write_func = st_write_function;
	make_header_func = make_header_function;
	accounting = accounting_type;
	buffer_size = EIF_BUFFER_SIZE;
}

/* Reset store function pointers and globals to their default values */

rt_public void rt_reset_store(void) {
	RT_GET_CONTEXT
	store_write_func = old_store_write_func;
	char_write_func = old_char_write_func;
	flush_buffer_func = old_flush_buffer_func;
	st_write_func = old_st_write_func;
	make_header_func = old_make_header_func;
	accounting = old_accounting;
	buffer_size = old_store_buffer_size;

	if (account != (char *) 0) {
		eif_rt_xfree(account);
		account = (char *) 0;
	}

	free_sorted_attributes();

	if (idr_temp_buf != (char *) 0) {
		eif_rt_xfree(idr_temp_buf);
		idr_temp_buf = (char *) 0;
	}
}

/* Functions definitions */

/* Basic store */
/* Store object hierarchy of root `object' without header. */
rt_public void estore(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	s_fides = (int) file_desc;

	rt_init_store (
		store_write,
		char_write,
		flush_st_buffer,
		st_write,
		NULL,
		0);

	allocate_gen_buffer();
	internal_store(object);

	rt_reset_store ();
}

rt_public EIF_INTEGER stream_estore(EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT
	rt_init_store (
		store_write,
		stream_write,
		flush_st_buffer,
		st_write,
		NULL,
		0);

	store_stream_buffer = *buffer;
	store_stream_buffer_size = size;
	store_stream_buffer_position = 0;

	allocate_gen_buffer();
	internal_store(object);

	*buffer = store_stream_buffer;
	rt_reset_store ();
	*real_size = (EIF_INTEGER) store_stream_buffer_position;
	CHECK("not too big", store_stream_buffer_size <= 0x7FFFFFFF);
	return (EIF_INTEGER) store_stream_buffer_size;
}

/* General store */
/* Store object hierarchy of root `object' and produce a header
 * so it can be retrieved by other systems. */
rt_public void eestore(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	s_fides = (int) file_desc;

	rt_init_store (
		store_write,
		char_write,
		flush_st_buffer,
		gst_write,
		make_header,
		TR_ACCOUNT);

	allocate_gen_buffer();
	internal_store(object);

	rt_reset_store ();
}

rt_public EIF_INTEGER stream_eestore(EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT
	rt_init_store (
		store_write,
		stream_write,
		flush_st_buffer,
		gst_write,
		make_header,
		TR_ACCOUNT);

	store_stream_buffer = *buffer;
	store_stream_buffer_size = size;
	store_stream_buffer_position = 0;

	allocate_gen_buffer();
	internal_store(object);
	*buffer = store_stream_buffer;

	rt_reset_store ();
	*real_size = (EIF_INTEGER) store_stream_buffer_position;
	CHECK("not too big", store_stream_buffer_size <= 0x7FFFFFFF);
	return (EIF_INTEGER) store_stream_buffer_size;
}

rt_public void basic_general_free_store (EIF_REFERENCE object)
{
	allocate_gen_buffer();
	internal_store(object);
}

#ifndef EIF_THREADS
/*
doc:	<attribute name="eif_is_discarding_attachment_marks" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Does `independent_store' discard the attachment marks if found during store operation? Default False.</summary>
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

	rt_init_store (
		NULL,
		char_write,
		idr_flush,
		ist_write,
		rmake_header,
		RECOVER_ACCOUNT);

		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) eif_rt_xmalloc (48, C_T, GC_OFF);
	if (!idr_temp_buf) {
		xraise (EN_MEM);
	}

	internal_store(object);

	run_idr_destroy ();
	eif_rt_xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;

	rt_reset_store ();
}

rt_public EIF_INTEGER stream_sstore (EIF_POINTER *buffer, EIF_INTEGER size, EIF_REFERENCE object, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT
	rt_init_store (
		NULL,
		stream_write,
		idr_flush,
		ist_write,
		rmake_header,
		RECOVER_ACCOUNT);

	store_stream_buffer = *buffer;
	store_stream_buffer_size = size;
	store_stream_buffer_position = 0;

		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) eif_rt_xmalloc (48, C_T, GC_OFF);
	if (!idr_temp_buf) {
		xraise (EN_MEM);
	}

	internal_store(object);

	run_idr_destroy ();
	eif_rt_xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;

	*buffer = store_stream_buffer;
	rt_reset_store ();
	*real_size = (EIF_INTEGER) store_stream_buffer_position;
	CHECK("not too big", store_stream_buffer_size <= 0x7FFFFFFF);
	return (EIF_INTEGER) store_stream_buffer_size;
}

rt_public void independent_free_store (EIF_REFERENCE object)
{
	RT_GET_CONTEXT
		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) eif_rt_xmalloc (48, C_T, GC_OFF);
	if (!idr_temp_buf) {
		xraise (EN_MEM);
	}

	internal_store(object);

	run_idr_destroy ();
	eif_rt_xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;
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

rt_shared void internal_store(char *object)
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
	RTYD;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		EIF_EO_STORE_UNLOCK;	/* Unlock mutex which was locked in `internal_store'. */
		rt_reset_store ();				/* Reset data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	if (accounting) {		/* Prepare character array */
		account = (char *) eif_rt_xmalloc(scount * sizeof(char), C_T, GC_OFF);
		if (account == (char *) 0)
			xraise(EN_MEM);
		memset (account, 0, scount * sizeof(char));
		if (accounting == RECOVER_ACCOUNT) {
#ifdef RECOVERABLE_DEBUG
			printf ("Storing in new recoverable format\n");
#endif
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
		}
		else {
				/* To help a better transition for the storable changes in 6.6, if the code is compiled
				 * in compatible mode, then we use the old storable format which does not store the version
				 * of the class. */
			if (egc_has_old_special_semantic) {
					/* As in version 6.5 and 6.4, when we are in compatible mode,
					 * we generate the previous format. */
				c = GENERAL_STORE_4_0;
			} else {
				c = GENERAL_STORE_6_6;
			}
			rt_kind_version = c;

				/* Allocate the array to store the sorted attributes */
			sorted_attributes = (unsigned int **) eif_rt_xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Malloc on sorted_attributes %d %d %lx\n", scount, scount * sizeof(unsigned int *), sorted_attributes);
#endif
			if (sorted_attributes == (unsigned int **) 0){
				eif_rt_xfree(account);
				xraise(EN_MEM);
			}
			memset (sorted_attributes, 0, scount * sizeof(unsigned int *));
		}
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
	l_failure = (char_write_func(&c, sizeof(char)) < 0);
	if ((c != INDEPENDENT_STORE_6_3) && (c != GENERAL_STORE_4_0) && (!l_failure)) {
			/* Then write the storable properties. */
		l_failure = (char_write_func(&l_store_properties, sizeof(char)) < 0);
	}
	if (l_failure) {
		if (accounting) {
			eif_rt_xfree(account);
			if (c==GENERAL_STORE_4_0)
					/* sorted_attributes is empty so a basic free is enough */
				eif_rt_xfree((char *)sorted_attributes);
				sorted_attributes = (unsigned int **) 0;
			}
		eise_io("Store: unable to write the kind of storable.");
	} else {
		EIF_EO_STORE_LOCK;
		obj_nb = 0;
		traversal(object, 1, accounting);

		if (accounting) {
			make_header_func();			/* Make header */
			eif_rt_xfree(account);			/* Free accouting character array */

			account = (char *) 0;
		}
		/* Write the count of stored objects */
		if (accounting == RECOVER_ACCOUNT) {
			widr_multi_uint32 (&obj_nb, 1);
		} else {
			buffer_write((char *)(&obj_nb), sizeof(uint32));
		}

#if DEBUG & 3
			printf (" %x", obj_nb);
#endif

		st_store(object);		/* Write objects to be stored */

		flush_buffer_func();	/* flush the buffer */

		EIF_EO_STORE_UNLOCK;
#if DEBUG & 3
		printf ("\n");
#endif
#ifdef RECOVERABLE_DEBUG
		fflush (stdout);
#endif
		expop(&eif_stack);
	}
}

rt_private void st_store(EIF_REFERENCE object)
{
	/* Second pass of the store mecahnism: writing on the disk. */
	RT_GET_CONTEXT
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
							st_store(o_ref);
						}
					}
				}
			} else if (!(flags & EO_COMP)) {		/* Special of references */
				for (ref = object; count > 0; count--,
						ref = (EIF_REFERENCE) ((EIF_REFERENCE *) ref + 1)) {
					o_ref = *(EIF_REFERENCE *) ref;
					if (o_ref != (EIF_REFERENCE) 0)
						st_store(o_ref);
				}
			} else {						/* Special of composites */
				elem_size = RT_SPECIAL_ELEM_SIZE(object);
				for (ref = object + OVERHEAD; count > 0;
					count --, ref += elem_size) {
					st_store(ref);
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
					st_store(o_ref);
				} else {
					has_transient_attributes = 1;
				}
			}
		}
	}

	if (!is_expanded) {
		st_write_func(object, has_transient_attributes);		/* write the object */
	}
}

rt_public void st_write(EIF_REFERENCE object, int has_transient_attributes)
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

rt_public void gst_write(EIF_REFERENCE object, int has_transient_attributes)
{
	/* Write an object.
	 * used for general store
	 */

	union overhead *zone;
	uint32 store_flags;
	uint16 flags;

	zone = HEADER(object);
	flags = zone->ov_flags;

	/* Write address */

	buffer_write((char *)(&object), sizeof(char *));

	store_flags = Merged_flags_dtype(flags,zone->ov_dtype);
	buffer_write((char *)(&store_flags), sizeof(uint32));
	st_write_cid (Dftype(object));

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
			CHECK("Proper version", rt_kind_version < GENERAL_STORE_6_4);
			l_extra_data = (uint32)(RT_SPECIAL_ELEM_SIZE(object));
		} else {
				/* We need to write the capacity with the new semantic. */
			l_extra_data = (uint32)(RT_SPECIAL_CAPACITY(object));
		}
		buffer_write((char *)(&count), sizeof(uint32));
		buffer_write((char *)(&l_extra_data), sizeof(uint32));
	}
	/* Write the body of the object */
	gen_object_write(object, flags, Dftype(object));

}

rt_public void ist_write(EIF_REFERENCE object, int has_transient_attributes)
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
	BODY_INDEX offset;

	rout_id = System(dtype).cn_attr[attrib_num];
	CAttrOffs(offset,rout_id,dtype);
	return offset;
#endif
}

rt_shared rt_uint_ptr get_alpha_offset(EIF_TYPE_INDEX dtype, rt_uint_ptr attrib_num)
{
	/* Get the offset for attribute number `attrib_num' (after alphabetical sort) */
	RT_GET_CONTEXT
#ifdef WORKBENCH
	int32 rout_id;				/* Attribute routine id */
	BODY_INDEX offset;
#endif
	rt_uint_ptr alpha_attrib_num;

	unsigned int *attr_types = sorted_attributes[dtype];

	if (attr_types == (unsigned int *)0) {
		alpha_attrib_num = attrib_num;
	} else {
		alpha_attrib_num = attr_types[attrib_num];
	}
#ifndef WORKBENCH
	return (System(dtype).cn_offsets[alpha_attrib_num]);
#else
	rout_id = System(dtype).cn_attr[alpha_attrib_num];
	CAttrOffs(offset,rout_id,dtype);
	return offset;
#endif
}

/*
doc:	<routine name="gen_object_write" export="private">
doc:		<summary>Store object using platform general format.</summary>
doc:		<param name="object" type="char *">Pointer to the object being stored. It is a `char *' and not an `EIF_REFERENCE' because some time `object' may not have an object header (case of an expanded without references in a SPECIAL instance.</param>
doc:		<param name="flags" type="uint16">Flags associated to the type of object pointed by `object'.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Full dynamic type of `object'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_eo_store_mutex</synchronization>
doc:	</routine>
*/

rt_private void gen_object_write(char *object, uint16 flags, EIF_TYPE_INDEX dftype)
{
		/* Writes an object to disk (used by the new (3.3) general store)
		 * It uses the same algorithm as `object_write' and should be updated
		 * at the same time.
		 */

	rt_uint_ptr attrib_offset, elem_size;
	EIF_TYPE_INDEX dtype = To_dtype(dftype);
	EIF_TYPE_INDEX exp_dftype;
	rt_uint_ptr num_attrib;
	uint32 store_flags;
	uint32 sk_type;

	num_attrib = System(dtype).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			num_attrib--;
			if (!EIF_IS_TRANSIENT_ATTRIBUTE(System(dtype), num_attrib)) {
				attrib_offset = get_alpha_offset(dtype, num_attrib);
				sk_type = *(System(dtype).cn_types + num_attrib) & SK_HEAD;
				switch (sk_type) {
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
								/* We don't actually need the size because per the validity rules they cannot be volatile. */
							elem_size = 0; break;
					default:
						elem_size = 0;
						eise_io("General store: not an Eiffel object.");
				}
				if (sk_type == SK_EXP) {
						/* General store does not need a value for the second argument since
						 * we do a field by field store. */
					gst_write (object + attrib_offset, 0);
				} else {
					buffer_write (object + attrib_offset, elem_size);
				}
			}
		}
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			EIF_INTEGER count;
			EIF_REFERENCE ref;

			count = RT_SPECIAL_COUNT(object);

			if (flags & EO_TUPLE) {
				buffer_write (object, (rt_uint_ptr) count * sizeof(EIF_TYPED_VALUE));
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
					if ((*dynamic_types++) == dtype)
						break;
				}
				dynamic_types--;
				patterns = info->patterns + nb_gen * (dynamic_types - info->dynamic_types);
				dgen = *patterns;


				if (!(flags & EO_REF)) {		/* Special of simple types */
					switch (dgen & SK_HEAD) {
						case SK_UINT8: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_NATURAL_8)); break;
						case SK_UINT16: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_NATURAL_16)); break;
						case SK_UINT32: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_NATURAL_32)); break;
						case SK_UINT64: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_NATURAL_64)); break;
						case SK_INT8: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_INTEGER_8)); break;
						case SK_INT16: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_INTEGER_16)); break;
						case SK_INT32: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_INTEGER_32)); break;
						case SK_INT64: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_INTEGER_64)); break;
						case SK_CHAR32: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_CHARACTER_32)); break;
						case SK_BOOL: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_BOOLEAN)); break;
						case SK_CHAR8: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_CHARACTER_8)); break;
						case SK_REAL32: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_REAL_32)); break;
						case SK_REAL64: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_REAL_64)); break;
						case SK_POINTER: buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_POINTER)); break;
						case SK_EXP:
							elem_size = RT_SPECIAL_ELEM_SIZE(object);
							exp_dftype = eif_gen_param_id(dftype, 1);
							store_flags = Merged_flags_dtype(EO_EXP,To_dtype(exp_dftype));
							buffer_write((char *) (&store_flags), sizeof(uint32));
							st_write_cid (exp_dftype);
#ifdef WORKBENCH
							ref = object + OVERHEAD;
#else
								/* In finalized mode, there is no header in a special which
								 * does not have the EO_REF flag. */
							ref = object;
#endif
							for (; count > 0; count --, ref += elem_size) {
								gen_object_write(ref, EO_EXP, exp_dftype);
							}
							break;
						default:
							eise_io("General store: not an Eiffel object.");
							break;
					}
				} else {
					if (!(flags & EO_COMP)) {	/* Special of references */
						buffer_write(object, (rt_uint_ptr) count*sizeof(EIF_REFERENCE));
					} else {			/* Special of composites */
						elem_size = RT_SPECIAL_ELEM_SIZE(object);
						exp_dftype = eif_gen_param_id(dftype, 1);
						store_flags = Merged_flags_dtype(EO_EXP,To_dtype(exp_dftype));
						buffer_write((char *)(&store_flags), sizeof(uint32));
						st_write_cid (exp_dftype);
						for (ref = object + OVERHEAD; count > 0; count --, ref += elem_size) {
							gen_object_write(ref, EO_EXP, exp_dftype);
						}
					}
				}
			}
		}
	}
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
				uint32 dgen, dgen_typ;
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
					CHECK("Not invalid", *dynamic_types != SK_INVALID);
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
							exp_dftype = eif_gen_param_id(dftype, 1);
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
						exp_dftype = eif_gen_param_id(dftype, 1);
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



rt_public void make_header(EIF_CONTEXT_NOARG)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_TYPE_INDEX i;
	char *vis_name;			/* Visible name of a class */
	int l_is_version_required = rt_kind_version >= GENERAL_STORE_6_6;
	char *l_storable_version;
	char *s_buffer = NULL;
	uint32 l_length;
	struct cecil_info *info;
	volatile int nb_line = 0;
	volatile size_t bsize = 80;
	jmp_buf exenv;
	RTYD;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		if (s_buffer) {
			eif_rt_xfree(s_buffer);
		}
		RTXSC;					/* Restore stack contexts */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	s_buffer = (char *) eif_rt_xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	if (!s_buffer) {
		xraise(EN_MEM);
	}
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eise_io("General store: unable to write number of different Eiffel types.");
	}
	buffer_write(s_buffer, (strlen (s_buffer)));


	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eise_io("General store: unable to write number of header lines.");
	}
	buffer_write(s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'. */

		sort_attributes(i);

		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6))
			{
				bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
				s_buffer = (char *) xrealloc (s_buffer, bsize, GC_OFF);
		}

		info = cecil_info_for_dynamic_type (i);
		if ((info != NULL) && (info->nb_param > 0)) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			EIF_TYPE_INDEX *dynamic_types = info->dynamic_types;
			uint32 *patterns;
			uint16 nb_gen = info->nb_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %ld %d", i, vis_name, EIF_Size(i), nb_gen)) {
				eise_io("General store: unable to write the generic type name.");
			}

			buffer_write(s_buffer, (strlen (s_buffer)));

			for (;;) {
				if ((*dynamic_types++) == i)
					break;
			}
			dynamic_types--;
			patterns = info->patterns + nb_gen * (dynamic_types - info->dynamic_types);
			for (j=0; j<nb_gen; j++) {
				long dgen;

				dgen = (long) *(patterns++);
				if (0 > sprintf(s_buffer, " %ld", dgen)) {
					eise_io("General store: unable to write the generic type description.");
				}
				buffer_write(s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *	"dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s %ld 0", i, vis_name, EIF_Size(i))) {
				eise_io("General store: unable to write type description.");
			}
			buffer_write(s_buffer, (strlen (s_buffer)));
		}

		s_buffer [0] = '\n';
		buffer_write(s_buffer, 1);

			/* Store the version number for the current type. */
		if (l_is_version_required) {
			l_storable_version = System(i).cn_version;
			if (l_storable_version) {
				l_length = (uint32) strlen(l_storable_version);
				buffer_write((char *)&l_length, sizeof(uint32));
				buffer_write(l_storable_version, l_length);
			} else {
				l_length = 0;
				buffer_write((char *)&l_length, sizeof(uint32));
			}
		}
	}
	eif_rt_xfree (s_buffer);
	s_buffer = (char *) 0;
	expop(&eif_stack);
}

rt_public void sort_attributes(int dtype)
{
	/* Sort the attributes alphabeticaly by type */
	RT_GET_CONTEXT
	struct cnode *class_info;		/* Info on the current type */
	unsigned int *s_attr;			/* Sorted attributes for the type */
	char **attr_names;
	uint32 *attr_types;
	unsigned int no_swap, swapped, tmp;

	unsigned long attr_nb;
	unsigned long j;

	class_info = &(System(dtype));
	attr_nb = class_info->cn_nbattr;

	if (attr_nb){
		attr_names = class_info->cn_names;
		attr_types = class_info->cn_types;

#ifdef DEBUG_GENERAL_STORE
printf ("attr_nb: %d class name: %s\n", attr_nb, class_info->cn_generator);
printf ("Dtype: %d \n", dtype);
#endif
		s_attr = (unsigned int*) eif_rt_xmalloc (attr_nb * sizeof(unsigned int), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("alloc s_attr (%d) %lx\n", dtype, s_attr);
#endif
		if (s_attr == (unsigned int*) 0)
			xraise(EN_MEM);

		sorted_attributes[dtype] = s_attr;

		for (j=0; j < attr_nb; j++)
			s_attr[j] = j;

		swapped = no_swap = 1;

		while (swapped)
			for (j = swapped = 0; j < attr_nb-1; j ++)
				if ((attr_types[s_attr[j]]==attr_types[s_attr[j+1]])&&
					(strcmp (attr_names[s_attr[j]], attr_names[s_attr[j+1]]) > 0)) {
#ifdef DEBUG
printf ("Swapping %s and %s\n", attr_names[s_attr[j]], attr_names[s_attr[j+1]]);
printf ("%d %d\n", s_attr[j], s_attr[j+1]);
printf ("%d %d\n", attr_types[s_attr[j]], attr_types[s_attr[j+1]]);
#endif
						swapped = 1;
						no_swap = 0;
						tmp = s_attr[j];
						s_attr[j] = s_attr[j+1];
						s_attr[j+1] = tmp;
					}

			/* if the skeleton is already sorted, bcopy will work both for store and retrieve */
		if (no_swap){
#ifdef DEBUG_GENERAL_STORE
printf ("Freeing s_attr %lx\n", s_attr);
#endif
			eif_rt_xfree((char *)s_attr);
			sorted_attributes[dtype] = (unsigned int*)0;
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

rt_private void widr_type_attribute (int16 dtype, int16 attrib_index)
{
	RT_GET_CONTEXT
	char *name = System (dtype).cn_names[attrib_index];
	int16 name_length = (int16) strlen (name);
	EIF_TYPE_INDEX *gtypes = System (dtype).cn_gtypes[attrib_index] + 1;
	int16 num_gtypes;
	int16 i;
	unsigned char basic_type;
#ifdef RECOVERABLE_DEBUG
	int16 *typearr = gtypes;
#endif

	REQUIRE("valid name_length", (size_t) name_length == strlen (name));

	num_gtypes = 0;
	for (i=0; gtypes[i] != TERMINATOR; i++) {
		 	/* count types, and ignore attachment marks if any and requested. */
		if (eif_is_discarding_attachment_marks) {
			while (RT_HAS_ANNOTATION_TYPE (gtypes[i])) {
				i++;
			}
		}
		num_gtypes++;
	}

#ifdef RECOVERABLE_DEBUG
	printf ("        %s:", name);
#endif
	/* Write name information: "name_length name" */
	widr_multi_int16 (&name_length, 1);
	widr_multi_char ((EIF_CHARACTER_8 *) name, strlen (name));
	basic_type = (unsigned char) (((System(dtype).cn_types[attrib_index] & SK_HEAD) >> 24) & 0x000000FF);
	widr_multi_char (&basic_type, 1);

	/* Write type information: "num_gtypes attribute_type {gen_types}*" */
	widr_multi_int16 (&num_gtypes, 1);
	/* Write type array */
	for (i=0; gtypes[i] != TERMINATOR; i++) {
		EIF_TYPE_INDEX gtype = gtypes[i];
#ifdef RECOVERABLE_DEBUG
		rt_shared char *name_of_attribute_type (int16 **type);
		printf ("%s%s", i==0 ? " " : i==1 ? " [" : ", ", name_of_attribute_type (&typearr));
		typearr++;
#endif
		if (eif_is_discarding_attachment_marks) {
			while (RT_HAS_ANNOTATION_TYPE (gtype)) {
				i++;
				gtype = gtypes [i];
			}
		} else {
			while (RT_HAS_ANNOTATION_TYPE (gtype)) {
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
			widr_multi_uint16 (&gtype, 1);
		}
	}
#ifdef RECOVERABLE_DEBUG
	printf ("%s\n", num_gtypes > 1 ? "]" : "");
#endif
}

rt_private void widr_type_attributes (int16 dtype)
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
	char *class_name = System (dtype).cn_generator;
	char *l_storable_version = System (dtype).cn_version;
	int16 name_length = (int16) strlen (class_name);
	uint32 l_length;
	int32 flags = (int32) System(dtype).cn_flags;

	REQUIRE("valid name_length", (size_t) name_length == strlen (class_name));

#ifdef RECOVERABLE_DEBUG
	printf ("Type %d %s", dtype, class_name);
#endif
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

rt_public void rmake_header(EIF_CONTEXT_NOARG)
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
		if (account[i])
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
		if (account[i])
			widr_type (i, l_is_version_required);
	}
}

rt_public void free_sorted_attributes(void)
	/* Free the memory allocated for `sorted_attributes'. */
{
	RT_GET_CONTEXT
	int i;
	unsigned int *s_attr;

	if (sorted_attributes != (unsigned int **)0) {
#ifdef DEBUG_GENERAL_STORE
printf ("free_sorted_attributes %lx\n", sorted_attributes);
#endif
		for (i=0; i < scount; i++)
			if ((s_attr = sorted_attributes[i])!= (unsigned int *) 0) {
				eif_rt_xfree((char *) s_attr);
#ifdef DEBUG_GENERAL_STORE
printf ("Free s_attr (%d) %lx\n", i, s_attr);
#endif
			}
		eif_rt_xfree((char *) sorted_attributes);
		sorted_attributes = (unsigned int **)0;
	}
}

rt_shared void buffer_write(char *data, size_t size)
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

rt_public void flush_st_buffer (void)
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

void store_write(size_t cmps_in_size)
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

	l_cidarr = eif_gen_cid (dftype);
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

	l_cidarr = eif_gen_cid (dftype);
	count = *l_cidarr;
	++l_cidarr;

	if (is_discarding) {
		val = 0;
		for (i=0; i < count; i++) {
			while (RT_HAS_ANNOTATION_TYPE (l_cidarr[i])) {
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
				while (RT_HAS_ANNOTATION_TYPE(val)) {
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
