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

#include "config.h"
#include "garcol.h"
#include "malloc.h"
#include "cecil.h"
#include "bits.h"
#include "local.h"
#include "plug.h"
#include "except.h"

/* Bits are stored in unsigned 32 bits integer, and padding occurs if needed.
 * This means some garbage bits may be found at the end of the bit field.
 * BIT_NBPACK computes the number of 'uint32' fields (bit units) needed to
 * store a given amount of bits.
 */
#define BIT_PACKSIZE	sizeof(uint32)		/* Size of a bit unit in bytes */
#define BIT_UNIT		32					/* Size of a bit unit in bits */
#define BIT_NBPACK(s)	(((s) / BIT_UNIT) + (((s) % BIT_UNIT) ? 1 : 0))

/* Bit shifting */
private char *b_left_shift();		/* Shift bit field to the left */
private char *b_right_shift();		/* Shift bit field to the right */

/* Bit rotating */
private char *b_left_rotate();		/* Rotate bit field to the left */
private char *b_right_rotate();		/* Rotate bit field to the right */

/*
 * Public declarations for bits manipulations
 */

public long b_count(bit)
char *bit;
{
	return ((struct bit *) bit)->b_length;		/* Size of a BIT object */
}

#ifndef TEST
public char *bmalloc(size)
long size;
{
	/* Memory allocation for an Eiffel bit structure. It either succeeds
	 * or raises the "No more memory" exception. `size' is the required size
	 * of the bit type, in bits.
	 */

	char *object;			/* Pointer to the freshly created bit object */
	long nbytes;			/* Object's size */
	extern int bit_dtype;	/* Dynamic type of BIT */
	extern char *eif_set();	/* Setting of Eiffel object */

	/* A BIT object has a length field (the number of bits in the object), and
	 * an arena where the bits are stored, from left to right, as an array of
	 * booleans (i.e. the first bit is the rightmost one, as opposed to the
	 * usual conventions).
	 */
	nbytes = BIT_NBPACK(size) * BIT_PACKSIZE + sizeof(uint32);
	object = xmalloc (nbytes, EIFFEL_T, GC_ON);		/* Allocate Eiffel object */

	if (object != (char *) 0) {
		LENGTH(object) = size;						/* Record size */
		return eif_set(object, nbytes, bit_dtype);	/* And set up the dtype */
	}

	eraise("object allocation", EN_MEM);	/* Signals no more memory */
	/* NOTREACHED */
}
#endif

public char b_equal(a, b)
char *a;
char *b;
{
	/* Standard equality between two bits */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'a' */

	if (a == b)					/* Pointer to the same object */
		return true;			/* Means objects are identical */

	len_a = LENGTH(a);
	len_b = LENGTH(b);

	if (len_a != len_b)			/* Bits do not have the same size */
		return false;			/* They can't be equal */

	addr_a = ARENA(a);
	addr_b = ARENA(b);
	last = addr_a + (BIT_NBPACK(len_a) - 1);

	for (; addr_a < last; addr_a++, addr_b++)	/* In the main part */
		if (*addr_a != *addr_b)					/* Return as soon as the */
			return false;						/* two bit units differ */

	/* For the last bit unit, we have to compare only the significant part
	 * of the bit field. The number of significant bits at the rightmost part
	 * is simply the size modulo BIT_UNIT. If the size was not a multiple of
	 * BIT_UNIT, a mask is constructed to keep only the significant bits.
	 */

	len_b = len_a % BIT_UNIT;
	if (len_b == 0)
		return (*addr_a == *addr_b) ? true : false;
	else
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);

	return ((*addr_a & len_b) == (*addr_b & len_b)) ? true : false;
}

public void b_copy(a, b)
char *a;
char *b;
{
	/* Copy bit field 'a' into 'b'. The function assume the size of 'b' is
	 * correct and 'b' must be a valid pointer (i.e. not void).
	 */

	register1 int len = LENGTH(a);	/* Macro evaluates its argument twice */

	bcopy(a, b, BIT_NBPACK(len) * BIT_PACKSIZE + sizeof(uint32));
}

