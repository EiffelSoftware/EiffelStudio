/* -*- c-basic-offset: 4 -*- */

#include "buffer.h"
#include <wchar.h>
#include "mico_types.h"
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

static char* charbuf;

/*******************************************************/

EIF_INTEGER  CORBA_byteorder (void)
{
#ifdef HAVE_BYTEORDER_LE
    return (EIF_INTEGER)1;
#else
    return (EIF_INTEGER)0;
#endif
}
/*******************************************************/

EIF_CHARACTER CORBA_int2character (EIF_INTEGER n)
{
    return (EIF_CHARACTER)n;
}
/*******************************************************/

EIF_INTEGER MICO_int2octet (EIF_INTEGER n)
{
    MICO_Octet res = (MICO_Octet)n; /* truncate to 8 bits */

    return (EIF_INTEGER) res;
}
/*******************************************************/

static char int_to_nibble(int);

EIF_POINTER MICO_to_hex (EIF_INTEGER n)
{
    int m = (int)n;

    charbuf = (char*) malloc (3);

    if (!charbuf)
        return (EIF_POINTER)0;

    charbuf [0] = int_to_nibble (m / 16);
    charbuf [1] = int_to_nibble (m % 16);
    charbuf [2] = '\0';
    return (EIF_POINTER) charbuf;
}
/*******************************************************/

void MICO_free_charbuf (void)
{
    free (charbuf);
}
/*******************************************************/

EIF_POINTER MICO_to_octal (EIF_INTEGER n)
{
    charbuf = (char*) malloc (5);

    if (!charbuf)
        return (EIF_POINTER)0;

    if (isprint((int)n))
    {
        charbuf[0] = (char)n;
        charbuf[1] = '\0';
    }
    else
        sprintf (charbuf, "%03o", (int)n);

    return (EIF_POINTER) charbuf;
}
/*******************************************************/

static char int_to_nibble (int n)
{
    static char* xdigits = "0123456789abcdef";
    if (n < 16)
        return xdigits[n];
    else
        return '@';
}
/*******************************************************/

static int nibble_to_int (EIF_CHARACTER c)
{
    c = tolower (c);
    return isdigit (c) ? c - '0' : c - 'a' + 10;

}
/*******************************************************/

EIF_INTEGER MICO_from_hex (EIF_CHARACTER c1, EIF_CHARACTER c2)
{
    return (16 * nibble_to_int (c1) + nibble_to_int (c2));
}
/*******************************************************/

EIF_INTEGER MICO_sizeof_long (void)
{
    return (EIF_INTEGER) sizeof(MICO_Long);
}
/*******************************************************/

EIF_INTEGER MICO_sizeof_ulong (void)
{
    return (EIF_INTEGER) sizeof(MICO_ULong);
}
/*******************************************************/

EIF_INTEGER MICO_swap2 (EIF_INTEGER n)
{
    MICO_Short s = (MICO_Short) n;
    short d;

    ((char*)&d)[0] = ((char*)&s)[1];
    ((char*)&d)[1] = ((char*)&s)[0];

    return (EIF_INTEGER) d;
}
/*******************************************************/

EIF_INTEGER MICO_swap4 (EIF_INTEGER n)
{
    MICO_Long s = (MICO_Long) n;
    long d;

    ((char*)&d)[0] = ((char*)&s)[3];
    ((char*)&d)[1] = ((char*)&s)[2];
    ((char*)&d)[2] = ((char*)&s)[1];
    ((char*)&d)[3] = ((char*)&s)[0];

    return (EIF_INTEGER) d;
}
/*******************************************************/

EIF_INTEGER MICO_swap8 (EIF_INTEGER n)
{
    MICO_Long s = (MICO_Long) n;
    long d;

    ((char*)&d)[0] = ((char*)&s)[7];
    ((char*)&d)[1] = ((char*)&s)[6];
    ((char*)&d)[2] = ((char*)&s)[5];
    ((char*)&d)[3] = ((char*)&s)[4];
    ((char*)&d)[4] = ((char*)&s)[3];
    ((char*)&d)[5] = ((char*)&s)[2];
    ((char*)&d)[6] = ((char*)&s)[1];
    ((char*)&d)[7] = ((char*)&s)[0];

    return (EIF_INTEGER) d;
}
/*******************************************************/

