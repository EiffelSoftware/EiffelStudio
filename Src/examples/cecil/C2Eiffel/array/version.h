/* Version.h */
/* Use to make the ISE EIFFEL v4.3 CECIL examples work with v4.2 */

#if VERSION > 42
/* Nothing to do for renaming */
/* Do not use eif_generic_id */

#else	/* Mapping with v4.2 routine and types */

/* Function types */

#define EIF_OBJECT EIF_OBJ
#define EIF_PROCEDURE EIF_PROC
#define EIF_INTEGER_FUNCTION	EIF_FN_INT
#define EIF_REAL_FUNCTION 		EIF_FN_FLOAT
#define EIF_DOUBLE_FUNCTION		EIF_FN_DOUBLE
#define EIF_CHARACTER_FUNCTION 	EIF_FN_CHAR
#define EIF_BOOLEAN_FUNCTION 	EIF_FN_BOOL
#define EIF_POINTER_FUNCTION 	EIF_FN_POINTER
#define EIF_REFERENCE_FUNCTION 	EIF_FN_REF
#define EIF_BIT_FUNCTION 		EIF_FN_BIT

/* Getting function addresses */

#define eif_procedure	eif_proc
#define eif_integer_function	eif_fn_int
#define eif_real_function 		eif_fn_float
#define eif_double_function		eif_fn_double
#define eif_character_function 	eif_fn_char
#define eif_boolean_function 	eif_fn_bool
#define eif_pointer_function 	eif_fn_pointer
#define eif_reference_function 	eif_fn_ref

/* Bit */

#define eif_bit_attribute eif_bit_attr
#define eif_bit_set_attribute eif_bit_set_attr
#define EIF_NOT_BIT_FIELD	EIF_NO_BFIELD

/* Other Cecil functions */

#define eif_protect henter
#define	eif_make_string eif_makestr

#endif /* VERSION */




