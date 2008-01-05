/*
	description: "Internal data representation."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="run_idr.c" header="rt_run_idr.h" version="$Id$" summary="IDR = Internal Data Representation, used for serialization in independent store">
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
#include "eif_eiffel.h"
#include "rt_bits.h"
#include "rt_err_msg.h"
#if !defined(CUSTOM) || defined(NEED_RETRIEVE_H)
#include "rt_retrieve.h"
#endif
#if !defined(CUSTOM) || defined(NEED_STORE_H)
#include "rt_store.h"
#endif
#include "rt_error.h"
#include "rt_run_idr.h"
#ifdef EIF_OS2
#include <io.h>
#endif
#include "eif_size.h"	/* Needed for R64SIZ */
#include "rt_malloc.h"
#include "rt_assert.h"
#include "rt_hashin.h"

#ifndef EIF_THREADS
/*
doc:	<attribute name="idr_temp_buf" return_type="char *" export="shared">
doc:		<summary>Buffer of 48 characters used for reading float/double in INDEPENDENT_STORE_4_4 and older. It iis shared so that it can be freed if an exception occurs.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<fixme>Since this only used for old storable that we are unlikely to ever retrieve again, we should allocate this buffer on the fly when we need it, or even do it statically on the stack.</fixme>
doc:	</attribute>
*/
rt_shared char *idr_temp_buf;

/*
doc:	<attribute name="amount_read" return_type="int" export="private">
doc:		<summary>Amount read into IDRF buffer used in `check_capacity'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int amount_read = 0;

/*
doc:	<attribute name="idrf_buffer_size" return_type="size_t" export="private">
doc:		<summary>Size of IDRF buffer set in `run_idr_init'. Default value of 256KB.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t idrf_buffer_size = 262144L;

/*
doc:	<attribute name="idrf" return_type="IDRF" export="private">
doc:		<summary>IDRF buffer</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private IDRF idrf;

/*
doc:	<attribute name="run_idr_read_func" return_type="int (*)(IDR *)" export="private">
doc:		<summary>`run_idr_read' function. This can be different depending on which version of INDEPENDENT_STORE we are using. The old one is based on `short' the new one on `long'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<fixme>Is this really needed now? I don't see any other possible function that could be used.</fixme>
doc:	</attribute>
*/
rt_private int (*run_idr_read_func) (IDR *bu);

#ifdef EIF_64_BITS
/*
doc:	<attribute name="idr_ref_table" return_type="struct htable *" export="shared">
doc:		<summary>Table used for converting 64-bit Eiffel references into 32-bit values.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private struct htable *idr_ref_table = NULL;
rt_private rt_uint_ptr idr_ref_table_counter = 0;
#endif
#endif

rt_private int run_idr_read (IDR *bu);
rt_private void old_ridr_multi_int (long int *obj, size_t num);
rt_private void old_widr_multi_int (long int *obj, size_t num);

#ifdef EIF_THREADS
rt_shared void eif_run_idr_thread_init (void)
	/* Initialize private data of `run_idr.c' in multithreaded environment. */
	/* Data is already zeroed, so only variables that needs something different
	 * than the default value will be initialized. */
{
	RT_GET_CONTEXT
	REQUIRE ("idr_temp_buf_null", idr_temp_buf == NULL);
	REQUIRE ("amount_read_is_zero", amount_read == 0);
	REQUIRE ("idrf_buffer_size_is_zero", idrf_buffer_size == 0);
/*	REQUIRE ("idrf_zeroed", ?? ); */
	REQUIRE ("run_idr_read_func_null", run_idr_read_func == NULL);

	idrf_buffer_size = 262144L;

	ENSURE ("idr_temp_buf_null", idr_temp_buf == NULL);
	ENSURE ("amount_read_is_zero", amount_read == 0);
	ENSURE ("idrf_buffer_size_is_zero", idrf_buffer_size == 262144L);
/*	ENSURE ("idrf_zeroed", ?? ); */
	ENSURE ("run_idr_read_func_null", run_idr_read_func == NULL);
}
#endif

