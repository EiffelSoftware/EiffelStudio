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
/*------------------------------------------------------------------*/

#define TERMINATOR			(int16) 0xFFFF
#define NONE_TYPE			(int16) 0xFFFE
#define LIKE_ARG_TYPE		(int16) 0xFFFD
#define LIKE_CURRENT_TYPE	(int16) 0xFFFC
#define LIKE_PFEATURE_TYPE	(int16) 0xFFFB
#define LIKE_FEATURE_TYPE	(int16) 0xFFFA
#define TUPLE_TYPE			(int16) 0xFFF9
#define FORMAL_TYPE			(int16) 0xFFF8
#define MAX_DFTYPE			(uint16) 0xFFF7

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
#define EIF_DOUBLE_CODE		0x03
#define EIF_REAL_CODE		0x04
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

/*------------------------------------------------------------------*/

extern char *eif_typename (int16);
extern int  eif_typename_len (int16);
extern int eif_gen_count_with_dftype (int16 dftype);
extern char eif_gen_typecode_with_dftype (int16 dftype, int pos);

#ifdef __cplusplus
}
#endif

#endif