EIF_INTEGER MICO_swap16 (EIF_INTEGER n)
{
  /* swap16 is not implemented */
}
/*******************************************************/

EIF_BOOLEAN MICO_have_ieee_fp (void)
{
#ifdef HAVE_IEEE_FP
    return (EIF_BOOLEAN) TRUE;
#else
    return (EIF_BOOLEAN) FALSE;
#endif
}
/*******************************************************/

EIF_DOUBLE MICO_swap4_fp (EIF_DOUBLE nd)
{
    MICO_Float s = (MICO_Float) nd;
    float d;

    ((char*)&d)[0] = ((char*)&s)[3];
    ((char*)&d)[1] = ((char*)&s)[2];
    ((char*)&d)[2] = ((char*)&s)[1];
    ((char*)&d)[3] = ((char*)&s)[0];

    return (EIF_DOUBLE) d;
}
/*******************************************************/

EIF_DOUBLE MICO_swap8_fp (EIF_DOUBLE nd)
{
    MICO_Double s = (MICO_Double) nd;
    double d;

    ((char*)&d)[0] = ((char*)&s)[7];
    ((char*)&d)[1] = ((char*)&s)[6];
    ((char*)&d)[2] = ((char*)&s)[5];
    ((char*)&d)[3] = ((char*)&s)[4];
    ((char*)&d)[4] = ((char*)&s)[3];
    ((char*)&d)[5] = ((char*)&s)[2];
    ((char*)&d)[6] = ((char*)&s)[1];
    ((char*)&d)[7] = ((char*)&s)[0];

    return (EIF_DOUBLE) d;
}
/*** Additions to make Buffer almost entirely in C ***********/

#define MINSIZE          128
#define RESIZE_THRESH    10000
#define RESIZE_INCREMENT 10000
#define TRUE             1
#define FALSE            0

typedef unsigned long ULong;
typedef int           Boolean;

typedef struct
{
    ULong        rptr, wptr;
    ULong        ralignbase;
    ULong        walignbase;
    ULong        len;
    MICO_Octet*  buf;
} BUF_DATA;

static MICO_Octet* MICO_alloc (ULong sz);
static MICO_Octet* MICO_realloc (MICO_Octet*, ULong, ULong);
static void        MICO_free (MICO_Octet*);

/*****************************************************/

EIF_CHARACTER DEBUG_byte_to_char (EIF_INTEGER n)
{
    return (EIF_CHARACTER) n;
}
/*******************************************************/

/*
 * b should point to the C-area of an ARRAY [INTEGER].
 */

void DEBUG_dump_buffer (EIF_POINTER bp,
			EIF_POINTER b)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    int       i;

    for (i = 0; i < bd->len; i++)
        ((EIF_INTEGER*)b)[i] = (EIF_INTEGER) bd->buf[i];
}
/*****************************************************/

EIF_INTEGER DEBUG_buffer_len (EIF_POINTER bp)
{
    return (EIF_INTEGER) ((BUF_DATA*) bp)->len;
}
/*****************************************************/

char* BUFFER_inbuf (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (char*) &(bd->buf[bd->wptr]);
}
/*****************************************************/

char* BUFFER_outbuf (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (char*) &(bd->buf[bd->rptr]);
}
/*****************************************************/

EIF_POINTER MICO_buffer_init (EIF_INTEGER size)
{
    BUF_DATA* bd = (BUF_DATA*) malloc (sizeof(BUF_DATA));
    ULong     sz = (ULong) size;

    if (!bd)
        return (EIF_POINTER)0;

    if (sz < MINSIZE)
        sz = MINSIZE;

    bd->buf = MICO_alloc (sz);
    bd->len = sz;
    bd->rptr = bd->wptr = 0;
    bd->ralignbase = bd->walignbase = 0;
    return (EIF_POINTER) bd;
}
/*****************************************************/

