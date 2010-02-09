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

RT_LNK EIF_REAL_32 eif_real_32_nan;
RT_LNK EIF_REAL_32 eif_real_32_negative_infinity;
RT_LNK EIF_REAL_32 eif_real_32_positive_infinity;
RT_LNK EIF_REAL_64 eif_real_64_nan;
RT_LNK EIF_REAL_64 eif_real_64_negative_infinity;
RT_LNK EIF_REAL_64 eif_real_64_positive_infinity;

/* Special conversion from EIF_NATURAL_64 to EIF_REAL_32 and EIF_REAL_64 as it is not
 * supported by all C compilers. */
#ifdef HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT
#define eif_uint64_to_real32(v) ((EIF_REAL_32) v)
#else
rt_private EIF_REAL_32 eif_uint64_to_real32 (EIF_NATURAL_64 v) {
	return
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C (0x7FFFFFFFFFFFFFFF)) -
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C (0x8000000000000000));
}
#endif

#ifdef HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT
#define eif_uint64_to_real64(v) ((EIF_REAL_64) v)
#else
rt_private EIF_REAL_64 eif_uint64_to_real64 (EIF_NATURAL_64 v) {
	return
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C(0x7FFFFFFFFFFFFFFF)) -
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) RTI64C(0x8000000000000000));
}
#endif

/* Bit representations of REALs. */
rt_private EIF_NATURAL_32 eif_real_32_bits (EIF_REAL_32 x) {
		/* We use an union instead of *((EIF_NATURAL_32 *) &x) to avoid a `type-punned pointer'
		 * warning with gcc. */
	union {
		EIF_REAL_32 r32;
		EIF_NATURAL_32 n32;
	} xconvert;
	xconvert.r32 = x;
	return xconvert.n32;
}
rt_private EIF_NATURAL_64 eif_real_64_bits (EIF_REAL_64 x) {
		/* We use an union instead of *((EIF_NATURAL_32 *) &x) to avoid a `type-punned pointer'
		 * warning with gcc. */
	union {
		EIF_REAL_64 r64;
		EIF_NATURAL_64 n64;
	} xconvert;
	xconvert.r64 = x;
	return xconvert.n64;
}

/* INF and NaN tests */
rt_private int eif_is_nan_real_32 (EIF_REAL_32 v) {
#ifndef EIF_NAN_NON_NATIVE_METHOD
		/* See http://dev.eiffel.com/ieee_arithmetic which shows that the native implementation
		 * is usually faster regardless of the platform. */
	return v != v;
#else
		/* We keep the implementation that does not use any floating point operations to find out
		 * if we have a NaN. First we clear the sign mark, then we ensure that it starts with 0x7ff
		 * and that the mantissa is not 0. */
	EIF_NATURAL_32 value = eif_real_32_bits (v);
	value &= ~0x80000000;
	return (value > 0x7ff00000);
#endif
}
rt_private int eif_is_nan_real_64 (EIF_REAL_64 v) {
#ifndef EIF_NAN_NON_NATIVE_METHOD
		/* See http://dev.eiffel.com/ieee_arithmetic which shows that the native implementation
		 * is usually faster regardless of the platform. */
	return v != v;
#else
		/* We keep the implementation that does not use any floating point operations to find out
		 * if we have a NaN. First we clear the sign mark, then we ensure that it starts with 0x7f8
		 * and that the mantissa is not 0. */
	EIF_NATURAL_64 value = eif_real_64_bits (v);
	value &= ~RTU64C(0x8000000000000000);
	return (value > RTU64C(0x7ff0000000000000));
#endif
}
rt_private int eif_is_negative_infinity_real_32 (EIF_REAL_32 x) {
	return x == eif_real_32_negative_infinity;
}
rt_private int eif_is_negative_infinity_real_64 (EIF_REAL_64 x) {
	return x == eif_real_64_negative_infinity;
}
rt_private int eif_is_positive_infinity_real_32 (EIF_REAL_32 x) {
	return x == eif_real_32_positive_infinity;
}
rt_private int eif_is_positive_infinity_real_64 (EIF_REAL_64 x) {
	return x == eif_real_64_positive_infinity;
}

