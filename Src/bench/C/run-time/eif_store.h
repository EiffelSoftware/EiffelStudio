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

/* Setting of `eif_is_new_independent_format' */
#define eif_set_new_independent_format(v)	eif_is_new_independent_format = (EIF_BOOLEAN) (v)

extern char rt_kind_version;

/*
 * Utilities
 */
extern int fides;			/* File descriptor used by `store_write' */
extern void st_write(char *object);			/* Write an object in file */
extern char *account;			/* Array of traversed dyn types */
extern long get_alpha_offset(uint32 o_type, uint32 attrib_num);
extern void flush_st_buffer(void);
extern void allocate_gen_buffer(void);
extern void buffer_write(register char *data, int size);

extern int current_position;
extern char * general_buffer;
extern long buffer_size;
extern int end_of_buffer;
RT_LNK void set_buffer_size (int);

/* compression */
extern char * cmps_general_buffer;

extern void (*make_header_func)(void);

extern void (*store_write_func)(void);
extern void store_write(void);

extern int (*char_write_func)(char *, int);
extern int char_write(char *pointer, int size);

extern void rt_init_store(
	void (*store_function) (void),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (char *),
	void (*make_header_function) (void),
	int accounting_type);
extern void rt_reset_store(void);

extern void make_header(void);				/* Make header */
extern void imake_header(void);				/* Make header */
extern void ist_write(char *object);
extern void gst_write(char *object);

extern long get_offset(uint32 o_type, uint32 attrib_num);          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
extern unsigned int **sorted_attributes;
extern void sort_attributes(int dtype);
extern void free_sorted_attributes(void);

/*
 * Eiffel calls
 */
extern void basic_general_free_store (char *object);
extern void independent_free_store (char *object);

RT_LNK void estore(EIF_INTEGER file_desc, char *object);
RT_LNK void eestore(EIF_INTEGER file_desc, char *object);
RT_LNK void sstore (EIF_INTEGER file_desc, char *object);

RT_LNK long stream_estore(char **stream, long size, char *object, EIF_INTEGER *);
RT_LNK long stream_eestore(char **stream, long size, char *object, EIF_INTEGER *);
RT_LNK long stream_sstore (char **stream, long size, char *object, EIF_INTEGER *);

RT_LNK char **stream_malloc (int stream_size);
RT_LNK void stream_free (char **stream);

RT_LNK EIF_BOOLEAN eif_is_new_independent_format;	/* Do we use the 4.5 independent
													   storable mechanism? */

#ifdef __cplusplus
}
#endif

#endif