void MICO_buffer_delete (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    if (bd->buf)
        MICO_free (bd->buf);

    free ((void*) bp);
}
/*****************************************************/

static MICO_Octet* MICO_alloc (ULong sz)
{
    MICO_Octet* p = (MICO_Octet*) malloc (sz);

    return p;
}
/*****************************************************/

static MICO_Octet* MICO_realloc (MICO_Octet* b, ULong osz, ULong nsz)
{
    MICO_Octet* p = (MICO_Octet*) realloc ((void*)b, nsz);

    return p;
}
/*****************************************************/

static void MICO_free (MICO_Octet* b)
{
    free ((void*)b);
}
/*****************************************************/

void MICO_reset (EIF_POINTER bp, EIF_INTEGER size)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     sz = (ULong) size;

    bd->ralignbase = bd->walignbase = 0;

    bd->wptr = 0;
    bd->rptr = 0;
    if (sz < MINSIZE)
        sz = MINSIZE;
    if (bd->len > sz)
    {
        MICO_free (bd->buf);
        bd->buf = MICO_alloc (sz);
        bd->len = sz;
    }
}
/*****************************************************/

static int LOCAL_resize (BUF_DATA* bd, EIF_INTEGER need)
{
    ULong     needed = (ULong) need;
    ULong     nlen;

    if (bd->wptr + needed > bd->len)
    {
        nlen = (bd->len < RESIZE_THRESH)
	  ? (2*(bd->len)) : (bd->len + RESIZE_INCREMENT);
        if (bd->wptr + needed > nlen)
             nlen = bd->wptr + needed;
        bd->buf = MICO_realloc (bd->buf, bd->len, nlen);

        if (!bd->buf)
            return -1;

        bd->len = nlen;
    }
    return 0;
}
/*****************************************************/

EIF_BOOLEAN MICO_resize (EIF_POINTER bp, EIF_INTEGER need)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (LOCAL_resize (bd, need) == 0) ? (EIF_BOOLEAN)1 : (EIF_BOOLEAN)0;
}
/*****************************************************/

void MICO_set_ralign_base (EIF_POINTER bp,
                           EIF_INTEGER base)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    bd->ralignbase = (ULong) base;
}
/*****************************************************/

void MICO_set_walign_base (EIF_POINTER bp,
                           EIF_INTEGER base)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    bd->walignbase = (ULong) base;
}
/*****************************************************/

EIF_BOOLEAN MICO_ralign (EIF_POINTER bp, EIF_INTEGER modulus)
{
    BUF_DATA* bd     = (BUF_DATA*) bp;
    ULong     modulo = (ULong) modulus;
    ULong     r      = (bd->rptr - bd->ralignbase) + modulo - 1;

    r -= r % modulo;
    r += bd->ralignbase;

    if (r > bd->wptr)
        return (EIF_BOOLEAN) FALSE;
     bd->rptr = r;
     return (EIF_BOOLEAN) TRUE;
}   
/*****************************************************/

/*
 * b should point to the C-area of an ARRAY [INTEGER].
 */

EIF_INTEGER MICO_peek (EIF_POINTER bp,
                       EIF_POINTER b,
                       EIF_INTEGER bcnt)
{
    BUF_DATA* bd   = (BUF_DATA*) bp;
    ULong     blen = (ULong) bcnt;
    int       i;

    if (bd->wptr - bd->rptr < blen)
        blen = bd->wptr - bd->rptr;
    for (i = 0; i < blen; ++i)
        ((EIF_INTEGER*)b)[i] = (EIF_INTEGER) bd->buf[bd->rptr + i];
    return (EIF_INTEGER) blen;
}
/*****************************************************/

EIF_BOOLEAN MICO_peek_one_octet (EIF_POINTER bp, EIF_POINTER op)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    if (bd->wptr <= bd->rptr)
        return (EIF_BOOLEAN) FALSE;
    *((EIF_INTEGER*)op) = (EIF_INTEGER) bd->buf[bd->rptr];
        return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/
