/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Definitions for workbench calls
*/

#ifndef _rt_wbench_h_
#define _rt_wbench_h_

#ifdef WORKBENCH

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

#endif /* WORKBENCH */

#endif
