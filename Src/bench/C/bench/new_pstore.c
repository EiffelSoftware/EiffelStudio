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
#include "eif_traverse.h"
#include "eif_hashinin.h"
#include "eif_error.h"
#include <assert.h>

#ifdef EIF_WIN32
#include <io.h>
#else
#include "unistd.h"
#endif

#include "new_pstore.h"

rt_private EIF_REFERENCE server; /* Current server used when storing */
rt_private void partial_store_append(EIF_REFERENCE object, fnptr mid, fnptr nid);
rt_private void hash_table_create (int size);	/* Create HASH_TABLE [INTEGER, ADDRESS] */
rt_private void hash_table_free ();	/* Free HASH_TABLE [INTEGER, ADDRESS] */
rt_private char *buffer_write (char *tmp_buffer, void *data, int size);
rt_private char *buffer_read (char *tmp_buffer, void *data, int size);
rt_private int store_object (EIF_REFERENCE object, int object_count);
rt_private EIF_REFERENCE retrieve_objects (EIF_INTEGER nb_obj);
rt_private int st_write_cid (char **tmp_buffer, uint32 dftype);	/* Store generic info */
rt_private char *rt_read_cid (char *tmp_buffer, uint32 *crflags, uint32 *nflags, uint32 oflags);

rt_private struct store_htable *address_table;	/* HASH_TABLE [INTEGER, ADDRESS] */
rt_private int max_object_id;	/* Current maximum allowed object id */
rt_private int storable_size;	/* Current size of storable */
rt_private char *buffer;	/* Memory area when storage is done */
rt_private EIF_INTEGER current_buffer_pos;	/* Offset where we are writing at the moment */
rt_private fnptr make_index, need_index;	/* Hook functions. */
rt_private int file_position;	/* File position as given */

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
	tmp_buffer = buffer_write (tmp_buffer, &obj_nb, sizeof(EIF_INTEGER));
	write (f_desc, buffer, current_buffer_pos);
	
	hash_table_free ();

	return file_position;
}

rt_public EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj)
{
	return NULL;
}

rt_public EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position)
	/* Retrieve all objects starting at `position' in `f_desc'. */
{
	EIF_INTEGER length;
	EIF_REFERENCE result;
	char gc_stopped = !gc_ison ();

	gc_stop();

		/* Create buffer */
	buffer = (char *) xmalloc (100000L, C_T, GC_OFF);

		/* Go to `position' in `f_desc'. */
	if (lseek (f_desc, position, SEEK_SET) == -1)
		esys ();

		/* Read size to read */
	if (read (f_desc, &length, sizeof(EIF_INTEGER)) <= 0) 
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

		/* Read full content of what needs to be read */
	if (read (f_desc, buffer, length) <= 0)
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

		/* Retrieve all requested objects.
		 * We will retrieve `*(EIF_INTEGER *) buffer' objects, since the number
		 * of objects to retrieved has been stored at the second position in the
		 * file */
	result = retrieve_objects (*(EIF_INTEGER *) buffer);

		/* Free `buffer' */
	xfree ((char *) buffer);
	buffer = NULL;

	if (!gc_stopped)
		gc_run();

	return result;
}

