/*

  ####    #####   ####   #####   ######          #    #
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           ######
      #     #    #    #  #####   #        ###    #    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###    #    #

	Declarations for store mechanism.

*/

#ifndef _rt_store_h_
#define _rt_store_h_

#include "eif_store.h"

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

/*
 * Utilities
 */
extern char *account;			/* Array of traversed dyn types */
extern long get_alpha_offset(uint32 o_type, uint32 attrib_num);
extern void flush_st_buffer(void);
extern void allocate_gen_buffer(void);
extern void buffer_write(register char *data, int size);

RT_LNK void set_buffer_size (EIF_INTEGER);

extern void store_write(void);

extern int char_write(char *pointer, int size);

extern void rt_init_store(
	void (*store_function) (void),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (EIF_REFERENCE),
	void (*make_header_function) (void),
	int accounting_type);
extern void rt_reset_store(void);

extern void make_header(void);				/* Make header */
extern void imake_header(void);				/* Make header */
extern void st_write(EIF_REFERENCE object);		/* Write an object in file */
extern void ist_write(EIF_REFERENCE object);
extern void gst_write(EIF_REFERENCE object);

extern long get_offset(uint32 o_type, uint32 attrib_num);          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
extern unsigned int **sorted_attributes;
extern void sort_attributes(int dtype);
extern void free_sorted_attributes(void);


extern void internal_store(char *object);

extern char * general_buffer;
extern int current_position;
extern long buffer_size;
extern long cmp_buffer_size;

/* compression */
extern char * cmps_general_buffer;

/* Actions */
extern int (*char_write_func)(char *, int);

#ifdef __cplusplus
}
#endif

#endif