/* NOTE: get1 is identical with get */

EIF_BOOLEAN MICO_get (EIF_POINTER bp, EIF_POINTER op)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_Octet o;
    if (bd->wptr <= bd->rptr)
        return (EIF_BOOLEAN) FALSE;
    o = bd->buf[bd->rptr++];
    *((EIF_INTEGER*)op) = (EIF_INTEGER)o;
    return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/

static Boolean MICO_get_untyped (BUF_DATA* bd, char* b, ULong l)
{
    if (bd->wptr - bd->rptr < l)
        return FALSE;
    memcpy (b, (char*) &(bd->buf[bd->rptr]), (int)l);
    bd->rptr += l;
    return TRUE;
}
/*****************************************************/

/*
 * This function differs from get_untyped in that
 * it checks for alignment on a two byte boundary
 * and copies two bytes.
 */

static Boolean MICO_get_untyped2 (BUF_DATA* bd, char* b)
{
    ULong     r  = ((bd->rptr - bd->ralignbase + 1) & ~1L) +
                      bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return FALSE;

    if (bd->wptr - r < 2)
        return FALSE;
    bd->rptr = r;
    memcpy (b, (char*) &(bd->buf[bd->rptr]), 2);
    bd->rptr += 2;
    return TRUE;
}
/*****************************************************/

/*
 * This function differs from get_untyped in that
 * it checks for alignment on a four byte boundary
 * and copies four bytes.
 */

static Boolean MICO_get_untyped4 (BUF_DATA* bd, char* b)
{
    ULong r;

    r  = ((bd->rptr - bd->ralignbase + 3) & ~3L) +
                        bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return FALSE;

    if (bd->wptr - r < 4)
        return FALSE;
    bd->rptr = r;

    memcpy (b, (char*) &(bd->buf[bd->rptr]), 4);
    bd->rptr += 4;
    return TRUE;
}
/*****************************************************/

/*
 * This function differs from get_untyped in that
 * it checks for alignment on an eight byte boundary
 * and copies eight bytes.
 */

static Boolean MICO_get_untyped8 (BUF_DATA* bd, char* b)
{
    ULong     r  = ((bd->rptr - bd->ralignbase + 7) & ~7L) +
                     bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return FALSE;

    if (bd->wptr - r < 8)
        return FALSE;
    bd->rptr = r;
    memcpy (b, (char*) &(bd->buf[bd->rptr]), 8);
    bd->rptr += 8;
    return TRUE;
}
/*****************************************************/

/*
 * This function differs from get_untyped in that
 * it checks for alignment on an eight byte boundary
 * and copies sixteen bytes.
 */

static Boolean MICO_get_untyped16 (BUF_DATA* bd, char* b)
{
    ULong     r  = ((bd->rptr - bd->ralignbase + 7) & ~7L) +
                       bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return FALSE;

    if (bd->wptr - r < 16)
        return FALSE;
    bd->rptr = r;
    memcpy (b, (char*) &(bd->buf[bd->rptr]), 16);
    bd->rptr += 16;
    return TRUE;
}
/*****************************************************/
/*
 * sp should point to an INTEGER.
 */

EIF_BOOLEAN MICO_get_short (EIF_POINTER bp, EIF_POINTER sp)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_Short s = (MICO_Short)0;
    Boolean    res;

    res = MICO_get_untyped2 (bd, (char*)&s);
    *((EIF_INTEGER*)sp) = (EIF_INTEGER) s;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * sp should point to an INTEGER.
 */

