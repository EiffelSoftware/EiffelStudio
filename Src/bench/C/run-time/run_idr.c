/*

    #    #####   #####           #####   #    #  #    #          ####
    #    #    #  #    #          #    #  #    #  ##   #         #    #
    #    #    #  #    #          #    #  #    #  # #  #         #
    #    #    #  #####           #####   #    #  #  # #  ###    #
    #    #    #  #   #           #   #   #    #  #   ##  ###    #    #
    #    #####   #    # #######  #    #   ####   #    #  ###     ####

	Internal data representation.

*/

#include "eif_portable.h"
#ifdef VXWORKS
#include <string.h>	/* For memcpy */
#endif

#include <stdio.h>
#include <sys/types.h>
#ifdef I_NETINET_IN
#include <netinet/in.h>
#else
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#endif
#include "eif_globals.h"
#include "eif_store.h"	/* For rt_kind_version */
#include "eif_retrieve.h"	/* For char_read_func */
#include "eif_eiffel.h"
#include "eif_bits.h"
#include "eif_err_msg.h"
#if !defined(CUSTOM) || defined(NEED_RETRIEVE_H)
#include "eif_retrieve.h"
#endif
#if !defined(CUSTOM) || defined(NEED_STORE_H)
#include "eif_store.h"
#endif
#include "eif_error.h"
#include "eif_run_idr.h"
#include "../idrs/idrf.h"
#ifdef EIF_OS2
#include <io.h>
#endif
#include "eif_size.h"	/* Needed for DBLSIZ */
#include "rt_malloc.h"


rt_shared char *idr_temp_buf;	/* This is shared so it can be freed
							 * if an exception occurs. */

/* Private Data */
rt_private int amount_read = 0;	/* Amount read into buffer (see check_capacity) */
rt_private long idrf_buffer_size = 262144L; /* Size of the IDRF buffer, set by `run_idr_init' */
rt_private IDRF idrf;

/* Private functions */
rt_private int (*run_idr_read_func) (IDR *bu);	/* `run_idr_read' function. This can be different
											 * depending on which version of INDEPENDENT_STORE
											 * we are using. The old one is based on `short'
											 * the new one on `long' */
rt_private int run_idr_read (IDR *bu);
rt_private void old_ridr_multi_int (long int *obj, int num);
rt_private void old_widr_multi_int (long int *obj, int num);

rt_public bool_t run_idr_setpos(IDR *idrs, int pos)
{
	/* Set the position of the stream to pos and return true if it is possible,
	 * false otherwise.
	 */

	if (pos >= idrs->i_size || pos < 0)
		return FALSE;
	
	idrs->i_ptr = idrs->i_buf + pos;
	return TRUE;
}

rt_public void run_mem_destroy(IDR *idrs)
{
	/* Release the memory used by the IDR stream */

	idrs->i_size = 0;
	if (idrs->i_buf != (char *) 0) {
		xfree(idrs->i_buf);
		idrs->i_buf = idrs->i_ptr = (char *) 0;
	}
}

rt_public void run_idrmem_create(IDR *idrs, char *addr, int len, int i_op)
          			/* The IDR structure managing the stream */
           			/* Address of the serializing buffer */
        			/* Length of the serializing buffer */
         			/* Operation wanted */
{
	/* Initialize a memory stream, where the (de)serialization is done in the
	 * provided buffer pointed to by addr.
	 */

	idrs->i_op = i_op;
	idrs->i_size = len;
	idrs->i_buf = addr;
	idrs->i_ptr = addr;
}


