/*
*/

#include <assert.h>
#include "eif_config.h"
#include "eif_tools.h"
#include "eif_special_table.h"
#include "eif_malloc.h"
#include "eif_except.h"	/* for eif_panic() */

#ifdef I_STRING
#include <string.h>		/* For memset(), bzero() */
#else
#include <strings.h>
#endif

rt_public int is_in_spt (struct special_table *spt, char *object)	
{
	int 	i;		/* index. */
	char 	**hvalues;
	long *hkeys;
	int32 	count;

	assert (object != (char *) 0);
	if (spt == (struct special_table *) 0)
		return 0;
	
	hvalues = spt->h_values;
	hkeys = spt->h_keys;
	count = spt->count;

	for (i = 0; i < count; i++)
	{
		if (hvalues [i] == object)	
			return 1;
	}
	return 0;
}
		
		
rt_public int spt_create(struct special_table *spt, int32 size)
{
	/* Create the special table with size `n'. */

	long *hkeys;		/* For key array creation. */
	char **hvalues;		/* For values array creation. */
	char **oldvalues;		/* For old values. */
	
	
	/************************
 	 * Preconditions	*
	 ************************/
	assert (spt != (struct special_table *) 0);	/* Must be preallocated. */
	assert (size > 0);				/* Size strictly positive, for resizing. */
	/* End of preconditions. */

	hkeys = (long  *) calloc(size, sizeof(long));	/* Mallocs array of keys */
	if (hkeys == (long *) 0)
		return -1;					/* Malloc failed */
	spt->h_keys = hkeys;		/* Where array of keys is stored */

	hvalues = (char **) malloc(size * sizeof (char *));			/* Mallocs array of values */
	if (hvalues == (char **) 0) {
		free(spt->h_keys);			/* Free keys array */
		return -1;					/* Malloc failed */
	}
	spt->h_values = hvalues;			/* Where array of values is stored */

	oldvalues = (char **) malloc(size * sizeof (char *));			/* Mallocs array of old values */
	if (oldvalues == (char **) 0) {
		free(spt->h_keys);			/* Free keys array */
		free(spt->h_values);			/* Free pointers array */
		return -1;					/* Malloc failed */
	}
	spt->old_values = oldvalues;			/* Where array of old values is stored */
	spt->h_size = size;				/* Size of hash table */
	spt->count  = 0;				/* Initially no items. */
	spt->old_count  = 0;				/* Initially no previous items. */

	spt_zero (spt);			/* Clean it. */
	return 0;			/* Creation was ok */
}

rt_public void spt_zero(struct special_table *spt)
{
	/* Initialize the special table with zeros */

	int32 hsize = spt->h_size;

	bzero(spt->h_keys, hsize * sizeof(long));
	bzero(spt->h_values, hsize * sizeof (char *));
	bzero(spt->old_values, hsize * sizeof (char *));
}
 
void spt_force(struct special_table *spt, register long key, char *val)
{
	if (-1 == spt_put(spt, key, val)) {		/* Insertion failed => special table full */
		if (spt_xtend(spt))		/* Extend the special table */
			eraise("special table extension failure", EN_FATAL);
		if (-1 == spt_put(spt, key, val)) 	/* Insertion failed again => Bailing out */
			eraise("Special insertion failure", EN_FATAL);
	}
}

rt_public int spt_put_old(struct special_table *spt, char *val)
{
	/* Puts an old value held at 'val' in special table 'spt'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 char 		**hvalues;	/* Array of values. */
	register3 int32 	hsize;		/* Size of special table */
	int32 count;

	if (val == (char *) 0)	/* No need to put a Void object. */
		return 0;

	/************************
	 * Preconditions	*
	 ************************/

#ifndef NDEBUG
	assert (spt != (struct special_table *) 0);
	assert (HEADER((char *) val)->ov_flags & EO_REF);	
	{
	int32 old_count = spt->count;
#endif	/* !NDEBUG */

	/* Initializations */

	count = spt->old_count;
	hsize = spt->h_size;
	hvalues = spt->old_values;

	/************************
	 * Check.		*
	 ************************/

	 assert (count <= hsize );
	
	/* End of preconditions. */

	/* Update. */
	count++;	/* Number of elements. */

	if (count > hsize)
	{
		/* No room left. */
			/* Update count for precondition checking. */
		return -1;	 
	}

	/* Insert item. */
	hvalues [count - 1] = val;

	/* Update spt.*/
	spt->old_count = count;

	/************************
	 * Postconditions. 	*
	 ************************/	
#ifndef NDEBUG
	assert (spt->old_count == old_count + 1);
	}
#endif	/* !NDEBUG */
	/* End of postconditions. */
	return 0;	/* Insertion successfull. */
}	/* spt_put_old () */

