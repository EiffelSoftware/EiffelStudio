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
#include <stdio.h>

#ifndef NULL
#define NULL 0
#endif

#include "malloc.h"				/* For macros HEADER */
#include "garcol.h"				/* For flags manipulation */

/*
 * Eiffel calls
 */
extern void estore();			/* Store by file name */

/*
 * Utilities
 */
extern int fides;			/* File descriptor used by `store_write' */
extern void st_write();			/* Write an object in file */
extern char *account;			/* Array of traversed dyn types */

extern void buffer_write();
extern void flush_st_buffer();

extern int current_position;
extern char * general_buffer;
extern int buffer_size;
extern int end_of_buffer;

extern void (*store_write_func)();
extern void store_write();

#endif
