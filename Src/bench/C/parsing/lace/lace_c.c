/*

 #         ##     ####   ######           ####            ####
 #        #  #   #    #  #               #    #          #    #
 #       #    #  #       #####           #               #
 #       ######  #       #               #        ###    #
 #       #    #  #    #  #               #    #   ###    #    #
 ######  #    #   ####   ###### #######   ####    ###     ####

		Routine for Lace syntax analysis
*/

#include "config.h"
#include "err_msg.h"
#include "lace_c.h"
#include "hector.h"
#include "plug.h"

/*
 * Declarations 
 */

static char *id_string;		/* Eiffel string buffer (instance of ID_SD) */
static char *id_pchar;		/* Pointer associated to `id_string' */

/*
 * Definitions
 */

void lp_init()
{
	/* Initialization of the Eiffel-yacc interface: must be done
	 * after calling feature `init' on instance of YACC_INIT.
	 */

	int i;
	EIF_OBJ addr;

	/* Allocation of an Eiffel ID */
	id_string = create_node(ID_SD);
	id_string = eif_freeze((EIF_OBJ) (&id_string));	/* Object shouldn't move */

	/* Initialization of the buffer with Eiffel routine 'make' of
	 * class ID_SD.
	 */
	(*c_id_create)(id_string, (long) IDLENGTH);

	/* Initialization of the list managment */
	object_stack = (char **) cmalloc(STACK_CHUNK * sizeof(char *));
	object_size = STACK_CHUNK;
	object_top = 0;
	count_stack = (int *) cmalloc(STACK_CHUNK * sizeof(int));
	count_size = STACK_CHUNK;
	count_top = -1;

}

void lp_ebuild_init()
{
	/* Initialization of the list managment */
	object_stack = (char **) cmalloc(STACK_CHUNK * sizeof(char *));
	object_size = STACK_CHUNK;
	object_top = 0;
	count_stack = (int *) cmalloc(STACK_CHUNK * sizeof(int));
	count_size = STACK_CHUNK;
	count_top = -1;
}

char *lp_file(file_pointer, filename)
FILE *file_pointer;
char *filename;
{
	/* Parse Lace source file `file_pointer'. It assumes that the file
	 * has been correctly opened.
	 * Return root node fo the corresponding abstract syntax tree
	 */

	extern FILE *xxin;			/* Yacc source file pointer */
	extern int xxparse();		/* Yacc parsing */
	extern int xxlineno;		/* Lex line number */
	extern int start_position;	/* Position in text of the first character
								 * in last token */
	extern int end_position;	/* Position in text of the last character in
								 * last token */
	extern void reset_lace_lex_parser();

	extern char *yacc_file_name;
#ifdef YYDEBUG
	extern int xxdebug;
#endif

	char buf[100];			/* Error message */
	int cancel;				/* Parsing cancelity */

	/* Initialization */
	xxlineno = 1;
	start_position = 0;
	end_position = 0;
	yacc_file_name = filename;
	
	/* Stack initialization */
	object_top = 0;
	count_top = -1;
	bzero (count_stack, count_size * sizeof(int));

#ifdef YYDEBUG
	xxdebug = 1;
#endif

	reset_lace_lex_parser();

	/*
	 * `id_pchar' is a reference on the attribute `area' of instance
	 * of ID_SD refered by `id_string'.
	 */
	id_pchar = *(char **) id_string;
	xxin = file_pointer;	
	cancel = xxparse();

	if (cancel) {
		rn_ast = (char *) 0;
		print_err_msg(stderr, "Syntax analysis canceled\n");
		exit(1);
	}
	return rn_ast;
}

char *lace_id (s)
char s[];
{
	/* Create an instance of ID_SD with string `s' and test
	 * the hash table where all the different ids are stored in
	 * order to share them eventually.
	 */

	char *result;

	/* FIXME: put internal error if strlen(s) > MAXILEN... */
	strcpy(id_pchar, s);
	/* Set attribute `count' of instance of ID_SD `id_string' */
	(eif_strset)(id_string, strlen(s));

	result = create_node(ID_SD);

	(*c_id_create)(result, (long) strlen(s));
	object_arg[0] = id_string;
	(*init_array[ID_SD])(result);

	return result;
}
