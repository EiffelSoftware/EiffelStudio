/*

  ####   ######    ##    #####    ####   #    #          #    #
 #       #        #  #   #    #  #    #  #    #          #    #
  ####   #####   #    #  #    #  #       ######          ######
      #  #       ######  #####   #       #    #   ###    #    #
 #    #  #       #    #  #   #   #    #  #    #   ###    #    #
  ####   ######  #    #  #    #   ####   #    #   ###    #    #

	Search table routines.
*/

#ifndef _eif_search_h_
#define _eif_search_h_

#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Search table declarations.
 */

#define EIF_SEARCH_OK		0		/* No conflict result value of `s_put' */
#define EIF_SEARCH_CONFLICT	1		/* Conflict result value of `s_put' */
#define EIF_SEARCH_FOUND	-1		/* Object found by `s_search' */

/*
 * Search table interface.
 */

extern struct s_table *s_create(uint32 size);	/* Creates search table */
extern int s_put(struct s_table *tbl, char *object);					/* Insertion in search table */
extern int32 s_search(struct s_table *tbl, char *object);			/* Search in table */
extern void s_resize(register struct s_table *tbl);				/* Search table resizing */

#ifdef __cplusplus
}
#endif

#endif

