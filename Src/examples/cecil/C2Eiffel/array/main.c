/* cecil example: create a an Eiffel array of integers from a C array */

#include <stdio.h>
#include "eif_setup.h"
#include "eif_eiffel.h"
	
int main (int argc,char **argv,char **envp) {

	EIF_INTEGER *c_array;
	int i;

	
	EIF_PROCEDURE p_make;		/* `make ' from MY_ARRAY [INTEGER] */
	EIF_PROCEDURE p_put;			/* `put' from MY_ARRAY [INTEGER] */
	EIF_PROCEDURE p_display;		/* `display' from MY_ARRAY [INTEGER] */
	EIF_TYPE_ID my_array_tid;	/* MY_ARRAY [INTEGER] type id */
	EIF_OBJECT o_array;		/* Protected indirection to an array of integers */

	EIF_INITIALIZE (failure)	/* Initialization of Eiffel run-time */

		/* Enable visible exception: raised whenever `eif_procedure'
		 * returns a NULL pointer. 
		 * Note: not necessary, since it is set by default */
	eif_enable_visible_exception ();

		/* Set Type id. */
		/* `eif_type_id has been extended to generic type since v4.3 */
	my_array_tid = eif_type_id ("MY_ARRAY[INTEGER]");	
	if (my_array_tid == EIF_NO_TYPE) 
			/* MY_ARRAY's type id not found. */
		eif_panic ("No type id.");

		/* Set procedures. */
	p_make = eif_procedure ("make", my_array_tid);	
	p_display = eif_procedure ("display", my_array_tid);
	p_put = eif_procedure ("put", my_array_tid);

		/* o_array is a protected indirection 
		 * it has to be accessed with `eif_access'
		 * and freed with `eif_wean' */	
	o_array = eif_create (my_array_tid);

		/* Call `make (1, 10)' on new array */
	(p_make) (eif_access (o_array), 1, 10);	

	printf ("Enter 10 integers:\n");
	c_array = (EIF_INTEGER *) malloc (10*sizeof (EIF_INTEGER));
		/* Set C array */
	for (i = 0; i < 10; i++) {
		printf ("Enter element %d: ", i + 1);
		scanf ("%ld", c_array+i);
	}
	printf ("\n");

		/* Set Eiffel array from C array */
	for (i = 0; i < 10; i++) 
				/* Call `put (value, i)' on array */
		(p_put) (eif_access (o_array), *(c_array+i), i+1);			

		
	(p_display) (eif_access (o_array));	/* Call `display on array */

	eif_wean (o_array);	/* Reclaim protected indirection so that the GC can
						 * collect it */

	EIF_DISPOSE_ALL		/* Reclaim all objects allocated by Eiffel run-time. */

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
