/*

 #####   ######   ####            ####
 #    #  #       #               #    #
 #    #  #####    ####           #
 #    #  #            #   ###    #
 #    #  #       #    #   ###    #    #
 #####   ######   ####    ###     ####

	Sofware DES functions.

	Written 12 Dec 1986 by Phil Karn, KA9Q; large sections adapted from
	the 1977 public-domain program by Jim Gillogly
*/

#include "eif_config.h"
#include "eif_portable.h"

/* These routines are written for a big endian machine. Make sure we swap
 * the bytes on a little endian machine.
 */
#if BYTEORDER == 0x12345678
#define LITTLE_ENDIAN
#endif
#if BYTEORDER == 0x1234
#define LITTLE_ENDIAN
#endif

#ifdef	LITTLE_ENDIAN
static uint32 byteswap();
#endif

/* Tables defined in the Data Encryption Standard documents */

/* initial permutation IP */
static char ip[] = {
	58, 50, 42, 34, 26, 18, 10,  2,
	60, 52, 44, 36, 28, 20, 12,  4,
	62, 54, 46, 38, 30, 22, 14,  6,
	64, 56, 48, 40, 32, 24, 16,  8,
	57, 49, 41, 33, 25, 17,  9,  1,
	59, 51, 43, 35, 27, 19, 11,  3,
	61, 53, 45, 37, 29, 21, 13,  5,
	63, 55, 47, 39, 31, 23, 15,  7
};

/* final permutation IP^-1 */
static char fp[] = {
	40,  8, 48, 16, 56, 24, 64, 32,
	39,  7, 47, 15, 55, 23, 63, 31,
	38,  6, 46, 14, 54, 22, 62, 30,
	37,  5, 45, 13, 53, 21, 61, 29,
	36,  4, 44, 12, 52, 20, 60, 28,
	35,  3, 43, 11, 51, 19, 59, 27,
	34,  2, 42, 10, 50, 18, 58, 26,
	33,  1, 41,  9, 49, 17, 57, 25
};

/* expansion operation matrix
 * This is for reference only; it is unused in the code
 * as the f() function performs it implicitly for speed
 */
#ifdef notdef
static char ei[] = {
	32,  1,  2,  3,  4,  5,
	 4,  5,  6,  7,  8,  9,
	 8,  9, 10, 11, 12, 13,
	12, 13, 14, 15, 16, 17,
	16, 17, 18, 19, 20, 21,
	20, 21, 22, 23, 24, 25,
	24, 25, 26, 27, 28, 29,
	28, 29, 30, 31, 32,  1 
};
#endif

/* permuted choice table (key) */
static char pc1[] = {
	57, 49, 41, 33, 25, 17,  9,
	 1, 58, 50, 42, 34, 26, 18,
	10,  2, 59, 51, 43, 35, 27,
	19, 11,  3, 60, 52, 44, 36,
	63, 55, 47, 39, 31, 23, 15,
	 7, 62, 54, 46, 38, 30, 22,
	14,  6, 61, 53, 45, 37, 29,
	21, 13,  5, 28, 20, 12,  4
};

/* number left rotations of pc1 */
static char totrot[] = {
	1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28
};

/* permuted choice key (table) */
static char pc2[] = {
	14, 17, 11, 24,  1,  5,
	 3, 28, 15,  6, 21, 10,
	23, 19, 12,  4, 26,  8,
	16,  7, 27, 20, 13,  2,
	41, 52, 31, 37, 47, 55,
	30, 40, 51, 45, 33, 48,
	44, 49, 39, 56, 34, 53,
	46, 42, 50, 36, 29, 32
};

/* The (in)famous S-boxes */
static char si[8][64] = {
	/* S1 */
	14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7,
	 0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8,
	 4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0,
	15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13,

	/* S2 */
	15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10,
	 3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5,
	 0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15,
	13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9,

	/* S3 */
	10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8,
	13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1,
	13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7,
	 1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12,

	/* S4 */
	 7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15,
	13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9,
	10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4,
	 3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14,

	/* S5 */
	 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9,
	14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6,
	 4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14,
	11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3,

	/* S6 */
	12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11,
	10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8,
	 9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6,
	 4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13,

	/* S7 */
	 4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1,
	13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6,
	 1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2,
	 6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12,

	/* S8 */
	13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7,
	 1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2,
	 7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8,
	 2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11
};