rt_public int run_idrf_create(int size)
         		/* Size of IDR buffers */
{
	/* Initializes memory for IDR operations. We create memory streams for
	 * input and output. Thus, all the input requests will have the same length,
	 * regardless of their type. The same applies for output request, although
	 * the size may not be the same. Return 0 if ok, -1 for failure.
	 */
	
	char *out_addr;			/* IDR output data buffer */
	char *in_addr;			/* IDR input data buffer */

	/* Create input IDR memory stream (decode mode) */
	if ((char *) 0 == (in_addr = (char *) xmalloc(size, C_T, GC_OFF)))
		return -1;

	/* Create output IDR memory stream (encode mode) */
	if ((char *) 0 == (out_addr = (char *) xmalloc(size, C_T, GC_OFF))) {
		xfree(in_addr);
		return -1;
	}

	run_idrmem_create(&idrf.i_decode, in_addr, size, IDR_DECODE);
	run_idrmem_create(&idrf.i_encode, out_addr, size, IDR_ENCODE);
	return 0;
}


rt_public void run_idr_init (long idrf_size, int type)
{
	idrf_buffer_size = idrf_size;

	run_idr_read_func = run_idr_read;

	if (-1 == run_idrf_create (idrf_size))
		eraise ("cannot allocate idrf", EN_MEM);

		/* Reset amount_read */
	amount_read = 0;

		/* When writting a storable we mark some space at the front of the buffer
		 * to store upon writting the size of block, so that only one write operation
		 * is performed */
	if (type)
		run_idr_setpos (&idrf.i_encode, sizeof(int32));
}

rt_public void run_idr_destroy (void)
{
	run_mem_destroy(&idrf.i_encode);
	run_mem_destroy(&idrf.i_decode);
}

rt_private int run_idr_read (IDR *bu)
{
	register char * ptr = bu->i_buf;
	int32 read_size;
	long amount_left;
	register int part_read;
	register int total_read = 0;

	if ((char_read_func ((char *)(&read_size), sizeof (int32))) < sizeof (int32))
		eise_io("Independent retrieve: unable to read buffer size.");

	read_size = ntohl (read_size);
#ifdef DEBUG
	if (read_size > idrs_size (bu))
		print_err_msg(stderr, "Too large %d info for %d buffer\n", read_size, idrs_size (bu));
#endif

	amount_left = read_size;
	while (total_read < read_size) {
		if ((part_read = char_read_func (ptr, amount_left)) < 0)
			eio();
		total_read += part_read;
		ptr += part_read;
		amount_left -= part_read;
		}
	return total_read;
}

rt_private void run_idr_write (IDR *bu)
{
	register char * ptr = idrs_buf (bu);
	int32 host_send, send_size = (int32) (bu->i_ptr - ptr);
	register int number_writen;

#ifdef DEBUG
	if (send_size == 0)
		print_err_msg(stderr, "send size equal zero");
#endif

	host_send = htonl (send_size - sizeof(int32));
	memcpy (ptr, &host_send, sizeof(int32));

	while (send_size > 0) {
		if ((number_writen = char_write_func (ptr, (int) send_size)) <= 0)
			eio();
		send_size -= number_writen;
		ptr += number_writen;
		}
}

rt_public void check_capacity (IDR *bu, int size)
{
	if (idrs_op (bu)) {
		if ((bu->i_ptr + size) > (bu->i_buf + amount_read)) {
			amount_read = run_idr_read_func (bu);
			(void) run_idr_setpos (bu, 0);
		}
	} else {
		if ((bu->i_ptr + size) > (bu->i_buf + bu->i_size)) {
			run_idr_write (bu);
			(void) run_idr_setpos (bu, sizeof(int32));
		}
	}
}

rt_public void idr_flush (void)
{
	check_capacity (&idrf.i_encode, idrf_buffer_size);
}

rt_public bool_t run_long(IDR *idrs, long int *lp, int len, int size)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * size);

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
#if LNGSIZ == 4
					/*encode for long = 4 bytes */
			value = htonl((uint32)(*(lp + (i++))));
			memcpy (idrs->i_ptr, &value, size);
			idrs->i_ptr += size;
