/* CECIL program converting a C string into an Eiffel String */
#include <stdio.h>
#include "eif_setup.h"
#include "eif_eiffel.h"
#ifdef EIF_WIN32
#include "eif_econsole.h"
#endif

int main (int argc,char **argv,char **envp) {

	char s [256];
	unsigned char c;
	int i = 0;

	
	EIF_PROCEDURE p_put_string;	/* `put_string' from STD_FILES */
	EIF_REFERENCE_FUNCTION f_io;		/* `io' from GENERAL (function) */ 
	EIF_REFERENCE o_str;	/* Eiffel String */
	EIF_OBJECT obj; 			/* Protected indirection to o_str */
	EIF_REFERENCE o_io;		/* `io' from GENERAL (object) */
	EIF_OBJECT i_io;		/* safe indirection to `io' from GENERAL (object) */

	EIF_INITIALIZE (failure)	/* Initialization of Eiffel run-time */

	p_put_string = eif_procedure ("put_string", eif_type_id ("STD_FILES"));

		/* `io' is a once function. On the C side it is a function and
		 * an object. We call it on `root_obj' which is the root-object
		 * of the Eiffel system.
		 */
	f_io = eif_reference_function ("io", eif_type_id ("STD_FILES")); 
	o_io = (f_io) (root_obj); /* Call `io' (on root_obj, which is the root 
							   * object).`io' can be called on any object, 
							   * since every type inherits from GENERAL */

	i_io = eif_protect (o_io);	/* Protect `io' */
	

	printf ("Enter a string to convert in Eiffel string:\n");
		
	while ((c= (unsigned char) getchar ()) != '\n') {
		/* Read the line, build the C string */
		s [i++] = c;
	}
	s [i] = '\0';


	o_str = RTMS (s);	/* Eiffel Run-time macro, that converts a C string
						 * into an Eiffel String */
	obj = eif_protect (o_str);	/* protect the return value of RTMS, we will
							     * access to the Eiffel string through
								 * eif_access (obj)	*/

	printf ("Now printing the Eiffel string from Eiffel.\n\n");

		/* Call to `io.put_string'. Note that `print' can be called instead
	     * without any initialization of `io' */	
	(p_put_string) (eif_access (i_io), eif_access (obj));/* Call `io.put_string (o_str)' */
	printf ("\n");
	eif_wean (obj);		/* Unprotect Eiffel string  */
	eif_wean (i_io);	/* Unprotect `io' */
		
	EIF_DISPOSE_ALL		/* Reclaim object allocated by Eiffel run-time. */

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
