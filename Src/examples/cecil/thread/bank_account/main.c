#include <stdio.h>
#include "eif_cecil.h"
#include "eif_setup.h"
#include "fext.h"
#ifdef EIF_WIN32
#include "eif_econsole.h"
#endif

#undef NDEBUG
#include <assert.h>

#define WITHDRAWERS 2
#define DEPOSITORS	3
#define INTERVAL 2

static struct bank_account *ba = NULL;	/* Shared bank account. */

extern EIF_PROCEDURE post;	/* POST_OFFICE.post */
extern EIF_OBJECT post_office;	/* POST_OFFICE object. */

int main (int argc, char **argv, char **envp)
{

	int i;
	EIF_OBJECT mutex = NULL;/* Shared mutex. */
	struct transaction *h;	/* Bank account's history. */
	EIF_TYPE_ID tid;	/* Multi-purpose eiffel type identifier. */
	EIF_OBJECT thr, 	/* CUSTOMER thread object. */
		boolean, 		/* BOOLEAN_REF object. */
		proxy; 			/* PROXY object. */	
	EIF_PROCEDURE make, /* CUSTOMER.make */
		mutex_make, 	/* MUTEX.make */
		post_make, 		/* POST_OFFICE.make */
		proxy_make, 	/* PROXY.make */
		bool_set, 		/* BOOLEAN_REF.set_item */
		bool_item; 		/* BOOLEAN_REF.item */
	EIF_INITIALIZE (failure)

	ba = (struct bank_account *) malloc (sizeof (struct bank_account));
	if (!ba)
		enomem ();
	ba->balance = 1000;
	h = (struct transaction *) malloc (LISTSZ * sizeof (struct transaction));
	if (!h)
		enomem ();
	ba->history = h;

	eif_enable_visible_exception ();

	/* Initialize a mutex object. */
	tid = eif_type_id ("MUTEX");
	if (tid == EIF_NO_TYPE)
		eif_panic ("Not a type");
	mutex_make = eif_procedure ("make", tid);
	mutex = eif_create (tid);
	mutex_make (eif_access (mutex));

	/* Initialize a BOOLEAN_REF object. */
	tid = eif_type_id ("BOOLEAN_REF");
	if (tid == EIF_NO_TYPE)
		eif_panic ("Not a type");
	boolean = eif_create (tid);
	bool_set = eif_procedure ("set_item", tid);
	(bool_set) (eif_access (boolean), EIF_FALSE);

	/* Initialize a PROXY [BOOLEAN_REF]  object. */
	tid = eif_type_id ("PROXY[BOOLEAN_REF]");
	if (tid == EIF_NO_TYPE)
		eif_panic ("Not a type");
	proxy = eif_create (tid);
	proxy_make = eif_procedure ("make", tid);
	(proxy_make) (eif_access (proxy), eif_access (boolean));
	

	/* Initialize a POST_OFFICE object. */
	tid = eif_type_id ("POST_OFFICE");
	if (tid == EIF_NO_TYPE)
		eif_panic ("Not a type");
	post_make = eif_procedure ("make", tid);
	post = eif_procedure ("post", tid);
	post_office = eif_create (tid);
	(post_make) (eif_access (post_office), 
				(EIF_POINTER) ba, 
				eif_access (proxy));

	/* Launching SAVERs. */
	tid = eif_type_id ("DEPOSITOR");
	make = eif_procedure ("make", tid);
	for (i = 0; i < DEPOSITORS; i ++) 
	{
		thr = eif_create (tid);
		(make) (eif_access (thr), (EIF_POINTER) ba, eif_access (mutex), eif_access (proxy));
	}

	/* Launching SPENDERs. */
	tid = eif_type_id ("WITHDRAWER");
	make = eif_procedure ("make", tid);
	for (i = 0; i < WITHDRAWERS; i ++) 
	{
		thr = eif_create (tid);
		(make) (eif_access (thr), (EIF_POINTER) ba, eif_access (mutex), eif_access (proxy));
	}
		

	
	eif_thr_join_all ();	/* Wait for child threads to terminate. */

	/* Free  C ressources. */
	free (h);
	free (ba);

	/* Free Eiffel ressources. */
	EIF_DISPOSE_ALL			
	
	return 0;
}


#ifdef EIF_WIN32
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	int argc;
	char **argv;
	char **envp;

	get_argcargv (&argc, &argv);
	envp = (char **) GetEnvironmentStrings ();
	return main(argc, argv, envp);
}
#endif
