/* Externals for routine objects */

#ifndef _eif_rout_obj
#define _eif_rout_obj

#ifdef __cplusplus
extern "C" {
#endif
	

	/*---------------------*/
	/*  For typed element  */
	/*---------------------*/

	/* Packed structure representing all types that
	 * a location can hold. */
typedef union {
	EIF_BOOLEAN		barg;
	EIF_CHARACTER	carg;
	EIF_WIDE_CHAR	wcarg;
	EIF_DOUBLE		darg;
	EIF_INTEGER_8	i8arg;
	EIF_INTEGER_16	i16arg;
	EIF_INTEGER_32	i32arg;
	EIF_INTEGER_64	i64arg;
	EIF_POINTER		parg;
	EIF_REAL		farg;
	EIF_REFERENCE	rarg;
} EIF_ARG_UNION;

	/* Typed element */
typedef struct {
	EIF_ARG_UNION element;
	char type;
} EIF_TYPED_ELEMENT;

/* New object of type `dftype' with routine dispatcher `rout_disp',
   argument tuple `args', open map `omap' and closed map `cmap'
*/
RT_LNK EIF_REFERENCE rout_obj_create (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER true_rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap, EIF_REFERENCE cmap);
RT_LNK EIF_REFERENCE rout_obj_create2 (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER true_rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap);

/* Argument structure (alloc/free) */

RT_LNK EIF_POINTER rout_obj_new_args (EIF_INTEGER count);
RT_LNK void rout_obj_free_args (EIF_POINTER);

/* Calls */

RT_LNK void rout_obj_call_function (EIF_REFERENCE res, EIF_POINTER rout, EIF_POINTER args);

#ifdef WORKBENCH
RT_LNK void rout_obj_call_procedure_dynamic (EIF_INTEGER_32 body_id, EIF_ARG_UNION* args, EIF_REFERENCE types);
RT_LNK void rout_obj_call_function_dynamic (EIF_INTEGER_32 body_id, EIF_ARG_UNION* args, EIF_REFERENCE types, EIF_REFERENCE res);
#endif

/* Macros */

#define rout_obj_call_procedure(r,a) ((void(*)(char *, char *, EIF_ARG_UNION *))(r))(((EIF_ARG_UNION*)(a))[0].rarg, (char *)(((EIF_ARG_UNION*)(a))+1), (EIF_ARG_UNION *)0)

#define rout_obj_call_agent(r,a, val) ((val(*)(EIF_TYPED_ELEMENT *))(r))((EIF_TYPED_ELEMENT *)(a))

#define RBVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? EIF_FALSE : *((EIF_BOOLEAN *)v))
#define RCVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_CHARACTER) 0 : *((EIF_CHARACTER *)v))
#define RWCVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_WIDE_CHAR) 0 : *((EIF_WIDE_CHAR *)v))
#define RDVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_DOUBLE) 0.0 : *((EIF_DOUBLE *)v))
#define RFVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_REAL) 0.0 : *((EIF_REAL *)v))
#define RI8VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_8) 0 : *((EIF_INTEGER_8 *)v))
#define RI16VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_16) 0 : *((EIF_INTEGER_16 *)v))
#define RI32VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_32) 0 : *((EIF_INTEGER_32 *)v))
#define RI64VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_64) 0 : *((EIF_INTEGER_64 *)v))
#define RPVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_POINTER) 0 : *((EIF_POINTER *)v))

#define rout_obj_putb(a,i,v) (((EIF_ARG_UNION *)(a))[i].barg = RBVAL(v))
#define rout_obj_putc(a,i,v) (((EIF_ARG_UNION *)(a))[i].carg = RCVAL(v))
#define rout_obj_putwc(a,i,v) (((EIF_ARG_UNION *)(a))[i].wcarg = RWCVAL(v))
#define rout_obj_putd(a,i,v) (((EIF_ARG_UNION *)(a))[i].darg = RDVAL(v))
#define rout_obj_putf(a,i,v) (((EIF_ARG_UNION *)(a))[i].farg = RFVAL(v))
#define rout_obj_puti8(a,i,v) (((EIF_ARG_UNION *)(a))[i].i8arg = RI8VAL(v))
#define rout_obj_puti16(a,i,v) (((EIF_ARG_UNION *)(a))[i].i16arg = RI16VAL(v))
#define rout_obj_puti32(a,i,v) (((EIF_ARG_UNION *)(a))[i].i32arg = RI32VAL(v))
#define rout_obj_puti64(a,i,v) (((EIF_ARG_UNION *)(a))[i].i64arg = RI64VAL(v))
#define rout_obj_putp(a,i,v) (((EIF_ARG_UNION *)(a))[i].parg = RPVAL(v))
#define rout_obj_putr(a,i,v) (((EIF_ARG_UNION *)(a))[i].rarg = (EIF_REFERENCE) v)

#define rout_putb(a,i,v) (((EIF_ARG_UNION *)(a))[i].barg = (v))
#define rout_putc(a,i,v) (((EIF_ARG_UNION *)(a))[i].carg = (v))
#define rout_putwc(a,i,v) (((EIF_ARG_UNION *)(a))[i].wcarg = (v))
#define rout_putd(a,i,v) (((EIF_ARG_UNION *)(a))[i].darg = (v))
#define rout_putf(a,i,v) (((EIF_ARG_UNION *)(a))[i].farg = (v))
#define rout_puti8(a,i,v) (((EIF_ARG_UNION *)(a))[i].i8arg = (v))
#define rout_puti16(a,i,v) (((EIF_ARG_UNION *)(a))[i].i16arg = (v))
#define rout_puti32(a,i,v) (((EIF_ARG_UNION *)(a))[i].i32arg = (v))
#define rout_puti64(a,i,v) (((EIF_ARG_UNION *)(a))[i].i64arg = (v))
#define rout_putp(a,i,v) (((EIF_ARG_UNION *)(a))[i].parg = (v))
#define rout_putr(a,i,v) (((EIF_ARG_UNION *)(a))[i].rarg = (EIF_REFERENCE) v)

/* Copy TUPLE element s[j] into t[i] */
#define rout_tuple_item_copy(t,i,s,j) \
	(*((EIF_TYPED_ELEMENT *) (t) + i)).element = (*((EIF_TYPED_ELEMENT *) (s) + j)).element;\
	if (eif_item_type(t,i) == 'r') RTAS(eif_reference_item(s,j), t);

/***************************************/
/* Macros used for tuple manipulations */
/***************************************/

/* Macro to access data directly from tuple item */
#define eif_tuple_item_type(item)			((EIF_TYPED_ELEMENT *) (item))->type
#define eif_reference_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.rarg
#define eif_boolean_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.barg
#define eif_character_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.carg
#define eif_wide_character_tuple_item(item)	((EIF_TYPED_ELEMENT *) (item))->element.wcarg
#define eif_double_tuple_item(item)			((EIF_TYPED_ELEMENT *) (item))->element.darg
#define eif_integer_8_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.i8arg
#define eif_integer_16_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.i16arg
#define eif_integer_32_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.i32arg
#define eif_integer_64_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.i64arg
#define eif_pointer_tuple_item(item)		((EIF_TYPED_ELEMENT *) (item))->element.parg
#define eif_real_tuple_item(item)			((EIF_TYPED_ELEMENT *) (item))->element.farg

/* Macro for accessing type of tuple element */
#define eif_item_type(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->type

/* Macro for accessing tuple element value */
#define eif_boolean_item(tuple,pos)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.barg
#define eif_character_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.carg
#define eif_wide_character_item(tuple,pos)	((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.wcarg
#define eif_double_item(tuple,pos)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.darg
#define eif_integer_8_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i8arg
#define eif_integer_16_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i16arg
#define eif_integer_32_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i32arg
#define eif_integer_64_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i64arg
#define eif_pointer_item(tuple,pos)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.parg
#define eif_real_item(tuple,pos)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.farg
#define eif_reference_item(tuple,pos)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.rarg

/* Macro for setting tuple element value from a reference object
 * `val' should not be Void */
#define eif_put_boolean_item_with_object(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.barg = *(EIF_BOOLEAN *)(val)
#define eif_put_character_item_with_object(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.carg = *(EIF_CHARACTER *)(val)
#define eif_put_wide_character_item_with_object(tuple,pos,val)	((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.wcarg = *(EIF_WIDE_CHAR *)(val)
#define eif_put_double_item_with_object(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.darg = *(EIF_DOUBLE *)(val)
#define eif_put_integer_8_item_with_object(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i8arg = *(EIF_INTEGER_8 *)(val)
#define eif_put_integer_16_item_with_object(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i16arg = *(EIF_INTEGER_16 *)(val)
#define eif_put_integer_32_item_with_object(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i32arg = *(EIF_INTEGER_32 *)(val)
#define eif_put_integer_64_item_with_object(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i64arg = *(EIF_INTEGER_64 *)(val)
#define eif_put_pointer_item_with_object(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.parg = *(EIF_POINTER *)(val)
#define eif_put_real_item_with_object(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.farg = *(EIF_REAL *)(val)
#define eif_put_reference_item_with_object(tuple,pos,val)		eif_put_reference_item(tuple,pos,val)

/* Macro for setting tuple element value */
#define eif_put_boolean_item(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.barg = (EIF_BOOLEAN)(val)
#define eif_put_character_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.carg = (EIF_CHARACTER)(val)
#define eif_put_wide_character_item(tuple,pos,val)	((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.wcarg = (EIF_WIDE_CHAR)(val)
#define eif_put_double_item(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.darg = (EIF_DOUBLE)(val)
#define eif_put_integer_8_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i8arg = (EIF_INTEGER_8)(val)
#define eif_put_integer_16_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i16arg = (EIF_INTEGER_16)(val)
#define eif_put_integer_32_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i32arg = (EIF_INTEGER_32)(val)
#define eif_put_integer_64_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.i64arg = (EIF_INTEGER_64)(val)
#define eif_put_pointer_item(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.parg = (EIF_POINTER)(val)
#define eif_put_real_item(tuple,pos,val)			((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.farg = (EIF_REAL)(val)
#define eif_put_reference_item(tuple,pos,val)		((EIF_TYPED_ELEMENT *) (tuple) + pos)->element.rarg = (val); RTAS((val),(tuple))

#ifdef __cplusplus
}
#endif

#endif
