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

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "eif_globals.h"
#include "eif_malloc.h"				/* For macros HEADER */
#include "eif_garcol.h"				/* For flags manipulation */

/* Different kinds of storage */

#define BASIC_STORE_3_1 '\0'
#define BASIC_STORE_3_2 '\02'
#define BASIC_STORE_4_0 '\06'
#define GENERAL_STORE_3_1 '\01'
#define GENERAL_STORE_3_2 '\03'
#define GENERAL_STORE_3_3 '\05'
#define GENERAL_STORE_4_0 '\07'
#define INDEPENDENT_STORE_3_2 '\04'
#define INDEPENDENT_STORE_4_0 '\10' /* Octal values */

/*
 * Eiffel calls
 */
extern void estore(EIF_INTEGER file_desc, char *object);			/* Store by file name */

/*
 * Utilities
 */
extern int fides;			/* File descriptor used by `store_write' */
extern void st_write(char *object);			/* Write an object in file */
extern char *account;			/* Array of traversed dyn types */
extern void allocate_gen_buffer(void);
extern long get_alpha_offset(uint32 o_type, uint32 attrib_num);
extern int fides;			/* File descriptor used by `store_write' */

#ifdef EIF_WINDOWS
rt_public void buffer_write(char *data, int size);
#else
extern void buffer_write(register char *data, int size);
#endif
extern void flush_st_buffer(void);

extern int current_position;
extern char * general_buffer;
extern int buffer_size;
extern int end_of_buffer;

/* compression */
extern char * cmps_general_buffer;

extern void (*store_write_func)(void);
extern void store_write(void);

extern int (*char_write_func)(char *, int);
extern int char_write(char *pointer, int size);

extern void rt_init_store(void (*store_function) (void), int (*char_write_function)
(char *, int), int buf_size);
extern void rt_reset_store(void);

extern long get_offset(uint32 o_type, uint32 attrib_num);          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
extern unsigned int **sorted_attributes;
extern void sort_attributes(int dtype);
extern void free_sorted_attributes(void);

extern void eestore(EIF_INTEGER file_desc, char *object);
extern void sstore (EIF_INTEGER fd, char *object);

#ifdef __cplusplus
}
#endif

#endif
