/*

    #    #####   #####    ####           #    #
    #    #    #  #    #  #               #    #
    #    #    #  #    #   ####           ######
    #    #    #  #####        #   ###    #    #
    #    #    #  #   #   #    #   ###    #    #
    #    #####   #    #   ####    ###    #    #

	Internal data representation.

	This is the same as XDRs, but IDRs cannot deal with floating point
	numbers. However, the result is a more compact stream of data, since
	there is absolutely no padding on a 4 bytes boundary (which is why I
	ever had to bother with those, grrr--RAM).
*/

#ifndef _idrs_h_
#define _idrs_h_

#define IDR_ENCODE	0		/* Serialization */
#define IDR_DECODE	1		/* Deserialization */

/* Constants definitions for IDR routines */
#ifndef bool_t
#define bool_t	int
#endif
#ifndef FALSE
#define FALSE	0
#endif
#ifndef TRUE
#define TRUE	1
#endif
#ifndef __dontcare__
#define __dontcare__	-1
#endif
#ifndef NULL
#define NULL	0
#endif

typedef struct idr {
	int i_op;			/* Type of operation */
	int i_size;			/* Size of buffer */
	char *i_buf;		/* Buffer where serialized data are stored */
	char *i_ptr;		/* Pointer into the serialized data */
} IDR;

struct idr_discrim {	/* Discrimination array for unions encoding */
	int id_value;		/* Value of union discriminent */
	bool_t (*id_fn)();	/* Function to call to serialize the union */
};

/*
 * User informations on the IDR streams.
 */

#define idrs_size(i)	((i)->i_size)
#define idrs_buf(i)		((i)->i_buf)
#define idrs_op(i)		((i)->i_op)

/*
 * IDR entry points
 */

extern void idrmem_create();	/* Initialize a memory IDR stream */
extern void idrmem_destroy();	/* Destruction of the memory IDR stream */
extern int idr_getpos();		/* Get position in stream */
extern int idr_size();			/* Retrieve/store a size (variable length) */
extern bool_t idr_setpos();		/* Set position in stream */
extern bool_t idr_void();		/* Always return TRUE */
extern bool_t idr_char();		/* Encoding of a char */
extern bool_t idr_uchar();		/* Encoding of an unsigned char */
extern bool_t idr_short();		/* Encoding of a short integer */
extern bool_t idr_ushort();		/* Encoding of an unsigned short */
extern bool_t idr_long();		/* Encoding of a long integer */
extern bool_t idr_ulong();		/* Encoding of an unsigned long */
extern bool_t idr_int();		/* Encoding of an integer */
extern bool_t idr_uint();		/* Encoding of an unsigned integer */
extern bool_t idr_float();		/* Encoding of a float */
extern bool_t idr_double();		/* Encoding of a double */
extern bool_t idr_opaque();		/* Opaque data transmission */
extern bool_t idr_vector();		/* Fixed size array */
extern bool_t idr_array();		/* Variable size array */
extern bool_t idr_stack();		/* Variable size stack (size not IDR'ed) */
extern bool_t idr_union();		/* Union encoding based on discriminent */
extern bool_t idr_poly();		/* Polymorphic union encoding with known type */
extern bool_t idr_read();		/* Read data from file and deserialize them */
extern bool_t idr_write();		/* Write serialized data to file */

#endif

