/*

  ####   ######    ##    #####    ####   #    #          #    #
 #       #        #  #   #    #  #    #  #    #          #    #
  ####   #####   #    #  #    #  #       ######          ######
      #  #       ######  #####   #       #    #   ###    #    #
 #    #  #       #    #  #   #   #    #  #    #   ###    #    #
  ####   ######  #    #  #    #   ####   #    #   ###    #    #

	Search table routines.
*/

#ifndef _search_h_
#define _search_h_

#ifdef __cplusplus
extern "C" {
#endif
 
/*
 * Search table declarations.
 */

struct s_table {
	uint32 s_size;		/* Search table size */
	uint32 s_count;		/* Count of inserted keys */
	char **s_keys;		/* Search table keys */
};

#define S_OK		0			/* No conflict result value of `s_put' */
#define S_CONFLICT	1			/* Conflict result value of `s_put' */
#define S_FOUND		-1			/* Object found by `s_search' */

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

