/*

 #####      #     #####   ####            ####
 #    #     #       #    #               #    #
 #####      #       #     ####           #
 #    #     #       #         #   ###    #
 #    #     #       #    #    #   ###    #    #
 #####      #       #     ####    ###     ####

	Primitives for manipulating Eiffel bits

	If this file is compiled with -DTEST, it will produce a standalone
	executable.
*/

#include "eif_portable.h"
#include "eif_garcol.h"
#include "eif_malloc.h"
#include "eif_cecil.h"
#include "rt_macros.h"					/* for BIT_PACKSIZE, BIT_UNIT */
#include "eif_bits.h"
#include "eif_local.h"
#include "eif_plug.h"
#include "eif_except.h"
#include "eif_lmalloc.h"				/* for eif_malloc() */
#include "eif_project.h"
#include <assert.h>

#include <string.h>

/* Bit shifting */
rt_private EIF_REFERENCE b_left_shift(EIF_REFERENCE bit, long int s);		/* Shift bit field to the left */
rt_private EIF_REFERENCE b_right_shift(EIF_REFERENCE bit, long int s);		/* Shift bit field to the right */

/* Bit rotating */
rt_private EIF_REFERENCE b_left_rotate(EIF_REFERENCE bit, long int s);		/* Rotate bit field to the left */
rt_private EIF_REFERENCE b_right_rotate(EIF_REFERENCE bit, long int s);		/* Rotate bit field to the right */

/*
 * Public declarations for bits manipulations
 */

rt_public EIF_REFERENCE b_eout(EIF_REFERENCE bit)
{
	/* Eiffel string for out representation of a bit */
	char *c_string;
	EIF_REFERENCE result;

	c_string = b_out(bit);					/* Build C string */
	result = makestr(c_string, strlen (c_string));	/* Build Eiffel string */
	xfree(c_string);						/* Free C string */

	return result;
}
	
rt_public char *b_out(EIF_REFERENCE bit)
{
	/* String value for bit attribute `bit' */
	uint32 len, val;
	char * result, *ptr;
	uint32 *last, *arena;
	int i;

	len = LENGTH(bit);
	arena = ARENA(bit);
	result = cmalloc((len + 3) * sizeof(char));
	ptr = result;
	last = arena + (BIT_NBPACK(len) - 1);
	for (; arena < last; arena++) {			/* Print fulled packs */
		val = *arena;
		for (i=BIT_UNIT-1; i>=0; i--)
			*ptr++ = (val & (1 << i)) ? '1':'0'; 
	}
	len %= BIT_UNIT;
	if (len == (uint32) 0)
		len = BIT_UNIT;
	val = *last;
	for(i=BIT_UNIT-1; i>=(int)(BIT_UNIT-len); i--)	/* Print last bits */
		*ptr++ = (val & (1 << i)) ? '1':'0';
	*ptr++ = 'b';
	*ptr = '\0';
	return result;
}

rt_public long b_count(EIF_REFERENCE bit)
{
	return ((struct bit *) bit)->b_length;		/* Size of a BIT object */
}

EIF_REFERENCE makebit(EIF_REFERENCE bit, long int bit_count)
{
	/* Returns a new bit object with value `s' */
	uint32 val;
	int i, j, nb_packs; /* %%ss removed , temp;*/
	EIF_REFERENCE result;
	uint32 *arena;
	long blength = bit_count;
	
	result = bmalloc(blength);		/* Creates bit object */
	arena = ARENA(result);
	nb_packs = BIT_NBPACK(blength);
	for (i=0; i<nb_packs-1; i++) {
		val = (uint32) 0;
		for (j=BIT_UNIT-1; j>=0 ; j--)
			val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
		*arena++ = val;
	}
	val = (uint32) 0;
	blength %= BIT_UNIT;
	if (blength == 0)
		blength = BIT_UNIT;
	for (j=BIT_UNIT-1; j>= (int)(BIT_UNIT-blength); j--)
	{
		val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
	}
	*arena = val;

	return result;
}