EIF_BOOLEAN MICO_get_ushort (EIF_POINTER bp, EIF_POINTER sp)
{
    BUF_DATA*   bd = (BUF_DATA*) bp;
    MICO_UShort s = (MICO_UShort)0;
    Boolean     res;

    res = MICO_get_untyped2 (bd, (char*)&s);
    *((EIF_INTEGER*)sp) = (EIF_INTEGER) s;

    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * lp should point to an INTEGER.
 */

EIF_BOOLEAN MICO_get_long (EIF_POINTER bp, EIF_POINTER lp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    MICO_Long l = (MICO_Long)0;
    Boolean   res;

    res = MICO_get_untyped4 (bd, (char*)&l);

    *((EIF_INTEGER*)lp) = (EIF_INTEGER) l;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * lp should point to an INTEGER.
 */

EIF_BOOLEAN MICO_get_ulong (EIF_POINTER bp, EIF_POINTER lp)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_ULong l = (MICO_ULong)0;
    Boolean    res;

    res = MICO_get_untyped4 (bd, (char*)&l);

    *((EIF_INTEGER*)lp) = (EIF_INTEGER) l;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * fp should point to a DOUBLE.
 */

EIF_BOOLEAN MICO_get_float (EIF_POINTER bp, EIF_POINTER fp)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_Float f = (MICO_Float)0;
    Boolean    res;

    res = MICO_get_untyped4 (bd, (char*)&f);

    *((EIF_DOUBLE*)fp) = (EIF_DOUBLE) f;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * dp should point to a DOUBLE.
 */

EIF_BOOLEAN MICO_get_double (EIF_POINTER bp, EIF_POINTER dp)
{
    BUF_DATA*   bd = (BUF_DATA*) bp;
    MICO_Double d = (MICO_Double)0;
    Boolean     res;

    res = MICO_get_untyped8 (bd, (char*)&d);

    *((EIF_DOUBLE*)dp) = (EIF_DOUBLE) d;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * cp should point to a CHARACTER.
 */

EIF_BOOLEAN MICO_get_char (EIF_POINTER bp, EIF_POINTER cp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    MICO_Char c = (MICO_Char)0;
    Boolean   res;

    res = MICO_get_untyped (bd, &c, sizeof (MICO_Char));
    *((EIF_CHARACTER*)cp) = (EIF_CHARACTER) c;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * cp should point to a CHARACTER.
 */

EIF_BOOLEAN MICO_get_wchar (EIF_POINTER bp, EIF_POINTER cp)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_WChar c = (MICO_WChar)0;
    Boolean    res;

    res = MICO_get_untyped (bd, (char*)&c, sizeof (MICO_WChar));
    *((EIF_CHARACTER*)cp) = (EIF_CHARACTER) c;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * bop should point to a BOOLEAN.
 */

EIF_BOOLEAN MICO_get_boolean (EIF_POINTER bp, EIF_POINTER bop)
{
    BUF_DATA*    bd = (BUF_DATA*) bp;
    MICO_Boolean b = (MICO_Boolean)0;
    Boolean      res;

    res = MICO_get_untyped (bd, (char*)&b, sizeof (MICO_Boolean));
    *((EIF_BOOLEAN*)bop) = (EIF_BOOLEAN) ((b) ? 1 : 0);
    return (EIF_BOOLEAN) res;
}
/*****************************************************/
/*
 * sp should point to a POINTER.
 */

EIF_BOOLEAN MICO_get_string (EIF_POINTER bp,
                             EIF_POINTER sp,
                             EIF_INTEGER len)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    Boolean   res;
    
    charbuf = malloc ((int)len + 1);

    if (!charbuf)
        return (EIF_BOOLEAN) FALSE;

    res     = MICO_get_untyped (bd, charbuf, (int)len);
    /* OMG document says nothing about a terminating '\0'. */
    charbuf[len] = '\0';
    *((EIF_POINTER*)sp) = (EIF_POINTER) charbuf;
    return (EIF_BOOLEAN) res;
}
/*****************************************************/

/* p should point to the C-area of an ARRAY [INTEGER] */

EIF_BOOLEAN MICO_get2 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     r  = ((bd->rptr - bd->ralignbase + 1) & ~1L) +
                      bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return (EIF_BOOLEAN) FALSE;

    if (r + 2 > bd->wptr)
        return (EIF_BOOLEAN) FALSE;
    
    bd->rptr = r;
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/

/* p should point to the C-area of an ARRAY [INTEGER] */

EIF_BOOLEAN MICO_get4 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     r  = ((bd->rptr - bd->ralignbase + 3) & ~3L) +
                        bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return (EIF_BOOLEAN) FALSE;

    if (r + 4 > bd->wptr)
        return (EIF_BOOLEAN) FALSE;
    
    bd->rptr = r;
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/

/* p should point to the C-area of an ARRAY [INTEGER] */

EIF_BOOLEAN MICO_get8 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     r  = ((bd->rptr - bd->ralignbase + 7) & ~7L) +
                     bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return (EIF_BOOLEAN) FALSE;

    if (r + 8 > bd->wptr)
        return (EIF_BOOLEAN) FALSE;
    
    bd->rptr = r;
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/
/*
 * Get 16 bytes with 8 byte alignment
 * p should point to the C-area of an ARRAY [INTEGER]. 
 */

EIF_BOOLEAN MICO_get16 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     r  = ((bd->rptr - bd->ralignbase + 7) & ~7L) +
                       bd->ralignbase;
    if (bd->rptr < bd->ralignbase)
        return (EIF_BOOLEAN) FALSE;

    if (r + 16 > bd->wptr)
        return (EIF_BOOLEAN) FALSE;
    
    bd->rptr = r;
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    *((EIF_INTEGER*)p)++ = (EIF_INTEGER) bd->buf[bd->rptr++];
    return (EIF_BOOLEAN) TRUE;
}
/*****************************************************/

void MICO_walign (EIF_POINTER bp, EIF_INTEGER modulus)
{
    BUF_DATA* bd     = (BUF_DATA*) bp;
    ULong     modulo = (ULong) modulus;
    ULong     w      = (bd->wptr - bd->walignbase) + modulo - 1;
    w -= w % modulo;
    w += bd->walignbase;
    LOCAL_resize (bd, w - bd->wptr);
    while (bd->wptr < w)
         bd->buf[bd->wptr++] = 0;
}
/*****************************************************/

/*
 * op should point to the C-area of an ARRAY [INTEGER].
 */

void MICO_replace (EIF_POINTER bp,
                   EIF_POINTER op,
                   EIF_INTEGER bleng)
{
    BUF_DATA* bd   = (BUF_DATA*) bp;
    ULong     blen = (ULong) bleng;
    int       i;

    MICO_reset (bp, bleng);
    for (i = 0; i < (int)blen; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) ((EIF_INTEGER*) op)[i];
}
/*****************************************************/

void MICO_replace_one_octet (EIF_POINTER bp, EIF_INTEGER o)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    MICO_reset (bp, 1);
    bd->buf[bd->wptr++] = (MICO_Octet) o;
}
/*****************************************************/

/*
 * o can be a C-pointer to anything.
 */

static void MICO_put_untyped (BUF_DATA* bd, char* o, ULong l)
{
    int   i;

    if (bd->wptr + l > bd->len)
        LOCAL_resize (bd, l);

    for (i = 0; i < l; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) o[i];
}
/*****************************************************/

/*
 * o can be a C-pointer to anything.
 * This function differs from put_untyped in that it
 * aligns on a two byte boundary and copies two bytes.
 */

static void MICO_put_untyped2 (BUF_DATA* bd, char* o)
{
    int   i;
    ULong     w  = ((bd->wptr - bd->walignbase + 1) & ~1L) +
                      bd->walignbase;
    if (w + 2 > bd->len)
        LOCAL_resize (bd, w + 2 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    for (i = 0; i < 2; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) o[i];
}
/*****************************************************/

/*
 * o can be a C-pointer to anything.
 * This function differs from put_untyped in that it
 * aligns on a four byte boundary and copies four bytes.
 */

static void MICO_put_untyped4 (BUF_DATA* bd, char* o)
{
    int   i;
    ULong w;

    w  = ((bd->wptr - bd->walignbase + 3) & ~3L) +
                      bd->walignbase;
    if (w + 4 > bd->len)
        LOCAL_resize (bd, w + 4 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    for (i = 0; i < 4; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) o[i];
}
/*****************************************************/

/*
 * o can be a C-pointer to anything.
 * This function differs from put_untyped in that it
 * aligns on an eight byte boundary and copies eight bytes.
 */

static void MICO_put_untyped8 (BUF_DATA* bd, char* o)
{
    int   i;
    ULong     w  = ((bd->wptr - bd->walignbase + 7) & ~7L) +
                      bd->walignbase;
    if (w + 8 > bd->len)
        LOCAL_resize (bd, w + 8 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    for (i = 0; i < 8; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) o[i];
}
/*****************************************************/

/*
 * o can be a C-pointer to anything.
 * This function differs from put_untyped in that it
 * aligns on an eight byte boundary and copies sixteen bytes.
 */

static void MICO_put_untyped16 (BUF_DATA* bd, char* o)
{
    int   i;
    ULong     w  = ((bd->wptr - bd->walignbase + 7) & ~7L) +
                       bd->walignbase;
    if (w + 16 > bd->len)
        LOCAL_resize (bd, w + 16 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    for (i = 0; i < 16; ++i)
        bd->buf[bd->wptr++] = (MICO_Octet) o[i];
}
/*****************************************************/

void MICO_put_short (EIF_POINTER bp, EIF_INTEGER n)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    short     s  = (short)n;

    MICO_put_untyped2 (bd, (char*)&s);
}
/*****************************************************/

void MICO_put_ushort (EIF_POINTER bp, EIF_INTEGER n)
{
   BUF_DATA*      bd = (BUF_DATA*) bp;
   unsigned short us = (unsigned short) n;
   
    MICO_put_untyped2 (bd, (char*)&us);
}
/*****************************************************/

void MICO_put_long (EIF_POINTER bp, EIF_INTEGER n)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    MICO_Long l  = (MICO_Long) n;

    MICO_put_untyped4 (bd, (char*)&l);
}
/*****************************************************/

void MICO_put_ulong (EIF_POINTER bp, EIF_INTEGER n)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_ULong ul = (MICO_ULong) n;

    MICO_put_untyped4 (bd, (char*)&ul);
}
/*****************************************************/

void MICO_put_float (EIF_POINTER bp, EIF_DOUBLE d)
{
    BUF_DATA*  bd = (BUF_DATA*) bp;
    MICO_Float f  = (MICO_Float) d;

    MICO_put_untyped4 (bd, (char*)&f);
}
/*****************************************************/

void MICO_put_double (EIF_POINTER bp, EIF_DOUBLE d)
{
    BUF_DATA*   bd = (BUF_DATA*) bp;
    MICO_Double dd = (MICO_Double) d;

    MICO_put_untyped8 (bd, (char*)&dd);
}
/*****************************************************/

void MICO_put_char (EIF_POINTER bp, EIF_CHARACTER c)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    char      cc = (char) c;

    MICO_put_untyped (bd, &cc, sizeof (char));
}
/*****************************************************/
/*
 * At the moment this is identical to put_char.
 * but maybe some day ...
 */
void MICO_put_wchar (EIF_POINTER bp, EIF_CHARACTER c)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    char      cc = (char) c;

    MICO_put_untyped (bd, &cc, sizeof (char));
}
/*****************************************************/

