/*
*/

#ifndef _eif_special_table_h_
#define _eif_special_table_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_config.h"
#include "eif_portable.h"

#ifdef EIF_REM_SET_OPTIMIZATION
#define	EIF_SPT_SZ	65536	
#endif	/* EIF_REM_SET_OPTIMIZATION */

struct special_table {
	int32 h_size;		/* Size of table */
	int32 count;		/* Index of last iserted items. */
	int32 old_count;		/* Index of last iserted items. */
	long *h_keys;		/* Array of keys (integers) */
	char **h_values;		/* Array of pointers. */
	char **old_values;		/* Previous array of pointers. */
};

/* Function declaration */
extern int is_in_spt (struct special_table *spt, char *object);
extern int spt_create(struct special_table *spt, int32 size);				/* Create special table */
extern int spt_put(struct special_table *spt, register long key, char *val);				/* Insert value in special table */
extern int spt_put_old(struct special_table *spt, char *val);				/* Insert old value in special table */
extern void spt_force(struct special_table *spt, register long key, char *val);				/* Insert value in special table (extending
									 * hash table if needed) */
extern int spt_replace(struct special_table *spt, char *old, char *val);
			/*  Replace the occurrence of `old' by `val' in `spt' */
extern int spt_xtend(struct special_table *spt);				/* Extend size of full special table */
extern void spt_zero(struct special_table *spt);				/* Initialize special table to zero */
extern void spt_free(struct special_table *spt);				/* Free special table */

#ifdef __cplusplus
}
#endif

#endif