rt_public EIF_BOOLEAN b_equal(EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Standard equality between two bits */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'a' */
	EIF_REFERENCE bita;
	EIF_REFERENCE bitb;

	assert(a);
	assert(b);

	if (a == b)					/* Pointer to the same object */
		return EIF_TRUE;			/* Means objects are identical */

	len_a = LENGTH(a);
	len_b = LENGTH(b);

	if (len_a != len_b) {			/* Bits do not have the same size */
		if (len_a > len_b) {
			bitb = bmalloc (len_a);/* Need to pad out bit (on right) */
			b_copy (b, bitb);
			bita = a;
		}
		else {
			bita = bmalloc (len_b);/* Need to pad out bit (on right) */
			b_copy (a, bita);
			bitb = b;
		}
	}
	else {							/* Bits have same size */
		bita = a;
		bitb = b;
	}
		/*return EIF_FALSE;	*/		/* They can't be equal */

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_a + (BIT_NBPACK(len_a) - 1);

	for (; addr_a < last; addr_a++, addr_b++)	/* In the main part */
		if (*addr_a != *addr_b)					/* Return as soon as the */
			return EIF_FALSE;						/* two bit units differ */

	/* For the last bit unit, we have to compare only the significant part
	 * of the bit field. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b = len_a % BIT_UNIT;
	if (len_b == 0)
		return (*addr_a == *addr_b) ? EIF_TRUE : EIF_FALSE;
	else
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);

	return ((*addr_a & len_b) == (*addr_b & len_b)) ? EIF_TRUE : EIF_FALSE;
}

rt_public void b_copy(EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Copy bit field 'a' into 'b'. The function assume the size of 'b' is
	 * correct and 'b' must be a valid pointer (i.e. not void).
	 */


	register1 int len1;				/* Macro evaluates its argument twice */
	register2 int len2;
	register3 uint32 *arena1;
	register4 uint32 *arena2;
	/* register5 union overhead *zone;*/ /* %%ss removed */
	/* register6 union overhead *zone2;*/ /* %%ss removed */
	int nb_pack1, nb_pack2, gap, idx;
	uint32 mask, val;
	if ((EIF_REFERENCE ) 0 == a)
		eif_panic (MTC "bit copy eif_panic (void source)");
	if ((EIF_REFERENCE ) 0 == b)
		eif_panic (MTC "bit copy eif_panic (void target)");

	len1 = LENGTH(a);
	len2 = LENGTH(b);

#ifdef MAY_PANIC
	if (len1 > len2)
		eif_panic("bits conformance violated");
#endif

	if (len1 == len2) {
		memcpy(b, a, BIT_NBPACK(len1) * BIT_PACKSIZE + sizeof(uint32));
		return;
	}


	/* Different bit sizes: copy `a' at the start of longer field of `b' */
	arena1 = ARENA(a);
	arena2 = ARENA(b);
	nb_pack1 = BIT_NBPACK(len1);
	idx = nb_pack1 - 1;				/* Index of last pack of `arena1' */
	/* First, copy first fulled packs of `arena1' into `arena2' (if any) */
	if (nb_pack1 > 1) {
		memcpy (arena2, arena1, idx * BIT_PACKSIZE);
	}
	/* Copy last pack of `arena1' with garbage bits set to zero */
	mask = len1 % BIT_UNIT;
	val = arena1[idx];
	arena2[idx] = (mask == (uint32) 0) ? val : val & ~((1<<(BIT_UNIT-mask))- 1);
	/* Set last fields of `arena2' to zero */
	nb_pack2 = BIT_NBPACK(len2);
	gap = nb_pack2 - nb_pack1;
	if (gap > 0) {
		memset ((arena2 + nb_pack1), 0, gap * BIT_PACKSIZE);
	}
}

rt_public EIF_REFERENCE b_clone(EIF_REFERENCE bit)
{
	/* Return a clone of the bit field 'bit' given as argument. Beware: there is
	 * object creation, hence a risk of having to face a GC cycle. Save your
	 * buffers :-)--RAM.
	 */

	EIF_GET_CONTEXT
	EIF_REFERENCE new;						/* Address of newly allocated object */

	RT_GC_PROTECT(bit);	/* Ensure address is updated by GC */
	new = bmalloc(LENGTH(bit));		/* Create new bit field */
	RT_GC_WEAN(bit);			/* It's safe now, object won't move */
	b_copy(bit, new);				/* Copy into newly allocated bits */

	return new;			/* Freshly allocated bit field object */
}