void MICO_put_boolean (EIF_POINTER bp, EIF_BOOLEAN b)
{
    BUF_DATA*    bd = (BUF_DATA*) bp;
    MICO_Boolean bb = (MICO_Boolean) b;

    MICO_put_untyped (bd, (char*)&bb, sizeof (MICO_Boolean));
}
/*****************************************************/

void MICO_put_string (EIF_POINTER bp,
                      EIF_POINTER sp,
                      EIF_INTEGER len)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    MICO_put_untyped (bd, (char*)sp, (int)len);
    /* OMG document says nothing about terminating '\0'. */
}
/*****************************************************/

void MICO_put_one_octet (EIF_POINTER bp,
                         EIF_INTEGER o)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    if (bd->wptr + 1 > bd->len)
        LOCAL_resize (bd, 1);

    bd->buf[bd->wptr++] = (MICO_Octet) o;
}
/*****************************************************/

/*
 * p should point to an INTEGER.
 */

void MICO_put1 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    if (bd->wptr + 1 > bd->len)
        LOCAL_resize (bd, 1);

    bd->buf[bd->wptr++] = *(MICO_Octet*)p;
}
/*****************************************************/

/*
 * p should point to the C-area of an ARRAY [INTEGER]
 */

void MICO_put2 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     w  = ((bd->wptr - bd->walignbase + 1) & ~1L) +
                      bd->walignbase;
    if (w + 2 > bd->len)
        LOCAL_resize (bd, w + 2 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
}
/*****************************************************/