rt_private EIF_REFERENCE retrieve_objects (EIF_INTEGER nb_obj)
{
	EIF_INTEGER i, j, object_id, dtype;
	EIF_INTEGER nb_bytes, nb_ref, object_size;
	EIF_REFERENCE *obj_array, o_ref, *o_field, o_ptr;
	uint32 crflags, fflags, flags;
	union overhead *zone;
	char *tmp_buffer = buffer + sizeof(EIF_INTEGER);

		/* Allocate array where all retrieved objects will be stored */
	obj_array = (EIF_REFERENCE *) xmalloc ((nb_obj + 1) * sizeof(EIF_REFERENCE), C_T, GC_OFF);

	for (i = 0; i < nb_obj ; i++) {
		tmp_buffer = buffer_read (tmp_buffer, &object_id, sizeof(EIF_INTEGER));
		tmp_buffer = buffer_read (tmp_buffer, &flags, sizeof(uint32));
			/* For generic conformance */
		tmp_buffer = rt_read_cid (tmp_buffer, &crflags, &fflags, flags);
	
		if (flags & EO_SPEC) {	/* Special reference */
			tmp_buffer = buffer_read (tmp_buffer, &object_size, sizeof(EIF_INTEGER));
			nb_bytes = object_size & B_SIZE;
			o_ref = spmalloc (nb_bytes);
			HEADER(o_ref)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
				/* Read SPECIAL content and copy it into `o_ref'. */
			tmp_buffer = buffer_read (tmp_buffer, o_ref, object_size);
		} else {
			nb_bytes = EIF_Size((uint16)(flags & EO_TYPE));
			o_ref = emalloc(crflags & EO_TYPE);
			tmp_buffer = buffer_read (tmp_buffer, o_ref, nb_bytes);
		}
			/* Store `o_ref' at `object_id' pos in `obj_array' */
		obj_array [object_id] = o_ref;
	}

		/* Update missing references */
	for (i = 1; i <= nb_obj ; i++) {
		o_ref = obj_array [i];
		zone = HEADER(o_ref);
		flags = zone->ov_flags;
		if (flags & EO_SPEC) {	/* SPECIAL object */
			if (flags & EO_REF) {	/* SPECIAL of reference */
				o_ptr = (EIF_REFERENCE) (o_ref + (zone->ov_size & B_SIZE) - LNGPAD_2);
				nb_ref = *(EIF_INTEGER *) o_ptr;
				for (j = 0; j < nb_ref; j++) {
					o_field = (EIF_REFERENCE *) o_ref[j];
					if (*o_field != NULL) {
						*o_field = obj_array [(EIF_INTEGER) (*o_field)];
						RTAS_OPT (*o_field, j, o_ref);
					}
				}
			}
		} else {				/* Normal object */
			dtype = Deif_bid(flags);
			nb_ref = References(dtype);
			for (j = 0; j < nb_ref; j ++) {
				o_field = (EIF_REFERENCE *) (o_ref + j * sizeof(EIF_REFERENCE));
				if (*o_field != NULL) {
					*o_field = obj_array [(EIF_INTEGER) (*o_field)];
					RTAS(*o_field, o_ref);
				}
			}
		}
	}

		/* Return root object */
	return obj_array [1];
}

rt_private void partial_store_append(EIF_REFERENCE object, fnptr mid, fnptr nid)
{
	int nb_stored_object;
	char gc_stopped = !gc_ison ();

	gc_stop();	/* Procedure `mid' or `nid' may trigger a GC cycle, and we don't want
				 * this to happen, since we keep a non-protected reference on objects */

		/* Do the complete traversals of objects that needs to be stored */
		/* Number of objects is stored in global variables `obj_nb'      */
	obj_nb = 0;
	storable_size = 0;
	traversal (object, 0);

	need_index = nid;
	make_index = mid;
	hash_table_create (obj_nb);
	
		/* `max_object_id' is initialized to `1' because `store_ht_value' already returns 
		 * `0' when it does not find an item */
	max_object_id = 1;


	current_buffer_pos += 2*sizeof(EIF_INTEGER);

	nb_stored_object = store_object (object, 0);
	assert (obj_nb == nb_stored_object);	/* Check that all objects have been stored */

	if (!gc_stopped)
		gc_run();
}