rt_public void b_put(EIF_REFERENCE bit, char value, int at)
		  				/* The Eiffel bit object */
	   					/* The position in the bit field (starting at 1) */
		   				/* The boolean value to be set */
{
	/* Set the bit at the specified location. The bit field is viewed as an
	 * array of bits, indexed from 1 (on the left side of the bit field).
	 * Note that no range check is performed.
	 */

	uint32 *addr;				/* Address of the arena */
	int idx;					/* Index of concerned bit unit */
	uint32 mask;				/* Mask to set bit */

	addr = ARENA(bit);			/* Where bit array starts */
	idx = BIT_NBPACK(at) - 1;	/* The 'at' bit must be there */

	/* The mask needed to set the bit is computed: first find the bit position
	 * within the bit unit, then build the mask and set the bit. Note that
	 * the 31st bit is the 1st according to Eiffel while bit 0 is the 32nd for
	 * Eiffel, hence the conversion below...
	 */

	mask = at % BIT_UNIT;				/* Bit position (usual 0 rightmost) */
	mask = mask ? BIT_UNIT - mask : 0;	/* Correct if multiple of BIT_UNIT */

	if (value)
		addr[idx] |= 1 << mask;
	else
		addr[idx] &= ~(1 << mask);
}

rt_public EIF_BOOLEAN b_item(EIF_REFERENCE bit, long int at)
{
	/* Return the value (EIF_FALSE or EIF_TRUE) of the bit 'at' in the bit field. Index
	 * starts at 1 for the leftmost bit and ends at the length of the bit
	 * field (this is the usual Eiffel view for an array, here of array of
	 * bits). No range checking is performed.
	 */

	uint32 *addr;				/* Address of the arena */
	int idx;					/* Index of concerned bit unit */
	uint32 mask;				/* Mask to set bit */

	addr = ARENA(bit);			/* Where bit array starts */
	idx = BIT_NBPACK(at) - 1;	/* The 'at' bit must be there */

	/* The mask needed to set the bit is computed: first find the bit position
	 * within the bit unit, then build the mask and set the bit. Note that
	 * the 31st bit is the 1st according to Eiffel while bit 0 is the 32nd for
	 * Eiffel, hence the conversion below...
	 */

	mask = at % BIT_UNIT;				/* Bit position (usual 0 rightmost) */
	mask = mask ? BIT_UNIT - mask : 0;	/* Correct if multiple of BIT_UNIT */

	return ((addr[idx] & (1 << mask)) >> mask ? EIF_TRUE : EIF_FALSE);
}

rt_public EIF_REFERENCE b_shift(EIF_REFERENCE bit, long int s)
{
	/* Shifts `bit' by `s' positions. If s is positive, shifiting is done to
	 * the right, otherwise to the left. A null value does nothing.
	 */

	if (s == 0L)					/* Null operation */
		return b_clone(bit);	/* No side effect wanted */

	if (s > 0L)
		return b_right_shift(bit, s);
	else
		return b_left_shift(bit, -s);
}

rt_private EIF_REFERENCE b_right_shift(EIF_REFERENCE bit, long int s)
{
	/* Shifts `bit' by `s' positions to the right */

	EIF_GET_CONTEXT
	int len;					/* Length of the bit field */
	int i;						/* Loop over the bit field */
	int units;					/* Number of bit units */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 *arena;	/* Where bit array starts */
	EIF_REFERENCE new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */
	RT_GC_PROTECT(bit);
	new = bmalloc(len);			/* Returned bit object */
	RT_GC_WEAN(bit);
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Amount of bit units needed */

	if (s > len)			/* Shifting more than bit field size */
		return new;			/* Reset bit field with zeros */

	memcpy (arena, ARENA (bit), units * BIT_PACKSIZE);

	/* First phase: full byte shifting. For instance, if BIT_UNIT is 32 and
	 * we want to shift 67 bits, then this is 2 * BIT_UNIT + 3, which means
	 * there is a 2 full byte shifting needed and then a single 3 bits shift.
	 */

	bshift = s / BIT_UNIT;		/* Amount of full byte shifting needed */
	if (bshift > 0) {
		for (i = units - 1; i >= bshift; i--)
			arena[i] = arena[i - bshift];
		for (i = 0; i < bshift; i++)
			arena[i] = 0;
	}

	/* Second phase: single bit shifting (less than BIT_UNIT). When shifting
	 * to the right, we don't have to bother with the garbage bits.
	 */

	bshift = s % BIT_UNIT;				/* Amount of bit shifting needed */
	if (bshift > 0) {
		previous = 0;
		mask = (1 << bshift) - 1;		/* Bits to be kept for later */
		for (i = 0; i < units; i++) {
			buffer = arena[i];
			arena[i] = (buffer >> bshift) | previous;
			previous = (buffer & mask) << (BIT_UNIT - bshift);
		}
	}

	return new;
}

