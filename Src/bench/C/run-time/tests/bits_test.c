#include "bits.c"

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
	struct bit *res;
	int nbytes;

	nbytes = BIT_NBPACK(size) * BIT_PACKSIZE + sizeof(uint32);
	res = (struct bit *) eif_malloc(nbytes);
	memset (res, 0, nbytes);
	LENGTH(res) = size;

	return (EIF_REFERENCE ) res;
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
