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

/* Routines to fill argument structure */

extern void rout_obj_putb (char *args, int idx, EIF_BOOLEAN b);
extern void rout_obj_putc (char *args, int idx, EIF_CHARACTER c);
extern void rout_obj_putd (char *args, int idx, EIF_DOUBLE d);
extern void rout_obj_puti (char *args, int idx, EIF_INTEGER i);
extern void rout_obj_putp (char *args, int idx, EIF_POINTER p);
extern void rout_obj_putf (char *args, int idx, EIF_REAL f);
extern void rout_obj_putr (char *args, int idx, EIF_REFERENCE r);

/* Calls */

extern void rout_obj_call_procedure (char *rout, char *tgt, char *args);
extern void rout_obj_call_function (char *cur, char *res, char *rout, char *tgt, char *args);

#endif

