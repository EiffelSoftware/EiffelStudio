/*

 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######

  ####   #####   ######   ####      #      ##    #
 #       #    #  #       #    #     #     #  #   #
  ####   #    #  #####   #          #    #    #  #
      #  #####   #       #          #    ######  #
 #    #  #       #       #    #     #    #    #  #
  ####   #       ######   ####      #    #    #  ###### #######

  #####    ##    #####   #       ######           ####
    #     #  #   #    #  #       #               #    #
    #    #    #  #####   #       #####           #
    #    ######  #    #  #       #        ###    #
    #    #    #  #    #  #       #        ###    #    #
    #    #    #  #####   ######  ######   ###     ####

	Interface for special_table.
	The special table is a 2 x N array. It records the
	special objects, full of references, which are old , with
	the index to the items that are young object (not old).
	Therefore, a special object can have several entries 
	(as many as it references a young object.)

	This table is used when the flag EIF_REM_SET_OPTIMIZATION is defined,
	and is particularly efficient when manupilating big arrays of objects.
	The time spent to scan an special object full of references is no longer 
	proportionnal to its size but to the number of new references that it has.
		
*/


#include "eif_portable.h"
#include "eif_tools.h"
#include "eif_special_table.h"
#include "eif_malloc.h"
#include "eif_lmalloc.h"
#include "eif_except.h"			/* For eif_panic() */
#include "rt_assert.h"
#include <string.h>				/* For memset(), bzero() */


#ifdef EIF_REM_SET_OPTIMIZATION

rt_public int is_in_spt (struct special_table *spt, EIF_REFERENCE object)	
{
	/* 
	 * For Assertions checkings: check if the `object' is in the
	 * special table `spt'.
	 */

	int 	i;					/* index. */
	char 	**hvalues;
	EIF_INTEGER_32 	*hkeys;
	int 	count;

	REQUIRE ("object not null", object != NULL);
	REQUIRE ("object not forwarded", !(HEADER (object)->ov_size & B_FWD));

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
}	/* is_in_spt () */
		
rt_public int spt_realloc (struct special_table *spt, int size)
{
	/* 
	 * Reallocate the special table up to size `n'. 
	 */

	int				gain;			/* Number of new free entries. */
	EIF_INTEGER		index;			/* Index of first free entry. */
	void			*temp;			/* Return value of realloc(). */
#ifndef NDEBUG
	int				old_count = spt->count;
	int				old_size  = spt->h_size;
#endif	/* !NDEBUG */
	
	
	REQUIRE ("spt allocated", spt != (struct special_table *) 0);
	REQUIRE ("spt full", spt->count == spt->h_size);
	REQUIRE ("New requested size bigger than previous one",size > spt->count);

	temp = (void *) eif_realloc (spt->h_keys, size * LNGSIZ);	
									/* Mallocs array of keys */
	if (temp == (void *) 0)			/* Has reallocation failed? */
		return -1;					/* Reallocation failed. */	
	spt->h_keys = (EIF_INTEGER *) temp;	/* Update h_keys. */

	temp = (void *) eif_realloc (spt->h_values, size * REFSIZ);
	if (temp == (void *) 0) {		/* Did it fail? */
		eif_free(spt->h_keys);			/* Free keys array.*/
		return -1;					/* Reallocation failed. */
	}
	spt->h_values = (EIF_REFERENCE *) temp;/* Update h_values. */

	temp = (void *) eif_realloc (spt->old_values, size * REFSIZ);
									/* Reallocate array of old values. */
	if (temp == (void *) 0) {		/* Did it fail? */
		eif_free(spt->h_keys);			/* Free keys array. */
		eif_free(spt->h_values);		/* Free pointers array. */
		return -1;					/* Reallocation failed. */
	}
	spt->old_values = (EIF_REFERENCE *) temp;
									/* Where array of old values is stored. */

	gain = size - spt->h_size;		/* Number of new free entries. */ 
	spt->h_size = size;				/* New size of special table. */
	index = spt->count;				/* Index of first free entry. */
	
	/* Initialize free entries to zero. */
	memset (spt->h_keys + index, 0, gain * LNGSIZ);
	memset (spt->h_values + index, 0, gain * REFSIZ);
	memset (spt->old_values + index, 0, gain * REFSIZ);

	ENSURE ("Bigger", spt->h_size > old_size);
	ENSURE ("Same count", spt->count == old_count);

	return 0;						/* Creation was ok */
}	/* spt_realloc () */
		
