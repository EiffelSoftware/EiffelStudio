/*
	EMAIN.TEMPLATE - Main entry point template for Windows. 
*/

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_macros.h"
#include "eif_sig.h"

extern void emain(int, EIF_NATIVE_CHAR **);
extern void egc_init_plug(void);
extern void egc_rcdt_init (void); 

int main (int argc, char ** argv, char ** envp)
{
	eif_alloc_init();
#ifdef EIF_THREADS
	eif_thr_init_root();
#endif
{
	GTCX
	struct ex_vect *exvect;
	jmp_buf exenv;

	egc_init_plug();
	initsig();
	initstk();
	exvect = exset((char *) 0, 0, (char *) 0);
	exvect->ex_jbuf = &exenv;
	if (setjmp(exenv))
		failure();

	eif_rtinit(argc, (EIF_NATIVE_CHAR **) argv, (EIF_NATIVE_CHAR **) envp);
	egc_rcdt_init (); 
	emain(argc, argv);
	reclaim();
	exit(0);
}
	return 0;
}

#ifdef __cplusplus
}
#endif
