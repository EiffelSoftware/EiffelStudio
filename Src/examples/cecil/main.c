#include "eiffel.h"
#include "except.h"

EIF_OBJ main_obj;
EIF_OBJ ll;


ECall(x,y,z) 
char *x;
char *y;
EIF_OBJ *z;

{
	EIF_PROC ep;
	EIF_TYPE_ID eti;
	EIF_OBJ eo;

	printf ("\n====== In Ecall ======\n");

	eti = eif_type_id(x); printf ("\tEiffel type id = %d\n", eti);

	ep = eif_proc(y,eti); printf ("\tEiffel procedure %s 0x%x\n", y, ep);

	eo = eif_access(z); printf ("\tEiffel object = 0x%x\n", eo);

	(ep)(eo);
	printf ("\n====== Done ======\n");
}

main(argc, argv, envp)
int argc;
char **argv;
char **envp;
{

    struct ex_vect *exvect;
    jmp_buf exenv;
 
    initsig();
    initstk();
    exvect = exset((char *) 0, 0, (char *) 0);
    exvect->ex_jbuf = (char *) exenv;
    if (echval = setjmp(exenv))
        failure();
 
	eif_rtinit (argc, argv, envp);

	main_obj = eif_create(eif_type_id("MAIN"));
	ECall("MAIN", "make", main_obj);
	ECall("MAIN", "test_ll", main_obj);
	ECall("MAIN", "print", main_obj);
	test_ll();
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
	field_obj = eif_field(eif_access(main_obj), "ll", EIF_REFERENCE);
	ll = henter(field_obj); printf ("\teif_field returns: %x, %x\n", ll, field_obj);

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
	ll_obj = eif_access(ll); printf ("\tLL object = 0x%x\n", ll_obj);

		/*
		 * Execture the print routine on the "ll" object
		 */
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
