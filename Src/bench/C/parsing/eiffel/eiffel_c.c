/*

 ######     #    ######  ######  ######  #                ####            ####
 #          #    #       #       #       #               #    #          #    #
 #####      #    #####   #####   #####   #               #               #
 #          #    #       #       #       #               #        ###    #
 #          #    #       #       #       #               #    #   ###    #    #
 ######     #    #       #       ######  ###### #######   ####    ###     ####

	External C routine for Eiffel syntax analysis
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"
#include "eiffel_c.h"
#include "eif_plug.h"
#include <stdio.h>
#ifdef EIF_VMS
#include <ctype.h>	/* for isupper, tolower */
#endif

/*
 * Declarations 
 */

static char *id_string;	/* Eiffel string buffer (instance of ID_AS) */
static char *id_pchar;		/* Pointer associated to `id_string' */

fnptr c_set_put;			/* Pointer on Eiffel feature `put' of class
							 * SUPLIERS_AS.
							 */
char *suppliers;			/* Instance of SUPPLIERS_AS where all the 
							 * supplier types are stored.
							 */
extern int nb_tilde;		/* Number of tildes */

/*
 * Declarations for generic parameter managment
 */

static char *Generic_name[MAX_GENERICS];	/* Array of formal generic name */
static int nb_generics;				/* Number of formal generic parameter
									 * name actualy in Generic_name.
									 */
static int generic_count;
static char *formals[MAX_GENERICS];			/* Array of formals: Shared Eiffel instances
									 * of class FORMAL_AS.
									 */

static int is_free(char *s);

/*
 * Definitions
 */

void eif_init(void)
{
	/* Initialization of the Eiffel-yacc interface: must be done
	 * after calling feature `init' on instance of YACC_INIT.
	 */

	int i;
	char *formal;

	/* Allocation of an Eiffel ID */
	id_string = create_node(ID_AS);
	id_string = eif_freeze((EIF_OBJ) (&id_string));	/* Object shouldn't move */

	/* Initialization of the buffer with Eiffel routine 'Create' of
	 * class ID_AS.
	 */
	(*c_id_create)(id_string, (long) IDLENGTH);

	/* Initialization of the formal generic type array. */
	for(i=0; i<MAX_GENERICS; i++) {
		int_arg[0] = i + 1;
		formal = create_node(FORMAL_AS);
		formal = eif_freeze((EIF_OBJ) (&formal));	/* Object shouldn't move */
		(*init_array[FORMAL_AS])(formal);
	}

}

char *c_parse(FILE *f, char *filename)
{
	/* Parse Eiffel source file named `filename'.
	 * Return root node fo the corresponding abstract syntax tree
	 */

	extern FILE *yyin;					/* Yacc source file pointer */
	extern int yyparse(void);				/* Yacc parsing */
	extern int yylineno;				/* Lex line number */
	extern char *yacc_file_name;		/* Eiffel file name */
	extern void reset_eiffel_lex_parser(void);
#ifdef YYDEBUG
	extern int yydebug;
#endif

	int cancel;				/* Parsing cancelity */
	int i;

	/* Initialization */
	yylineno = 1;
	yacc_file_name = filename;
	yyin = f;
	current_location = (struct location *) cmalloc (sizeof (struct location));
	current_location->start_position = 0;
	current_location->end_position = 0;
	current_location->line_number = 0;

	reset_eiffel_lex_parser();

	/* Creation of the set of suppliers */
	suppliers = create_node(SUPPLIERS_AS);
	/* Call of feature `Create' of class SUPPLIERS_AS */
	(*init_array[SUPPLIERS_AS])(suppliers);

	/* Re-evaluation of `id_phar' : Gc is off so this reference won't move
	 * This is a magouille, we know that references are placed at the top
	 * of the object structure, and that STRING (ID_AS) class only has one
	 * reference, namely to the `area'. Hence the following instruction
	 * will save the address of the `area'.
	 */ 
	 
	id_pchar = *(char **) id_string;

	/* Initialization of formal generical parameter */
	nb_generics = 0;
	generic_count = 0;

	/* Stack initialization */
	object_top = 0;
	count_top = -1;
	bzero (count_stack, count_size * sizeof(int));
	generic_count = 0;

	/* Parsing */
#ifdef YYDEBUG
	yydebug = 1;
#endif
	cancel = yyparse();

	/* Free Generic_name array */
	if (nb_generics)
		for (i=0; i < nb_generics; i++)
			free(Generic_name[i]);

#ifdef DEBUG
	printf("Finished with object_top = %d\n", object_top);
#endif
	return rn_ast;
}