#else
							/*encode for long = 8bytes */
			uint32 upper, lower;
			unsigned long temp;
		
			temp = (unsigned long) *(lp + (i++));	/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & 0x00000000ffffffff);
			upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
			value = htonl((uint32)(lower));
			memcpy(idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			memcpy (idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;

#endif
		}
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			while (len > i) {
				memcpy (&value, idrs->i_ptr, size);
#if LNGSIZ > 4
				*(lp + i) = (long) ntohl(value);
				idrs->i_ptr += size;
				if (*(lp + i) & 0x80000000) {
					*(lp + i) &= 0xffffffff7fffffff;
					*(lp + (i++)) |= 0x8000000000000000;
				}
				else
					i++;
#else
				*(lp + (i++)) = (long) ntohl(value);
				idrs->i_ptr += size;
#endif
			}
		} else {				/*decode an 8 byte long */
			while (len > i) {
				long upper, lower; /* %%ss removed , temp;*/

				memcpy (&value, idrs->i_ptr, 4);
				lower = (long) ntohl(value);
				idrs->i_ptr += 4;
				memcpy (&value, idrs->i_ptr, 4);
				upper = (long) ntohl(value);
				idrs->i_ptr += 4;
#if PTRSIZ == 4
						/*if the data has come from a 8 byte */
				*(lp + i) = lower;		/* long machine and we are only a 4 byte*/
				if (upper & 0x80000000){
					if (lower & 0x80000000)
						print_err_msg(stderr, "64 bit int truncated to 32 bit \n");
					*(lp + (i++)) |= 0x80000000;
				} else {
					i++;
					if (upper)
						print_err_msg(stderr, "64 bit int truncated to 32 bit \n");
				}
							/*long machine only take the lower 4 bytes*/
							/* This will cause lost of data but l am */
						/* assuming we do not send any longs between*/
						/* 64 bit to 32 bit that are larger than 2^32 */

#else
						/* rejoin the upper and lower parts */ 

				*(lp + (i++)) = (lower & 0x00000000ffffffff) | (upper << 32);
#endif
			}
		}
	}
	return TRUE;
}

rt_public bool_t run_ulong(IDR *idrs, long unsigned int *lp, int len, int size)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * size);

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
#if LNGSIZ == 4
					/*encode for long = 4 bytes */
			value = htonl((uint32)(*(lp + (i++))));
			memcpy (idrs->i_ptr, &value, size);
			idrs->i_ptr += size;
#else
							/*encode for long = 8bytes */
			uint32 upper, lower;
			unsigned long temp;
		
			temp = *(lp + (i++));		/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & 0x00000000ffffffff);
			upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
			value = htonl((uint32)(lower));
			memcpy (idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			memcpy (idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;
#endif
		}
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			while (len > i) {
				memcpy (&value, idrs->i_ptr, size);
				*(lp + (i++)) = (unsigned long) ntohl(value);
				idrs->i_ptr += size;
			}
		} else {						/*decode an 8 byte long */
			while (len > i) {
				uint32 lower, upper;
				memcpy (&lower, idrs->i_ptr, 4);
				idrs->i_ptr += 4;
				memcpy (&upper, idrs->i_ptr, 4);
				idrs->i_ptr += 4;
#if LNGSIZ == 4
						/*if the data has come from a 8 byte */
				*(lp + (i++)) = (unsigned long) ntohl(lower);		/* long machine and we are only a 4 byte*/
						/*long machine only take the lower 4 bytes*/
						/* This will cause lost of data but l am */
						/* assuming we do not send any longs between*/
						/* 64 bit to 32 bit that are larger than 2^32 */
#else
						/* rejoin the upper and lower parts */ 

				*(lp + (i++)) = (((unsigned long) ntohl(lower)) & 0x00000000ffffffff) | 
								(((unsigned long) ntohl(upper)) << 32);
#endif
			}
		}
	}
	return TRUE;
}

