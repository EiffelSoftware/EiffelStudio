/*

  ####    #####   ####   #####   ######          #    #
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           ######
      #     #    #    #  #####   #        ###    #    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###    #    #

	Declarations for store mechanism.

*/

#ifndef _eif_store_h_
#define _eif_store_h_

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "eif_globals.h"
#include "eif_malloc.h"				/* For macros HEADER */
#include "eif_garcol.h"				/* For flags manipulation */

#ifdef __cplusplus
extern "C" {
#endif

/* Different kinds of storage */
#define BASIC_STORE_3_1			0x00
#define BASIC_STORE_3_2			0x02
#define BASIC_STORE_4_0			0x06
#define GENERAL_STORE_3_1		0x01
#define GENERAL_STORE_3_2		0x03
#define GENERAL_STORE_3_3		0x05
#define GENERAL_STORE_4_0		0x07
#define INDEPENDENT_STORE_3_2	0x04
#define INDEPENDENT_STORE_4_0	0x08
#define INDEPENDENT_STORE_4_3	0x09
#define INDEPENDENT_STORE_4_4	0x0A
#define INDEPENDENT_STORE_5_0	0x0B
/* TODO: Should this be called INDEPENDENT_STORE_5_3? */
#define RECOVERABLE_STORE_5_3	0x0C

/* Setting of `eif_is_new_independent_format' */
RT_LNK void eif_set_new_independent_format(EIF_BOOLEAN v);
RT_LNK EIF_BOOLEAN eif_is_new_recoverable_format_active (void);

/*
 * Eiffel calls
 */
RT_LNK void estore(EIF_INTEGER file_desc, char *object);
RT_LNK void eestore(EIF_INTEGER file_desc, char *object);
RT_LNK void sstore (EIF_INTEGER file_desc, char *object);

RT_LNK EIF_INTEGER stream_estore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_eestore(EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);
RT_LNK EIF_INTEGER stream_sstore (EIF_POINTER *, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER *);

RT_LNK void set_buffer_size (EIF_INTEGER);

RT_LNK EIF_POINTER *stream_malloc (EIF_INTEGER stream_size);
RT_LNK void stream_free (EIF_POINTER *stream);

/* Features needed for EiffelNet */
RT_LNK void basic_general_free_store(EIF_REFERENCE);
RT_LNK void independent_free_store (EIF_REFERENCE);
RT_LNK void rt_init_store(
	void (*store_function) (void),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (EIF_REFERENCE),
	void (*make_header_function) (void),
	int accounting_type);
RT_LNK void rt_reset_store(void);
RT_LNK void flush_st_buffer(void);
RT_LNK void st_write(EIF_REFERENCE object);		/* Write an object in file */
RT_LNK void ist_write(EIF_REFERENCE object);
RT_LNK void gst_write(EIF_REFERENCE object);
RT_LNK void store_write(void);
RT_LNK void make_header(void);				/* Make header */
RT_LNK void rmake_header(void);				/* Make header */
RT_LNK void imake_header(void);				/* Make header */

#ifdef __cplusplus
}
#endif

#endif