rt_private EIF_REFERENCE b_left_shift(EIF_REFERENCE bit, long int s)
{
	/* Shifts `bit' by `s' positions to the left */

	EIF_GET_CONTEXT
	int len;					/* Length of the bit field */
	int i;						/* Loop over the bit field */
	int units;					/* Number of bit units */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 *arena;	/* Where bit array starts */
	EIF_REFERENCE new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */
	RT_GC_PROTECT(bit);
	new = bmalloc(len);			/* Returned bit object */
	RT_GC_WEAN(bit);
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	if (s > len)			/* Shifting more than bit field size */
		return new;			/* Reset bit field with zeros */

	memcpy (arena, ARENA(bit), units * BIT_PACKSIZE);

	/* When shifting to the left, we must clear the garbage bits at the right
	 * end of the bitfield before any shifting action.
	 */

	bshift = len % BIT_UNIT;	/* Amount of trailing garbage bits */
	if (bshift > 0)
		arena[units - 1] &= ((1 << bshift) - 1) << (BIT_UNIT - bshift);

	/* First phase: full byte shifting. For instance, if BIT_UNIT is 32 and
	 * we want to shift 67 bits, then this is 2 * BIT_UNIT + 3, which means
	 * there is a 2 full byte shifting needed and then a single 3 bits shift.
	 */

	bshift = s / BIT_UNIT;		/* Amount of full byte shifting needed */
	if (bshift > 0) {
		for (i = bshift; i <= units - 1; i++)
			arena[i - bshift] = arena[i];
		for (i = units - bshift; i < units; i++)
			arena[i] = 0;
	}

	/* Second phase: single bit shifting (less than BIT_UNIT). When shifting
	 * to the left, the garbage bits have been reset to zero, so it is safe to
	 * blindly shift bits.
	 */

	bshift = s % BIT_UNIT;				/* Amount of bit shifting needed */
	if (bshift > 0) {
		previous = 0;
		mask = ((1 << bshift) - 1) << (BIT_UNIT - bshift);
		for (i = units - 1; i >= 0; i--) {
			buffer = arena[i];
			arena[i] = (buffer << bshift) | previous;
			previous = (buffer & mask) >> (BIT_UNIT - bshift);
		}
	}

	return new;
}

rt_public EIF_REFERENCE b_rotate(EIF_REFERENCE bit, long int s)
{
	/* Rotates `bit' by `s' positions. If s is positive, rotation is done to
	 * the right, otherwise to the left. A null value does nothing.
	 */

	if (s == 0L)					/* A null operation */
		return b_clone(bit);	/* No side effect wanted */

	if (s > 0L)
		return b_right_rotate(bit, s);
	else
		return b_left_rotate(bit, -s);
}

