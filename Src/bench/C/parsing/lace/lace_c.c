/*

 #         ##     ####   ######           ####            ####
 #        #  #   #    #  #               #    #          #    #
 #       #    #  #       #####           #               #
 #       ######  #       #               #        ###    #
 #       #    #  #    #  #               #    #   ###    #    #
 ######  #    #   ####   ###### #######   ####    ###     ####

		Routine for Lace syntax analysis
*/

#include "eif_config.h"
#include "eif_err_msg.h"
#include "lace_c.h"
#include "eif_hector.h"
#include "eif_plug.h"

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

char *lp_file(FILE *file_pointer, char *filename)
{
	/* Parse Lace source file `file_pointer'. It assumes that the file
	 * has been correctly opened.
	 * Return root node fo the corresponding abstract syntax tree
	 */

	extern FILE *xxin;			/* Yacc source file pointer */
	extern int xxparse();		/* Yacc parsing */
	extern int xxlineno;		/* Lex line number */
	extern struct location *current_location;   /* Record the position of the first, and the 
												 * last character in last token 
												 * Record also the line number of the token */
	extern void reset_lace_lex_parser();

	extern char *yacc_file_name;
#ifdef YYDEBUG
	extern int xxdebug;
#endif

	int cancel;				/* Parsing cancelity */

	/* Initialization */
	xxlineno = 1;
	current_location = (struct location *) cmalloc (sizeof (struct location));
	current_location->start_position = 0;
	current_location->end_position = 0;
	current_location->line_number = 0;
	yacc_file_name = filename;
	
	/* Stack initialization */
	object_top = 0;
	count_top = -1;
	memset  (count_stack, 0, count_size * sizeof(int));

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

char *lace_id (char s[])
{
	/* Create an instance of ID_SD with string `s' and test
	 * the hash table where all the different ids are stored in
	 * order to share them eventually.
	 */

	char *result;

	/* FIXME: put internal error if strlen(s) > MAXILEN... */
	strcpy(id_pchar, s);
	/* Set attribute `count' of instance of ID_SD `id_string' */
	(egc_strset)(id_string, strlen(s));

	result = create_node(ID_SD);

	(*c_id_create)(result, (long) strlen(s));
	object_arg[0] = id_string;
	(*init_array[ID_SD])(result);

	return result;
}