rt_public void run_idr_init (size_t idrf_size, int type)
{
	RT_GET_CONTEXT
	idrf_buffer_size = idrf_size;

	run_idr_read_func = run_idr_read;

		/* Because we might mark the first `n' bytes of the buffer (see above
		 * instruction), we need to make sure that we have enough allocated memory
		 * to read or store `idrf_buffer_size' bytes.
		 */
	if (-1 == idrf_create (&idrf, idrf_size + sizeof(int32)))
		eraise ("cannot allocate idrf", EN_MEM);

		/* Reset amount_read */
	amount_read = 0;

		/* When writting a storable we mark some space at the front of the buffer
		 * to store upon writting the size of block, so that only one write operation
		 * is performed */
	if (type) {
		idr_setpos (&idrf.i_encode, sizeof(int32));
	}

#ifdef EIF_64_BITS
	idr_ref_table_counter = 0;
	idr_ref_table = (struct htable*) eif_rt_xmalloc (sizeof (struct htable), C_T, GC_OFF);
	if (idr_ref_table == NULL) {
		eraise ("Cannot allocate 64-32 mapping table", EN_MEM);
		xraise (EN_MEM);
	} else {
		if (ht_create (idr_ref_table, 10000, sizeof(rt_uint_ptr)) == -1) {
			eraise ("Cannot create 64-32 mapping table", EN_MEM);
		}
	}
#endif
}

rt_public void run_idr_destroy (void)
{
	RT_GET_CONTEXT
	idrf_destroy(&idrf);
#ifdef EIF_64_BITS
	ht_free (idr_ref_table);
	idr_ref_table = NULL;
	idr_ref_table_counter = 0;
#endif
}

rt_private int run_idr_read (IDR *bu)
{
	RT_GET_CONTEXT
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
		if ((part_read = char_read_func (ptr, amount_left)) <= 0) {
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		}
		total_read += part_read;
		ptr += part_read;
		amount_left -= part_read;
		}
	return total_read;
}

rt_private void run_idr_write (IDR *bu)
{
	RT_GET_CONTEXT
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

rt_public void check_capacity (IDR *bu, size_t size)
{
	RT_GET_CONTEXT
	if (idrs_op (bu)) {
		if ((bu->i_ptr + size) > (bu->i_buf + amount_read)) {
			amount_read = run_idr_read_func (bu);
			(void) idr_setpos (bu, 0);
		}
	} else {
		if ((bu->i_ptr + size) > (bu->i_buf + bu->i_size)) {
			run_idr_write (bu);
			(void) idr_setpos (bu, sizeof(int32));
		}
	}
}

rt_public void idr_flush (void)
{
	RT_GET_CONTEXT
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
#if LNGSIZ == 4
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

rt_public bool_t run_uint_ptr (IDR *idrs, void *lp, size_t len, size_t size)
{
	/* Serialize a pointer value */

	uint32 value;		/* Value in network byte order */
	rt_uint_ptr *data = (rt_uint_ptr *) lp;
	size_t i = 0;

	check_capacity (idrs, len * size);

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
#if PTRSIZ == 4
					/*encode for pointer = 4 bytes */
			CHECK("Valid size", size == PTRSIZ);
			value = htonl((uint32)(*(data + (i++))));
			memcpy (idrs->i_ptr, &value, size);
			idrs->i_ptr += size;
#elif PTRSIZ == 8
							/*encode for long = 8bytes */
			uint32 upper, lower;
			rt_uint_ptr temp;
		
			temp = *(data + (i++));		/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & RTI64C(0x00000000ffffffff));
			upper = (uint32) ((temp >> 32) & RTI64C(0x00000000ffffffff));
			value = htonl((uint32)(lower));
			memcpy (idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			memcpy (idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;
#else
#			error "PTRSIZ not known"
#endif
		}
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			while (len > i) {
				memcpy (&value, idrs->i_ptr, size);
				*(data + (i++)) = (rt_uint_ptr) ntohl(value);
				idrs->i_ptr += size;
			}
		} else {						/*decode an 8 byte long */
			while (len > i) {
				uint32 lower, upper;
				memcpy (&lower, idrs->i_ptr, 4);
				idrs->i_ptr += 4;
				memcpy (&upper, idrs->i_ptr, 4);
				idrs->i_ptr += 4;
#if PTRSIZ == 4
					/* We read an 8 bytes pointer, but we can only store the lower 4 bytes. */
				*(data + (i++)) = (rt_uint_ptr) ntohl(lower);
#elif PTRSIZ == 8
						/* rejoin the upper and lower parts */ 

				*(data + (i++)) = (((rt_uint_ptr) ntohl(lower)) & RTI64C(0x00000000ffffffff)) | 
								(((rt_uint_ptr) ntohl(upper)) << 32);
#else
#			error "PTRSIZ not known"
#endif
			}
		}
	}
	return TRUE;
}
rt_public bool_t run_ulong(IDR *idrs, long unsigned int *lp, size_t len, size_t size)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	size_t i = 0;

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