rt_private EIF_REFERENCE b_right_rotate(EIF_REFERENCE bit, long int s)
{
	/* Rotates `bit' by `s' positions to the right */

	EIF_GET_CONTEXT
	int len;				/* Length of the bit field */
	int i;					/* Loop over the bit field */
	int units;				/* Number of bit units */
	int idx;				/* Index of bit unit where garbage bits arrived */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 *arena;	/* Where bit array starts */
	uint32 last;				/* Saves value of last bit unit (rightmost) */
	EIF_REFERENCE new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */

	if (s > len)			/* Rotating more than bit field size */
		s %= len;			/* Keep only the modulo part */

	if (s > (len / 2))		/* Rotating more than half the length */
		return b_left_rotate(bit, len - s);

	RT_GC_PROTECT(bit);
	new = bmalloc(len);			/* The bit object which will be rotated */
	RT_GC_WEAN(bit);
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	memcpy (arena, ARENA(bit), units * BIT_PACKSIZE);

	/* First phase: full byte rotating. For instance, if BIT_UNIT is 32 and
	 * we want to rotate 67 bits, then this is 2 * BIT_UNIT + 3, which means
	 * we need a 2 full bytes rotating and then a single 3 bits rotation.
	 */

	bshift = s / BIT_UNIT;		/* Amount of full byte rotation needed */
	if (bshift > 0) {
		for (i = units - 1; i >= bshift; i--)
			arena[i] = arena[i - bshift];
		for (i = 0; i < bshift; i++)
			arena[i] = ARENA(bit)[units - bshift + i];
	}

	/* Second phase: garbage bit resetting. If we did full byte rotation and
	 * there were garbage bits at the right end of the bit field, then those
	 * bits are now somewhere withing the bit field. We need to save the
	 * current garbage bits, and re-inject them at the left side, shifting the
	 * remaining bits up to the garbage bits, hence squeezing them away.
	 */

	if (bshift > 0) {				/* Full byte rotation was performed */
		idx = bshift - 1;			/* Index where garbage bits are stuffed */
		bshift = len % BIT_UNIT;	/* Number of non-garbage bits */
		if (bshift > 0) {
			bshift = BIT_UNIT - bshift;		/* Number of garbage bits */
			previous = 0;
			mask = (1 << bshift) - 1;		/* Bits to be kept for later */
			for (i = 0; i <= idx; i++) {
				buffer = arena[i];
				arena[i] = (buffer >> bshift) | previous;
				previous = (buffer & mask) << (BIT_UNIT - bshift);
			}
			arena[0] |= (arena[units - 1] & mask) << (BIT_UNIT - bshift);
		}
	}

	/* Third phase: single bit rotating (less than BIT_UNIT). The complexity
	 * is brought by the garbage bits at the end of the bit field, which must
	 * be saved and re-injected at the beginning to replace the zeros added by
	 * the shifting operation.
	 */

	bshift = s % BIT_UNIT;				/* Amount of bit rotating needed */
	if (bshift > 0) {
		last = arena[units - 1];			/* Save last bit unit */
		idx = BIT_UNIT - len % BIT_UNIT;	/* Save number of garbage bits */
		if (idx == BIT_UNIT)
			idx = 0;						/* No garbage: size % BIT_UNIT = 0 */
		previous = 0;
		mask = (1 << bshift) - 1;		/* Bits to be kept for later */
		for (i = 0; i < units; i++) {
			buffer = arena[i];
			arena[i] = (buffer >> bshift) | previous;
			previous = (buffer & mask) << (BIT_UNIT - bshift);
		}
		i = bshift - (BIT_UNIT - idx);	/* Overshifted bits */
		if (i > 0) {					/* Shifted more than the saved bits */
			previous = arena[units - 1];
			previous &= (1 << idx) - 1;	/* Keep only garbage bits */
			idx -= i;					/* bshift < BIT_UNIT => i < idx */
			last >>= i;					/* Leave room for added bits */
			previous >>= idx;			/* Keep only the i first garbage bits */
			previous <<= BIT_UNIT - i;	/* Move i bits at the beginning */
			last |= previous;			/* Merge bits into already saved ones */
		}
		last >>= idx;					/* Remove garbage bits */
		last <<= (BIT_UNIT - bshift);	/* The leftmost bshift bits are ready */
		arena[0] |= last;				/* Merge them, rotation is completed */
	}

	return new;
}

