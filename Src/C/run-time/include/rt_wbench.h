/*
	description: "Definitions for workbench calls."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_wbench_h_
#define _rt_wbench_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

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
		info = eorg_table[(y)]; \
		desc = (desc_tab[info.origin])[(z)]; \
		(x) = (desc[info.offset]).offset; \
	}	

#define CBodyId(x,y,z)	\
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)]; \
		desc = (desc_tab[info.origin])[(z)]; \
		(x) = (desc[info.offset]).body_index; \
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

extern void rt_wexp(int routine_id, EIF_TYPE_INDEX dyn_type, EIF_REFERENCE object);						/* Creation call for expanded types */

#ifdef __cplusplus
}
#endif

#endif /* WORKBENCH */

#endif