public char *b_clone(bit)
char *bit;
{
	/* Return a clone of the bit field 'bit' given as argument. Beware: there is
	 * object creation, hence a risk of having to face a GC cycle. Save your
	 * buffers :-)--RAM.
	 */

	char *new;						/* Address of newly allocated object */

	epush(&loc_stack, &bit);		/* Ensure address is updated by GC */
	new = bmalloc(LENGTH(bit));		/* Create new bit field */
	epop(&loc_stack, 1);			/* It's safe now, object won't move */
	b_copy(bit, new);				/* Copy into newly allocated bits */

	return new;			/* Freshly allocated bit field object */
}

public void b_put(bit, at, value)
char *bit;				/* The Eiffel bit object */
int at;					/* The position in the bit field (starting at 1) */
char value;				/* The boolean value to be set */
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

	addr[idx] |= value << mask;			/* Value must be 0 or 1 */
}

public char b_item(bit, at)
char *bit;
long at;
{
	/* Return the value (0 or 1) of the bit 'at' in the bit field. Index
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

	return (addr[idx] & (1 << mask)) >> mask;
}

public char *b_shift(bit, s)
char *bit;
long s;
{
	/* Shifts `bit' by `s' positions. If s is positive, shifiting is done to
	 * the right, otherwise to the left. A null value does nothing.
	 */

	if (s == 0)					/* Null operation */
		return b_clone(bit);	/* No side effect wanted */

	if (s > 0)
		return b_right_shift(bit, s);
	else
		return b_left_shift(bit, -s);
}