rt_private EIF_REFERENCE b_left_rotate(EIF_REFERENCE bit, long int s)
{
	/* Rotates `bit' by `s' positions to the left */

	EIF_GET_CONTEXT
	int len;				/* Length of the bit field */
	int i;					/* Loop over the bit field */
	int units;				/* Number of bit units */
	int idx;				/* Index of bit unit where garbage bits arrived */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 last;		/* Saves value of last bit unit (leftmost) */
	uint32 *arena;				/* Where bit array starts */
	EIF_REFERENCE new;					/* The new bit object */

	len = LENGTH(bit);			/* Length of bit field */

	if (s > len)			/* Rotating more than bit field size */
		s %= len;			/* Keep only the modulo part */

	if (s > (len / 2))		/* Rotating more than half the length */
		return b_right_rotate(bit, len - s);

	RT_GC_PROTECT(bit);
	new = bmalloc(len);			/* The new bit object which will be rotated */
	RT_GC_WEAN(bit);
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	memcpy (arena, ARENA(bit), units * BIT_PACKSIZE);

	/* First phase: full byte rotating. For instance, if BIT_UNIT is 32 and
	 * we want to rotate 67 bits, then this is 2 * BIT_UNIT + 3, which means
	 * we need a 2 full bytes rotating and then a single 3 bits rotation.
	 */

	bshift = s / BIT_UNIT;		/* Amount of full byte rotation needed */
	if (bshift > 0) {
		for (i = bshift; i <= units - 1; i++)
			arena[i - bshift] = arena[i];
		for (i = 0; i < bshift; i++)
			arena[units - bshift + i] = ARENA(bit)[i];
	}

	/* Second phase: garbage bit resetting. If we did full byte rotation and
	 * there were garbage bits at the right end of the bit field, then those
	 * bits are now somewhere withing the bit field. We simply shift back to
	 * the left up to the place where the garbage bits are located, hence
	 * squeezing them away.
	 */

	if (bshift > 0) {				/* Full byte rotation was performed */
		idx = units - bshift - 1;	/* Index where garbage bits are stuffed */
		bshift = len % BIT_UNIT;	/* Number of non-garbage bits */
		if (bshift > 0) {
			bshift = BIT_UNIT - bshift;		/* Number of garbage bits */
			previous = 0;
			mask = ((1 << bshift) - 1) << (BIT_UNIT - bshift);
			for (i = units - 1; i > idx; i--) {
				buffer = arena[i];
				arena[i] = (buffer << bshift) | previous;
				previous = (buffer & mask) >> (BIT_UNIT - bshift);
			}
			buffer = arena[idx] & ~((1 << bshift) - 1);
			arena[idx] = buffer | previous;
		}
	}


	/* Third phase: single bit rotating (less than BIT_UNIT). Here again the
	 * complexity is brought by the mere existence of garbage bits. Indeed we
	 * shift them in the bit field and then overwrite them with the bits coming
	 * from the leftmost side.
	 */

	bshift = s % BIT_UNIT;					/* Amount of bit rotating needed */
	if (bshift > 0) {
		last = arena[0];					/* Save first bit unit */
		idx = BIT_UNIT - len % BIT_UNIT;	/* Save number of garbage bits */
		if (idx == BIT_UNIT)
			idx = 0;						/* No garbage: size % BIT_UNIT = 0 */
		buffer = arena[units - 1];			/* Get last bit unit */
		buffer &= ~((1 << idx) -1);			/* Clear garbage bits */
		arena[units - 1] = buffer | (last >> (BIT_UNIT - idx));
		previous = 0;
		mask = ((1 << bshift) - 1) << (BIT_UNIT - bshift);
		for (i = units - 1; i >= 0; i--) {
			buffer = arena[i];
			arena[i] = (buffer << bshift) | previous;
			previous = (buffer & mask) >> (BIT_UNIT - bshift);
		}
		i = bshift - idx;				/* Missing bits (with extra garbage) */
		if (i > 0) {					/* Shifted more than the merged bits */
			last <<= idx;				/* Those were already merged */
			last >>= BIT_UNIT - i;		/* We need those i bits */
			buffer = arena[units - 1] & ~((1 << i) - 1);
			arena[units - 1] = buffer | last;
		}
	}

	return new;
}

rt_public EIF_REFERENCE b_and (EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Performs the logical AND operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	EIF_GET_CONTEXT
	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	RT_GC_PROTECT(b);
	a = b_clone(a);
	RT_GC_WEAN(b);
	len_a = LENGTH(a);
	len_b = LENGTH(b);

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_b + (BIT_NBPACK(len_b) - 1);

	for (; addr_b < last; addr_a++, addr_b++)	/* In the main part */
		*addr_a &= *addr_b;						/* Perform the AND operation */

	/* For the last bit unit, we have to AND only the significant part of the
	 * bit field `b'. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b %= BIT_UNIT;			/* Amount of needed bits in last unit */
	if (len_b == 0)
		*addr_a++ &= *addr_b;
	else {
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);
		*addr_a++ &= (*addr_b & len_b);
	}

	/* If there are some more bit units at the end of `a', they have to be
	 * reset to 0 (as they are AND'ed with zeros).
	 */

	last = ARENA(a) + (BIT_NBPACK(len_a) - 1);
	for (; addr_a <= last; addr_a++)
		*addr_a = 0;

	return a;
}

