/*

  #   #    ##     ####    ####            ####
   # #    #  #   #    #  #    #          #    #
    #    #    #  #       #               #
    #    ######  #       #        ###    #
    #    #    #  #    #  #    #   ###    #    #
    #    #    #   ####    ####    ###     ####

	External C routine Eiffel-Yacc interface
*/

#include "eif_err_msg.h"
#include "eif_gen_conf.h"
#include "yacc.h"

/*
 * Special dynamic types
 */

static int16 feature_as_dtype;		/* Dynamic type of instances of
									 * FEATURE_AS */
static int16 invariant_as_dtype;	/* Dynamic type of instances of
									 * INVARIANT_AS.
									 */
/*
 * Result of parsing
 */

char * rn_ast;			/* Result of Yacc parsing */
/*
 * Declarations 
 */

int yy_dt_array[MAX_CONSTRUCT_TYPE]; /* Array of dynamic type */
fnptr init_array[MAX_CONSTRUCT_TYPE];
							/* Array of initialization routines of AS node:
							 * pointers on features `set' of descendants
							 * of class AST_NODE created by YACC.
							 */
/*
 * Declarations for list managment
 */

char **object_stack;			/* Object stack for fixed list creation */
int object_top;					/* Top index of stack `object_stack' */
int object_size;				/* Current object stack size */
int *count_stack;				/* Stack for count of fixed list */
int count_size;					/* Current count stack size */
int count_top;					/* Top index of stack `count_stack' */

fnptr c_list_area;				/* List creation */

/* 
 * Declarations for id creation
 */

fnptr c_id_create;				/* String creation routine */
fnptr c_id_area;				/* Area of ID: Eiffel feature `to_c' of
								 * class STRING
								 */

char token_str[STRINGLENGTH];	/* Allocated buffer for strings read by
								 * lexical analyzers.
								 */
int yacc_position;				/* Position recorded in AST */
int yacc_line_number;			/* Line number recorded in AST */

/* 
 * Declarations for argument passing  between Eiffel and Yacc
 */

char *object_arg[10];		/* Array of references arguments */
char bool_arg[10];			/* Array of boolean arguments */
long int_arg[10];			/* Array of integer arguments */
float real_arg[10];			/* Array of real arguments */
char char_arg;				/* Character argument */

/*
 * Id position managment
 */

struct location *current_location;
 

/*
 * Building the interface
 */

void c_get_address (int32 n, char *obj, fnptr rout)
{
	/* Initialize Eiffel-yacc interface for dynamic type `n'. */

	yy_dt_array[n] = Dtype(obj);
	init_array[n] = rout;
}

void getid_area(fnptr to_c)
{
	/* Initializa access to special objets of ids. */

	c_id_area = to_c;
}

void getid_create(fnptr create)
{
	/* Initializa access to special objets of ids. */

	c_id_create = create;
}

/*
 * Managing the lists: the objective is to make Yacc produce instance
 * of FIXED_LIST, so we manage two stacks, one for the objects `object_stack',
 * and another one for the list counts `count_stack'.
 */

void c_get_list_area(fnptr to_c)
{
	/* Initialize access to special objects of fixed lists. */

	c_list_area = to_c;
}

void list_init(void)
{
	/* Yacc is beginning to parse a list: index of stack `count_stack' must
	 * be increase by 1. Take care of possible reallocation.
	 */
	
	count_top++;
	if (count_top >= count_size) {
		/* reallocation */
		count_size += STACK_CHUNK;
		if ((count_stack = (int *) xrealloc
				((char *) count_stack, count_size * sizeof(int), GC_OFF)) == 0)
			internal_error("Memory allocation failed\n");
	}
}

char *list_new(int list_type)
{
	/* Yacc finished parsing a list. Return a pointer on a Eiffel fixed
	 * list.
	 */

	char *result;			/* Eiffel fixed list to create */
	int list_count;			/* Count of the fixed list */
	char *area;				/* Special object */
	int16 typearr [4];		/* Type array for the generic creation of the FIXED_LIST */
	int16 dynamic_list_type;/* Dynamic type of the current list */

	/* Creation of an Eiffel fixed list and allocation of an special
	 * object for it.
	 */
	list_count = count_stack[count_top];
	count_stack[count_top--] = 0;

	if (list_count == 0)
		return 0;

		/* Update index of the object stack */
	object_top -= list_count;

	/* Creation of an instance of CONSTRUCT_LIST and call of the creation
	 * precedure of ARRAY in order to create a special object.
	 */
	dynamic_list_type = rtud_inv[yy_dt_array[list_type]];

	typearr [0] = -1;			/* No static call context */
	typearr [1] = dynamic_list_type;	/* Base type of FIXED_LIST */
	typearr [2] = rtud_inv[Dftype(object_stack [object_top])];			/* Parameter type */
	typearr [3] = -1;			/* To specify the end of the array */

	result = emalloc (eif_compound_id ((int16 *)0, (char *)0, (int16) dynamic_list_type, typearr));

	(*init_array[list_type])(result, (long) list_count);

	/* Evaluation of the special area with the feature `to_c' of
	 * class ARRAY.
	 */
	area = ((char *(*)()) c_list_area)(result);

#ifdef DEBUG
	printf("Creating new list with %d items [%d]\n", list_count, object_top);
#endif

	/* Copy in the `area' of the fixed list */
	bcopy(	object_stack + object_top,			/* Source: stack */
			area, 								/* Target: area */
			list_count * sizeof(char *));		/* Byte number */
	return result;
}

