/*
	description: "Declarations for features used by C generated code."
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

#ifndef _eif_helpers_h_
#define _eif_helpers_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Special conversion from EIF_NATURAL_64 to EIF_REAL_32 and EIF_REAL_64 as it is not
 * supported by all C compilers. */
rt_private EIF_REAL_32 eif_uint64_to_real32 (EIF_NATURAL_64 v) {
#ifdef HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT
	return (EIF_REAL_32) v;
#else
	return
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C (0x7FFFFFFFFFFFFFFF)) -
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C (0x8000000000000000));
#endif
}

rt_private EIF_REAL_64 eif_uint64_to_real64 (EIF_NATURAL_64 v) {
#ifdef HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT
	return (EIF_REAL_64) v;
#else
	return
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C(0x7FFFFFFFFFFFFFFF)) -
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C(0x8000000000000000));
#endif
}

/* Absolute value computation */
rt_private EIF_INTEGER_8 eif_abs_int8 (EIF_INTEGER_8 i) {
	return (i > 0 ? i : -i);
}
rt_private EIF_INTEGER_16 eif_abs_int16 (EIF_INTEGER_16 i) {
	return (i > 0 ? i : -i);
}
rt_private EIF_INTEGER_32 eif_abs_int32 (EIF_INTEGER_32 i) {
	return (i > 0 ? i : -i);
}
rt_private EIF_INTEGER_64 eif_abs_int64 (EIF_INTEGER_64 i) {
	return (i > 0 ? i : -i);
}
rt_private EIF_REAL_32 eif_abs_real32 (EIF_REAL_32 r) {
	return (r > 0 ? r : -r);
}
rt_private EIF_REAL_64 eif_abs_real64 (EIF_REAL_64 d) {
	return (d > 0 ? d : -d);
}

/* Max computation */
rt_private EIF_NATURAL_8 eif_max_uint8 (EIF_NATURAL_8 i, EIF_NATURAL_8 j) {
	return (i > j ? i : j);
}
rt_private EIF_NATURAL_16 eif_max_uint16 (EIF_NATURAL_16 i, EIF_NATURAL_16 j) {
	return (i > j ? i : j);
}
rt_private EIF_NATURAL_32 eif_max_uint32 (EIF_NATURAL_32 i, EIF_NATURAL_32 j) {
	return (i > j ? i : j);
}
rt_private EIF_NATURAL_64 eif_max_uint64 (EIF_NATURAL_64 i, EIF_NATURAL_64 j) {
	return (i > j ? i : j);
}
rt_private EIF_INTEGER_8 eif_max_int8 (EIF_INTEGER_8 i, EIF_INTEGER_8 j) {
	return (i > j ? i : j);
}
rt_private EIF_INTEGER_16 eif_max_int16 (EIF_INTEGER_16 i, EIF_INTEGER_16 j) {
	return (i > j ? i : j);
}
rt_private EIF_INTEGER_32 eif_max_int32 (EIF_INTEGER_32 i, EIF_INTEGER_32 j) {
	return (i > j ? i : j);
}
rt_private EIF_INTEGER_64 eif_max_int64 (EIF_INTEGER_64 i, EIF_INTEGER_64 j) {
	return (i > j ? i : j);
}
rt_private EIF_CHARACTER eif_max_char (EIF_CHARACTER i, EIF_CHARACTER j) {
	return (i > j ? i : j);
}
rt_private EIF_WIDE_CHAR eif_max_wide_char (EIF_WIDE_CHAR i, EIF_WIDE_CHAR j) {
	return (i > j ? i : j);
}
rt_private EIF_REAL_32 eif_max_real32 (EIF_REAL_32 i, EIF_REAL_32 j) {
	return ((i != i) || (i > j) ? i : j);
}
rt_private EIF_REAL_64 eif_max_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return ((i != i) || (i > j) ? i : j);
}

/* Min computation */
rt_private EIF_NATURAL_8 eif_min_uint8 (EIF_NATURAL_8 i, EIF_NATURAL_8 j) {
	return (i < j ? i : j);
}
rt_private EIF_NATURAL_16 eif_min_uint16 (EIF_NATURAL_16 i, EIF_NATURAL_16 j) {
	return (i < j ? i : j);
}
rt_private EIF_NATURAL_32 eif_min_uint32 (EIF_NATURAL_32 i, EIF_NATURAL_32 j) {
	return (i < j ? i : j);
}
rt_private EIF_NATURAL_64 eif_min_uint64 (EIF_NATURAL_64 i, EIF_NATURAL_64 j) {
	return (i < j ? i : j);
}
rt_private EIF_INTEGER_8 eif_min_int8 (EIF_INTEGER_8 i, EIF_INTEGER_8 j) {
	return (i < j ? i : j);
}
rt_private EIF_INTEGER_16 eif_min_int16 (EIF_INTEGER_16 i, EIF_INTEGER_16 j) {
	return (i < j ? i : j);
}
rt_private EIF_INTEGER_32 eif_min_int32 (EIF_INTEGER_32 i, EIF_INTEGER_32 j) {
	return (i < j ? i : j);
}
rt_private EIF_INTEGER_64 eif_min_int64 (EIF_INTEGER_64 i, EIF_INTEGER_64 j) {
	return (i < j ? i : j);
}
rt_private EIF_CHARACTER eif_min_char (EIF_CHARACTER i, EIF_CHARACTER j) {
	return (i < j ? i : j);
}
rt_private EIF_WIDE_CHAR eif_min_wide_char (EIF_WIDE_CHAR i, EIF_WIDE_CHAR j) {
	return (i < j ? i : j);
}
rt_private EIF_REAL_32 eif_min_real32 (EIF_REAL_32 i, EIF_REAL_32 j) {
	return ((i != i) || (i < j) ? i : j);
}
rt_private EIF_REAL_64 eif_min_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return ((i != i) || (i < j) ? i : j);
}

