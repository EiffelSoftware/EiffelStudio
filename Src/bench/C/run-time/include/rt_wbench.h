/*

 #    #  #####   ######  #    #   ####   #    #          #    #
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          ######
 # ## #  #    #  #       #  # #  #       #    #   ###    #    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###    #    #

		Definitions for workbench calls

*/

#ifndef _rt_wbench_h_
#define _rt_wbench_h_

#include "eif_wbench.h"	

#ifdef __cplusplus
extern "C" {
#endif

/* Macros for call structure manipulation:
 *  CAttrOffs(x,y,z)
 *  CBodyId(x,y,z)
 *  CGENFeatType(t,x,y,z)
 *  MPatId(x)
 *  FPatId(x)
 */

#define CAttrOffs(x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
	}	

#define CBodyId(x,y,z)	\
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
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

#ifdef __cplusplus
}
#endif

#endif