rt_public bool_t run_int(IDR *idrs, uint32 *ip, size_t len)
{
	/* Serialize a int byte */

	uint32 value;		/* Value in network byte order */
	size_t i = 0;

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


rt_public void ridr_multi_char (EIF_CHARACTER *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap = idrf_buffer_size / sizeof (EIF_CHARACTER);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_decode, num);
		memcpy (obj, idrf.i_decode.i_ptr, num);
		idrf.i_decode.i_ptr += num;
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;

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

rt_public void widr_multi_char (EIF_CHARACTER *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap = idrf_buffer_size / sizeof (EIF_CHARACTER);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_encode, num);
		memcpy (idrf.i_encode.i_ptr, obj, num);
		idrf.i_encode.i_ptr += num;
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;

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


rt_public void ridr_multi_any (char *obj, size_t num)
{
	ridr_multi_ptr (obj, num);
}

#ifdef EIF_64_BITS
rt_private rt_uint_ptr mapped_address (rt_uint_ptr val)
	/* If address of `val' does not fit on 31-bit we map it with `idr_ref_table'.
	 * The idea is that all addresses above 0x7FFFFFFF are mapped to the address
	 * 0xF???????? and the one below 0x7FFFFFFF remains as is. */
{
	RT_GET_CONTEXT
	rt_uint_ptr l_obj = val;

	if (l_obj > 0x7FFFFFFF) {
		rt_uint_ptr *l_slot = (rt_uint_ptr *) ht_first (idr_ref_table, val);
		if (l_slot && (*l_slot != 0)) {
			l_obj = *l_slot;
		} else {
			idr_ref_table_counter++;
			CHECK("not too big counter", idr_ref_table_counter <= 0x7FFFFFFF);
			l_obj = 0xF0000000 | idr_ref_table_counter;
			if (!l_slot) {
				ht_force (idr_ref_table, (rt_uint_ptr) val,  &l_obj);
			} else {
				*l_slot = l_obj;
			}
		}
	}
	return l_obj;
}
#endif

rt_public void widr_multi_any (char *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap = idrf_buffer_size / sizeof (char *);
	char s = (char) sizeof (char *);
#ifdef EIF_64_BITS
	rt_uint_ptr l_obj;
	rt_uint_ptr *lptr = (rt_uint_ptr *) obj;
	size_t i;
#endif

	check_capacity (&idrf.i_encode, sizeof (char));
	memcpy (idrf.i_encode.i_ptr, &s, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

#ifdef EIF_64_BITS
	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_encode, num * sizeof (char *));
		for (i = num; i > 0; i--, lptr++) {
			l_obj = mapped_address (*(rt_uint_ptr *) lptr);
			run_uint_ptr (&idrf.i_encode, &l_obj, 1, sizeof (char *));
		}
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;
		rt_uint_ptr *lptr = (rt_uint_ptr *) obj;
		while (count) {
			check_capacity (&idrf.i_encode, cap * sizeof (char *));
			for (i = cap; i > 0; i--, lptr++) {
				l_obj = mapped_address (*(rt_uint_ptr *) lptr);
				run_uint_ptr (&idrf.i_encode, &l_obj, 1, sizeof (char *));
			}
			count--;
		}
		check_capacity (&idrf.i_encode, left_over * sizeof (char *));
		for (i = left_over; i > 0; i--, lptr++) {
			l_obj = mapped_address (*(rt_uint_ptr *) lptr);
			run_uint_ptr (&idrf.i_encode, &l_obj, 1, sizeof (char *));
		}
	}
#else
	if ((num - cap) <= 0) {
		run_uint_ptr (&idrf.i_encode, obj, num, sizeof (char *));
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;
		rt_uint_ptr *lptr = (rt_uint_ptr *) obj;

		while (count) {
			run_uint_ptr (&idrf.i_encode, lptr, cap, sizeof (char *));
			lptr += cap;
			count--;
		}
		run_uint_ptr (&idrf.i_encode, lptr, left_over, sizeof (char *));
	}
#endif
}

