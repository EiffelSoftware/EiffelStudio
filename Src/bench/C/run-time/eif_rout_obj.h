/* Externals for routine objects */

#ifndef _eif_rout_obj
#define _eif_rout_obj

#ifdef __cplusplus
extern "C" {
#endif
	
/* New object of type `dftype' with routine dispatcher `rout_disp',
   argument tuple `args', open map `omap' and closed map `cmap'
*/

RT_LNK EIF_REFERENCE rout_obj_create (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER true_rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap, EIF_REFERENCE cmap);

/* Union structure for arguments */

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

#ifdef __cplusplus
}
#endif

#endif
