/*
 *   eif_compress.h
 *
 *   Abstract: compression - decompression algorithms
 *
 *   Author: Hubert Divoux
 *
 *   Copyright (c) 1996, Interactive Software Engineering Inc.
 *   All rights reserved.
 *
 */


#ifndef _eif_compress_h_
#define _eif_compress_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"

#define EIF_CMPS_HEAD_DIS_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_OUT_SIZE (sizeof (uint32))
#define EIF_CMPS_HEAD_PAD_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_SIZE (EIF_CMPS_HEAD_DIS_SIZE + EIF_CMPS_HEAD_OUT_SIZE + EIF_CMPS_HEAD_PAD_SIZE)

#define EIF_CMPS_DIS_CMPS     0x01
#define EIF_CMPS_DIS_NO_CMPS  0x00 

#define EIF_CMPS_IN_SIZE  262144L /* 32768 */
#define EIF_CMPS_OUT_SIZE ((EIF_CMPS_IN_SIZE * 9) / 8 + 1 + EIF_CMPS_HEAD_SIZE)

#define EIF_DCMPS_IN_SIZE EIF_CMPS_OUT_SIZE
#define EIF_DCMPS_OUT_SIZE (EIF_CMPS_IN_SIZE + 7)

extern void eif_compress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);
extern void eif_decompress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);
extern void eif_cmps_read_u32_from_char_buf (unsigned char* in_buf, uint32* pout_value);
extern void eif_cmps_write_u32_to_char_buf (uint32 in_value, unsigned char* out_buf);

/* old K&R declarations
extern void eif_compress (unsigned char *in_buf, long unsigned int in_size, unsigned char *out_buf, long unsigned int *pout_size);
extern void eif_decompress (unsigned char *in_buf, long unsigned int in_size, unsigned char *out_buf, long unsigned int *pout_size);
extern void eif_cmps_read_u32_from_char_buf (unsigned char *in_buf, uint32 *pout_value);
extern void eif_cmps_write_u32_to_char_buf (uint32 in_value, unsigned char *out_buf);
*/

#ifdef __cplusplus
}
#endif

#endif /* !_eif_compress_h_ */

