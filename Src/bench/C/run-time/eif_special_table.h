/*

 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######

  ####   #####   ######   ####      #      ##    #
 #       #    #  #       #    #     #     #  #   #
  ####   #    #  #####   #          #    #    #  #
      #  #####   #       #          #    ######  #
 #    #  #       #       #    #     #    #    #  #
  ####   #       ######   ####      #    #    #  ###### #######


  #####    ##    #####   #       ######          #    #
    #     #  #   #    #  #       #               #    #
    #    #    #  #####   #       #####           ######
    #    ######  #    #  #       #        ###    #    #
    #    #    #  #    #  #       #        ###    #    #
    #    #    #  #####   ######  ######   ###    #    #

	Header for eif_special_table.h
*/

#ifndef _eif_special_table_h_
#define _eif_special_table_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_REM_SET_OPTIMIZATION
#define	EIF_SPT_SZ	8192	
#define	EIF_SPT_SZ_MAX	8192	
#endif	/* EIF_REM_SET_OPTIMIZATION */

struct special_table {
	int			 	h_size;			/* Size of table */
	int			 	count;			/* Index of next free entry. */
	int 			old_count;		/* Count at before last collection. */
	EIF_INTEGER_32 	*h_keys;		/* Array of keys (integers) */
	EIF_REFERENCE 	*h_values;		/* Array of pointers. */
	EIF_REFERENCE	*old_values;	/* Previous array of pointers. */
};

/* Function declaration */
extern int is_in_spt (struct special_table *spt, char *object);
extern int spt_create(struct special_table *spt, int size);		
						/* Create special table. */
extern int spt_realloc (struct special_table *spt, int size);		
						/* Reallocate special table. */
extern int spt_put(struct special_table *spt, register long key, char *val);				/* Insert value in special table */
extern int spt_put_old(struct special_table *spt, char *val);				/* Insert old value in special table */
extern void spt_force(struct special_table *spt, register long key, char *val);
		/* Insert value in special table (extending hash table if needed). */
extern int spt_replace(struct special_table *spt, char *old, char *val);
		/*  Replace the occurrence of `old' by `val' in `spt' */
extern int spt_xtend(struct special_table *spt);	
		/* Extend size of full special table */
extern void spt_zero(struct special_table *spt);
		/* Initialize special table to zero */
extern void spt_free(struct special_table *spt);	/* Free special table */

#ifdef __cplusplus
}
#endif

#endif
