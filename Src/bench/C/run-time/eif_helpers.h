/*

 #    #  ######  #       #####   ######  #####    ####           #    #
 #    #  #       #       #    #  #       #    #  #               #    #
 ######  #####   #       #    #  #####   #    #   ####           ######
 #    #  #       #       #####   #       #####        #   ###    #    #
 #    #  #       #       #       #       #   #   #    #   ###    #    #
 #    #  ######  ######  #       ######  #    #   ####    ###    #    #

	Declarations for features used by C generated code.

*/

#ifndef _eif_helpers_h_
#define _eif_helpers_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
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
rt_private EIF_REAL eif_abs_real (EIF_REAL r) {
	return (r > 0 ? r : -r);
}
rt_private EIF_DOUBLE eif_abs_double (EIF_DOUBLE d) {
	return (d > 0 ? d : -d);
}

/* Max computation */
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
rt_private EIF_REAL eif_max_real (EIF_REAL i, EIF_REAL j) {
	return (i > j ? i : j);
}
rt_private EIF_DOUBLE eif_max_DOUBLE (EIF_DOUBLE i, EIF_DOUBLE j) {
	return (i > j ? i : j);
}

/* Min computation */
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
rt_private EIF_REAL eif_min_real (EIF_REAL i, EIF_REAL j) {
	return (i < j ? i : j);
}
rt_private EIF_DOUBLE eif_min_DOUBLE (EIF_DOUBLE i, EIF_DOUBLE j) {
	return (i < j ? i : j);
}


#ifdef __cplusplus
}
#endif

#endif
