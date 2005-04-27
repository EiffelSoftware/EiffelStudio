/*

 #    #  ######  #    #           ####    #####   ####   #####   ######         ####
 ##   #  #       #    #          #          #    #    #  #    #  #             #    #
 # #  #  #####   #    #           ####      #    #    #  #    #  #####         #
 #  # #  #       # ## #               #     #    #    #  #####   #        ###  #
 #   ##  #       ##  ##          #    #     #    #    #  #   #   #        ###  #    #
 #    #  ######  #    # #######   ####      #     ####   #    #  ######   ###   ####

	New Partial store mechanism

*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_memory.h"
#include "eif_hashinin.h"
#include "rt_error.h"
#include "rt_assert.h"
#include "rt_malloc.h"
#include "rt_except.h"
#include "rt_gen_conf.h"

#ifdef EIF_WINDOWS
#include <io.h>
#else
#include "unistd.h"
#endif

#include "new_pstore.h"

#define MAX_BUFFER_SIZE	1000000L		/* Default size of buffer */

rt_private EIF_REFERENCE server; /* Current server used when storing */
rt_private void partial_store_append(EIF_REFERENCE object, fnptr mid, fnptr nid);
rt_private void hash_table_create (int size);	/* Create HASH_TABLE [INTEGER, ADDRESS] */
rt_private void hash_table_free ();	/* Free HASH_TABLE [INTEGER, ADDRESS] */
rt_private char *buffer_write (char *tmp_buffer, void *data, int size);
rt_private char *buffer_read (char *tmp_buffer, void *data, int size);
rt_private int store_object (EIF_REFERENCE object, int a_object_count);
rt_private EIF_REFERENCE retrieve_objects (EIF_INTEGER nb_obj);
rt_private int st_write_cid (char **tmp_buffer, uint32 dftype);	/* Store generic info */
rt_private char *rt_read_cid (char *tmp_buffer, uint32 *crflags, uint32 *nflags, uint32 oflags);
rt_private void new_traversal (EIF_REFERENCE object);	/* Object traversal */

rt_private struct store_htable *address_table;	/* HASH_TABLE [INTEGER, ADDRESS] */
rt_private int max_object_id;	/* Current maximum allowed object id */
rt_private char *buffer;	/* Memory area when storage is done */
rt_private EIF_INTEGER current_buffer_pos;	/* Offset where we are writing at the moment */
rt_private fnptr make_index, need_index;	/* Hook functions. */
rt_private int file_position;	/* File position as given */
rt_private EIF_INTEGER pstore_obj_nb;	/* Numberof stored objects computed by `traversal'. */

rt_public long store_append(
		EIF_INTEGER f_desc,
		EIF_REFERENCE object,
		fnptr mid,
		fnptr nid,
		EIF_REFERENCE s)
	/* Append `object' in file `f', and applies routine `mid'
	 * on server `s'. Return position in the file where the object is
	 * stored. */
{
	char *tmp_buffer;
	EIF_INTEGER size;

		/* Initialization */
	server = s;

	if ((file_position = lseek ((int) f_desc, 0, SEEK_END)) == -1)
		eraise ("Unable to seek on internal data files", EN_SYS);

	partial_store_append(object, mid, nid);

		/* We do not count the first EIF_INTEGER */
	tmp_buffer = buffer;
	size = current_buffer_pos - sizeof(EIF_INTEGER);
	tmp_buffer = buffer_write (tmp_buffer, &size, sizeof(EIF_INTEGER));
	tmp_buffer = buffer_write (tmp_buffer, &pstore_obj_nb, sizeof(EIF_INTEGER));
	write (f_desc, buffer, current_buffer_pos);
	
	hash_table_free ();

	return file_position;
}

rt_public EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj, long length)
{
	EIF_REFERENCE result;
	char gc_stopped = !gc_ison ();

	gc_stop();

		/* Go to `position' in `f_desc'. */
	if (lseek (f_desc, position, SEEK_SET) == -1)
		esys ();

		/* Create buffer */
	buffer = (char *) eif_rt_xmalloc (length, C_T, GC_OFF);

		/* Read full content of what needs to be read */
	if (read (f_desc, buffer, length) <= 0)
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

		/* Initialize buffer position */
	current_buffer_pos = 0;

		/* Retrieve all requested `nb_obj' objects. */
	result = retrieve_objects (nb_obj);

		/* Free `buffer' */
	eif_rt_xfree ((char *) buffer);
	buffer = NULL;

	if (!gc_stopped)
		gc_run();

	return result;
}