/* 32-bit permutation function P used on the output of the S-boxes */
static char p32i[] = {	
	16,  7, 20, 21,
	29, 12, 28, 17,
	 1, 15, 23, 26,
	 5, 18, 31, 10,
	 2,  8, 24, 14,
	32, 27,  3,  9,
	19, 13, 30,  6,
	22, 11,  4, 25
};
/* End of DES-defined tables */

/* Lookup tables initialized once only at startup by desinit() */
static int32 (*sp)[64];		/* Combined S and P boxes */

static char (*iperm)[16][8];	/* Initial and final permutations */
static char (*fperm)[16][8];

/* 8 6-bit subkeys for each of 16 rounds, initialized by setkey() */
static unsigned char (*kn)[8];

/* bit 0 is left-most in byte */
static int bytebit[] = {
	0200,0100,040,020,010,04,02,01
};

static int nibblebit[] = {
	 010,04,02,01
};
static int desmode;

rt_private void permute();
rt_private void round();
rt_private int32 f();
rt_private void perminit();
rt_private int spinit();

/* Allocate space and initialize DES lookup arrays
 * mode == 0: standard Data Encryption Algorithm
 * mode == 1: DEA without initial and final permutations for speed
 * mode == 2: DEA without permutations and with 128-byte key (completely
 *            independent subkeys for each round)
 */
int desinit(int mode)
{
#ifdef __VMS	/* why? this belongs in a header! And, it's wrong to boot. */
	/* s.b. void* malloc(size_t); */
#else
/*	char *malloc(); */
#endif

	if(sp != NULL){
		/* Already initialized */
		return 0;
	}
	desmode = mode;
	
	if((sp = (int32 (*)[64])malloc(sizeof(int32) * 8 * 64)) == NULL){
		return -1;
	}
	spinit();
	kn = (unsigned char (*)[8])malloc(sizeof(char) * 8 * 16);
	if(kn == NULL){
		free((char *)sp);
		return -1;
	}
	if(mode == 1 || mode == 2)	/* No permutations */
		return 0;

	iperm = (char (*)[16][8])malloc(sizeof(char) * 16 * 16 * 8);
	if(iperm == NULL){
		free((char *)sp);
		free((char *)kn);
		return -1;
	}
	perminit(iperm,ip);

	fperm = (char (*)[16][8])malloc(sizeof(char) * 16 * 16 * 8);
	if(fperm == NULL){
		free((char *)sp);
		free((char *)kn);
		free((char *)iperm);
		return -1;
	}
	perminit(fperm,fp);
	
	return 0;
}
/* Free up storage used by DES */
void desdone()
{
	if(sp == NULL)
		return;	/* Already done */

	free((char *)sp);
	free((char *)kn);
	if(iperm != NULL)
		free((char *)iperm);
	if(fperm != NULL)
		free((char *)fperm);

	sp = NULL;
	iperm = NULL;
	fperm = NULL;
	kn = NULL;
}
/* Set key (initialize key schedule array) */
void setkey(char *key)
	 /* 64 bits (will use only 56) */
{
	char pc1m[56];		/* place to modify pc1 into */
	char pcr[56];		/* place to rotate pc1 into */
	register int i,j,l;
	int m;

	/* In mode 2, the 128 bytes of subkey are set directly from the
	 * user's key, allowing him to use completely independent
	 * subkeys for each round. Note that the user MUST specify a
	 * full 128 bytes.
	 *
	 * I would like to think that this technique gives the NSA a real
	 * headache, but I'm not THAT naive.
	 */
	if(desmode == 2){
		for(i=0;i<16;i++)
			for(j=0;j<8;j++)
				kn[i][j] = *key++;
		return;
	}
	/* Clear key schedule */
	for (i=0; i<16; i++)
		for (j=0; j<8; j++)
			kn[i][j]=0;

	for (j=0; j<56; j++) {		/* convert pc1 to bits of key */
		l=pc1[j]-1;		/* integer bit location	 */
		m = l & 07;		/* find bit		 */
		pc1m[j]=(key[l>>3] &	/* find which key byte l is in */
			bytebit[m])	/* and which bit of that byte */
			? 1 : 0;	/* and store 1-bit result */
	}
	for (i=0; i<16; i++) {		/* key chunk for each iteration */
		for (j=0; j<56; j++)	/* rotate pc1 the right amount */
			pcr[j] = pc1m[(l=j+totrot[i])<(j<28? 28 : 56) ? l: l-28];
			/* rotate left and right halves independently */
		for (j=0; j<48; j++){	/* select bits individually */
			/* check bit that goes to kn[j] */
			if (pcr[pc2[j]-1]){
				/* mask it in if it's there */
				l= j % 6;
				kn[i][j/6] |= bytebit[l] >> 2;
			}
		}
	}
}
/* In-place encryption of 64-bit block */
void endes(char *block)
{
	register int i;
	uint32 work[2]; 		/* Working data storage */
	int32 tmp;

	permute(block,iperm,(char *)work);	/* Initial Permutation */
#ifdef LITTLE_ENDIAN
	work[0] = byteswap(work[0]);
	work[1] = byteswap(work[1]);
#endif

	/* Do the 16 rounds */
	for (i=0; i<16; i++)
		round(i,work);

	/* Left/right half swap */
	tmp = work[0];
	work[0] = work[1];	
	work[1] = tmp;

#ifdef LITTLE_ENDIAN
	work[0] = byteswap(work[0]);
	work[1] = byteswap(work[1]);
#endif
	permute((char *)work,fperm,block);	/* Inverse initial permutation */
}

