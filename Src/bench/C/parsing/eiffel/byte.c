#include "macros.h"
#include "except.h"
#include "bits.h"
#include <stdio.h>

long ca_ssiz();			/* Short integer size */
long ca_lsiz();			/* Long integer size */

void ca_put(area, c, i)
char *area;
char c;
long i;
{
	/* Put character `c' at position `i' in character array `area'. */
	
	area[i] = c;
}

char ca_item(area, i)
char *area;
long i;
{
	/* Item at position `i' in character array `area'. */
	
	return area[i];
}

void ca_copy(from, to, nbitems, at)
char *from, *to;
long nbitems, at;
{
	/* Copy `nbitems' character from `from' into `to'. */

	bcopy(from, to + at, nbitems * sizeof(char));
}

void ca_zero(area, size)
char *area;
long size;
{
	/* Reset character array `area' to zero. */

	bzero(area, size * sizeof(char));
}

void ca_wlong (area, val, index)
char *area;
long index, val;
{
	/* Write long integer `val' in array of character `area', starting
	 * at the index `index'. */

	long xlong = val;
	char *p;
	int i;

	p = (char *) &xlong;
	for (i = 0; i < sizeof(long); i++)
		*(area + i + index) = *p++;
}

void ca_wdouble (area, val, index)
char *area;
double val;
long index;
{
	/* Write double `val' in array of character `area', starting
	 * at the index `index'. */

	double xdouble = val;
	char *p;
	int i;

	p = (char *) &xdouble;
	for (i = 0; i < sizeof(double); i++)
		*(area + i + index) = *p++;
}

void ca_wshort(area, val, index)
char *area;
long index, val;
{
	/* Write short integer `val' in array of character `area', starting
	 * at the index `index'. */

	short xshort = (short) val;
	char *p;
	int i;

	p = (char *) &xshort;
	for (i = 0; i < sizeof(short); i++)
		*(area + i + index) = *p++;
}

void ca_wint32(area, val, index)
char *area;
long index, val;
{
	/* Write int32 integer `val' in array of character `area', starting
	 * at the index `index'. */

	int32 xint32 = (int32) val;
	char *p;
	int i;

	p = (char *) &xint32;
	for (i = 0; i < sizeof(int32); i++)
		*(area + i + index) = *p++;
}

void ca_wuint32(area, val, index)
char *area;
long index, val;
{
	/* Write short integer `val' in array of character `area', starting
	 * at the index `index'. */

	uint32 xuint32 = (uint32) val;
	char *p;
	int i;

	p = (char *) &xuint32;
	for (i = 0; i < sizeof(uint32); i++){
		*(area + i + index) = *p++;
	}
}

long ca_bsize (blength)
long blength;
{
	/* Returns number of uint32 fields for encoding a bit of length
	 * `blength'. */

	return BIT_NBPACK(blength);
}

void ca_wbit(area, bit, index, blength)
char *area, *bit;
long index, blength;
{
	/* Write bits value	`bit' of length in `area' stating at `index'.
	 */

	uint32 val;
	int i, j, nb_packs;

	nb_packs = BIT_NBPACK(blength);
	for (i=0; i<nb_packs-1; i++) {
		val = (uint32) 0;
		for (j=BIT_UNIT-1; j>=0 ; j--)
			val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
		ca_wuint32(area,val,index + i*sizeof(uint32));
	}
	val = (uint32) 0;
	blength %= BIT_UNIT;
	if (blength == 0)
		blength = BIT_UNIT;
	for (j=BIT_UNIT-1; j>= (int)(BIT_UNIT-blength); j--) 
		val += (1 << j) * ((*bit++ == '1') ? 1 : 0);
	ca_wuint32(area,val,index + (nb_packs-1)*sizeof(uint32));
}

long ca_lsiz()
{
	/* Long size. */

	return (long) sizeof(long);
}

long ca_ssiz()
{
	/* Short integer size. */

	return (long) sizeof(short);
}

long ca_sint32()
{
	/* int32 integer size. */

	return (long) sizeof(int32);
}

long ca_suint32()
{
	/* uint32 integer size. */

	return (long) sizeof(uint32);
}

void ca_store(area, siz, fil)
char *area;
long siz;
FILE *fil;
{
	if (fwrite(area, sizeof(char), siz, fil) != siz)
		xraise(EN_IO);
}

long c_char_size()
{
	return (long) sizeof(char);
}

long c_long_size()
{
	return (long) sizeof(long);
}

long c_float_size()
{
	return (long) sizeof(float);
}

long c_double_size()
{
	return (long) sizeof(double);
}

long c_pointer_size()
{
	return (long) sizeof(char *(*)());
}

long c_reference_size()
{
	return (long) sizeof(char *);
}

void write_int (file, val)
FILE *file;
long val;
{
	fwrite(&val, sizeof(long), 1, file);
}
