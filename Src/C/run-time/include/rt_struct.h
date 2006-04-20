/*
	description: "Private structure definitions."
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

#ifndef _rt_struct_h_
#define _rt_struct_h_

#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef WORKBENCH
extern int32 **ecall;					/* Updated pointer */
extern struct rout_info *eorg_table;	/* Updated pointer */
extern struct desc_info ***desc_tab;	/* Global descriptor table */

/* Melting Ice technology */
extern unsigned char **melt;				/* Byte code array of melted eiffel features */
extern int *mpatidtab;			/* Table of pattern id's indexed by body id's */

#define Routids(x)	ecall[x]	/* Routine id array */
#endif

/*
 * Run time declarations (tables produced by the compiler).
 */

#ifndef WORKBENCH
RT_LNK long *nbref;		/* Gives # of references given DT */
#endif

/* Macro to extract from `cn_flags' of `node' of type `struct cnode' and gets
 * the appropriate information. */
#define EIF_IS_DEFERRED_FLAG			0x1000
#define EIF_IS_COMPOSITE_FLAG			0x0800
#define EIF_HAS_DISPOSE_FLAG			0x0400
#define EIF_IS_EXPANDED_FLAG			0x0200
#define EIF_IS_DECLARED_EXPANDED_FLAG	0x0100

#define EIF_TUPLE_CODE(node)				(EIF_TUPLE_CODE_MASK & (node).cn_flags)
#define EIF_IS_DEFERRED_TYPE(node)			(((node).cn_flags & EIF_IS_DEFERRED_FLAG) == EIF_IS_DEFERRED_FLAG)
#define EIF_IS_COMPOSITE_TYPE(node)			(((node).cn_flags & EIF_IS_COMPOSITE_FLAG) == EIF_IS_COMPOSITE_FLAG)
#define EIF_TYPE_HAS_DISPOSE(node)			(((node).cn_flags & EIF_HAS_DISPOSE_FLAG) == EIF_HAS_DISPOSE_FLAG)
#define EIF_IS_EXPANDED_TYPE(node)			(((node).cn_flags & EIF_IS_EXPANDED_FLAG) == EIF_IS_EXPANDED_FLAG)
#define EIF_IS_TYPE_DECLARED_AS_EXPANDED(node)	\
	(((node).cn_flags & EIF_IS_DECLARED_EXPANDED_FLAG) == EIF_IS_DECLARED_EXPANDED_FLAG)
#define EIF_NEEDS_REFERENCE_KEYWORD(node)	\
	(((node).cn_flags & (EIF_IS_DECLARED_EXPANDED_FLAG | EIF_IS_EXPANDED_FLAG)) == EIF_IS_DECLARED_EXPANDED_FLAG)
#define EIF_NEEDS_EXPANDED_KEYWORD(node)	\
	(((node).cn_flags & (EIF_IS_DECLARED_EXPANDED_FLAG | EIF_IS_EXPANDED_FLAG)) == EIF_IS_EXPANDED_FLAG)


#ifndef WORKBENCH
#define Cecil(type)			egc_ce_rname[type]			/* Final mode acces to hash table */
#define References(type)	nbref[type] 	/* # of references */
#define Dispose(type)		egc_edispose[type]	/* Dispose routine */
#define Disp_rout(type)		egc_edispose[type]	/* Does type have disp routine */
#define XCreate(type)		egc_ecreate[type]	/* Initialization routine */
#else
#define Cecil(type)			esystem[type].cn_cecil	/* Workbench mode access */
#define References(type)	esystem[type].cn_nbref
#define Disp_rout(type)		EIF_TYPE_HAS_DISPOSE(esystem[type]) /* Does type have disp routine ? */
#define Dispose(type) ((void (*)()) wdisp(type));
										/* Dispose routine */
#define XCreate(type)	     \
	(EIF_IS_COMPOSITE_TYPE(esystem[type]) ? (char *(*)()) wstdinit : (char *(*)()) 0)
#endif



#ifdef __cplusplus
}
#endif

#endif