rt_public void ridr_multi_ptr (char *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	memcpy (&s, idrf.i_decode.i_ptr, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = idrf_buffer_size / s;

	if ((num - cap) <= 0) {
		run_uint_ptr (&idrf.i_decode, obj, num, s);
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;
		rt_uint_ptr *lptr = (rt_uint_ptr *) obj;

		while (count) {
			run_uint_ptr (&idrf.i_decode, lptr, cap, s);
			lptr += cap;
			count--;
		}
		run_uint_ptr (&idrf.i_decode, lptr, left_over, s);
	}
}

rt_public void widr_multi_ptr (char *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap = idrf_buffer_size / sizeof (char *);
	char s = (char) sizeof (char *);

	check_capacity (&idrf.i_encode, sizeof (char));
	memcpy (idrf.i_encode.i_ptr, &s, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_uint_ptr (&idrf.i_encode, obj, num, sizeof (char *));
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;
		rt_uint_ptr *lptr = (rt_uint_ptr *) obj;

		while (count) {
			run_uint_ptr (&idrf.i_encode, lptr, cap, sizeof (char *));
			lptr += cap;
			count--;
		}
		run_uint_ptr (&idrf.i_encode, lptr, left_over, sizeof (char *));
	}
}


rt_public void ridr_multi_int8 (EIF_INTEGER_8 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

	while (num > i++) {
		check_capacity (&idrf.i_decode, CHRSIZ);
		memcpy (obj++, idrf.i_decode.i_ptr, CHRSIZ);
		idrf.i_decode.i_ptr += CHRSIZ;
	}
}

rt_public void widr_multi_int8 (EIF_INTEGER_8 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

	while (num > i++) {
		check_capacity (&idrf.i_encode, CHRSIZ);
		memcpy  (idrf.i_encode.i_ptr, obj++, CHRSIZ);
		idrf.i_encode.i_ptr += CHRSIZ;
	}
}

rt_public void ridr_multi_int16 (EIF_INTEGER_16 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
	EIF_INTEGER_16 value;

	while (num > i++) {
		check_capacity (&idrf.i_decode, I16SIZ);
		memcpy (&value, idrf.i_decode.i_ptr, I16SIZ);
		*obj++ = (EIF_INTEGER_16) ntohs(value);
		idrf.i_decode.i_ptr += I16SIZ;
	}
}

rt_public void widr_multi_int16 (EIF_INTEGER_16 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
	EIF_INTEGER_16 value;

	while (num > i++) {
		check_capacity (&idrf.i_encode, I16SIZ);
		value = htons(*obj++);
		memcpy  (idrf.i_encode.i_ptr, &value, I16SIZ);
		idrf.i_encode.i_ptr += I16SIZ;
	}
}

rt_public void ridr_multi_int32 (EIF_INTEGER_32 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

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

rt_public void widr_multi_int32 (EIF_INTEGER_32 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

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

rt_public void ridr_multi_int64 (EIF_INTEGER_64 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
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
		*obj++ = (lower & RTI64C(0x00000000ffffffff)) | (upper << 32);
	}
}

rt_public void widr_multi_int64 (EIF_INTEGER_64 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
	uint32 upper, lower, value;
	EIF_INTEGER_64 temp;

	while (num > i++) {
		check_capacity (&idrf.i_encode, I64SIZ);
	
		temp = *obj++;		/*split long into upper and lower 4 bytes */
		lower = (uint32) (temp & RTI64C(0x00000000ffffffff));
		upper = (uint32) ((temp >> 32) & RTI64C(0x00000000ffffffff));
		value = htonl((uint32)(lower));
		memcpy  (idrf.i_encode.i_ptr, &value, 4);
		value = htonl((uint32)(upper));
		memcpy  (idrf.i_encode.i_ptr + 4, &value, 4);
		idrf.i_encode.i_ptr += I64SIZ;
	}
}

rt_public void ridr_multi_uint8 (EIF_NATURAL_8 *obj, size_t num) {
	EIF_INTEGER_8 *data = (EIF_INTEGER_8 *) obj;
	ridr_multi_int8 (data, num);
}

rt_public void widr_multi_uint8 (EIF_NATURAL_8 *obj, size_t num) {
	EIF_INTEGER_8 *data = (EIF_INTEGER_8 *) obj;
	widr_multi_int8 (data, num);
}

rt_public void ridr_multi_uint16 (EIF_NATURAL_16 *obj, size_t num) {
	EIF_INTEGER_16 *data = (EIF_INTEGER_16 *) obj;
	ridr_multi_int16 (data, num);
}

rt_public void widr_multi_uint16 (EIF_NATURAL_16 *obj, size_t num) {
	EIF_INTEGER_16 *data = (EIF_INTEGER_16 *) obj;
	widr_multi_int16 (data, num);
}

rt_public void ridr_multi_uint32 (EIF_NATURAL_32 *obj, size_t num) {
	EIF_INTEGER_32 *data = (EIF_INTEGER_32 *) obj;
	ridr_multi_int32 (data, num);
}

rt_public void widr_multi_uint32 (EIF_NATURAL_32 *obj, size_t num) {
	EIF_INTEGER_32 *data = (EIF_INTEGER_32 *) obj;
	widr_multi_int32 (data, num);
}

rt_public void ridr_multi_uint64 (EIF_NATURAL_64 *obj, size_t num) {
	EIF_INTEGER_64 *data = (EIF_INTEGER_64 *) obj;
	ridr_multi_int64 (data, num);
}

rt_public void widr_multi_uint64 (EIF_NATURAL_64 *obj, size_t num) {
	EIF_INTEGER_64 *data = (EIF_INTEGER_64 *) obj;
	widr_multi_int64 (data, num);
}

rt_public void ridr_multi_float (EIF_REAL_32 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
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
		EIF_REAL_64 tmp;
		while (num > i++) {
			ridr_multi_double (&tmp, 1);
			*obj++ = (EIF_REAL_32) tmp;
		}
	}
}

rt_public void widr_multi_float (EIF_REAL_32 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;
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
		EIF_REAL_64 tmp;
		while (num > i++) {
			tmp = (EIF_REAL_64) *(obj++);
			widr_multi_double (&tmp, 1);
		}
	}
}