/* In-place decryption of 64-bit block */
void dedes(char *block)
{
	register int i;
	uint32 work[2];	/* Working data storage */
	int32 tmp;

	permute(block,iperm,(char *)work);	/* Initial permutation */

#ifdef LITTLE_ENDIAN
	work[0] = byteswap(work[0]);
	work[1] = byteswap(work[1]);
#endif

	/* Left/right half swap */
	tmp = work[0];
	work[0] = work[1];	
	work[1] = tmp;

	/* Do the 16 rounds in reverse order */
	for (i=15; i >= 0; i--)
		round(i,work);

#ifdef LITTLE_ENDIAN
	work[0] = byteswap(work[0]);
	work[1] = byteswap(work[1]);
#endif

	permute((char *)work,fperm,block);	/* Inverse initial permutation */
}

/* Permute inblock with perm */
rt_private void permute(char *inblock, char perm[16][16][8], char *outblock)
	 /* result into outblock,64 bits */
	 /* perm: 2K bytes defining perm. */
{
	register int i,j;
	register char *ib, *ob;		/* ptr to input or output block */
	register char *p, *q;

	if(perm == NULL){
		/* No permutation, just copy */
		for(i=8; i!=0; i--)
			*outblock++ = *inblock++;
		return;
	}
	/* Clear output block	 */
	for (i=8, ob = outblock; i != 0; i--)
		*ob++ = 0;

	ib = inblock;
	for (j = 0; j < 16; j += 2, ib++) { /* for each input nibble */
		ob = outblock;
		p = perm[j][(*ib >> 4) & 017];
		q = perm[j + 1][*ib & 017];
		for (i = 8; i != 0; i--){   /* and each output byte */
			*ob++ |= *p++ | *q++;	/* OR the masks together*/
		}
	}
}

