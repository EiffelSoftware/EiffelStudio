/*
	description: "Internal data representation."
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

#include "idrs.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern void eif_run_idr_thread_init (void);
#else
extern char *idr_temp_buf;				/*temporary buffer for idr float and double */
#endif

extern void run_idr_init (size_t idrf_size, int type);
extern void run_idr_destroy (void);
extern void check_capacity (IDR *bu, size_t size);
extern void idr_flush (void);
extern void ridr_multi_char (EIF_CHARACTER *obj, size_t num);
extern void widr_multi_char (EIF_CHARACTER *obj, size_t num);
extern void ridr_multi_any (char *obj, size_t num);
extern void widr_multi_any (char *obj, size_t num);
extern void ridr_multi_int8 (EIF_INTEGER_8 *obj, size_t num);
extern void widr_multi_int8 (EIF_INTEGER_8 *obj, size_t num);
extern void ridr_multi_int16 (EIF_INTEGER_16 *obj, size_t num);
extern void widr_multi_int16 (EIF_INTEGER_16 *obj, size_t num);
extern void ridr_multi_int32 (EIF_INTEGER_32 *obj, size_t num);
extern void widr_multi_int32 (EIF_INTEGER_32 *obj, size_t num);
extern void ridr_multi_int64 (EIF_INTEGER_64 *obj, size_t num);
extern void widr_multi_int64 (EIF_INTEGER_64 *obj, size_t num);
extern void ridr_norm_int (uint32 *obj);
extern void widr_norm_int (uint32 *obj);
extern void ridr_multi_float (EIF_REAL_32 *obj, size_t num);
extern void widr_multi_float (EIF_REAL_32 *obj, size_t num);
extern void ridr_multi_double (EIF_REAL_64 *obj, size_t num);
extern void widr_multi_double (EIF_REAL_64 *obj, size_t num);
extern void ridr_multi_bit (struct bit *obj, size_t num, size_t elm_siz);
extern void widr_multi_bit (struct bit *obj, size_t num, uint32 len, size_t elm_siz);
extern int idr_read_line(char *bu, size_t max_size);

#ifdef __cplusplus
}
#endif