rt_public int spt_put(struct special_table *spt, register long key, char *val)
{
	/* Puts value held at 'val' tagged with key 'key' in special table 'spt'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 char 		**hvalues;	/* Array of values. */
	register3 int32 	hsize;		/* Size of special table */
	register4 long *hkeys;		/* Array of keys */
	int32 count;

	if (val == (char *) 0)	/* No need to put a Void object. */
		return 0;

	/************************
	 * Preconditions	*
	 ************************/

#ifndef NDEBUG
	assert (spt != (struct special_table *) 0);
		{
		int32 ofst = key;
		if (key != -1)
		{
		char *itm =  *(char **)(val + ofst * sizeof (EIF_REFERENCE));
		union overhead *iz = HEADER (itm);
		union overhead *zone = HEADER (val);

#ifdef SPT_PUT_DEBUG
		printf("spt_put: at 0x%x (type %d, %d bytes) %s %s %s %s, \n\t\t\twith item %x, offset %ld (type %d, %d bytes) %s age %ld, %s %s %s %s %s %s %s\n",
			val,
			HEADER(
				zone->ov_size & B_FWD ? zone->ov_fwd : val
			)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE,
			zone->ov_size & B_FWD ? "forwarded" : "",
			zone->ov_flags & EO_MARK ? "marked" : "",
			zone->ov_flags & EO_REF ? "ref" : "",
			zone->ov_flags & EO_COMP ? "comp" : "",
			itm,
			ofst,
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_TYPE,
			iz->ov_size & B_SIZE,
			iz->ov_size & B_FWD ? "forwarded" : "",
			((HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_AGE)  >> 24) / 2,
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_OLD ? "old " : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_REM ? "remembered" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_MARK ? "marked" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_REF ? "ref" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_EXP ? "exp" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_COMP ? "comp" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_SPEC ? "spec" : ""
		);
#endif	/* SPT_PUT_DEBUG */
	assert (!((HEADER (iz->ov_size & B_FWD ? iz->ov_fwd : itm))->ov_flags & EO_SPEC));	/* Not special */
	assert (!((HEADER (iz->ov_size & B_FWD ? iz->ov_fwd : itm))->ov_flags & EO_OLD));	/* Not old */
	assert (HEADER((char *) val)->ov_flags & EO_REF);	
	}
		}
	{
	int32 old_count = spt->count;
#endif	/* !NDEBUG */

	/* Initializations */

	count = spt->count;
	hsize = spt->h_size;
	hkeys = spt->h_keys;
	hvalues = spt->h_values;

	/************************
	 * Check.		*
	 ************************/

	 assert (count <= hsize );
	
	/* End of preconditions. */

	/* Update. */
	count++;	/* Number of elements. */

	if (count > hsize)
	{
		/* No room left. */
			/* Update count for precondition checking. */
		return -1;	 
	}

#ifdef SPT_PUT_DEBUG
	printf ("Inserting in special table object %x with offset %ld at %ld\n",
			val, key, count);
#endif	/* SPT_PUT_DEBUG */

	/* Insert item. */
	hkeys [count - 1] = key;
	hvalues [count - 1] = val;

	/* Update spt.*/
	spt->count = count;

	/************************
	 * Postconditions. 	*
	 ************************/	
#ifndef NDEBUG
	assert (spt->count == old_count + 1);
	}
#endif	/* !NDEBUG */
	/* End of postconditions. */
	return 0;	/* Insertion successfull. */
}	/* spt_put () */
	