private char *b_right_shift(bit, s)
char *bit;
long s;
{
	/* Shifts `bit' by `s' positions to the right */

	int len;					/* Length of the bit field */
	int i;						/* Loop over the bit field */
	int units;					/* Number of bit units */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 *arena;	/* Where bit array starts */
	char *new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */
	new = bmalloc(len);			/* Returned bit object */
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Amount of bit units needed */

	if (s > len)			/* Shifting more than bit field size */
		return new;			/* Reset bit field with zeros */

	bcopy(ARENA(bit), arena, units * BIT_PACKSIZE);

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

private char *b_left_shift(bit, s)
char *bit;
long s;
{
	/* Shifts `bit' by `s' positions to the left */

	int len;					/* Length of the bit field */
	int i;						/* Loop over the bit field */
	int units;					/* Number of bit units */
	register1 int bshift;		/* Byte/bit shifting amount */
	register2 uint32 mask;		/* Mask used to save shifted bytes */
	register3 uint32 buffer;	/* Buffer for shifting */
	register4 uint32 previous;	/* Previous buffer to be merged */
	register5 uint32 *arena;	/* Where bit array starts */
	char *new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */
	new = bmalloc(len);			/* Returned bit object */
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	if (s > len)			/* Shifting more than bit field size */
		return new;			/* Reset bit field with zeros */

	bcopy(ARENA(bit), arena, units * BIT_PACKSIZE);

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

public char *b_rotate(bit, s)
char *bit;
int s;
{
	/* Rotates `bit' by `s' positions. If s is positive, rotation is done to
	 * the right, otherwise to the left. A null value does nothing.
	 */

	if (s == 0)					/* A null operation */
		return b_clone(bit);	/* No side effect wanted */

	if (s > 0)
		return b_right_rotate(bit, s);
	else
		return b_left_rotate(bit, -s);
}

private char *b_right_rotate(bit, s)
char *bit;
int s;
{
	/* Rotates `bit' by `s' positions to the right */

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
	char *new;					/* New bit object */

	len = LENGTH(bit);			/* Length of bit field */

	if (s > len)			/* Rotating more than bit field size */
		s %= len;			/* Keep only the modulo part */

	if (s > (len / 2))		/* Rotating more than half the length */
		return b_left_rotate(bit, len - s);

	new = bmalloc(len);			/* The bit object which will be rotated */
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	bcopy(ARENA(bit), arena, units * BIT_PACKSIZE);

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

private char *b_left_rotate(bit, s)
char *bit;
long s;
{
	/* Rotates `bit' by `s' positions to the left */

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
	char *new;					/* The new bit object */

	len = LENGTH(bit);			/* Length of bit field */

	if (s > len)			/* Rotating more than bit field size */
		s %= len;			/* Keep only the modulo part */

	if (s > (len / 2))		/* Rotating more than half the length */
		return b_right_rotate(bit, len - s);

	new = bmalloc(len);			/* The new bit object which will be rotated */
	arena = ARENA(new);			/* Where bit array starts */
	units = BIT_NBPACK(len);	/* Ampunt of bit units needed */

	bcopy(ARENA(bit), arena, units * BIT_PACKSIZE);

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

public char *b_and (a, b)
char *a, *b;
{
	/* Performs the logical AND operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	a = b_clone(a);
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
	for (; addr_a < last; addr_a++)
		*addr_a = 0;

	return a;
}

public char *b_implies(a, b)
char *a, *b;
{
	/* Performs the logical '=>' operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	a = b_clone(a);
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
	if (len_b == 0)
		*addr_a++ = ~(*addr_a) | *addr_b;
	else {
		len_b = ((1 << len_b) - 1) << (BIT_UNIT - len_b);
		*addr_a++ = ~(*addr_a) | (*addr_b & len_b);
	}

	/* If there are some more bit units at the end of `a', they have to be
	 * inverted with NOT (as they are =>'ed with zeros).
	 */

	last = ARENA(a) + (BIT_NBPACK(len_a) - 1);
	for (; addr_a < last; addr_a++)
		*addr_a = ~(*addr_a);

	return a;
}

public char *b_or(a, b)
char *a, *b;
{
	/* Performs the logical OR operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	a = b_clone(a);
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

public char *b_xor(a, b)
char *a, *b;
{
	/* Performs the logical XOR operation between `a' and `b' into `a'. The
	 * routine assumes that length of `b' is lesser or equal to length of `a'.
	 * This is the implication of the conformance constraint. The `b' fields
	 * is logically extended with zeros at the rightmost part to match the size
	 * of `a'.
	 */

	register1 uint32 len_a;		/* Length of the bit field a */
	register2 uint32 len_b;		/* Length of the bit field b */
	register3 uint32 *addr_a;	/* Pointer into the arena of 'a' */
	register4 uint32 *addr_b;	/* Pointer into the arena of 'b' */
	register5 uint32 *last;		/* Last bit unit in 'b' */

	a = b_clone(a);
	len_a = LENGTH(a);
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

public char *b_not(a)
char *a;
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

#ifdef TEST

/* This section implements a set of tests for the bits package.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

public int epush() {}
public void epop() {}
public char *xmalloc() {}
public void eraise() {}
public char *eif_set() {}
public int bit_dtype;
public struct stack loc_stack;

private void dump_bit(bit)
char *bit;
{
	int l = LENGTH(bit);
	uint32 *a = ARENA(bit);
	int u = BIT_NBPACK(l);
	int i;

	printf("BIT %d", l);
	for (i = 0;  i < u; i++)
		printf(" 0x%x", a[i]);
	printf("\n");
}

public char *bmalloc(size)
int size;
{
	struct bit *new;
	int nbytes;
	extern Malloc_t malloc();

	nbytes = BIT_NBPACK(size) * BIT_PACKSIZE + sizeof(uint32);
	new = (struct bit *) malloc(nbytes);
	bzero(new, nbytes);
	LENGTH(new) = size;

	return (char *) new;
}

public void main()
{
	char *b1, *b2;

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
