#include "eif_setup.h"
#include "eif_eiffel.h"

int main(int argc,char **argv,char **envp);
void eiff_call (char *class_name, char *proc_name, EIF_OBJECT target);
void eiff_call_1_arg (char *class_name, char *proc_name, EIF_OBJECT target, EIF_OBJECT arg);
void cecil_test ();

EIF_OBJECT main_obj;	/* Eiffel object of type MAIN */
EIF_OBJECT linked_list;	/* Attribute of `main_obj': `linked_list' */

/************************************************************************/
#ifdef EIF_WIN32	/* Only for Windows */

APIENTRY WinMain(HANDLE hInstance, HANDLE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
	/* Winmain function which is called when linking on Windows 
	 * with the option -SUBSYSTEM:WINDOWS instead of
	 * -SUBSYSTEM:CONSOLE in the cecil.lnk file.
	 */
{
	char **eif_environ;
	int argc;
	char **argv;
	
		/* Initialization of the command line which is going to be passed to eiffel */
	get_argcargv (&argc, &argv);
	eif_environ = (char **) GetEnvironmentStrings();
	main(argc, argv, eif_environ);
	FreeEnvironmentStrings ((LPTSTR) eif_environ);
	return 0;
}

#endif /* EIF_WIN32 */

/************************************************************************/

void eiffel_call(char *class_name, char *proc_name, EIF_OBJECT target) 
	/* Call the procedure `proc_name' from class `class_name' on the 
	 * Eiffel object `target'. No argument given.
	 */
{
	EIF_PROCEDURE e_proc;	/* Eiffel procedure `proc_name' */
	EIF_TYPE_ID type_id;	/* Eiffel type identifier for class `class_name' */

	printf ("\n====== In eiffel_call ======\n");

		/* Get and print type identifier of Eiffel class. */	
	type_id = eif_type_id(class_name);
	if (type_id == EIF_NO_TYPE)	{
		fprintf (stderr,  "No type id for %s\n", class_name);
		eif_panic ("No type id");	/* Raise an Eiffel panic.*/
	}

   	printf ("\tEiffel type id = %d\n", type_id);

		/* Get and print the address of the Eiffel procedure. */
	e_proc = eif_procedure(proc_name, type_id);	
	if (e_proc == (EIF_PROCEDURE) 0) {
			/* if the visible exception is enabled, raise it instead */
		fprintf (stderr, "%s not visible\n", proc_name);
		eif_panic ("Routine not visible");	/* Check your Ace file */
	}
   	printf ("\tEiffel procedure %s 0x%x\n", proc_name, e_proc);

		/* Print direct reference to Eiffel object. */
	printf ("\tEiffel object = 0x%x\n", (EIF_REFERENCE)eif_access (target)); 

		/* Call Eiffel procedure on Eiffel object. */ 
	(e_proc)(eif_access (target));	
	printf ("\n====== Done ======\n");
}

/************************************************************************/

void eiffel_call_1_arg(char *class_name,char *proc_name,EIF_OBJECT target, EIF_OBJECT arg) 
	/* Call the procedure `proc_name' from class `class_name' on the 
	 * Eiffel object `object'. One argument given.
	 */
{
	EIF_PROCEDURE e_proc;
	EIF_TYPE_ID type_id;

	printf ("\n====== In eiffel_call_1_arg ======\n");

		/* Get and print type identifier of Eiffel class. */	
	type_id = eif_type_id(class_name); /* get type identifier of Eiffel class */
	if (type_id == EIF_NO_TYPE) {
		fprintf (stderr, "No type id for %s\n", class_name);
		eif_panic ("No type id");
	}
	printf ("\tEiffel type id = %d\n", type_id);

		/* Get and print the address of the Eiffel procedure. */
	e_proc = eif_procedure(proc_name, type_id);
	if (e_proc == (EIF_PROCEDURE) 0) {
			/* if the visible exception is enabled, raise it instead */
		fprintf (stderr, "%s not visible\n", proc_name);	/* Check your Ace file */
		eif_panic ("Routine not visible");
	}
		
   	printf ("\tEiffel procedure %s 0x%x\n", proc_name, e_proc);

		/* Print direct reference to Eiffel objects. */
	printf ("\tEiffel object = 0x%x\n", (EIF_REFERENCE) eif_access (target));
	printf ("\tEiffel object = 0x%x\n", (EIF_REFERENCE) eif_access (arg));

		/* Call Eiffel procedure on Eiffel object. */ 
	printf ("Execute the Eiffel code `print (linked_list)' from the C side:\n");
	(e_proc)(eif_access (target), eif_access (arg));
	printf ("\n====== Done ======\n");
}

/************************************************************************/

int main(int argc,char **argv,char **envp)
{
	/* Main function. Initialize, execute CECIL calls i
	 * and reclaim run-time.
	 */

	int main_id; 	/* Type id of MAIN */
	EIF_INITIALIZE(failure)	/* Initialize run-time */
		/* Initialize an instance of class MAIN. 
		 * This does not call the creation procedure. 
		 * The returned object is already protected (EIF_OBJECT).
		 */
#if VERSION >= 43
		/* Enable/Disable visible exception */
	printf ("Do you want to enable the visible exception? (y-yes, n-no):");
	switch (getchar ()) {
		case 'y': 	
			printf ("Enable visible exception\n");
			eif_enable_visible_exception ();	/* Default */
			break;
		default:
			printf ("Disable visible exception\n");
			eif_disable_visible_exception ();	
			break;
	}	
#endif
	main_id = eif_type_id ("MAIN");
	if (main_id == EIF_NO_TYPE)
		eif_panic ("No type id for MAIN");
	main_obj = eif_create(main_id);

		/* Call creation procedure on Eiffel object. */
	eiffel_call("MAIN", "make", main_obj);

		/* Call `test_linked_list' on Eiffel object. */
	eiffel_call("MAIN", "test_linked_list", main_obj);
	
		/* Call `print' on Eiffel object. */
	eiffel_call_1_arg("MAIN", "print", main_obj, main_obj); 

		/* Perform basic CECIL tests. */
	cecil_test();
	
	EIF_DISPOSE_ALL	/* Reclaim all objects allocated by the Eiffel run-time */

	return 0;
}

/************************************************************************/

void cecil_test() {

	/* Basic CECIL tests. */

	EIF_PROCEDURE p_proc;	/* Addres to the Eiffel procedure to test */
	EIF_PROCEDURE p_forth;	/* `forth' from LINKED_LIST */
	EIF_TYPE_ID string_id;		/* Type id of STRING */
	EIF_TYPE_ID linked_list_id;	/* Type id of LINKED_LIST */
	EIF_OBJECT i_linked_list;	/* safe pointer to `linked_list' from MAIN */
	EIF_REFERENCE o_linked_list;	/* Direct reference (unsafe) to `linked_list'
									 * from MAIN */
		/* for visibility test */ 
	char rout_name[64], class_name[64];	
	int type_id;

	printf ("\n====== In cecil_test ======\n");

		/* Get the protected "linked_list" field of the main object. */
	o_linked_list = eif_field((EIF_REFERENCE) eif_access(main_obj), "linked_list", EIF_REFERENCE);	
		/* Protect `o_linked_listect'. Get its indirection `linked_list'. */
	linked_list = (EIF_OBJECT) eif_protect(o_linked_list);
	printf ("\tprotected indirection of %x is %x\n", o_linked_list, linked_list);

		/* Get and print the type id of class STRING. */
	string_id = eif_type_id("STRING"); 
	if (string_id == EIF_NO_TYPE) 
		eif_panic ("No type id for STRING");
	
	printf ("\tEiffel type id of STRING = %d\n", string_id);

		/* Get the type id of class LINKED_LIST [STRING]. */
	linked_list_id = eif_type_id ("LINKED_LIST[STRING]");
	if (linked_list_id == EIF_NO_TYPE)
		eif_panic ("No type id for LINKED_LIST[STRING]");
   	printf ("\tEiffel type id of LINKED_LIST [STRING] = %d\n", linked_list_id);


		/* Get and print address of `forth' from LINKED_LIST. */
	p_forth = eif_procedure("forth", linked_list_id); 
	if (p_forth == (EIF_PROCEDURE) 0) 
		eif_panic ("forth not visible");	/* Check your Ace file */

	printf ("\tLinked List forth: %x\n", p_forth);

		/* Get the object corresponding to the "linked_list" field. */
	i_linked_list = eif_access(linked_list); 
	printf ("\tLinked list object = 0x%x\n", i_linked_list);

		/* Test visible exception */
	getchar ();
	printf ("Do you want to test the visibility of an Eiffel routine? (y-yes, n-no):\n");
	switch (getchar ()) {
		case 'y':	/* Test visibility of a routine in a class */
			
			printf ("Name of the routine (only procedure):");
			scanf ("%s", rout_name);
			printf ("Class name where the routine is defined:");
			scanf ("%s", class_name);
			type_id = eif_type_id (class_name);	/* Get type id of class `class_name' */
			if (type_id == EIF_NO_TYPE)	/* Do not find it in system */ 
				printf ("Class %s not in system\n", class_name);
			else {
				p_proc = eif_procedure (rout_name, type_id);
				if (p_proc == (EIF_PROCEDURE) 0)
					/* Raise a visible exception if enabled */
					printf ("This routine is not visible\n");
				else
					printf ("This routine is visible\n");
			}
			break;
		default:
			break;
	}	
			
				
		/* Test precondition violation */
	getchar ();
	printf ("Do you want raise a precondition violation? (y-yes, n-no):\n");
	switch (getchar ()) {
		case 'y':
		/* Execute 10 times the `forth' routine on the "linked_list" object. */
			printf ("Try to perform 10 forth on linked_list which has only five elements;\na precondition will be violated\n");

			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			(p_forth)(i_linked_list);
			printf ("No precondition violation raised! Check your Ace file\n");
			break;
		default:
			break;
	}
	printf ("\n====== Done ======\n");
}
