/*
 *   compress.h
 *
 *   Abstract: compression - decompression algorithms
 *
 *   Author: Hubert Divoux
 *
 *   Copyright (c) 1996, Interactive Software Engineering Inc.
 *   All rights reserved.
 *
 */


#ifndef _compress_h_
#define _compress_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "portable.h"

#define EIF_CMPS_IN_SIZE 32768
#define EIF_CMPS_OUT_SIZE ((EIF_CMPS_IN_SIZE * 9) / 8 + 1 + EIF_CMPS_HEAD_SIZE)
#define EIF_DCMPS_IN_SIZE EIF_CMPS_OUT_SIZE
#define EIF_DCMPS_OUT_SIZE (EIF_CMPS_IN_SIZE + 7)

#define EIF_CMPS_HEAD_DIS_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_OUT_SIZE (sizeof (uint32))
#define EIF_CMPS_HEAD_PAD_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_SIZE (EIF_CMPS_HEAD_DIS_SIZE + EIF_CMPS_HEAD_OUT_SIZE + EIF_CMPS_HEAD_PAD_SIZE)

#define EIF_CMPS_DIS_CMPS     0x01
#define EIF_CMPS_DIS_NO_CMPS  0x00 

/* future ANSI function declarations 
void eif_compress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);
void eif_decompress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);
void eif_cmps_read_u32_from_char_buf (unsigned char* in_buf, uint32* pout_value);
void eif_cmps_write_u32_to_char_buf (uint32 in_value, unsigned char* out_buf);
*/

void eif_compress ();
void eif_decompress ();
void eif_cmps_read_u32_from_char_buf ();
void eif_cmps_write_u32_to_char_buf ();

#ifdef __cplusplus
}
#endif

#endif /* !_compress_h_ */

