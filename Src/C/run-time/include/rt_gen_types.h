/*
	description: "Constants used for generic conformance."
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

#ifndef _rt_gen_types_h_
#define _rt_gen_types_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/*------------------------------------------------------------------*/
/* Constant values for special type                                 */
/* You must also update SHARED_GEN_CONF_LEVEL after adding          */
/* new codes!!                                                      */
/* Also see INVALID_DTYPE in eif_gen_conf.h                         */
/*------------------------------------------------------------------*/

#define TERMINATOR				0xFFFF
#define NONE_TYPE				0xFFFE
#define LIKE_ARG_TYPE			0xFFFD
#define LIKE_CURRENT_TYPE		0xFFFC
#define LIKE_PFEATURE_TYPE		0xFFFB
#define LIKE_FEATURE_TYPE		0xFFFA
#define TUPLE_TYPE				0xFFF9
#define FORMAL_TYPE				0xFFF8
#define PARENT_TYPE_SEPARATOR	0xFFF7

/* Currently we only support up to 4 annotations which can be read at once. */
#define ATTACHED_TYPE			0xFF11
#define DETACHABLE_TYPE			0xFF12
#define FROZEN_TYPE				0xFF14

/* Maximum valid type value one can have. */
#define MAX_DTYPE				0xFF00

/* conveniences */
#define RT_HAS_ANNOTATION_TYPE(g)	(((g) & 0xFFF0) == 0xFF10)
#define RT_IS_ATTACHED_TYPE(g)		(((g) & ATTACHED_TYPE) == ATTACHED_TYPE)
#define RT_IS_DETACHABLE_TYPE(g)	(((g) & DETACHABLE_TYPE) == DETACHABLE_TYPE)
#define RT_IS_FROZEN_TYPE(g)		(((g) & FROZEN_TYPE) == FROZEN_TYPE)

/* Offset that needs to be skipped when finding TUPLE_TYPE. It corresponds
 * to TUPLE_TYPE and nb generic parameters in current tuple type definition. */
#define TUPLE_OFFSET	2

/*------------------------------------------------------------------*/
/* One character codes for the basic types and one for all the      */
/* others. Make sure to assign different letters to new basic types.*/
/* You must update 'rout_obj.c' after adding new codes!!!           */
/* You must also update ROUTINE class after adding new codes!!      */
/*------------------------------------------------------------------*/

#define EIF_TUPLE_CODE_MASK 0x0F
#define EIF_REFERENCE_CODE	0x00
#define EIF_BOOLEAN_CODE	0x01
#define EIF_CHARACTER_CODE	0x02
#define EIF_REAL_64_CODE	0x03
#define EIF_REAL_32_CODE	0x04
#define EIF_POINTER_CODE	0x05
#define EIF_INTEGER_8_CODE	0x06
#define EIF_INTEGER_16_CODE	0x07
#define EIF_INTEGER_32_CODE	0x08
#define EIF_INTEGER_64_CODE	0x09
#define EIF_NATURAL_8_CODE	0x0A
#define EIF_NATURAL_16_CODE	0x0B
#define EIF_NATURAL_32_CODE 0x0C
#define EIF_NATURAL_64_CODE 0x0D
#define EIF_WIDE_CHAR_CODE	0x0E

#define EIF_EXPANDED_CODE_EXTENSION 0x10
#define EIF_BIT_CODE_EXTENSION 0x20

/*------------------------------------------------------------------*/

extern char eif_gen_typecode_with_dftype (EIF_TYPE_INDEX dftype, uint32 pos);

#ifdef EIF_ASSERTIONS
rt_private int rt_valid_type_index(int dftype) {
	if (dftype < (int) MAX_DTYPE) {
		return 1;
	} else {
		return 0;
	}
}
#endif

#ifdef __cplusplus
}
#endif

#endif

