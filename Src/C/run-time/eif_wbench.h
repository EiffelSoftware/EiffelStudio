/*
	description: "Definitions for workbench calls."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2010, Eiffel Software."
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

#ifndef _eif_wbench_h_
#define _eif_wbench_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_debug.h"
#include "eif_globals.h"
#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_REFERENCE_FUNCTION wfeat(int routine_id, EIF_TYPE_INDEX dtype); /* Feature call */
RT_LNK EIF_REFERENCE_FUNCTION wfeat_inv(int routine_id, char *name, EIF_REFERENCE object); /* Nested feature call */
RT_LNK uint32 wattr(int routine_id, EIF_TYPE_INDEX dtype);					/* Attribute access */
RT_LNK uint32 wattr_inv(int routine_id, char *name, EIF_REFERENCE object);	/* Nested attribute access */
RT_LNK EIF_TYPE wtype_gen(int routine_id, EIF_TYPE_INDEX dtype, EIF_TYPE_INDEX dftype);		/* Creation type (generic) */

RT_LNK EIF_REFERENCE_FUNCTION wdisp(EIF_TYPE_INDEX dyn_type); /* Feature call for dispose routine */ 
RT_LNK EIF_REFERENCE_FUNCTION wcopy(EIF_TYPE_INDEX dyn_type); /* Feature call for copy routine */ 
RT_LNK EIF_REFERENCE_FUNCTION wis_equal(EIF_TYPE_INDEX dyn_type); /* Feature call for is_equal routine */ 

RT_LNK void init_desc(void);				/* Call structure initialization */
RT_LNK void put_desc(const struct desc_info *desc_ptr, int org, int dtype);					/* Call structure insertion */
RT_LNK void put_mdesc(const struct desc_info *desc_ptr, int org, int dtype);				/* Melted call structure insertion */
RT_LNK void create_desc(void);				/* Call structure creation */
RT_LNK char desc_fill;					/* Is it an actual insertion or do we 
										 * wish to compute the size ? */

RT_LNK void eif_invoke_test_routine (EIF_REFERENCE obj, int body_id);

#define IDSC(x,y,z) put_desc(x,y,z)		/* Descriptor initialization */
#define IMDSC(x,y,z) put_mdesc(x,y,z)	/* Melted descriptor initialization */

#ifdef __cplusplus
}
#endif

#endif