/*
 * p should point to the C-area of an ARRAY [INTEGER]
 */

void MICO_put4 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     w  = ((bd->wptr - bd->walignbase + 3) & ~3L) +
                      bd->walignbase;
    if (w + 4 > bd->len)
        LOCAL_resize (bd, w + 4 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
}
/*****************************************************/

/*
 * p should point to the C-area of an ARRAY [INTEGER]
 */

void MICO_put8 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     w  = ((bd->wptr - bd->walignbase + 7) & ~7L) +
                      bd->walignbase;
    if (w + 8 > bd->len)
        LOCAL_resize (bd, w + 8 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
}
/*****************************************************/

/*
 * put 16 bytes with 8 byte alignment.
 * p should point to the C-area of an ARRAY [INTEGER]
 */

void MICO_put16 (EIF_POINTER bp, EIF_POINTER p)
{
    BUF_DATA* bd = (BUF_DATA*) bp;
    ULong     w  = ((bd->wptr - bd->walignbase + 7) & ~7L) +
                       bd->walignbase;
    if (w + 16 > bd->len)
        LOCAL_resize (bd, w + 16 - bd->wptr);
    while (bd->wptr < w)
        bd->buf[bd->wptr++] = 0;

    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
    bd->buf[bd->wptr++] = (MICO_Octet) *((EIF_INTEGER*)p)++;
}
/*****************************************************/

