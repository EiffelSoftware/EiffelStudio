/*
	description: "[
			Internal Data Representation. Used by EiffelStudio classic debugger and by the
			C storable mechanism.
			]"
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

#ifndef _idrs_h_
#define _idrs_h_

#include "eif_config.h"
#include "eif_portable.h"
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

#define IDR_ENCODE	0		/* Serialization */
#define IDR_DECODE	1		/* Deserialization */

/* Constants definitions for IDR routines */
#ifndef bool_t
#define bool_t	int
#endif

#ifndef FALSE
#define FALSE	0
#endif

#ifndef TRUE
#define TRUE	1
#endif

typedef struct idr {
	int i_op;			/* Type of operation */
	size_t i_size;			/* Size of buffer */
	char *i_buf;		/* Buffer where serialized data are stored */
	char *i_ptr;		/* Pointer into the serialized data */
} IDR;

typedef struct idrs {	/* An encoding/decoding IDR filter */
	IDR i_encode;		/* Stream used for encoding (serialization) */
	IDR i_decode;		/* Stream used for decoding (deserialization) */
} IDRF;

/*
 * User informations on the IDR streams.
 */

#define idrs_size(i)	((i)->i_size)
#define idrs_buf(i)		((i)->i_buf)
#define idrs_op(i)		((i)->i_op)

/*
 * IDR entry points
 */

RT_LNK int idrf_create(IDRF *idrf, size_t size);
RT_LNK void idrf_destroy(IDRF *idrf);
RT_LNK void idrf_reset_pos(IDRF *idrf);
RT_LNK bool_t idr_setpos(IDR *idrs, size_t pos);

#ifdef __cplusplus
}
#endif

#endif
