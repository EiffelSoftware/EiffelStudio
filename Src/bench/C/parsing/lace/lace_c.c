/*

 #         ##     ####   ######           ####            ####
 #        #  #   #    #  #               #    #          #    #
 #       #    #  #       #####           #               #
 #       ######  #       #               #        ###    #
 #       #    #  #    #  #               #    #   ###    #    #
 ######  #    #   ####   ###### #######   ####    ###     ####

		Routine for Lace syntax analysis
*/

#include <stdio.h>
#include "config.h"
#include "lace_c.h"
#include "hector.h"
#include "plug.h"

extern Malloc_t malloc();

/*
 * Declarations 
 */

int string_mode;	/* Is the parser reading a string? */
int to_parse_size;	/* Size of `to_parse' in string mode */
char *to_parse;		/* Current string being parsed by yacc (if string_mode)*/
char *file_name;

static char *id_string;		/* Eiffel string buffer (instance of ID_SD) */
static char *id_object;		/* Eiffel instance od ID_SD */
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
	id_string = eif_freeze(&id_string);	/* Object shouldn't move */

	id_object = create_node(ID_SD);
	id_object = eif_freeze(&id_object);

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
	extern char xxsbuf[];
	extern char *xxsptr;

	extern char *yacc_file_name;
#ifdef YYDEBUG
	extern int xxdebug;
#endif

	char buf[100];			/* Error message */
	int cancel;				/* Parsing cancelity */

	/* Initialization */
	string_mode = 0;
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

	/* Reset lex parser */
	xxsptr = xxsbuf;

	/*
	 * `id_pchar' is a reference on the attribute `area' of instance
	 * of ID_SD refered by `id_string'.
	 */
	id_pchar = *(char **) id_string;
	xxin = file_pointer;	
	cancel = xxparse();

	if (cancel) {
		rn_ast = (char *) 0;
		fprintf(stderr, "Syntax analysis canceled\n");
		exit(1);
	}
	return rn_ast;
}

char *lp_string(toparse,filename)
char *toparse;
char *filename;
{
	/* Parse Lace source string `to_parse'.
	 * Return root node fo the corresponding abstract syntax tree
	 */

	extern int xxparse();	/* Yacc parsing */
	extern int xxlineno;	/* Lex line number */
	extern int start_position;	/* Position in text of the first character
								 * in last token */
	extern int end_position;	/* Position in text of the last character
								 * in last token */
	extern char *yacc_file_name;
	extern char *xxsptr;
	extern char xxsbuf[];
#ifdef YYDEBUG
	extern int xxdebug;
#endif

	char buf[100];			/* Error message */
	int cancel;				/* Parsing cancelity */

	/* Initialization */
	to_parse_size = strlen(toparse);
	string_mode = 1;
	to_parse = toparse;
	xxlineno = 1;
	yacc_file_name = filename;
	
	/* Stack initialization */
	object_top = 0;
	count_top - -1;
	bzero (count_stack, count_size * sizeof(int));

	/* Reset lex */
	xxsptr = xxsbuf;

	/* Parsing */
#ifdef YYDEBUG
	xxdebug = 1;
#endif
	start_position = 0;
	end_position = 0;
	cancel = xxparse();

	/* Cancelation if error */	
	if (cancel) {
		/* Error during parsing */
		rn_ast = (char *) 0;
	}
#ifdef DEBUG
	printf("Finished with object_top = %d\n", object_top);
#endif
	return rn_ast;
}

char *lace_id (s, start, end)
char s[];
int start, end;
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