rt_public int spt_create(struct special_table *spt, int  size)
{
	/* 
	 * Create the special table with size `n'. 
	 */

	EIF_INTEGER_32 *hkeys;					/* For key array creation. */
	EIF_REFERENCE *hvalues;			/* For values array creation. */
	EIF_REFERENCE *oldvalues;		/* For old values. */
	
	REQUIRE ("spt allocated", spt != (struct special_table *) 0);
	REQUIRE ("requested size positive", size > 0);

	hkeys = (EIF_INTEGER  *) eif_calloc(size, sizeof(long));	/* Mallocs array of keys */
	if (hkeys == (EIF_INTEGER_32 *) 0)
		return -1;					/* Malloc failed */
	spt->h_keys = hkeys;			/* Where array of keys is stored */

	hvalues = (EIF_REFERENCE *) eif_malloc(size * REFSIZ);
									/* Mallocs array of values */
	if (hvalues == (EIF_REFERENCE *) 0) {
		eif_free(spt->h_keys);			/* Free keys array */
		return -1;					/* Malloc failed */
	}
	spt->h_values = hvalues;		/* Where array of values is stored */

	oldvalues = (EIF_REFERENCE *) eif_malloc(size * REFSIZ);
									/* Mallocs array of old values */
	if (oldvalues == (EIF_REFERENCE *) 0) {
		eif_free(spt->h_keys);			/* Free keys array */
		eif_free(spt->h_values);		/* Free pointers array */
		return -1;					/* Malloc failed */
	}
	spt->old_values = oldvalues;	/* Where array of old values is stored */
	spt->h_size = size;				/* Size of hash table */
	spt->count  = 0;				/* Initially no items. */
	spt->old_count  = 0;			/* Initially no previous items. */

	spt_zero (spt);					/* Clean it. */

	return 0;						/* Creation was ok */
}	/* spt_create () */

rt_public void spt_zero(struct special_table *spt)
{
	/* 
	 * Initialize the special table with zeros.
	 */

	int hsize = spt->h_size;

	memset (spt->h_keys, 0, hsize * LNGSIZ);
	memset (spt->h_values, 0, hsize * REFSIZ);
	memset (spt->old_values, 0, hsize * REFSIZ);
}	/* spt_zero () */
 
rt_public void spt_force(struct special_table *spt, register long key, EIF_REFERENCE val)
{
	/* 
	 * Same as `spt_put' and eventually resize the table when necessary. 
	 */

	if (-1 == spt_put(spt, key, val)) {	
								/* Insertion failed => special table full */
		if (spt_xtend(spt))		/* Extend the special table */
			eraise("special table extension failure", EN_FATAL);
		if (-1 == spt_put(spt, key, val)) 	
								/* Insertion failed again => Bailing out */
			eraise("Special insertion failure", EN_FATAL);
	}
}	/* spt_force () */

rt_public int spt_put_old(struct special_table *spt, EIF_REFERENCE val)
{
	/* 
	 * Puts an old value held at 'val' in special table 'spt'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 char 		**hvalues;	/* Array of values. */
	register3 int 		hsize;		/* Size of special table */
	int32 count;

	if (val == (EIF_REFERENCE) 0)	/* No need to put a Void object. */
		return 0;

	REQUIRE ("spt allocated", spt != (struct special_table *) 0);
	REQUIRE ("val has EO_REF flag", HEADER(val)->ov_flags & EO_REF);	

#ifdef EIF_ASSERTIONS
	{
	int32 old_count = spt->count;
#endif

	/* Initializations */

	count = spt->old_count;
	hsize = spt->h_size;
	hvalues = spt->old_values;

	CHECK ("count smaller than capacity", count <= hsize );

	/* Update. */
	count++;	/* Number of elements. */

	if (count > hsize)
			/* No room left. */
		return -1;	 

		/* Insert item. */
	hvalues [count - 1] = val;

		/* Update spt.*/
	spt->old_count = count;

#ifdef EIF_ASSERTIONS
	ENSURE ("count incremented", spt->old_count == old_count + 1);
	}
#endif

	return 0;				/* Insertion successfull. */
}	/* spt_put_old () */