rt_public EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position)
	/* Retrieve all objects starting at `position' in `f_desc'. */
{
	EIF_INTEGER length;
	EIF_REFERENCE result;
	char gc_stopped = !gc_ison ();

	gc_stop();

		/* Go to `position' in `f_desc'. */
	if (lseek (f_desc, position, SEEK_SET) == -1)
		esys ();

		/* Read size to read */
	if (read (f_desc, &length, sizeof(EIF_INTEGER)) <= 0) 
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

		/* Create buffer */
	buffer = (char *) eif_rt_xmalloc (length, C_T, GC_OFF);

		/* Read full content of what needs to be read */
	if (read (f_desc, buffer, length) <= 0)
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

		/* Initialize buffer position */
	current_buffer_pos = 0;

		/* Retrieve all requested objects.
		 * We will retrieve `*(EIF_INTEGER *) buffer' objects, since the number
		 * of objects to retrieved has been stored at the second position in the
		 * file */

	result = retrieve_objects (*(EIF_INTEGER *) buffer);

		/* Free `buffer' */
	eif_rt_xfree ((char *) buffer);
	buffer = NULL;

	if (!gc_stopped)
		gc_run();

	return result;
}

rt_private EIF_REFERENCE retrieve_objects (EIF_INTEGER nb_obj)
{
	EIF_INTEGER i, j, object_id, dtype;
	EIF_INTEGER nb_bytes, nb_ref;
	EIF_REFERENCE *obj_array, o_ref, o_ptr, *o_field;
	EIF_INTEGER min_object_id;
	uint32 crflags, fflags, flags;
	union overhead *zone;
	char *tmp_buffer = buffer + sizeof(EIF_INTEGER);

		/* Allocate array where all retrieved objects will be stored */
	obj_array = (EIF_REFERENCE *) eif_rt_xmalloc (nb_obj * sizeof(EIF_REFERENCE), C_T, GC_OFF);

		/* Get the lower bound of the `obj_array' array, by reading the ID of
		 * the first object that we are reading.*/
	(void) buffer_read (tmp_buffer, &min_object_id, sizeof(EIF_INTEGER));

		/* First pass of retrieving. We create `nb_obj' objects in one
		 * pass without resolving the references between objects.
		 * At this point, all objects which have references, contains
		 * numbers between 1 and `nb_obj'.*/
	for (i = 0; i < nb_obj ; i++) {
			/* Read ID of `i-th' object. */
		tmp_buffer = buffer_read (tmp_buffer, &object_id, sizeof(EIF_INTEGER));

			/* Read flags of `i-th' object. */
		tmp_buffer = buffer_read (tmp_buffer, &flags, sizeof(uint32));

			/* Read creation flags for generic conformance */
		tmp_buffer = rt_read_cid (tmp_buffer, &crflags, &fflags, flags);
	
		if (flags & EO_SPEC) {	/* Special reference */
			CHECK("Not tuple", !(flags & EO_TUPLE));
				/* Read SPECIAL size. */
			tmp_buffer = buffer_read (tmp_buffer, &nb_bytes, sizeof(EIF_INTEGER));

				/* Create SPECIAL */
			o_ref = spmalloc (nb_bytes, EIF_FALSE);

				/* Set generic types and flags */
			HEADER(o_ref)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);

				/* Read SPECIAL content and copy it into `o_ref'. */
			tmp_buffer = buffer_read (tmp_buffer, o_ref, nb_bytes);
		} else {
				/* Read Object size */
			nb_bytes = EIF_Size((uint16)(flags & EO_TYPE));

				/* Create object and copy its content from `tmp_buffer'. */
			o_ref = emalloc(crflags & EO_TYPE);
			tmp_buffer = buffer_read (tmp_buffer, o_ref, nb_bytes);
		}
			/* Store `o_ref' at `object_id' pos in `obj_array' */
		obj_array [object_id - min_object_id] = o_ref;
			/* Make sure that the retrieved `object_id' is valid. */
		CHECK("valid object_id",  ((object_id - min_object_id) < nb_obj));
	}

		/* Now, all objects have been retrieved, we do need to update
		 * references between objects, so that we have a consistent object.
		 * We have to start the loop at `1' because `obj_array' starts at
		 * `1'. This is imposed by the storing mechanism which cannot use
		 * `0' as lower bound, since it is used for error checking. */
	for (i = 0; i < nb_obj ; i++) {
		o_ref = obj_array [i];
		zone = HEADER(o_ref);
		flags = zone->ov_flags;
		if (flags & EO_SPEC) {	/* SPECIAL object */
			CHECK("Not tuple", !(flags & EO_TUPLE));
				/* We update SPECIAL object only if it is full of references. */
			if (flags & EO_REF) {	/* SPECIAL of reference */
					/* Get the number of elements in SPECIAL */
				o_ptr = (EIF_REFERENCE) (o_ref + (zone->ov_size & B_SIZE) - LNGPAD_2);
				nb_ref = *(EIF_INTEGER *) o_ptr;

				for (j = 0; j < nb_ref; j++) {
					o_field = (EIF_REFERENCE *) (o_ref + j * sizeof(EIF_REFERENCE));
						/* Make sure that the reference points on a valid
						 * object, i.e. which has a valid `object_id'. */
					CHECK("Valid object", ((((EIF_INTEGER) *o_field) - min_object_id) < nb_obj));
					if (*o_field != NULL) {
						*o_field = obj_array [((EIF_INTEGER) (*o_field)) - min_object_id];
						RTAS_OPT (*o_field, j, o_ref);
					}
				}
			}
		} else {				/* Normal object */
			dtype = Deif_bid(flags);
			nb_ref = References(dtype);
			for (j = 0; j < nb_ref; j ++) {
				o_field = (EIF_REFERENCE *) (o_ref + j * sizeof(EIF_REFERENCE));
					/* Make sure that the reference points on a valid
					 * object, i.e. which has a valid `object_id'. */
				CHECK("valid object", ((((EIF_INTEGER) *o_field) - min_object_id) < nb_obj));
				if (*o_field != NULL) {
					*o_field = obj_array [((EIF_INTEGER) (*o_field)) - min_object_id];
					RTAS(*o_field, o_ref);
				}
			}
		}
	}

		/* Return root object stored in first entry of `obj_array'. */
	return obj_array[0];
}

