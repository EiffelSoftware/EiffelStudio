#include "eif_setup.h"
#include "eif_eiffel.h"

EIF_OBJ main_obj;
EIF_OBJ ll;


ECall(char *x,char *y,EIF_OBJ z) 
{
	EIF_PROC ep;
	EIF_TYPE_ID eti;
	EIF_REFERENCE eo;

	printf ("\n====== In Ecall ======\n");

	eti = eif_type_id(x); printf ("\tEiffel type id = %d\n", eti);

	ep = eif_proc(y,eti); printf ("\tEiffel procedure %s 0x%x\n", y, ep);

	eo = (EIF_REFERENCE) eif_access(z); printf ("\tEiffel object = 0x%x\n", eo);

	(ep)(eo);
	printf ("\n====== Done ======\n");
}

ECall_1arg(char *x,char *y,EIF_OBJ z, EIF_OBJ arg) 
{
	EIF_PROC ep;
	EIF_TYPE_ID eti;
	EIF_REFERENCE eo, eo_arg;

	printf ("\n====== In Ecall_1arg ======\n");

	eti = eif_type_id(x); printf ("\tEiffel type id = %d\n", eti);

	ep = eif_proc(y, eti); printf ("\tEiffel procedure %s 0x%x\n", y, ep);

	eo = (EIF_REFERENCE) eif_access(z); printf ("\tEiffel object = 0x%x\n", eo);
	eo_arg = (EIF_REFERENCE) eif_access (arg); printf ("\tEiffel object = 0x%x\n",eo_arg);
	printf ("We execute here the Eiffel code `print (ll)' from the C side\n");
	(ep)(eo, eo_arg);
	printf ("\n====== Done ======\n");
}

main(int argc,char **argv,char **envp)
{

	EIF_INITIALIZE(failure)

	main_obj = eif_create(eif_type_id("MAIN"));
	ECall("MAIN", "make", main_obj);
	ECall("MAIN", "test_ll", main_obj);
	ECall_1arg("MAIN", "print", main_obj, main_obj); /* print `main_obj' */
	test_ll();
	
	EIF_DISPOSE_ALL
}

test_ll() {

EIF_PROC print_proc;
EIF_TYPE_ID string_id;
EIF_TYPE_ID ll_id;
EIF_OBJ ll_obj;
char *field_obj;

	printf ("\n====== In test_ll ======\n");
		/* 
		 * Get the protected "ll" field of the main object.
		 */
	field_obj = eif_field((EIF_REFERENCE) eif_access(main_obj), "ll", EIF_REFERENCE);
	ll = (EIF_OBJ) henter(field_obj);
 printf ("\teif_field returns: %x, %x\n", ll, field_obj);

		/* 
		 * Get the cecil id of class STRING
		 */
	string_id = eif_type_id("STRING"); printf ("\tEif id of STRING = %d\n", string_id);

		/* 
		 * Get the cecil id of class LINKED_LIST [STRING]
		 */
	ll_id = eif_generic_id("LINKED_LIST", string_id); printf ("\tEif id of LINKED_LIST [STRING] = %d\n", ll_id);


		/* 
		 */
	print_proc = eif_proc("forth", ll_id); printf ("\tLL print: %x\n", print_proc);

		/* 
		 * Get the object corresponding to the "ll" field
		 */
	ll_obj = (EIF_REFERENCE) eif_access(ll); printf ("\tLL object = 0x%x\n", ll_obj);

		/*
		 * Execture the print routine on the "ll" object
		 */
	printf ("Try to perform 10 forth on ll which has only five elements;\na precondition will be violated\n");

	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);
	(print_proc)(ll_obj);

	printf ("\n====== Done ======\n");
}