rt_public bool_t run_int(IDR *idrs, uint32 *ip, int len)
{
	/* Serialize a int byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * sizeof (uint32));

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
			value = htonl(*(ip + (i++)));
			memcpy (idrs->i_ptr, &value, sizeof (uint32));
			idrs->i_ptr += sizeof (uint32);
		}
	} else {
		while (len > i) {
			memcpy (&value, idrs->i_ptr, sizeof (uint32));
			*(ip + (i++)) = ntohl(value);
			idrs->i_ptr += sizeof (uint32);
		}
	}
	return TRUE;
}


rt_public void ridr_multi_char (EIF_CHARACTER *obj, int num)
{
	int cap = idrf_buffer_size / sizeof (EIF_CHARACTER);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_decode, num);
		memcpy (obj, idrf.i_decode.i_ptr, num);
		idrf.i_decode.i_ptr += num;
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			check_capacity (&idrf.i_decode, cap);
            memcpy  (obj,idrf.i_decode.i_ptr, cap);
			obj += cap;
            idrf.i_decode.i_ptr += cap;
			count--;
		}
		check_capacity (&idrf.i_decode, left_over);
		memcpy (obj, idrf.i_decode.i_ptr, left_over);
		idrf.i_decode.i_ptr += left_over;
	}
}

rt_public void widr_multi_char (EIF_CHARACTER *obj, int num)
{
	int cap = idrf_buffer_size / sizeof (EIF_CHARACTER);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_encode, num);
		memcpy (idrf.i_encode.i_ptr, obj, num);
		idrf.i_encode.i_ptr += num;
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			check_capacity (&idrf.i_encode, cap);
			memcpy (idrf.i_encode.i_ptr, obj, cap);
			obj += cap;
			idrf.i_encode.i_ptr += cap;
			count--;
		}

		check_capacity (&idrf.i_encode, left_over);
		memcpy (idrf.i_encode.i_ptr, obj, left_over);
		idrf.i_encode.i_ptr += left_over;

	}
}


rt_public void ridr_multi_any (char *obj, int num)
{
	int cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	memcpy (&s, idrf.i_decode.i_ptr, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = idrf_buffer_size / s;

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, num, s);
	} else {
		int count = num / cap;
		int left_over = num % cap;
		long *lptr = (long *) obj;

		while (count) {
			run_ulong (&idrf.i_decode, (long unsigned int *) lptr, cap, s);
			lptr += cap;
			count--;
		}
		run_ulong (&idrf.i_decode, (long unsigned int *) lptr, left_over, s);
	}
}

rt_public void widr_multi_any (char *obj, int num)
{
	int cap = idrf_buffer_size / sizeof (char *);
	char s = (char) sizeof (char *);

	check_capacity (&idrf.i_encode, sizeof (char));
	memcpy (idrf.i_encode.i_ptr, &s, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, num, sizeof (char *));
	} else {
		int count = num / cap;
		int left_over = num % cap;
		long *lptr = (long *) obj;

		while (count) {
			run_ulong (&idrf.i_encode, (long unsigned int *) lptr, cap, sizeof (char *));
			lptr += cap;
			count--;
		}
		run_ulong (&idrf.i_encode, (long unsigned int *) lptr, left_over, sizeof (char *));
	}
}

rt_public void ridr_multi_int8 (EIF_INTEGER_8 *obj, int num)
{
	register int i = 0;

	while (num > i++) {
		check_capacity (&idrf.i_decode, CHRSIZ);
		memcpy (obj++, idrf.i_decode.i_ptr, CHRSIZ);
		idrf.i_decode.i_ptr += CHRSIZ;
	}
}

rt_public void widr_multi_int8 (EIF_INTEGER_8 *obj, int num)
{
	register int i = 0;

	while (num > i++) {
		check_capacity (&idrf.i_encode, CHRSIZ);
		memcpy  (idrf.i_encode.i_ptr, obj++, CHRSIZ);
		idrf.i_encode.i_ptr += CHRSIZ;
	}
}

rt_public void ridr_multi_int16 (EIF_INTEGER_16 *obj, int num)
{
	register int i = 0;
	EIF_INTEGER_16 value;

	while (num > i++) {
		check_capacity (&idrf.i_decode, I16SIZ);
		memcpy (&value, idrf.i_decode.i_ptr, I16SIZ);
		*obj++ = (EIF_INTEGER_16) ntohs(value);
		idrf.i_decode.i_ptr += I16SIZ;
	}
}

rt_public void widr_multi_int16 (EIF_INTEGER_16 *obj, int num)
{
	register int i = 0;
	EIF_INTEGER_16 value;

	while (num > i++) {
		check_capacity (&idrf.i_encode, I16SIZ);
		value = htons(*obj++);
		memcpy  (idrf.i_encode.i_ptr, &value, I16SIZ);
		idrf.i_encode.i_ptr += I16SIZ;
	}
}

rt_public void ridr_multi_int32 (EIF_INTEGER_32 *obj, int num)
{
	register int i = 0;

	if (rt_kind_version < INDEPENDENT_STORE_5_0) {
		old_ridr_multi_int ((long int *) obj, num);
	} else {
		EIF_INTEGER_32 value;

		while (num > i++) {
			check_capacity (&idrf.i_decode, LNGSIZ);
			memcpy (&value, idrf.i_decode.i_ptr, LNGSIZ);
			*obj++ = (EIF_INTEGER_32) ntohl(value);
			idrf.i_decode.i_ptr += LNGSIZ;
		}
	}
}

rt_public void widr_multi_int32 (EIF_INTEGER_32 *obj, int num)
{
	register int i = 0;

	if (rt_kind_version < INDEPENDENT_STORE_5_0) {
		old_widr_multi_int ((long int *) obj, num);	
	} else {
		EIF_INTEGER_32 value;

		while (num > i++) {
			check_capacity (&idrf.i_encode, LNGSIZ);
			value = htonl(*obj++);
			memcpy  (idrf.i_encode.i_ptr, &value, LNGSIZ);
			idrf.i_encode.i_ptr += LNGSIZ;
		}
	}
}

rt_public void ridr_multi_int64 (EIF_INTEGER_64 *obj, int num)
{
	register int i = 0;
	EIF_INTEGER_64 upper, lower;
	uint32 value;

	while (num > i++) {
		check_capacity (&idrf.i_decode, I64SIZ);
		memcpy (&value, idrf.i_decode.i_ptr, 4);
		lower = (EIF_INTEGER_64) ntohl(value);
		memcpy (&value, idrf.i_decode.i_ptr + 4, 4);
		upper = (EIF_INTEGER_64) ntohl(value);
		idrf.i_decode.i_ptr += I64SIZ;
				/* rejoin the upper and lower parts */ 
		*obj++ = (lower & 0x00000000ffffffff) | (upper << 32);
	}
}

