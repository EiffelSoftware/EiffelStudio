/*

 #    #  #####   ######  #    #   ####   #    #          #    #
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          ######
 # ## #  #    #  #       #  # #  #       #    #   ###    #    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###    #    #

		Definitions for workbench calls

*/

#ifndef _wbench_h_
#define _wbench_h_

#include "debug.h"			/* for onceadd() */
#include "update.h"			/* for update() */
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

extern fnptr **eif_address_table;		/* Table of $ operator encapsulation functions */
extern char *(*wfeat(int static_type, int32 feature_id, int dyn_type))(/* ??? */);				/* Feature call */
extern char *(*wpfeat(int32 origin, int32 offset, int dyn_type))(/* ??? */);				/* Precompiled feature call */
extern char *(*wfeat_inv(int static_type, int32 feature_id, char *name, char *object))(/* ??? */);			/* Nested feature call */
extern char *(*wpfeat_inv(int32 origin, int32 offset, char *name, char *object))(/* ??? */);			/* Nested precompiled feature call */
extern void wexp(int static_type, int32 feature_id, int dyn_type, char *object);						/* Creation call for expanded types */
extern void wpexp(int32 origin, int32 offset, int dyn_type, char *object);			/* Creation call for precomp expanded types */
extern char *(*wdisp(int dyn_type))(/* ??? */);          	/* Feature call for dispose routine */ 
extern long	wattr(int static_type, int32 feature_id, int dyn_type);					/* Attribute access */
extern long	wpattr(int32 origin, int32 offset, int dyn_type);					/* Precompiled attribute access */
extern long wattr_inv(int static_type, int32 feature_id, char *name, char *object);				/* Nested attribute access */
extern long wpattr_inv(int32 origin, int32 offset, char *name, char *object);				/* Nested precompiled attribute access*/
extern int wtype(int static_type, int32 feature_id, int dyn_type);						/* Creation type */
extern int wptype(int32 origin, int32 offset, int dyn_type);					/* Creation type of a precomp feature */


extern void init_desc(void);				/* Call structure initialization */
extern void put_desc(struct desc_info *desc_ptr, int org, int dtype);					/* Call structure insertion */
extern void put_mdesc(struct desc_info *desc_ptr, int org, int dtype);				/* Melted call structure insertion */
extern void create_desc(void);				/* Call structure creation */
extern char desc_fill;					/* Is it an actual insertion or do we 
										 * wish to compute the size ? */

#define IDSC(x,y,z) put_desc(x,y,z)		/* Descriptor initialization */
#define IMDSC(x,y,z) put_mdesc(x,y,z)	/* Melted descriptor initialization */

/* Macros for call structure manipulation:
 *  CAttrOffs(x,y,z)
 *  CBodyIdx(x,y,z)
 *	CFeatType(x,y,z)
 *  MPatId(x)
 *  FPatId(x)
 *  DLEMPatId(x)
 *  DLEFPatId(x)
 */

#define CAttrOffs(x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
	}	

#define CBodyIdx(x,y,z)	\
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
	}	

#define CFeatType(x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).type ;\
	}	

#define MPatId(x) mpatidtab[x]
#define FPatId(x) fpatidtab[x]
#define DLEMPatId(x) dle_mpatidtab[x]
#define DLEFPatId(x) dle_fpatidtab[x]

#ifdef __cplusplus
}
#endif

#endif