rt_private void partial_store_append(EIF_REFERENCE object, fnptr mid, fnptr nid)
{
	int nb_stored_object;
	char gc_stopped = !gc_ison ();

	gc_stop();	/* Procedure `mid' or `nid' may trigger a GC cycle, and we don't want
				 * this to happen, since we keep a non-protected reference on objects */

		/* Do the complete traversals of objects that needs to be stored */
		/* Number of objects is stored in global variables `pstore_obj_nb'      */
	pstore_obj_nb = 0;
	new_traversal (object);

	need_index = nid;
	make_index = mid;
	hash_table_create (pstore_obj_nb);
	
		/* `max_object_id' is initialized to `1' because `store_ht_value' already returns 
		 * `0' when it does not find an item */
	max_object_id = 1;

		/* Initialize buffer position for new storing */
		/* The first two EIF_INTEGERs are the length of the STORABLE and 
		 * the number of objects to retrieve. */
	current_buffer_pos = 0;
	current_buffer_pos += 2*sizeof(EIF_INTEGER);

	nb_stored_object = store_object (object, 0);
	CHECK("Stored all objects", (pstore_obj_nb == nb_stored_object));	/* Check that all objects have been stored */

	if (!gc_stopped)
		gc_run();
}

rt_private int store_object (EIF_REFERENCE object, int a_object_count)
	/* Store `object' to `buffer' */
{
	EIF_BOOLEAN object_needs_index;
	uint32 fflags, flags;
	union overhead *zone = HEADER(object);
	EIF_INTEGER saved_buffer_pos, object_id, written_byte = 0;
	EIF_INTEGER i, nb_ref, object_size, dtype, ref_size;
	EIF_INTEGER saved_object_count = a_object_count;
	EIF_REFERENCE o_ref, o_ptr, null_value = NULL;
	char *saved_buffer;

		/* Get Current buffer position */
	saved_buffer_pos = current_buffer_pos;

		/* Get Pointer to current buffer position */
	saved_buffer = buffer + saved_buffer_pos;

		/* Store in HASH_TABLE new entry (object, max_object_id) */
	store_ht_put (address_table, (long unsigned int) object, max_object_id);

		/* Write object ID */
	saved_buffer = buffer_write (saved_buffer, &max_object_id, sizeof(EIF_REFERENCE));
	written_byte += sizeof(EIF_REFERENCE);

		/* Reset the EO_STORE flags */
	zone->ov_flags &= ~EO_STORE;

		/* Get object information */
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);
	CHECK("Not expanded", (!((flags & EO_EXP) != (uint32) 0)));	/* Check that `object' is not expanded */

		/* One more stored object */
	a_object_count++;

		/* Store object information */
	saved_buffer = buffer_write (saved_buffer, &flags, sizeof(uint32));
	written_byte += sizeof(uint32);
	written_byte += st_write_cid (&saved_buffer, fflags & EO_TYPE);

	if (flags & EO_SPEC) {	/* SPECIAL object */
		CHECK("Not tuple", !(flags & EO_TUPLE));
			/* Compute SPECIAL size */
		object_size = (zone->ov_size & B_SIZE);

			/* We have to save the size of the SPECIAL object */
		saved_buffer = buffer_write(saved_buffer, &object_size, sizeof(EIF_INTEGER));
		written_byte += sizeof(EIF_INTEGER);
		current_buffer_pos += (written_byte + object_size);

		if (flags & EO_REF) {	/* SPECIAL of references */
			EIF_INTEGER real_count, count;
			EIF_REFERENCE ref;

			o_ptr = (EIF_REFERENCE) (object + object_size - LNGPAD_2);
			count = *(EIF_INTEGER *) o_ptr;

				/* Compute the difference between `count' and the read count
				 * because we can have some padding in the area */
			real_count = (object_size - LNGPAD_2)/sizeof(EIF_REFERENCE) - count;

				/* We do not handle special which contains expanded types */
			CHECK("Not composite", (!(flags & EO_COMP)));

			for (ref = object;
				 count > 0;
				 count--, ref = (EIF_REFERENCE) ((EIF_REFERENCE *) ref + 1)) {
				o_ref = *(EIF_REFERENCE *) ref;
				if (o_ref != NULL) {
					zone = HEADER(o_ref);
					if (zone->ov_flags & EO_STORE) {
							/* Found a new non-stored object. We need to give it a new
							 * id and to store it in the HASH_TABLE */

							/* Compute new ID for new object */
						object_id = ++max_object_id;

							/* Recursion for storing sub-objects */
						a_object_count = store_object(o_ref, a_object_count);
					} else {
							/* Retrieve `object_id' of already stored Eiffel object */
						object_id = (int) store_ht_value (address_table, (long unsigned int) o_ref);
					}
					saved_buffer = buffer_write (saved_buffer, &object_id, sizeof(EIF_REFERENCE));
				} else {
					saved_buffer = buffer_write (saved_buffer, &null_value, sizeof(EIF_REFERENCE));
				}
			}
				/* Write 0 for the padding area */
			for (;real_count > 0; real_count--)
				saved_buffer = buffer_write (saved_buffer, &null_value, sizeof(EIF_REFERENCE));

				/* Write SPECIAL info located at the end of the SPECIAL area */
			saved_buffer = buffer_write (saved_buffer, object + object_size - LNGPAD_2, LNGPAD_2);
		} else {				/* SPECIAL of basic types */
			saved_buffer = buffer_write (saved_buffer, object, object_size);
		}
	} else {				/* Normal object */
		dtype = Deif_bid(flags);
		nb_ref = References(dtype);
		object_size = EIF_Size(dtype);
		current_buffer_pos += (written_byte + object_size);

			/* Traversal of references of `object' */
		for ( i = nb_ref, o_ptr = object; 
			  i > 0;
			  i--, o_ptr = (EIF_REFERENCE) (((EIF_REFERENCE *) o_ptr) + 1)
		) {
			o_ref = *(EIF_REFERENCE *)o_ptr;
			if (o_ref != NULL) {
				zone = HEADER(o_ref);
				if (zone->ov_flags & EO_STORE) {
						/* Found a new non-stored object. We need to give it a new
						 * id and to store it in the HASH_TABLE */

						/* Compute new ID for new object */
					object_id = ++max_object_id;

						/* Recursion for storing sub-objects */
					a_object_count = store_object(o_ref, a_object_count);
				} else {
						/* Retrieve `object_id' of already stored Eiffel object */
					object_id = (int) store_ht_value (address_table, (long unsigned int) o_ref);
				}
				saved_buffer = buffer_write (saved_buffer, &object_id, sizeof(EIF_REFERENCE));
			} else {
				saved_buffer = buffer_write (saved_buffer, &null_value, sizeof(EIF_REFERENCE));
			}
		}
			/* Now write remaining basic type fields to buffer */
		ref_size = nb_ref * sizeof(EIF_REFERENCE);
		saved_buffer = buffer_write (saved_buffer, object + ref_size, object_size - ref_size);
	}

		/* Check if the Eiffel side needs to remember the position where we stored `object'.
		 * If it needs to call Eiffel, we send the `file_position' where `object' has been
		 * written and also the number of objects that composes `object'. */
	object_needs_index = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))
			need_index) (server, object);

	if (object_needs_index) 
		(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER))
			make_index)(server,
						object,
						file_position + saved_buffer_pos,	/* Check why we need to read 4 bytes less */
						a_object_count - saved_object_count,
						current_buffer_pos - saved_buffer_pos);

	return a_object_count;
}