rt_public void widr_multi_int64 (EIF_INTEGER_64 *obj, int num)
{
	register int i = 0;
	uint32 upper, lower, value;
	EIF_INTEGER_64 temp;

	while (num > i++) {
		check_capacity (&idrf.i_encode, I64SIZ);
	
		temp = *obj++;		/*split long into upper and lower 4 bytes */
		lower = (uint32) (temp & 0x00000000ffffffff);
		upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
		value = htonl((uint32)(lower));
		memcpy  (idrf.i_encode.i_ptr, &value, 4);
		value = htonl((uint32)(upper));
		memcpy  (idrf.i_encode.i_ptr + 4, &value, 4);
		idrf.i_encode.i_ptr += I64SIZ;
	}
}

rt_public void ridr_multi_float (EIF_REAL *obj, int num)
{
	register int i = 0;
	char temp_len;

	if (rt_kind_version < INDEPENDENT_STORE_5_0) {
		while (num > i++) {
			check_capacity (&idrf.i_decode, sizeof (char));
			memcpy (&temp_len, idrf.i_decode.i_ptr, sizeof(char));
			idrf.i_decode.i_ptr += sizeof (char);

			check_capacity (&idrf.i_decode, (int)temp_len);
			memcpy (idr_temp_buf, idrf.i_decode.i_ptr, (int)temp_len);
			idrf.i_decode.i_ptr += (int)temp_len;
			*(idr_temp_buf + temp_len) = '\0';
			sscanf (idr_temp_buf, "%f", (obj++));
		}
	} else {
		EIF_DOUBLE tmp;
		while (num > i++) {
			ridr_multi_double (&tmp, 1);
			*obj++ = (EIF_REAL) tmp;
		}
	}
}