rt_public EIF_REFERENCE b_implies(EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Performs the logical '=>' operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	EIF_GET_CONTEXT
	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	RT_GC_PROTECT(b);
	a = b_clone(a);
	RT_GC_WEAN(b);
	len_a = LENGTH(a);
	len_b = LENGTH(b);

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_b + (BIT_NBPACK(len_b) - 1);

	for (; addr_b < last; addr_a++, addr_b++)	/* In the main part */
		*addr_a = ~(*addr_a) | *addr_b;			/* Perform the => operation */

	/* For the last bit unit, we have to '=>' only the significant part of the
	 * bit field `b'. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b %= BIT_UNIT;			/* Amount of needed bits in last unit */
	if (len_b == 0) {
		*addr_a = ~(*addr_a) | *addr_b;
		addr_a++;
	}
	else {
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);
		*addr_a = ~(*addr_a) | (*addr_b & len_b);
		addr_a++;
	}

	/* If there are some more bit units at the end of `a', they have to be
	 * inverted with NOT (as they are =>'ed with zeros).
	 */

	last = ARENA(a) + (BIT_NBPACK(len_a) - 1);
	for (; addr_a <= last; addr_a++)
		*addr_a = ~(*addr_a);

	return a;
}

rt_public EIF_REFERENCE b_or(EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Performs the logical OR operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	EIF_GET_CONTEXT
	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	RT_GC_PROTECT(b);
	a = b_clone(a);
	RT_GC_WEAN(b);
	len_a = LENGTH(a);
	len_b = LENGTH(b);

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_b + (BIT_NBPACK(len_b) - 1);

	for (; addr_b < last; addr_a++, addr_b++)	/* In the main part */
		*addr_a |= *addr_b;						/* Perform the OR operation */

	/* For the last bit unit, we have to OR only the significant part of the
	 * bit field `b'. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b %= BIT_UNIT;			/* Amount of needed bits in last unit */
	if (len_b == 0)
		*addr_a++ |= *addr_b;
	else {
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);
		*addr_a++ |= (*addr_b & len_b);
	}

	/* If there are some more bit units at the end of `a', they have to be
	 * left alone (as they are OR'ed with zeros).
	 */

	return a;
}

rt_public EIF_REFERENCE b_xor(EIF_REFERENCE a, EIF_REFERENCE b)
{
	/* Performs the logical XOR operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	EIF_GET_CONTEXT
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	RT_GC_PROTECT(b);
	a = b_clone(a);
	RT_GC_WEAN(b);
	len_b = LENGTH(b);

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_b + (BIT_NBPACK(len_b) - 1);

	for (; addr_b < last; addr_a++, addr_b++)	/* In the main part */
		*addr_a ^= *addr_b;						/* Perform the XOR operation */

	/* For the last bit unit, we have to XOR only the significant part of the
	 * bit field `b'. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b %= BIT_UNIT;			/* Amount of needed bits in last unit */
	if (len_b == 0)
		*addr_a++ ^= *addr_b;
	else {
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);
		*addr_a++ ^= (*addr_b & len_b);
	}

	/* If there are some more bit units at the end of `a', they have to be
	 * left alone (as they are XOR'ed with zeros).
	 */

	return a;
}

rt_public EIF_REFERENCE b_not(EIF_REFERENCE a)
{
	/* Performs the logical NOT operation on `a' */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register3 uint32 *last;		/* Last bit unit in 'a' */

	a = b_clone(a);
	len_a = LENGTH(a);
	addr_a = ARENA(a);
	last = addr_a + (BIT_NBPACK(len_a) - 1);

	for (; addr_a <= last; addr_a++)
		*addr_a = ~(*addr_a);			/* Perform the NOT operation */

	return a;
}

rt_public EIF_REFERENCE b_mirror(EIF_REFERENCE a)
{
	/* Mirror the bits, 110b -> 011b. This is done the slow way. I leave the
	 * fast way as an exercice to the reader--RAM.
	 */

	uint32 left;		/* Position on the left side */
	uint32 right;		/* Position on the right side */
	char bl;			/* Current left bit value */
	char br;			/* Current right bit value */

	a = b_clone(a);

	for (right = LENGTH(a), left = 1; right > left; right--, left++) {
		br = b_item(a, right);
		bl = b_item(a, left);
		b_put(a, (char) right, (int) bl);
		b_put(a, (char) left, (int) br);
	}

	return a;
}