rt_private int store_object (EIF_REFERENCE object, int object_count)
	/* Store `object' to `buffer' */
{
	EIF_BOOLEAN object_needs_index;
	uint32 fflags, flags;
	union overhead *zone = HEADER(object);
	EIF_INTEGER saved_buffer_pos, object_id, written_byte = 0;
	EIF_INTEGER i, nb_ref, object_size, dtype, ref_size;
	EIF_INTEGER saved_object_count = object_count;
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


		/* Get object information */
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);
	assert (!((flags & EO_EXP) != (uint32) 0));	/* Check that `object' is not expanded */

		/* One more stored object */
	object_count++;

		/* Store object information */
	saved_buffer = buffer_write (saved_buffer, &flags, sizeof(uint32));
	written_byte += sizeof(uint32);
	written_byte += st_write_cid (&saved_buffer, fflags & EO_TYPE);

	if (flags & EO_SPEC) {	/* SPECIAL object */
			/* Compute SPECIAL size */
		object_size = (zone->ov_size & B_SIZE);

			/* We have to save the size of the SPECIAL object */
		saved_buffer = buffer_write(saved_buffer, &object_size, sizeof(EIF_INTEGER));
		written_byte += sizeof(EIF_INTEGER);
		current_buffer_pos += (written_byte + object_size);

		if (flags & EO_REF) {	/* SPECIAL of references */
			EIF_INTEGER count;
			EIF_REFERENCE ref;

			o_ptr = (EIF_REFERENCE) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
			count = *(EIF_INTEGER *) o_ptr;

				/* We do not handle special which contains expanded types */
			assert (!(flags & EO_COMP));

			for (ref = object;
				 count > 0;
				 count--, ref = (EIF_REFERENCE) ((EIF_REFERENCE *) ref + 1)) {
				o_ref = *(EIF_REFERENCE *) ref;
				if (o_ref != NULL) {
					zone = HEADER(o_ref);
					if (zone->ov_flags & EO_STORE) {
							/* Found a new non-stored object. We need to give it a new
							 * id and to store it in the HASH_TABLE */

							/* Reset the EO_STORE flags */
						zone->ov_flags &= ~EO_STORE;

							/* Compute new ID for new object */
						object_id = ++max_object_id;

							/* Recursion for storing sub-objects */
						object_count = store_object(o_ref, object_count);
					} else {
							/* Retrieve `object_id' of already stored Eiffel object */
						object_id = (int) store_ht_value (address_table, (long unsigned int) o_ref);
					}
					saved_buffer = buffer_write (saved_buffer, &object_id, sizeof(EIF_REFERENCE));
				} else {
					saved_buffer = buffer_write (saved_buffer, &null_value, sizeof(EIF_REFERENCE));
				}
			}
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

						/* Reset the EO_STORE flags */
					zone->ov_flags &= ~EO_STORE;

						/* Compute new ID for new object */
					object_id = ++max_object_id;

						/* Recursion for storing sub-objects */
					object_count = store_object(o_ref, object_count);
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
		(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))
			make_index)(server,
						object,
						file_position + saved_buffer_pos,
						object_count - saved_object_count);

	return object_count;
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
	buffer = (char *) xmalloc (100000L, C_T, GC_OFF);
	address_table = (struct store_htable *) xmalloc(sizeof(struct store_htable), C_T, GC_OFF);
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
	xfree ((char *) buffer);
	buffer = NULL;
}

rt_private char *rt_read_cid (char *tmp_buffer, uint32 *crflags, uint32 *nflags, uint32 oflags)
{
	int16 count, dftype;
	static int16 cidarr [256];

	*nflags = oflags;   /* default */
	*crflags = oflags;

	tmp_buffer = buffer_read (tmp_buffer, &count, sizeof (int16));

	if (count < 2)  /* Nothing to read */
		return tmp_buffer;

	*cidarr = count;
	tmp_buffer = buffer_read (tmp_buffer, cidarr+1, count * sizeof (int16));
	cidarr [count+1] = -1;

	dftype = eif_gen_id_from_cid (cidarr, (int *)0);

	*nflags = (oflags & EO_UPPER) | dftype;

	if (crflags != (uint32 *) 0)
		/* Used for creation (emalloc). Map type */
		*crflags = *nflags;

	return tmp_buffer;
}

rt_private int st_write_cid (char **tmp_buffer, uint32 dftype)

{
	int16 *cidarr, count;
	int result = 0;

	cidarr = eif_gen_cid ((int16) dftype);
	count  = *cidarr;

	*tmp_buffer = buffer_write (*tmp_buffer, &count, sizeof(int16));
	result += sizeof(int16);

	/* If count = 1 then we don't need to write more data */

	if (count > 1) {
		*tmp_buffer = buffer_write (*tmp_buffer, cidarr+1, count * sizeof (int16));
		result += count * sizeof(int16);
	}

	return result;
}