rt_public void widr_multi_float (EIF_REAL *obj, int num)
{
	register int i = 0;
	char temp_len;

	if (rt_kind_version < INDEPENDENT_STORE_5_0) {
		while (num > i++) {
			sprintf (idr_temp_buf, "%f", *(obj++));
			temp_len = (char) strlen (idr_temp_buf);
			check_capacity (&idrf.i_encode, sizeof (char));
			memcpy (idrf.i_encode.i_ptr, &temp_len, sizeof(char));
			idrf.i_encode.i_ptr += sizeof (char);

			check_capacity (&idrf.i_encode, (int)temp_len);
			memcpy  (idrf.i_encode.i_ptr, idr_temp_buf, (int)temp_len);
			idrf.i_encode.i_ptr += (int)temp_len;
		}
	} else {
		EIF_DOUBLE tmp;
		while (num > i++) {
			tmp = (EIF_DOUBLE) *(obj++);
			widr_multi_double (&tmp, 1);
		}
	}
}

#if DBLSIZ != 8
"Warning there is a problem with the current platform which does not
have a 8 bytes EIF_DOUBLE"
#endif

rt_public void ridr_multi_double (EIF_DOUBLE *obj, int num)
{
	register int i = 0;

	if (rt_kind_version < INDEPENDENT_STORE_4_4) {
		char temp_len;

		while (num > i++) {
			check_capacity (&idrf.i_decode, sizeof (char));
			memcpy (&temp_len, idrf.i_decode.i_ptr, sizeof(char));
			idrf.i_decode.i_ptr += sizeof (char);

			check_capacity (&idrf.i_decode, (int)temp_len);
			memcpy  (idr_temp_buf, idrf.i_decode.i_ptr, (int)temp_len);
			idrf.i_decode.i_ptr += (int)temp_len;
			*(idr_temp_buf + temp_len) = '\0';
			sscanf (idr_temp_buf, "%lf", obj++);
		}
	} else {
		while (num > i++) {
			check_capacity (&idrf.i_decode, DBLSIZ);
#if BYTEORDER == 0x4321
			{
				int j;
				char double_buffer[DBLSIZ];
				char *idr_buffer;

				idr_buffer = idrf.i_decode.i_ptr;
					/* Reverse the order of the EIF_DOUBLE since we stored EIF_DOUBLEs in
					* little endian mode */
				for (j=0;j<DBLSIZ;j++) 
					double_buffer[DBLSIZ - 1 - j] = idr_buffer [j];
				memcpy (obj++, double_buffer,DBLSIZ);
			}
#elif BYTEORDER == 0x1234
			memcpy  (obj++, idrf.i_decode.i_ptr, DBLSIZ);
#endif
			idrf.i_decode.i_ptr += DBLSIZ;
		}
	}
}

rt_public void widr_multi_double (EIF_DOUBLE *obj, int num)
{
	register int i = 0;

	if (rt_kind_version < INDEPENDENT_STORE_4_4) {
		char temp_len;

		while (num > i++) {
			sprintf (idr_temp_buf, "%f", *(obj++));
			temp_len = (char) strlen (idr_temp_buf);
			check_capacity (&idrf.i_encode, sizeof (char));
			memcpy (idrf.i_encode.i_ptr, &temp_len, sizeof(char));
			idrf.i_encode.i_ptr += sizeof (char);

			check_capacity (&idrf.i_encode, (int)temp_len);
			memcpy  (idrf.i_encode.i_ptr, idr_temp_buf, (int)temp_len);
			idrf.i_encode.i_ptr += (int)temp_len;
		}
	} else {
		while (num > i++) {
			check_capacity (&idrf.i_encode, DBLSIZ);
#if BYTEORDER == 0x4321
			{
				int j;
				char double_buffer [DBLSIZ];
				char *idr_buffer;

				idr_buffer = idrf.i_encode.i_ptr;
				memcpy (double_buffer, obj++, DBLSIZ);
					/* Reverse the order of the EIF_DOUBLE since we stored EIF_DOUBLEs in
					* little endian mode */
				for (j=0;j<DBLSIZ;j++) 
					idr_buffer[DBLSIZ - 1 - j] = double_buffer [j];
			}
#elif BYTEORDER == 0x1234
			memcpy  (idrf.i_encode.i_ptr, obj++, DBLSIZ);
#endif
			idrf.i_encode.i_ptr += DBLSIZ;
		}
	}
}