void c_get_set_put(fnptr put)
{
	/* Initialize pointer on feature `put' of class SUPPLIERS_AS. */

	c_set_put = put;
}

/*
 * Managing the formal Eiffel generic parameter: esential for the
 * instantiation process. Yacc parser formal declared generic parameter
 * of an Eiffel class. When encoutering a formal generic parameter in
 * a type supplier of the class, it does the pattern matching and
 * creates instances fo FORMAL_AS with their `position' well calculated.
 */

void generic_inc(void)
{
	/* Increment the number of formal generic parameter found. */
	generic_count++;
}

/*
 * Default clause for an inspect instruction
 */
char *inspect_else(void)
{
	/* Return an instruction list as default part of a
	 * multi-branch instruction. This list can be empty. */
 
	char *result = list_new(CONSTRUCT_LIST_AS);
	return result;
}

char *create_generic(char *gen_name, char *constrained, char *creation_routines)
{
	/* Return a formal generic parameter. */

	char *result;		/* Eiffel instance of FORMAL_AS */

	if ((gen_name[0] == '\0') && !constrained)
		return (char *) 0;

	/* Save the name of the generic parameter. */
	if (nb_generics <  MAX_GENERICS)
		Generic_name[nb_generics++] = str_save(gen_name);
	else
			/* Create a special syntax error if MAX_GENERICS generic
			 * parameters have already been found. The following
			 * comment is invalid!.
			 */
		(*syntax9)(Error_handler);

	/* Even if already MAX_GENERICS generic parameters have been found, we
	 * create a new FORMAL_GENERIC node. The error will be reported
	 * later on, during semantic checks.
	 */

	/* Creation of an Eiffel instance of FORMAL_AS */
	result = create_node(FORMAL_DEC_AS);
	object_arg[0] = create_id(gen_name);
	object_arg[1] = constrained;
	object_arg[2] = creation_routines;
	int_arg[0] = generic_count;
	(*init_array[FORMAL_DEC_AS])(result);

	return result;
}

/*
 * Creating Eiffel objects
 */

char *create_class(char *cl_name, char deferred, char expanded, char separate, char *indexes, char *generics, char *obsolete, char *parents, char *creators, char *features, char *invariant, char *cl_list, int end_pos)
{
	/* Create an instance of CLASS_AS */
	
	char *result;

	if (!cl_name)
		return (char *) 0;
	result = create_node(CLASS_AS);
	object_arg[0] = cl_name;
	object_arg[1] = indexes;
	object_arg[2] = generics;
	object_arg[3] = parents;
	object_arg[4] = creators;
	object_arg[5] = features;
	object_arg[6] = invariant;
	object_arg[7] = suppliers;
	object_arg[8] = cl_list;
	object_arg[9] = obsolete;
	bool_arg[0] = deferred;
	bool_arg[1] = expanded;
	bool_arg[2] = separate;
	int_arg[0] = end_pos;

	(*init_array[CLASS_AS])(result);

	return result;
}

char *create_id(char *s)
{
	/* Create an instance of ID_AS with string `s' and test
	 * the hash table where all the different ids are stored in
	 * order to share them eventually.
	 */

	char *result;

	/* Fill the Eiffel string buffer with `s' */
	strcpy(id_pchar, s);

	/* Memory allocation */
	result = create_node(ID_AS);
	/* Set attribute `count' of instance of ID_AS `id_string' */
	(egc_strset)(id_string, strlen(s));

	/* Initialization of the new Eiffel instance of ID_AS through
	 * feature `Create' of class ID_AS.
	 */
	(*c_id_create)(result, (long) strlen(s));

	/* Fill the new Eiffel id with the buffer */
	object_arg[0] = id_string;
	(*init_array[ID_AS])(result);

	return result;
}