#if R64SIZ != 8
"Warning there is a problem with the current platform which does not have a 8 bytes EIF_REAL_64"
#endif

rt_public void ridr_multi_double (EIF_REAL_64 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

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
			check_capacity (&idrf.i_decode, R64SIZ);
#if BYTEORDER == 0x4321
			{
				int j;
				char double_buffer[R64SIZ];
				char *idr_buffer;

				idr_buffer = idrf.i_decode.i_ptr;
					/* Reverse the order of the EIF_REAL_64 since we stored EIF_REAL_64s in
					* little endian mode */
				for (j=0;j<R64SIZ;j++) 
					double_buffer[R64SIZ - 1 - j] = idr_buffer [j];
				memcpy (obj++, double_buffer,R64SIZ);
			}
#elif BYTEORDER == 0x1234
			memcpy  (obj++, idrf.i_decode.i_ptr, R64SIZ);
#endif
			idrf.i_decode.i_ptr += R64SIZ;
		}
	}
}

rt_public void widr_multi_double (EIF_REAL_64 *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t i = 0;

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
			check_capacity (&idrf.i_encode, R64SIZ);
#if BYTEORDER == 0x4321
			{
				int j;
				char double_buffer [R64SIZ];
				char *idr_buffer;

				idr_buffer = idrf.i_encode.i_ptr;
				memcpy (double_buffer, obj++, R64SIZ);
					/* Reverse the order of the EIF_REAL_64 since we stored EIF_REAL_64s in
					* little endian mode */
				for (j=0;j<R64SIZ;j++) 
					idr_buffer[R64SIZ - 1 - j] = double_buffer [j];
			}
#elif BYTEORDER == 0x1234
			memcpy  (idrf.i_encode.i_ptr, obj++, R64SIZ);
#endif
			idrf.i_encode.i_ptr += R64SIZ;
		}
	}
}