EIF_INTEGER MICO_length_unread (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (EIF_INTEGER) (bd->wptr - bd->rptr);
}
/*****************************************************/

EIF_INTEGER MICO_rpos (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (EIF_INTEGER) bd->rptr;
}
/*****************************************************/

EIF_INTEGER MICO_wpos (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (EIF_INTEGER) bd->wptr;
}
/*****************************************************/

EIF_INTEGER MICO_ralign_base (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (EIF_INTEGER) bd->ralignbase;
}
/*****************************************************/

EIF_INTEGER MICO_walign_base (EIF_POINTER bp)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    return (EIF_INTEGER) bd->walignbase;
}
/*****************************************************/

EIF_BOOLEAN MICO_rseek_beg (EIF_POINTER bp,
                            EIF_INTEGER off)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    if ((ULong) off > bd->wptr)
        return (EIF_BOOLEAN)0;
    else
    {
        bd->rptr = (ULong) off;
        return (EIF_BOOLEAN)1;
    }
}
/*****************************************************/

EIF_BOOLEAN MICO_rseek_rel (EIF_POINTER bp,
                            EIF_INTEGER off)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    if ((bd->rptr + (ULong)off) > bd->wptr)
        return (EIF_BOOLEAN)0;
    else
    {
        bd->rptr += (ULong) off;
        return (EIF_BOOLEAN)1;
    }
}
/*****************************************************/

void MICO_wseek_beg (EIF_POINTER bp,
                     EIF_INTEGER off)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    bd->wptr = (ULong) off;
}
/*****************************************************/

void MICO_wseek_rel (EIF_POINTER bp,
                     EIF_INTEGER off)
{
    BUF_DATA* bd = (BUF_DATA*) bp;

    bd->wptr += (ULong) off;
}
/*****************************************************/
        




