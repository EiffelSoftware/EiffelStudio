#include "eif_eiffel.h"
#include "eif_except.h"

#define PROC		0
#define FN_REF		1
#define FN_BOOL		2
#define FN_CHAR		3
#define FN_INT		4
#define FN_REAL		5
#define FN_DOUBLE	6
#define FN_POINTER	7
#define FN_BIT		8
#define FIELD_REF	9


/*
 **************************************************************
 *                      Exception switch
 **************************************************************
 */
extern unsigned char eif_ignore_invisible;

c_ignore_invisible() 
{
	eif_ignore_invisible = (unsigned char) 1;
}


/*
 **************************************************************
 *                      FEATURE DISPATCH RESULTS
 **************************************************************
 */


EIF_OBJ		result_obj;
EIF_BOOLEAN	result_bool;
EIF_CHARACTER	result_char;
EIF_INTEGER	result_int;
EIF_REAL	result_float;
EIF_DOUBLE	result_double;
EIF_POINTER	result_pointer;
EIF_BIT		result_bit;


EIF_OBJ		c_result_obj()	{ return result_obj; }
EIF_BOOLEAN	c_result_bool() { return result_bool; }
EIF_CHARACTER	c_result_char() { return result_char; }
EIF_INTEGER	c_result_int() { return result_int; }
EIF_REAL	c_result_real() { return result_float; }
EIF_DOUBLE	c_result_double() { return result_double; }
EIF_POINTER	c_result_pointer() { return result_pointer; }
EIF_BIT		c_result_bit() { return result_bit; }


/*
 **************************************************************
 *                   CLASS & FEATURE VALIDITY
 **************************************************************
 */

EIF_BOOLEAN
c_is_class_visible(class_name)
	char	*class_name;
{
	return (eif_type_id(class_name) != EIF_NO_TYPE || eif_generic_id(class_name) != EIF_NO_TYPE); 
}

EIF_BOOLEAN
c_is_valid_feature(class_name, feature_name)
	char		*class_name;
	char		*feature_name;
{
	void 		*ef;
	EIF_TYPE_ID	eti;

	ef = NULL;

	eti = eif_type_id(class_name); 
	if (eti == EIF_NO_TYPE) eti = eif_generic_id(class_name); 
	if (eti != EIF_NO_TYPE) ef = eif_proc(feature_name, eti); 

	return (ef != NULL);
}


/*
 **************************************************************
 *                      OBJECT CREATION
 **************************************************************
 */

/*
 * create an object by name
 */
EIF_OBJ
c_create_obj(class_name, make_proc_name, make_arg)
	char		*class_name;
	char		*make_proc_name;
	EIF_OBJ		make_arg;
{
	EIF_OBJ		eo = NULL, main_obj;
	EIF_PROC	ep;
	EIF_TYPE_ID	eti;
	

	eti = eif_type_id(class_name); 
	if (eti != EIF_NO_TYPE) {
		main_obj = eif_create(eti);
		ep = eif_proc(make_proc_name, eti);
		eo = eif_access(main_obj);
		(ep)(eo, make_arg);
	}

	return eo;
}


/*
 **************************************************************
 *                      FEATURE DISPATCH
 **************************************************************
 */

/*
 * dispatch FEATURE call. Caller must inspect relevant result_xxx 
 * variable afterwards, except in the case of procedure call
 */
void
c_dispatch_feature(obj, feature_name, arg, feature_type)
	EIF_OBJ		obj;
	char		*feature_name;
	EIF_OBJ		arg;
	EIF_INTEGER	feature_type;
{
	void		*ef;
	EIF_TYPE_ID	eti;

	eti = Dtype(obj); 
	if (eti != EIF_NO_TYPE) {
		switch (feature_type) {

		case PROC:
		    ef = eif_proc(feature_name, eti); 
		    if (ef != NULL) ((EIF_PROC) ef)(obj, arg);
		    break;

		case FN_REF:
		    ef = eif_fn_ref(feature_name, eti); 
		    if (ef != NULL) result_obj = ((EIF_FN_REF) ef)(obj, arg);
		    break;

		case FN_BOOL:
		    ef = eif_fn_bool(feature_name, eti); 
		    if (ef != NULL) result_bool = ((EIF_FN_BOOL) ef)(obj, arg);
		    break;

		case FN_CHAR:
		    ef = eif_fn_char(feature_name, eti); 
		    if (ef != NULL) result_char = ((EIF_FN_CHAR) ef)(obj, arg);
		    break;

		case FN_INT:
		    ef = eif_fn_int(feature_name, eti); 
		    if (ef != NULL) result_int = ((EIF_FN_INT) ef)(obj, arg);
		    break;

		case FN_REAL:
		    ef = eif_fn_float(feature_name, eti); 
		    if (ef != NULL) result_float = ((EIF_FN_FLOAT) ef)(obj, arg);
		    break;

		case FN_DOUBLE:
		    ef = eif_fn_double(feature_name, eti); 
		    if (ef != NULL) result_double = ((EIF_FN_DOUBLE) ef)(obj, arg);
		    break;

		case FN_POINTER:
		    ef = eif_fn_pointer(feature_name, eti); 
		    if (ef != NULL) result_pointer = ((EIF_FN_POINTER) ef)(obj, arg);
		    break;

		case FN_BIT:
		    ef = eif_fn_bit(feature_name, eti); 
		    if (ef != NULL) result_bit = ((EIF_FN_BIT) ef)(obj, arg);
		    break;

		case FIELD_REF:
		    result_obj = eif_field(obj, feature_name, EIF_REFERENCE); 
		    break;

		default:
		    break;

		}
	}
}

/*
 *         +---------------------------------------------------+
 *         |                                                   |
 *         |                Copyright (c) 1998                 |
 *         |            Deep Thought Informatics P/L           |
 *         |        Australian Company Number 076 645 291      |
 *         |                                                   |
 *         | Duplication and distribution permitted with this  |
 *         | notice  intact.  Please send  modifications  and  |
 *         | suggestions  to the Deep Thought Informatics, in  |
 *         | the  interests  of maintenance  and improvement.  |
 *         |                                                   |
 *         |           email: info@deepthought.com.au          |
 *         |                                                   |
 *         +---------------------------------------------------+
 */

