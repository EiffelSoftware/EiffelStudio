#include "eif_macros.h"
#include "eif_except.h"
#include "eif_bits.h"
#include <stdio.h>
#include <string.h>

void ca_int64 (char *area, EIF_INTEGER_64 val, long int pos)
{
	/* Write long integer `val' in array of character `area', starting
	 * at the index `pos'. */

	char *p;
	int i;

	p = (char *) &val;
	for (i = 0; i < sizeof(EIF_INTEGER_64); i++)
		*(area + i + pos) = *p++;
}

void ca_wlong (char *area, long int val, long int pos)
{
	/* Write long integer `val' in array of character `area', starting
	 * at the index `pos'. */

	long xlong = val;
	char *p;
	int i;

	p = (char *) &xlong;
	for (i = 0; i < sizeof(long); i++)
		*(area + i + pos) = *p++;
}

void ca_wdouble (char *area, double val, long int pos)
{
	/* Write double `val' in array of character `area', starting
	 * at the index `pos'. */

	double xdouble = val;
	char *p;
	int i;

	p = (char *) &xdouble;
	for (i = 0; i < sizeof(double); i++)
		*(area + i + pos) = *p++;
}

void ca_wshort(char *area, long int val, long int pos)
{
	/* Write short integer `val' in array of character `area', starting
	 * at the index `pos'. */

	short xshort = (short) val;
	char *p;
	int i;

	p = (char *) &xshort;
	for (i = 0; i < sizeof(short); i++)
		*(area + i + pos) = *p++;
}

void ca_wint32(char *area, long int val, long int pos)
{
	/* Write int32 integer `val' in array of character `area', starting
	 * at the index `pos'. */

	int32 xint32 = (int32) val;
	char *p;
	int i;

	p = (char *) &xint32;
	for (i = 0; i < sizeof(int32); i++)
		*(area + i + pos) = *p++;
}

void ca_wuint32(char *area, long int val, long int pos)
{
	/* Write short integer `val' in array of character `area', starting
	 * at the index `pos'. */

	uint32 xuint32 = (uint32) val;
	char *p;
	int i;

	p = (char *) &xuint32;
	for (i = 0; i < sizeof(uint32); i++){
		*(area + i + pos) = *p++;
	}
}

long ca_bsize (long int blength)
{
	/* Returns number of uint32 fields for encoding a bit of length
	 * `blength'. */

	return BIT_NBPACK(blength);
}

void ca_wbit(char *area, char *bit, long int pos, long int blength)
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
		ca_wuint32(area,val,pos + i*sizeof(uint32));
	}
	val = (uint32) 0;
	blength %= BIT_UNIT;
	if (blength == 0)
		blength = BIT_UNIT;
	for (j=BIT_UNIT-1; j>= (int)(BIT_UNIT-blength); j--) 
		val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
	ca_wuint32(area,val,pos + (nb_packs-1)*sizeof(uint32));
}

void ca_store(char *area, long int siz, FILE *fil)
{
	if (fwrite(area, sizeof(char), siz, fil) != (size_t) siz)
		xraise(EN_IO);
}

void write_int (FILE *file, long int val)
{
	fwrite(&val, sizeof(long), 1, file);
}