#ifdef TEST

/* This section implements a set of tests for the bits package.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

rt_public int epush(register struct stack *stk, register EIF_REFERENCE value) {}
rt_public void epop(register struct stack *stk, register int nb_items) {}
rt_public EIF_REFERENCE xmalloc(unsigned int nbytes, int type, int gc_flag) {}
rt_public void eraise(char *tag, int val) {}
rt_public EIF_REFERENCE eif_set(EIF_REFERENCE object, unsigned int nbytes, uint32 type) {}
rt_public struct stack loc_stack;

rt_private void dump_bit(EIF_REFERENCE bit)
{
	int l = LENGTH(bit);
	uint32 *a = ARENA(bit);
	int u = BIT_NBPACK(l);
	int i;

	printf("BIT %d", l);
	for (i = 0;  i < u; i++)
		printf(" 0x%lx", a[i]);
	printf("\n");
}

rt_public EIF_REFERENCE bmalloc(int size)
{
	struct bit *new;
	int nbytes;

	nbytes = BIT_NBPACK(size) * BIT_PACKSIZE + sizeof(uint32);
	new = (struct bit *) eif_malloc(nbytes);
	memset (new, 0, nbytes);
	LENGTH(new) = size;

	return (EIF_REFERENCE ) new;
}

rt_public void main(void)
{
	EIF_REFERENCE b1, *b2;

	b1 = bmalloc(36);
	b_put(b1, 1, 1);
	b_put(b1, 9, 1);
	b_put(b1, 17, 1);
	printf("First bit\n");
	dump_bit(b1);

	printf("Second bit\n");
	b2 = bmalloc(40);
	b_put(b2, 40, 1);
	b_put(b2, 39, 1);
	b_put(b2, 38, 1);
	b_put(b2, 37, 1);
	b_put(b2, 36, 1);
	b_put(b2, 35, 1);
	dump_bit(b2);

	printf("Cloning\n");
	b2 = b_clone(b2);
	dump_bit(b2);

	printf("Oring of two bits\n");
	b1 = b_or(b2, b1);
	dump_bit(b1);

	printf("Rotating +/- 1\n");
	b1 = b_rotate(b1, 1);
	dump_bit(b1);
	b1 = b_rotate(b1, -1);
	dump_bit(b1);

	printf("Rotating +/- 5\n");
	b1 = b_rotate(b1, 5);
	dump_bit(b1);
	b1 = b_rotate(b1, -5);
	dump_bit(b1);

	printf("Rotating +16\n");
	b1 = b_rotate(b1, 16);
	dump_bit(b1);
	printf("Rotating +16\n");
	b1 = b_rotate(b1, 16);
	dump_bit(b1);
	printf("Rotating +8\n");
	b1 = b_rotate(b1, 8);
	dump_bit(b1);

	printf("Rotating -16\n");
	b1 = b_rotate(b1, -16);
	dump_bit(b1);
	printf("Rotating -16\n");
	b1 = b_rotate(b1, -16);
	dump_bit(b1);
	printf("Rotating -8\n");
	b1 = b_rotate(b1, -8);
	dump_bit(b1);

	printf("Shifting -8\n");
	b1 = b_shift(b1, -8);
	dump_bit(b1);
	printf("Shifting +8\n");
	b1 = b_shift(b1, 8);
	dump_bit(b1);

	printf("New bit 260\n");
	b1 = bmalloc(260);
	b_put(b1, 1, 1);
	b_put(b1, 33, 1);
	b_put(b1, 65, 1);
	b_put(b1, 97, 1);
	b_put(b1, 129, 1);
	b_put(b1, 161, 1);
	b_put(b1, 260, 1);
	dump_bit(b1);

	printf("Rotating +259\n");
	b1 = b_rotate(b1, 259);
	dump_bit(b1);
	printf("Rotating -259\n");
	b1 = b_rotate(b1, -259);
	dump_bit(b1);

	printf("Rotating -36\n");
	b1 = b_rotate(b1, -36);
	dump_bit(b1);
	printf("Rotating +36\n");
	b1 = b_rotate(b1, 36);
	dump_bit(b1);
}

#endif