rt_private char *buffer_read (char *tmp_buffer, void *data, int size)
	/* Read `size' bytes from `tmp_buffer' and put them in `data'.
	 * Returns `tmp_buffer + size'. */
{
	int i;
	for (i = 0; i < size ; i++)
		(*((char *)data)++) = tmp_buffer[i];
	return tmp_buffer + size;
}

rt_private char *buffer_write (char *tmp_buffer, void *data, int size)
	/* Write `size' bytes of `data' into `tmp_buffer'
	 * Returns `tmp_buffer + size'. */
{
	int i;
	for (i = 0; i < size; i++)
		tmp_buffer[i] = *((char *)data)++;
	return tmp_buffer + size;
}

rt_private void hash_table_create (int size)
	/* Create data structures used when storing Eiffel objects */
{
	buffer = (char *) eif_rt_xmalloc (MAX_BUFFER_SIZE, C_T, GC_OFF);
	address_table = (struct store_htable *) eif_rt_xmalloc(sizeof(struct store_htable), C_T, GC_OFF);
	if (address_table == (struct store_htable *) 0)
		xraise(EN_MEM);
	if (-1 == store_ht_create(address_table, size, sizeof(EIF_INTEGER)))
		xraise(EN_MEM);
	store_ht_zero(address_table);
}