/* Three way comparison computation */
rt_private EIF_INTEGER_32 eif_twc_uint8 (EIF_NATURAL_8 i, EIF_NATURAL_8 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_uint16 (EIF_NATURAL_16 i, EIF_NATURAL_16 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_uint32 (EIF_NATURAL_32 i, EIF_NATURAL_32 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_uint64 (EIF_NATURAL_64 i, EIF_NATURAL_64 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_int8 (EIF_INTEGER_8 i, EIF_INTEGER_8 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_int16 (EIF_INTEGER_16 i, EIF_INTEGER_16 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_int32 (EIF_INTEGER_32 i, EIF_INTEGER_32 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_int64 (EIF_INTEGER_64 i, EIF_INTEGER_64 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_char (EIF_CHARACTER i, EIF_CHARACTER j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_wide_char (EIF_WIDE_CHAR i, EIF_WIDE_CHAR j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_real32 (EIF_REAL_32 i, EIF_REAL_32 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}
rt_private EIF_INTEGER_32 eif_twc_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return (i < j ? -1 : (j < i) ? 1 : 0);
}

/* INF and NaN tests */
rt_private EIF_BOOLEAN eif_is_inf_real_32 (EIF_REAL_32 x) {
	EIF_REAL_32 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_32 *)(l_x)) & 0x7F800000)==0x7F800000) &&
             ((*((EIF_NATURAL_32 *)(l_x)) & 0x007FFFFF)==0x00000000) );
}
rt_private EIF_BOOLEAN eif_is_inf_real_64 (EIF_REAL_64 x) {
	EIF_REAL_64 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x7FF0000000000000))==RTU64C(0x7FF0000000000000)) &&
             ((*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x000FFFFFFFFFFFFF))==RTU64C(0x0000000000000000)) );
}
rt_private EIF_BOOLEAN eif_is_nan_real_32 (EIF_REAL_32 x) {
	EIF_REAL_32 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_32 *)(l_x)) & 0x7F800000)==0x7F800000) &&
	         (*((EIF_NATURAL_32 *)(l_x)) & 0x007FFFFF) );
}

rt_private EIF_BOOLEAN eif_is_nan_real_64 (EIF_REAL_64 x) {
	EIF_REAL_64 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x7FF0000000000000))==RTU64C(0x7FF0000000000000)) &&
	          (*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x000FFFFFFFFFFFFF)) );
}
rt_private EIF_BOOLEAN eif_is_quiet_nan_real_32 (EIF_REAL_32 x) {
	EIF_REAL_32 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_32 *)(l_x)) & 0x7FC00000)==0x7FC00000) &&
              (*((EIF_NATURAL_32 *)(l_x)) & 0x007FFFFF) );
}
rt_private EIF_BOOLEAN eif_is_quiet_nan_real_64 (EIF_REAL_64 x) {
	EIF_REAL_64 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x7FF8000000000000))==RTU64C(0x7FF8000000000000)) &&
              (*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x000FFFFFFFFFFFFF)) );
}
rt_private EIF_BOOLEAN eif_is_signaling_nan_real_32 (EIF_REAL_32 x) {
	EIF_REAL_32 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_32 *)(l_x)) & 0x7FC00000)==0x7F800000) &&
	          (*((EIF_NATURAL_32 *)(l_x)) & 0x007FFFFF) );
}
rt_private EIF_BOOLEAN eif_is_signaling_nan_real_64 (EIF_REAL_64 x) {
	EIF_REAL_64 *l_x = &x;
	return EIF_TEST( ((*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x7FF8000000000000))==RTU64C(0x7FF0000000000000)) &&
              (*((EIF_NATURAL_64 *)(l_x)) & RTU64C(0x000FFFFFFFFFFFFF)) );
}

/* Floating point is_equal computation */
rt_private EIF_BOOLEAN eif_fpeq_real_32 (EIF_REAL_32 i, EIF_REAL_32 j) {
	return EIF_TEST(eif_is_nan_real_32(i) ? eif_is_nan_real_32(j) : i == j);
}
rt_private EIF_BOOLEAN eif_fpeq_real_64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return EIF_TEST(eif_is_nan_real_64(i) ? eif_is_nan_real_64(j) : i == j);
}

/* NaN constants */
rt_private EIF_REAL_32 eif_signaling_nan_real_32 () {
	EIF_NATURAL_32 s_nan = 0x7FA00000;
	EIF_NATURAL_32 *l_s_nan = &s_nan;
	return * ((EIF_REAL_32 *) l_s_nan);
}
rt_private EIF_REAL_64 eif_signaling_nan_real_64 () {
	EIF_NATURAL_64 s_nan = RTU64C(0x7FF4000000000000);
	EIF_NATURAL_64 *l_s_nan = &s_nan;
	return * ((EIF_REAL_64 *) l_s_nan);
}
rt_private EIF_REAL_32 eif_quiet_nan_real_32 () {
	EIF_NATURAL_32 q_nan = 0x7FC00000;
	EIF_NATURAL_32 *l_q_nan = &q_nan;
	return * ((EIF_REAL_32 *) l_q_nan);
}
rt_private EIF_REAL_64 eif_quiet_nan_real_64 () {
	EIF_NATURAL_64 q_nan = RTU64C(0x7FF8000000000000);
	EIF_NATURAL_64 *l_q_nan = &q_nan;
	return * ((EIF_REAL_64 *) l_q_nan);
}

#ifdef __cplusplus
}
#endif

#endif
