/*

  ####    #####   ####   #####   ######          #    #
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           ######
      #     #    #    #  #####   #        ###    #    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###    #    #

	Declarations for store mechanism.

*/

#ifndef _store_h_
#define _store_h_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "malloc.h"				/* For macros HEADER */
#include "garcol.h"				/* For flags manipulation */

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
extern void estore();			/* Store by file name */

/*
 * Utilities
 */
extern int fides;			/* File descriptor used by `store_write' */
extern char fstoretype;		/* File storage type used by `store_write' */
extern void st_write();			/* Write an object in file */
extern char *account;			/* Array of traversed dyn types */
extern void allocate_gen_buffer();
extern long get_alpha_offset();
extern int fides;			/* File descriptor used by `store_write' */

#ifdef EIF_WINDOWS
rt_public void buffer_write(char *data, int size);
#else
extern void buffer_write();
#endif
extern void flush_st_buffer();

extern int current_position;
extern char * general_buffer;
extern int buffer_size;
extern int end_of_buffer;

/* compression */
extern char * cmps_general_buffer;

extern void (*store_write_func)();
extern void store_write();

extern void rt_init_store();
extern void rt_reset_store();

extern long get_offset();          /* get offset of attrib in object*/

	/* General store utilities (3.3 and later) */
extern unsigned int **sorted_attributes;
extern void sort_attributes();
extern void free_sorted_attributes();

#ifdef __cplusplus
}
#endif

#endif