void list_push(char *obj)
{
	/* A list element `obj' is pushed onto the object stack `object_stack'.
	 * The object counter in the stack `count_stack' must be increment
	 * by 1. Take care of possible reallocation of `object_stack'.
	 */

	if (obj == 0)
		return;
	if (object_top >= object_size) {
		/* Reallocation */
		object_size += STACK_CHUNK;
#ifdef DEBUG
	printf("Object stack reallocation\n");
#endif
		if ((object_stack = (char * *) xrealloc
				((char *) object_stack, object_size * sizeof(char *), GC_OFF)) == 0)
			internal_error("Memory allocation failed\n");
	}
#ifdef DEBUG
	printf("Pushing list item 0x%lx at %d\n", obj, object_top);
#endif
	object_stack[object_top++] = obj;
	count_stack[count_top]++;
}

/*
 * Passing arguments between Yacc and Eiffel
 */

char *yacc_arg(long i)
{
	/* Returns the i_th argument in `object_arg'. */

	return object_arg[i];
}

char yacc_bool_arg(long i)
{
	/* Returns the i_th boolean argument in `bool_arg' */

	return bool_arg [i];
}

long yacc_int_arg(char i)
{
	/* Returns the i_th integer argument in `int_arg'. */

	return int_arg[i];
}

float yacc_real_arg(long i)
{
	/* Returns the i_th real argument in `real_arg'. */

	return real_arg[i];
}

char yacc_char_arg(void)
{
	return char_arg;
}

char *create_node(int dyn_type)
{
	/* Create an Eiffel object of dynamic type `dyn_type'.
	 * Return an Eiffel object pointer.
	 */

	return emalloc(yy_dt_array[dyn_type]);
}

char *create_node1(int dyn_type, char * arg1)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a one-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	(*init_array[dyn_type])(result);
	return result;
}

char *create_node2(int dyn_type, char *arg1, char *arg2)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a two-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	(*init_array[dyn_type])(result);
	return result;
}

char *create_node3(int dyn_type, char *arg1, char *arg2, char *arg3)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a three-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	object_arg[2] = arg3;
	(*init_array[dyn_type])(result);
	return result;
}

char *create_node4(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a four-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	object_arg[2] = arg3;
	object_arg[3] = arg4;
	(*init_array[dyn_type]) (result);
	return result;
}

char *create_node5( int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a five-argument routine.
	 */

	char * result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	object_arg[2] = arg3;
	object_arg[3] = arg4;
	object_arg[4] = arg5;
	(*init_array[dyn_type])(result);
	return result;
}

char *create_node6(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5, char *arg6)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a five-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	object_arg[2] = arg3;
	object_arg[3] = arg4;
	object_arg[4] = arg5;
	object_arg[5] = arg6;
	(*init_array[dyn_type])(result);
	return result;
}

char *create_node7(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5, char *arg6, char *arg7)
{
	/* Create an Eiffel object of dynamic type `dyn_type' and initialiaze
	 * it with a five-argument routine.
	 */

	char *result;

	result = create_node(dyn_type);
	object_arg[0] = arg1;
	object_arg[1] = arg2;
	object_arg[2] = arg3;
	object_arg[3] = arg4;
	object_arg[4] = arg5;
	object_arg[5] = arg6;
	object_arg[6] = arg7;
	(*init_array[dyn_type])(result);
	return result;
}

void internal_error (char *s)
{
	print_err_msg(stderr,"Internal Error: %s\n", s);
	exit (1);
}

/*
 * Test for instance of FEATURE_AS and INVARIANT_AS
 */

void set_dtype1(char *obj)
{
	/* Assign to `feature_as_dtype' the dynamic type of `obj'. */

	feature_as_dtype = Dftype(obj);
}

void set_dtype2(char *obj)
{
	/* Assign to `invariant_as_dtype' the dynamic type of `obj'. */

	invariant_as_dtype = Dftype(obj);
}

char is_feature_as(char *obj)
{
	/* Is `obj' an instance of FEATURE_AS ? */

	return (Dftype(obj) == feature_as_dtype) ? '\01' : '\0';
}

char is_invariant_as(char *obj)
{
	/* Is `obj' an instance of INVARIANT_AS ? */

    return (Dftype(obj) == invariant_as_dtype) ? '\01' : '\0';
}

