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
	bool_t (*id_fn)(IDR *, void *);	/* Function to call to serialize the union */
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

extern void idrmem_create(IDR *idrs, char *addr, int len, int i_op);	/* Initialize a memory IDR stream */
extern void idrmem_destroy(IDR *idrs);	/* Destruction of the memory IDR stream */
extern int idr_getpos(IDR *idrs);		/* Get position in stream */
extern int idr_size(IDR *idrs, int *lp, int maxlength);			/* Retrieve/store a size (variable length) */
extern bool_t idr_setpos(IDR *idrs, int pos);		/* Set position in stream */
extern bool_t idr_void(IDR *idrs, void *ext);		/* Always return TRUE */
extern bool_t idr_char(IDR *idrs, char *cp);		/* Encoding of a char */
extern bool_t idr_u_char(IDR *idrs, unsigned char *cp);		/* Encoding of an unsigned char */
extern bool_t idr_short(IDR *idrs, short int *sp);		/* Encoding of a short integer */
extern bool_t idr_u_short(IDR *idrs, short unsigned int *sp);		/* Encoding of an unsigned short */
extern bool_t idr_long(IDR *idrs, long int *lp);		/* Encoding of a long integer */
extern bool_t idr_u_long(IDR *idrs, long unsigned int *lp);		/* Encoding of an unsigned long */
extern bool_t idr_int(IDR *idrs, int *ip);		/* Encoding of an integer */
extern bool_t idr_u_int(IDR *idrs, unsigned int *ip);		/* Encoding of an unsigned integer */
extern bool_t idr_float(IDR *idrs, float *fp);		/* Encoding of a float */
extern bool_t idr_double(IDR *idrs, double *dp);		/* Encoding of a double */
extern bool_t idr_string(IDR *idrs, char **sp, int maxlen);	/* Encoding of a string */

extern bool_t idr_opaque(IDR *idrs, char *p, int len);		/* Opaque data transmission */
extern bool_t idr_vector(IDR *idrs, char *array, int size, int elemsize, bool_t (*idr_elem) (IDR *, void *));		/* Fixed size array */
extern bool_t idr_array(IDR *idrs, char **ap, int *lp, int maxlength, int elemsize, bool_t (*idr_elem) (IDR *, void *));		/* Variable size array */
extern bool_t idr_stack(IDR *idrs, char **ap, int size, int elemsize, bool_t (*idr_elem) (IDR *, void *));		/* Variable size stack (size not IDR'ed) */
extern bool_t idr_union(IDR *idrs, int *type, char *unp, struct idr_discrim *arms, bool_t (*dfltarm) (IDR *, void *));		/* Union encoding based on discriminent */
extern bool_t idr_poly(IDR *idrs, int type, char *unp, struct idr_discrim *arms, bool_t (*dfltarm) (IDR *, void *));		/* Polymorphic union encoding with known type */
extern bool_t idr_read(IDR *idrs, int fd, char *bp, bool_t (*idr_bp) (IDR *, void *));		/* Read data from file and deserialize them */
extern bool_t idr_write(IDR *idrs, int fd, char *bp, bool_t (*idr_bp) (IDR *, void *));		/* Write serialized data to file */

#endif

