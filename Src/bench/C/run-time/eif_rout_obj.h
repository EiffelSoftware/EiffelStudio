/* Externals for routine objects */

#ifndef _eif_rout_obj
#define _eif_rout_obj

/* New object of type `dftype' with routine dispatcher `rout_disp' */
extern char *rout_obj_create (int16 dftype, char *rout_disp);

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

extern void rout_obj_call_function (char *cur, char *res, char *rout, char *tgt, char *args);

/* Macros */

#define rout_obj_call_procedure(r,t,a) ((void(*)(char *, char *, EIF_ARG_UNION *))(r))((t), (a), (EIF_ARG_UNION *)0)

#define rout_obj_putb(a,i,v) (((EIF_ARG_UNION *)(a))[i].barg = *((EIF_BOOLEAN *)v))
#define rout_obj_putc(a,i,v) (((EIF_ARG_UNION *)(a))[i].carg = *((EIF_CHARACTER *)v))
#define rout_obj_putd(a,i,v) (((EIF_ARG_UNION *)(a))[i].darg = *((EIF_DOUBLE *)v))
#define rout_obj_puti(a,i,v) (((EIF_ARG_UNION *)(a))[i].iarg = *((EIF_INTEGER *)v))
#define rout_obj_putp(a,i,v) (((EIF_ARG_UNION *)(a))[i].parg = *((EIF_POINTER *)v))
#define rout_obj_putf(a,i,v) (((EIF_ARG_UNION *)(a))[i].farg = (EIF_REAL)v)
#define rout_obj_putr(a,i,v) (((EIF_ARG_UNION *)(a))[i].rarg = (EIF_REFERENCE)v)

#endif