/* Do one DES cipher round */
rt_private void round(int num, uint32 *block)
	 /* num: i.e. the num-th one	 */
{
	int32 f();

	/* The rounds are numbered from 0 to 15. On even rounds
	 * the right half is fed to f() and the result exclusive-ORs
	 * the left half; on odd rounds the reverse is done.
	 */
	if(num & 1){
		block[1] ^= f(block[0],kn[num]);
	} else {
		block[0] ^= f(block[1],kn[num]);
	}
}
/* The nonlinear function f(r,k), the heart of DES */
rt_private int32 f(uint32 r, unsigned char subkey[8])
	 /* 32 bits */
	 /* 48-bit key for this round */
{
	register uint32 rval,rt;
#ifdef	TRACE
	unsigned char *cp;
	int i;

	printf("f(%08lx, %02x %02x %02x %02x %02x %02x %02x %02x) = ",
		r,
		subkey[0], subkey[1], subkey[2],
		subkey[3], subkey[4], subkey[5],
		subkey[6], subkey[7]);
#endif
	/* Run E(R) ^ K through the combined S & P boxes
	 * This code takes advantage of a convenient regularity in
	 * E, namely that each group of 6 bits in E(R) feeding
	 * a single S-box is a contiguous segment of R.
	 */
	rt = (r >> 1) | ((r & 1) ? 0x80000000 : 0);
	rval = 0;
	rval |= sp[0][((rt >> 26) ^ *subkey++) & 0x3f];
	rval |= sp[1][((rt >> 22) ^ *subkey++) & 0x3f];
	rval |= sp[2][((rt >> 18) ^ *subkey++) & 0x3f];
	rval |= sp[3][((rt >> 14) ^ *subkey++) & 0x3f];
	rval |= sp[4][((rt >> 10) ^ *subkey++) & 0x3f];
	rval |= sp[5][((rt >> 6) ^ *subkey++) & 0x3f];
	rval |= sp[6][((rt >> 2) ^ *subkey++) & 0x3f];
	rt = (r << 1) | ((r & 0x80000000) ? 1 : 0);
	rval |= sp[7][(rt ^ *subkey) & 0x3f];
#ifdef	TRACE
	printf(" %08lx\n",rval);
#endif
	return rval;
}
/* initialize a perm array */
rt_private void perminit(char perm[16][16][8], char p[64])
	 /* perm: 64-bit, either init or final */
{
	register int l, j, k;
	int i,m;

	/* Clear the permutation array */
	for (i=0; i<16; i++)
		for (j=0; j<16; j++)
			for (k=0; k<8; k++)
				perm[i][j][k]=0;

	for (i=0; i<16; i++)		/* each input nibble position */
		for (j = 0; j < 16; j++)/* each possible input nibble */
		for (k = 0; k < 64; k++)/* each output bit position */
		{   l = p[k] - 1;	/* where does this bit come from*/
			if ((l >> 2) != i)  /* does it come from input posn?*/
			continue;	/* if not, bit k is 0	 */
			if (!(j & nibblebit[l & 3]))
			continue;	/* any such bit in input? */
			m = k & 07;	/* which bit is this in the byte*/
			perm[i][j][k>>3] |= bytebit[m];
		}
}

/* Initialize the lookup table for the combined S and P boxes */
rt_private int spinit()
{
	char pbox[32];
	int p,i,s,j,rowcol;
	int32 val;

	/* Compute pbox, the inverse of p32i.
	 * This is easier to work with
	 */
	for(p=0;p<32;p++){
		for(i=0;i<32;i++){
			if(p32i[i]-1 == p){
				pbox[p] = i;
				break;
			}
		}
	}
	for(s = 0; s < 8; s++){			/* For each S-box */
		for(i=0; i<64; i++){		/* For each possible input */
			val = 0;
			/* The row number is formed from the first and last
			 * bits; the column number is from the middle 4
			 */
			rowcol = (i & 32) | ((i & 1) ? 16 : 0) | ((i >> 1) & 0xf);
			for(j=0;j<4;j++){	/* For each output bit */
				if(si[s][rowcol] & (8 >> j)){
				 val |= 1L << (31 - pbox[4*s + j]);
				}
			}
			sp[s][i] = val;

#ifdef DES_DEBUG
			printf("sp[%d][%2d] = %08lx\n",s,i,sp[s][i]);
#endif
		}
	}
    return 0;
}
#ifdef	LITTLE_ENDIAN
/* Byte swap a int32 */
static uint32 byteswap(uint32 x)
{
	register char *cp,tmp;

	cp = (char *)&x;
	tmp = cp[3];
	cp[3] = cp[0];
	cp[0] = tmp;

	tmp = cp[2];
	cp[2] = cp[1];
	cp[1] = tmp;

	return x;
}
#endif
