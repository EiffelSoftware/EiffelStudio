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
	Declarations for features used by C generated code.
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
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) 0x7FFFFFFFFFFFFFFF) -
	(EIF_REAL_32) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) 0x8000000000000000);
#endif
}

rt_private EIF_REAL_64 eif_uint64_to_real64 (EIF_NATURAL_64 v) {
#ifdef HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT
	return (EIF_REAL_64) v;
#else
	return
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) 0x7FFFFFFFFFFFFFFF) -
	(EIF_REAL_64) ((EIF_INTEGER_64) v & (EIF_INTEGER_64) 0x8000000000000000);
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
	return (i > j ? i : j);
}
rt_private EIF_REAL_64 eif_max_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return (i > j ? i : j);
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
	return (i < j ? i : j);
}
rt_private EIF_REAL_64 eif_min_real64 (EIF_REAL_64 i, EIF_REAL_64 j) {
	return (i < j ? i : j);
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



#ifdef __cplusplus
}
#endif

#endif