rt_public int spt_put 	(struct special_table *spt, register long key, 
						EIF_REFERENCE val)
{
	/* 
	 * Puts value held at 'val' tagged with key 'key' in special table 'spt'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 char 				**hvalues;	/* Array of values. */
	register3 int  				hsize;		/* Size of special table */
	register4 EIF_INTEGER_32	*hkeys;		/* Array of keys */
	int32 count;

	if (val == (EIF_REFERENCE)  0)	/* No need to put a Void object. */
		return 0;

#ifdef EIF_ASSERTIONS
	REQUIRE ("spt allocated", spt != (struct special_table *) 0);
	{
		int32 ofst = key;
		if (key != -1)
		{
		EIF_REFERENCE itm =  *(EIF_REFERENCE *) (val + ofst * REFSIZ);
		union overhead *iz = HEADER (itm);

#ifdef SPT_PUT_DEBUG
		union overhead *zone = HEADER (val);
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
	REQUIRE ("Not special", !((HEADER (iz->ov_size & B_FWD ? iz->ov_fwd : itm))->ov_flags & EO_SPEC));
	REQUIRE ("Not old", !((HEADER (iz->ov_size & B_FWD ? iz->ov_fwd : itm))->ov_flags & EO_OLD));	/* Not old */
	REQUIRE ("val does not have EO_REF flags", HEADER((EIF_REFERENCE) val)->ov_flags & EO_REF);	
	}
		}
	{
	int32 old_count = spt->count;
#endif

		/* Initializations */
	count = spt->count;
	hsize = spt->h_size;
	hkeys = spt->h_keys;
	hvalues = spt->h_values;

	CHECK ("count smaller than capacity", count <= hsize );

	/* Update. */
	count++;	/* Number of elements. */

	if (count > hsize)
			/* No room left. */
		return -1;	 

#ifdef SPT_PUT_DEBUG
	printf ("Inserting in special table object %x with offset %ld at %ld\n",
			val, key, count);
#endif	/* SPT_PUT_DEBUG */

	/* Insert item. */
	hkeys [count - 1] = key;
	hvalues [count - 1] = val;

	/* Update spt.*/
	spt->count = count;

#ifdef EIF_ASSERTIONS
	ENSURE ("Count has been incremented", spt->count == old_count + 1);
	}
#endif
	return 0;	/* Insertion successfull. */
}	/* spt_put () */
	

rt_public int spt_replace(struct special_table *spt, EIF_REFERENCE old, EIF_REFERENCE val)
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

	REQUIRE ("spt allocated", spt != (struct special_table *) 0);
	REQUIRE ("old not null", old != (EIF_REFERENCE)  0);

		/* Initializations */
	hvalues = spt->h_values;
	count = spt->count;

	/* Scan array of pointers and replace each occurrences. */
	for (i = 0; i < count; i++) {
		if (hvalues [i] == old) {
			done = 1;
			hvalues [i] = val;
		}
	}

#ifdef EIF_ASSERTIONS
		/* No more occurrences of `old' in `spt'. */
	count = spt->count;
	for (i = 0; i < count; i++)
		ENSURE ("Replacement in special table worked", hvalues [i] != old)
#endif

	return done;
}	/* spt_replace () */

rt_public int spt_xtend(struct special_table *spt)
{
	/* The special table 'spt' is full and needs resizing. 
	 * We add 50% of old size and
	 * copy the old table in the new one, before freeing the old one. Note that
	 * h_create multiplies the number we give by 5/4, so 5/4*3/2 yields ~2, i.e.
	 * the final size will be the double of the previous one (modulo next prime
	 * number).
	 * Return 0 if extension was ok, -1 otherwise.
	 */

	EIF_INTEGER				size;		/* Size before reallocation. */
#ifndef NDEBUG
	EIF_INTEGER 			count = spt->count;			/* For postcondition. */
	EIF_INTEGER				old_count = spt->old_count;	/* For postcondition. */
	int						old_size = spt->h_size;		/* For postcondition. */
#endif	/* !NDEBUG */

	REQUIRE ("Special table full", count == spt->h_size);

	size = spt->h_size;
	if (-1 == spt_realloc (spt, 2 * size ))
		return -1;						/* Extension of special table failed. */

	ENSURE ("Same count", count == spt->count);
	ENSURE ("Bigger capacity", (old_size * 2) == spt->h_size);
	ENSURE ("Not full", count < spt->h_size);

	return 0;		/* Extension was ok. */
}	/* spt_xtend () */

rt_public void spt_free(struct special_table *spt)
{
	/* Free hash table arrays and descriptor. */

	eif_free(spt->h_values);
	eif_free(spt->old_values);
	eif_free(spt->h_keys);
	eif_free(spt);
}	/* spt_free () */

#endif /* EIF_REM_SET_OPTIMIZATION */