rt_public void ridr_multi_bit (struct bit *obj, size_t num, size_t elm_siz)
{
	RT_GET_CONTEXT
	size_t i = 0;
	int siz, number_of_bits;
	size_t cap;
	uint32 *iptr = ARENA (obj);


	run_int (&idrf.i_decode, (uint32 *) (&number_of_bits), 1);
	CHECK("valid number of bits", number_of_bits <= 0x000FFFF);
	siz = BIT_NBPACK (number_of_bits);
	cap = idrf_buffer_size / (siz * sizeof (uint32));


	if (cap != 0) {
		while (num > i) {
			LENGTH ((((char *)obj) + (elm_siz * i++))) = (uint16) number_of_bits;
			run_int (&idrf.i_decode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		size_t loop_c, count = (siz * sizeof (uint32)) / idrf_buffer_size;
		size_t left_over = (siz * sizeof (uint32))% idrf_buffer_size;
		size_t write_size = idrf_buffer_size / sizeof (uint32);

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

rt_public void widr_multi_bit (struct bit *obj, size_t num, uint32 len, size_t elm_siz)
{
	RT_GET_CONTEXT
	size_t i = 0;
	int siz = BIT_NBPACK (len);
	size_t cap;
	uint32 *iptr = ARENA (obj);

	cap = idrf_buffer_size / (siz * sizeof (uint32));

	run_int (&idrf.i_encode, &len, 1);
	if (cap != 0) {
		while (num > i++) {
			run_int (&idrf.i_encode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		size_t loop_c, count = (siz * sizeof (uint32)) / idrf_buffer_size;
		size_t left_over = (siz * sizeof (uint32)) % idrf_buffer_size;
		size_t write_size = idrf_buffer_size / sizeof (uint32);

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
	RT_GET_CONTEXT
	run_int (&idrf.i_decode, obj, 1);
}

rt_public void widr_norm_int (uint32 *obj)
{
	RT_GET_CONTEXT
	run_int (&idrf.i_encode, obj, 1);
}

rt_public int idr_read_line (char *bu, size_t max_size)
{
	char *ptr = bu;
	size_t i;

	for (i = 1; i < max_size; i++) {
		ridr_multi_char ((EIF_CHARACTER *) ptr, 1);
		if (*(ptr++) == '\n')
			break;
	}
	*ptr = '\0';
	return ptr > bu;
}

rt_private void old_ridr_multi_int (long int *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	memcpy (&s, idrf.i_decode.i_ptr, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = idrf_buffer_size / s;

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, num, s);
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;

		while (count) {
			run_ulong (&idrf.i_decode, (long unsigned int *) obj, cap, s);
			obj += cap;
			count--;
		}
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, left_over, s);
	}
}

rt_private void old_widr_multi_int (long int *obj, size_t num)
{
	RT_GET_CONTEXT
	size_t cap = idrf_buffer_size / sizeof (long);
	char s = (char) sizeof (long);

	check_capacity (&idrf.i_encode, sizeof (char));
	memcpy (idrf.i_encode.i_ptr, &s, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, num, sizeof (long));
	} else {
		size_t count = num / cap;
		size_t left_over = num % cap;

		while (count) {
			run_ulong (&idrf.i_encode, (long unsigned int *) obj, cap, sizeof (long));
			obj += cap;
			count--;
		}
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, left_over, sizeof (long));
	}
}

/*
doc:</file>
*/