rt_public void ridr_multi_bit (struct bit *obj, int num, long int elm_siz)
{
	int i = 0;
	int siz, number_of_bits;
	int cap;
	uint32 *iptr = ARENA (obj);


	run_int (&idrf.i_decode, (uint32 *) (&number_of_bits), 1);
	siz = BIT_NBPACK (number_of_bits);
	cap = idrf_buffer_size / (siz * sizeof (uint32));


	if (cap != 0) {
		while (num > i) {
			LENGTH ((((char *)obj) + (elm_siz * i++))) = number_of_bits;
			run_int (&idrf.i_decode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		int loop_c, count = (siz * sizeof (uint32)) / idrf_buffer_size;
		int left_over = (siz * sizeof (uint32))% idrf_buffer_size;
		int write_size = idrf_buffer_size / sizeof (uint32);

		while (num > i++) {
			loop_c = count;
			while (loop_c) {

				run_int (&idrf.i_decode, iptr, write_size);
				iptr += write_size;
				loop_c--;
			} 
			run_int (&idrf.i_decode, iptr, left_over);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	}
}

rt_public void widr_multi_bit (struct bit *obj, int num, uint32 len, int elm_siz)
{
	int i = 0;
	int siz = BIT_NBPACK (len);
	int cap;
	uint32 *iptr = ARENA (obj);

	cap = idrf_buffer_size / (siz * sizeof (uint32));

	run_int (&idrf.i_encode, &len, 1);
	if (cap != 0) {
		while (num > i++) {
			run_int (&idrf.i_encode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		int loop_c, count = (siz * sizeof (uint32)) / idrf_buffer_size;
		int left_over = (siz * sizeof (uint32)) % idrf_buffer_size;
		int write_size = idrf_buffer_size / sizeof (uint32);

		while (num > i++) {
			loop_c = count;
			while (loop_c) {

				run_int (&idrf.i_encode, iptr, write_size);
				iptr += write_size;
				loop_c--;
			} 
			run_int (&idrf.i_encode, iptr, left_over);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	}
}

rt_public void ridr_norm_int (uint32 *obj)
{
	run_int (&idrf.i_decode, obj, 1);
}

rt_public void widr_norm_int (uint32 *obj)
{
	run_int (&idrf.i_encode, obj, 1);
}

rt_public int idr_read_line (char *bu, int max_size)
{
	char *ptr = bu;
	register int i;

	for (i = 1; i < max_size; i++) {
		ridr_multi_char ((EIF_CHARACTER *) ptr, 1);
		if (*(ptr++) == '\n')
			break;
	}
	*ptr = '\0';
	return (ptr - bu);
}

rt_private void old_ridr_multi_int (long int *obj, int num)
{
	int cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	memcpy (&s, idrf.i_decode.i_ptr, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = idrf_buffer_size / s;

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, num, s);
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			run_ulong (&idrf.i_decode, (long unsigned int *) obj, cap, s);
			obj += cap;
			count--;
		}
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, left_over, s);
	}
}

rt_private void old_widr_multi_int (long int *obj, int num)
{
	int cap = idrf_buffer_size / sizeof (long);
	char s = (char) sizeof (long);

	check_capacity (&idrf.i_encode, sizeof (char));
	memcpy (idrf.i_encode.i_ptr, &s, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, num, sizeof (long));
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			run_ulong (&idrf.i_encode, (long unsigned int *) obj, cap, sizeof (long));
			obj += cap;
			count--;
		}
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, left_over, sizeof (long));
	}
}
