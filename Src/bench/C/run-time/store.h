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
extern FILE *st_file;			/* File used bu `st_write' */
extern void st_write();			/* Write an object in file */
extern char *account;			/* Array of traversed dyn types */
#endif