char *create_type_class(char *id, char *generics)
{
	/* Create a class type. Take care of formal generics. */

	int i;
	char *s;
	char *formal;

	/* Look for a formal generic parameter. */
	s = (char *)(c_id_area)(id);
	if (!generics) {
		for(i=0;i<nb_generics;i++)
			if(!strcmp(s, Generic_name[i])) {
#ifdef DEBUG
printf("Generic #%d recognized\n", i);
#endif
				int_arg [0] = i + 1;
				formal = create_node(FORMAL_AS);
				(*init_array[FORMAL_AS])(formal);
				return formal;
			}
	}

	if (0 == strcmp(s,"character"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(CHAR_TYPE_AS);
	else if (0 == strcmp(s,"boolean"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(BOOL_TYPE_AS);
	else if (0 == strcmp(s,"integer"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(INT_TYPE_AS);
	else if (0 == strcmp(s,"real"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(REAL_TYPE_AS);
	else if (0 == strcmp(s,"double"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(DOUBLE_TYPE_AS);
	else if (0 == strcmp(s,"none"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(NONE_TYPE_AS);
	else if (0 == strcmp(s,"pointer"))
		if (generics)
			(*syntax8)(Error_handler);
		else
			return create_node(POINTER_TYPE_AS);
	else {
		/* It is a common class type */

		/* Put the supplier in `suppliers' */
		(*c_set_put)(suppliers,id);

		return create_node2(CLASS_TYPE_AS, id, generics);
	}
	/* NOTREACHED */
}

char *create_fclause_as(char *clients, char *feature_list, int start_pos)
{
	int_arg[0] = start_pos;
	return create_node2(FEATURE_CLAUSE_AS,clients,feature_list);
}

char *create_feature_as(char *names, char *declaration, int start_pos, int end_pos)
{
	int_arg[0] = start_pos;
	int_arg[1] = end_pos;
	return create_node2(FEATURE_AS,names,declaration);
}

char *create_routine_as(char *obsolete, int start_pos, char *precs, char *locals, char *body, char *posts, char *rescue)
{
	int_arg[0] = start_pos;
	return create_node6(ROUTINE_AS,obsolete,precs,locals,body,posts,rescue);
}

char *create_routine_object(char *type, char *name, char *parameters)
{
	int_arg[0] = nb_tilde;
	return create_node3 (ROUTINE_CREATION_AS, type, name, parameters);
}

char *create_exp_class_type(char *id, char *generics)
{
	/* Create an expanded class type. Update supplier list `suppliers'. */

	/* Update `suppliers' */
	(*c_set_put)(suppliers,id);

	return create_node2(EXP_TYPE_AS,id,generics);
}

char *create_separate_class_type(char *id, char *generics)
{
	/* Create a separate class type. Update supplier list `suppliers'. */

	/* Update `suppliers' */
	(*c_set_put)(suppliers,id);

	return create_node2(SEPARATE_TYPE_AS,id,generics);
}

char *create_int(char *an_int, int sign)
{
	/* Return pointer on Eiffel instance of INTEGER_AS */
	long value;
	char *result;

	if (!an_int[0])
		return (char *) 0;

	sscanf(an_int,"%ld",&value);
	if (sign)
		value = -value;

	int_arg[0] = value;
	result = create_node(INTEGER_AS);
	(*init_array[INTEGER_AS])(result);

	return result;
}

char *create_real(char *a_real, int sign)
{
	/* Return a pointer on an Eiffel instance of REAL_AS. */
 
	char *result, *value;
 
	if (sign) {
		value = (char *) malloc((strlen(a_real) + 2) * sizeof(char));
		strcpy(value, "-");
		strcat(value, a_real);
	} else
		value = a_real;
	result = create_node(REAL_AS);
	object_arg [0] = create_id(value);
	(*init_array[REAL_AS])(result);
 
	return result;
}

char *create_char(char *a_char)
{
	/* Return a pointer on an Eiffel instance of CHAR_AS. */
	char *result;

	char_arg = a_char[0];
	result = create_node(CHAR_AS);
	(*init_array[CHAR_AS])(result);

	return result;
}

char *create_bool(int b)
{
	/* Return an Eiffel instance of BOOL_AS. */
	char *result;

	result = create_node(BOOL_AS);
	if (!b)
		bool_arg[0] = '\0';
	else
		bool_arg[0] = '\01';
	(*init_array[BOOL_AS])(result);

	return result;
}

char *create_string(char *s)
{
	/* Return pointer on Eiffel instance of STRING_AS */

	return create_node1(STRING_AS, RTMS(s));
}

char *create_feature_name(int dyn_type, char *name, char is_frozen)
{
	/* Create an instance descendant of FEATURE_NAME */

	char *result;

	bool_arg[0] = is_frozen;
	object_arg[0] = name;
	result = create_node(dyn_type);
	(*init_array[dyn_type])(result);

	return result;
}

/*
 * Prefix/Infix operator analysis primitives
 */

rt_public int is_infix(char *s)
{
	/* Is `s' a valid infix operator ? */

	char *str;
	char c;
	int i, length;
	extern char *std_infix(register char *str, register unsigned int len);	/* Hash table query */

	/*
	 * Convert s to lower before comparing it to the standard
	 * infix operators
	 */
	length = strlen(s);
	str = (char *) malloc ((length + 1) * sizeof(char));
	strncpy(str,s,length);
	str[length] = '\0';
	for (i=0; i<length; i++) {
		c = s[i];
		if (isupper(c))
			str[i] = tolower(c);
	}

	/*
	 * gperf cannot generate hash table with backslashs as keys: so we have to
	 * perform the extra test with `strcmp' 
	 */
	if ((std_infix(str,length) != (char *) 0) || (0 == strcmp(s,"\\\\"))) {
		free (str);
		return (1);
	} else {
		free(str);
		return (is_free(s));
	}
}

rt_public int is_prefix(char *s)
{
	/* Is `s' a valid prefix operator ? */

	char *str;
	char c;
	int i, length;
	extern char *std_prefix(register char *str, register unsigned int len);	/* Hash table query */

	/*
	 * Convert s to lower before comparing it to the standard
	 * infix operators
	 */
	length = strlen(s);
	str = (char *) malloc ((length + 1) * sizeof(char));
	strncpy(str,s,length);
	str[length] = '\0';
	for (i=0; i<length; i++) {
		c = s[i];
		if (isupper(c))
			str[i] = tolower(c);
	}

	/*
	 * gperf cannot generate hash table with backslashs as keys: so we have to
	 * perform the extra test with `strcmp' 
	 */
	if ((std_prefix(str,length) != (char *) 0) || (0 == strcmp(s,"\\\\"))) {
		free (str);
		return (1);
	} else {
		free(str);
		return (is_free(s));
	}
}


rt_private int is_free(char *s)
{
	/* Is `s' a free operator ?
	 * The first character needs to be one of: @, #, |, &
	 * The following characters must be printable, and exlude
	 * new-line, space and tab
	 */

	switch (s[0]) {
	case '@':
	case '#':
	case '|':
	case '&':
		s++;
		while (*s) {
			if (((*s) == '%') || ((*s) <= 32) || ((*s) >= 127))
				return 0;
			else
				*s++;
		}
		return 1;
	default:
		return 0;
	}
}

/* Rescue instruction list */

char *rescue_instr()
{
	/* Return the list of rescue instructions if any. */
	/* Otherwise return an empty list.                */
 
	char *result = list_new(CONSTRUCT_LIST_AS);
 
	if (result == (char *) 0) 
	{
		result = create_node(CONSTRUCT_LIST_AS);
		(*init_array[CONSTRUCT_LIST_AS])(result,0L);
	}
	return result;
}
