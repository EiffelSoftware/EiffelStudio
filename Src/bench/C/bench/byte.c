#include "eif_macros.h"
#include "rt_except.h"
#include "eif_bits.h"
#include <stdio.h>
#include <string.h>

rt_public long ca_bsize (long int blength)
{
	/* Returns number of uint32 fields for encoding a bit of length
	 * `blength'. */

	return BIT_NBPACK(blength);
}

rt_public void ca_wbit(char *area, char *bit, long int pos, long int blength)
{
	/* Write bits value	`bit' of length in `area' stating at `pos'.
	 */

	uint32 val;
	int i, j, nb_packs;

	nb_packs = BIT_NBPACK(blength);
	for (i=0; i<nb_packs-1; i++) {
		val = (uint32) 0;
		for (j=BIT_UNIT-1; j>=0 ; j--)
			val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
		memcpy (area + pos + i*sizeof(uint32), &val, sizeof(uint32));
	}
	val = (uint32) 0;
	blength %= BIT_UNIT;
	if (blength == 0)
		blength = BIT_UNIT;
	for (j=BIT_UNIT-1; j>= (int)(BIT_UNIT-blength); j--) 
		val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
	memcpy (area + pos + (nb_packs - 1) * sizeof(uint32), &val, sizeof (uint32));
}

rt_public void ca_store(char *area, long int siz, FILE *fil)
{
	if (fwrite(area, sizeof(char), siz, fil) != (size_t) siz)
		xraise(EN_IO);
}

rt_public void write_int (FILE *file, long int val)
{
	fwrite(&val, sizeof(long), 1, file);
}
