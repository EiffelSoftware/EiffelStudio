/* Externals for routine objects */

#ifndef _eif_rout_obj
#define _eif_rout_obj

#ifdef __cplusplus
extern "C" {
#endif
	
/* New object of type `dftype' with routine dispatcher `rout_disp',
   target `tgt', argument tuple `args' and target_position `tpos'.
*/

extern char *rout_obj_create (int16 dftype, char *rout_disp, char *tgt, char *args, int16 tpos);

/* Union structure for arguments */

typedef union {

	EIF_BOOLEAN     barg;
	EIF_CHARACTER   carg;
	EIF_DOUBLE      darg;
	EIF_INTEGER     iarg;
	EIF_POINTER     parg;
	EIF_REAL        farg;
	EIF_REFERENCE   rarg;

} EIF_ARG_UNION;

/* Argument structure (alloc/free) */

extern char *rout_obj_new_args (int count);
extern void rout_obj_free_args (char *);

/* Calls */

extern void rout_obj_call_function (char *cur, char *res, char *rout, char *args);

/* Macros */

#define rout_obj_call_procedure(r,a) ((void(*)(char *, char *, EIF_ARG_UNION *))(r))(((EIF_ARG_UNION*)(a))[0].rarg, (char *)(((EIF_ARG_UNION*)(a))+1), (EIF_ARG_UNION *)0)

#define RBVAL(v) (((char*)(v))==0 ? EIF_FALSE : *((EIF_BOOLEAN *)v))
#define RCVAL(v) (((char*)(v))==0 ? (EIF_CHARACTER) 0 : *((EIF_CHARACTER *)v))
#define RDVAL(v) (((char*)(v))==0 ? (EIF_DOUBLE) 0.0 : *((EIF_DOUBLE *)v))
#define RIVAL(v) (((char*)(v))==0 ? (EIF_INTEGER) 0 : *((EIF_INTEGER *)v))
#define RPVAL(v) (((char*)(v))==0 ? (EIF_POINTER) 0 : *((EIF_POINTER *)v))
#define RFVAL(v) (((char*)(v))==0 ? (EIF_REAL) 0.0 : *((EIF_REAL *)v))

#define rout_obj_putb(a,i,v) (((EIF_ARG_UNION *)(a))[i].barg = RBVAL(v))
#define rout_obj_putc(a,i,v) (((EIF_ARG_UNION *)(a))[i].carg = RCVAL(v))
#define rout_obj_putd(a,i,v) (((EIF_ARG_UNION *)(a))[i].darg = RDVAL(v))
#define rout_obj_puti(a,i,v) (((EIF_ARG_UNION *)(a))[i].iarg = RIVAL(v))
#define rout_obj_putp(a,i,v) (((EIF_ARG_UNION *)(a))[i].parg = RPVAL(v))
#define rout_obj_putf(a,i,v) (((EIF_ARG_UNION *)(a))[i].farg = RFVAL(v))
#define rout_obj_putr(a,i,v) (((EIF_ARG_UNION *)(a))[i].rarg = (EIF_REFERENCE)v)
			
#ifdef __cplusplus
}
#endif

#endif
