/*

 #    #  #####   ######  #    #   ####   #    #          #    #
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          ######
 # ## #  #    #  #       #  # #  #       #    #   ###    #    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###    #    #

		Definitions for workbench calls

*/

#ifndef _eif_wbench_h_
#define _eif_wbench_h_

#include "eif_debug.h"			/* for onceadd() */
#include "eif_update.h"			/* for update() */
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_FN_REF wfeat(int static_type, int32 feature_id, int dyn_type); /* Feature call */
RT_LNK EIF_FN_REF wpfeat(int32 origin, int32 offset, int dyn_type);	/* Precompiled feature call */
RT_LNK EIF_FN_REF wfeat_inv(int static_type, int32 feature_id, char *name, char *object); /* Nested feature call */
RT_LNK EIF_FN_REF wpfeat_inv(int32 origin, int32 offset, char *name, char *object);/* Nested precompiled feature call */
RT_LNK void wexp(int static_type, int32 feature_id, int dyn_type, char *object);						/* Creation call for expanded types */
RT_LNK void wpexp(int32 origin, int32 offset, int dyn_type, char *object);			/* Creation call for precomp expanded types */
RT_LNK EIF_FN_REF wdisp(int dyn_type); /* Feature call for dispose routine */ 
RT_LNK long	wattr(int static_type, int32 feature_id, int dyn_type);					/* Attribute access */
RT_LNK long	wpattr(int32 origin, int32 offset, int dyn_type);					/* Precompiled attribute access */
RT_LNK long wattr_inv(int static_type, int32 feature_id, char *name, char *object);				/* Nested attribute access */
RT_LNK long wpattr_inv(int32 origin, int32 offset, char *name, char *object);				/* Nested precompiled attribute access*/
RT_LNK int wtype(int static_type, int32 feature_id, int dyn_type);						/* Creation type */
RT_LNK int wptype(int32 origin, int32 offset, int dyn_type);					/* Creation type of a precomp feature */
RT_LNK int wtype_gen(int static_type, int32 feature_id, char *object);						/* Creation type (generic) */
RT_LNK int wptype_gen(int32 origin, int32 offset, char *object);						/* Creation type of a precomp generic feature */


RT_LNK void init_desc(void);				/* Call structure initialization */
RT_LNK void put_desc(struct desc_info *desc_ptr, int org, int dtype);					/* Call structure insertion */
RT_LNK void put_mdesc(struct desc_info *desc_ptr, int org, int dtype);				/* Melted call structure insertion */
RT_LNK void create_desc(void);				/* Call structure creation */
RT_LNK char desc_fill;					/* Is it an actual insertion or do we 
										 * wish to compute the size ? */

#define IDSC(x,y,z) put_desc(x,y,z)		/* Descriptor initialization */
#define IMDSC(x,y,z) put_mdesc(x,y,z)	/* Melted descriptor initialization */

/* Macros for call structure manipulation:
 *  CAttrOffs(x,y,z)
 *  CBodyIdx(x,y,z)
 *	CFeatType(x,y,z)
 *  CGENFeatType(t,x,y,z)
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

#define CGENFeatType(t,x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(t) = (desc[info.offset]).type ;\
		(x) = (desc[info.offset]).gen_type ;\
	}

#define MPatId(x) mpatidtab[x]
#define FPatId(x) egc_fpatidtab[x]
#define DLEMPatId(x) dle_mpatidtab[x]
#define DLEFPatId(x) dle_fpatidtab[x]

#ifdef __cplusplus
}
#endif

#endif