#ifndef EIF_IEEE_BEHAVIOR
/* For comparison purposes, we actually assume that NaN is the lowest value.
 * Per http://dev.eiffel.com/ieee_arithmetic the following algorithm are the 
 * ones which are running the quickest most of the time. It is a tradeoff.
 */

/* For REAL_32 */
rt_private int eif_is_equal_real_32 (EIF_REAL_32 d1, EIF_REAL_32 d2) {
	return (d1 == d1 ? d1 == d2 : d2 != d2);
}

rt_private int eif_is_less_real_32 (EIF_REAL_32 d1, EIF_REAL_32 d2) {
	return (d1 == d1 ? d1 < d2 : d2 == d2);
}

rt_private int eif_is_less_equal_real_32 (EIF_REAL_32 d1, EIF_REAL_32 d2) {
	return (d1 == d1 ? d1 <= d2 : 1);
}

rt_private int eif_is_greater_real_32 (EIF_REAL_32 d1, EIF_REAL_32 d2) {
	return (d2 == d2 ? d1 > d2 : d1 == d1);
}

rt_private int eif_is_greater_equal_real_32 (EIF_REAL_32 d1, EIF_REAL_32 d2) {
	return (d2 == d2 ? d1 >= d2 : 1);
}

/* For REAL_64 */
rt_private int eif_is_equal_real_64 (EIF_REAL_64 d1, EIF_REAL_64 d2) {
	return (d1 == d1 ? d1 == d2 : d2 != d2);
}

rt_private int eif_is_less_real_64 (EIF_REAL_64 d1, EIF_REAL_64 d2) {
	return (d1 == d1 ? d1 < d2 : d2 == d2);
}

rt_private int eif_is_less_equal_real_64 (EIF_REAL_64 d1, EIF_REAL_64 d2) {
	return (d1 == d1 ? d1 <= d2 : 1);
}

rt_private int eif_is_greater_real_64 (EIF_REAL_64 d1, EIF_REAL_64 d2) {
	return (d2 == d2 ? d1 > d2 : d1 == d1);
}

rt_private int eif_is_greater_equal_real_64 (EIF_REAL_64 d1, EIF_REAL_64 d2) {
	return (d2 == d2 ? d1 >= d2 : 1);
}


#endif

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
#ifdef EIF_IEEE_BEHAVIOR
	return ((i != i) || (i > j) ? i : j);
#else
	return (eif_is_greater_equal_real_32(i, j) ? i : j);
#endif
}
rt_private EIF_REAL_64 eif_max_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
#ifdef EIF_IEEE_BEHAVIOR
	return ((i != i) || (i > j) ? i : j);
#else
	return (eif_is_greater_equal_real_64(i, j) ? i : j);
#endif
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
#ifdef EIF_IEEE_BEHAVIOR
	return ((i != i) || (i < j) ? i : j);
#else
	return (eif_is_less_equal_real_32(i, j) ? i : j);
#endif
}
rt_private EIF_REAL_64 eif_min_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
#ifdef EIF_IEEE_BEHAVIOR
	return ((i != i) || (i < j) ? i : j);
#else
	return (eif_is_less_equal_real_64(i, j) ? i : j);
#endif
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
#ifdef EIF_IEEE_BEHAVIOR
	return (i < j ? -1 : (j < i) ? 1 : 0);
#else
	return (eif_is_less_real_32(i, j) ? -1 : eif_is_less_real_32(j, i) ? 1 : 0);
#endif
}
rt_private EIF_INTEGER_32 eif_twc_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
#ifdef EIF_IEEE_BEHAVIOR
	return (i < j ? -1 : (j < i) ? 1 : 0);
#else
	return (eif_is_less_real_64(i, j) ? -1 : eif_is_less_real_64(j, i) ? 1 : 0);
#endif
}


#ifdef __cplusplus
}
#endif

#endif