rt_public int spt_replace(struct special_table *spt, char *old, char *val)
{
	/* 
	 * Replace all occurrences of `old' in h_hvalues by `val'.
	 */

	int done = 0;
	int32	count;	/* Count of special table. */
	int 	i;
	char 	**hvalues;	/* Array of pointers. */

#ifdef SPT_REPLACE_DEBUG
	printf ("SPT_REPLACE: Replace in table %x, object %x by new %x\n", spt, old, val);
#endif	/* SPT_REPLACE_DEBUG. */
	/************************
	 * Precondition.	*
	 ************************/
	assert (spt != (struct special_table *) 0);
	assert (old != (char *) 0);
	assert (val != (char *) 0);
	/* End of preconditions. */

	/* Initializations */
	hvalues = spt->h_values;
	count = spt->count;

	/* Scan array of pointers and replace each occurrences. */
	for (i = 0; i < count; i++)
	{
		if (hvalues [i] == old)
		{
			done = 1;
			hvalues [i] = val;
		}
	}

	/************************
	 * Postcondition.	*
	 ************************/
#ifndef NDEBUG
	/* No more occurrences of `old' in `spt'. */
	
	count = spt->count;
	for (i = 0; i < count; i++)
	{
		if (hvalues [i] == old)
			eif_panic ("Replacement in special table did not work");
	}

#endif	/* !NDEBUG */
	return done;
}	/* spt_replace () */

rt_public int spt_xtend(struct special_table *spt)
{
	/* The special table 'spt' is full and needs resizing. We add 50% of old size and
	 * copy the old table in the new one, before freeing the old one. Note that
	 * h_create multiplies the number we give by 5/4, so 5/4*3/2 yields ~2, i.e.
	 * the final size will be the double of the previous one (modulo next prime
	 * number).
	 * Return 0 if extension was ok, -1 otherwise.
	 */

	register1 int size;				/* Size of old special table */
	register2 int sval = sizeof (char *);		/* Size of an special table item */
	register3 long *keys;			/* To loop over keys */
	register4 char **vals;			/* To loop over values */
	register char **oldvals;			/* To loop over old values */
	int i;
	struct special_table new_spt;
	int32 old_size = spt->h_size;
	int32	count;
	int32	old_count = spt->old_count;
	count = spt->count;

	/************************
	 * Preconditions.	*
	 ************************/
#ifndef NDEBUG

	 assert (count == spt->h_size);	/* Special table full. */
#endif	/* !NDEBUG */
	
	/* End of preconditions. */

	size = spt->h_size;
	if (-1 == spt_create(&new_spt, 2 * size ))
		return -1;		/* Extension of special table failed */

	keys  = spt->h_keys;				/* Start of array of keys */
	vals = spt->h_values;				/* Start of array of values */

	/* Now loop over the whole table, inserting each item in the new one */

	for (i = 0; i < count; i++)
	{
		(void) spt_put(&new_spt, keys [i], vals [i]);
	}

	for (i = 0; i < old_count; i++)
	{
		(void) spt_put_old (&new_spt, oldvals [i]);
	}

	/* Free old special table and set special table descriptor */
	free(spt->old_values);			/* Free in allocation order */
	free(spt->h_values);			/* Free in allocation order */
	free(spt->h_keys);				/* To make eif_free happy (coalescing) */
	bcopy(&new_spt, spt, sizeof(struct special_table));

	/************************
	 * Postconditions.	*
	 ************************/

	 assert (count == spt->count);	/* Special table count remains the same. */
	 assert ((old_size * 2) == spt->h_size);	/* Special table bigger. */
	 assert (count < spt->h_size);	/* Special table not full. */
	
	/* End of postconditions. */
	return 0;		/* Extension was ok */
}	/* spt_xtend () */

rt_public void spt_free(struct special_table *spt)
{
	/* Free hash table arrays and descriptor */

	free(spt->h_values);
	free(spt->h_keys);
	free((char *) spt);
}