rt_private void hash_table_free ()
	/* Free data structures used when storing Eiffel objects */
{
	store_ht_free (address_table);
	address_table = NULL;
	eif_rt_xfree ((char *) buffer);
	buffer = NULL;
}

rt_private char *rt_read_cid (char *tmp_buffer, uint32 *crflags, uint32 *nflags, uint32 oflags)
{
	int16 count, dftype;
	static int16 l_cidarr [256];

	*nflags = oflags;   /* default */
	*crflags = oflags;

	tmp_buffer = buffer_read (tmp_buffer, &count, sizeof (int16));

	if (count < 2)  /* Nothing to read */
		return tmp_buffer;

	*l_cidarr = count;
	tmp_buffer = buffer_read (tmp_buffer, l_cidarr+1, count * sizeof (int16));
	l_cidarr [count+1] = -1;

	dftype = eif_gen_id_from_cid (l_cidarr, (int *)0);

	*nflags = (oflags & EO_UPPER) | dftype;

	if (crflags != (uint32 *) 0)
		/* Used for creation (emalloc). Map type */
		*crflags = *nflags;

	return tmp_buffer;
}

rt_private int st_write_cid (char **tmp_buffer, uint32 dftype)

{
	int16 *l_cidarr, count;
	int result = 0;
	char *tmp=*tmp_buffer;

	l_cidarr = eif_gen_cid ((int16) dftype);
	count  = *l_cidarr;

	*tmp_buffer = buffer_write (*tmp_buffer, &count, sizeof(int16));
	
	/* If count = 1 then we don't need to write more data */

	if (count > 1)
		*tmp_buffer = buffer_write (*tmp_buffer, l_cidarr+1, count * sizeof (int16));

	return (int) (*tmp_buffer - tmp);
}

rt_private void new_traversal (EIF_REFERENCE object)
	/* Set all objects referenced from `object' with `EO_STORE' flags
	 * and returns the number of objects that has been encountered. */
{
	EIF_REFERENCE o_ref;
	EIF_INTEGER count, i;
	union overhead *zone;
	uint32 flags;

	zone = HEADER(object);
	flags = zone->ov_flags;

	if ((flags & EO_C) || (flags & EO_STORE))
		return;

	zone->ov_flags |= EO_STORE;	/* We marked object as traversed. */
	pstore_obj_nb++;

	if (flags & EO_SPEC) {	/* Special object */
		CHECK("Not tuple", !(flags & EO_TUPLE));
		if (!(flags & EO_REF))	/* Object does not have any references. */
			return;
		CHECK("Not composite", (!(flags & EO_COMP)));	/* We do not handle SPECIAL of expanded objects. */

		count = *(EIF_INTEGER *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
	} else {
		count = References(Deif_bid(flags));
	}

		/* Perform recursion on enclosed references */
	for (i = 0; i < count; i++) {
		o_ref = *((EIF_REFERENCE *) object + i);
		if (o_ref != NULL)
			new_traversal (o_ref);
	}
}
