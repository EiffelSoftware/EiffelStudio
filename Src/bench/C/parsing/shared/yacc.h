/*

  #   #    ##     ####    ####           #    #
   # #    #  #   #    #  #    #          #    #
    #    #    #  #       #               ######
    #    ######  #       #        ###    #    #
    #    #    #  #    #  #    #   ###    #    #
    #    #    #   ####    ####    ###    #    #

	Include file for basics of Eiffel-Yacc interface
*/

#include "macros.h"
#include "struct.h"
#include "typenode.h"
#include "limits.h"

/*
 * Eiffel object (Abstract Systac Nodes0 creation
 */

extern char		*create_node(),
				*create_node1(),
				*create_node2(),
				*create_node3(),
				*create_node4(),
				*create_node5(),
				*create_node6(),
				*create_node7();


/*
 * Interface managment
 */

extern int yy_dt_array[];				/* Dynamic type array */
extern fnptr init_array[];				/* Initialization routines array */


/*
 * Id managment
 */

extern fnptr c_id_area;					/* Access to area of STRING */
extern fnptr c_id_create;				/* STRING allocation */
extern char token_str[];				/* Buffer for strings */
extern int yacc_position;				/* Position recorded in AST */
extern fnptr c_list_area;				/* Access to an area */

/*
 * List managment
 */
#undef STACK_CHUNK
#define STACK_CHUNK		100
extern char **object_stack;			/* Object stack for fixed list creation */
extern int object_top;				/* Top index of stack `object_stack' */
extern int object_size;				/* Current object stack size */
extern int *count_stack;			/* Stack for count of fixed list */
extern int count_size;				/* Current count stack size */
extern int count_top;				/* Top index of stack `count_stack' */

extern void list_init();
extern void list_push();
extern char *list_new();

/*
 * Click list managment
 */
extern char **click_stack;			/* Object stack for fixed list creation */
extern int click_top;				/* Top index of stack `click_stack' */
extern int click_size;				/* Current object stack size */

extern int click_list_push();
extern char *click_list_new();
extern void click_list_init();
extern int start_position, end_position;
extern void click_list_set();		/* click_set routine for CLICK_INDIR */
extern int click_list_start();		/* start_position function of CLICK_INDIR */
extern char *click_list_elem();     /* node_function routine for CLICK_INDIR */

/*
 * Declarations for argument passing  between Eiffel and Yacc
 */

extern char *object_arg[10];		/* Array of references arguments */
extern char bool_arg[10];			/* Array of boolean arguments */
extern long int_arg[10];			/* Array of integer arguments */
extern float real_arg[10];			/* Array of real arguments */
extern char char_arg;				/* Character argument */

/*
 * Error managment
 */

extern char *Error_handler;			/* Compiler error handler */
extern fnptr syntax1;				/* Routine for syntax error */
extern fnptr syntax2;				/* Routine for manifest string too long */
extern fnptr syntax3;				/* Routine for bad string extension */
extern fnptr syntax4;				/* Routine for uncompleted string */
extern fnptr syntax5;				/* Routine for bad character */
extern fnptr syntax6;				/* Routine for empty string */
extern fnptr syntax7;				/* Routine for identifier too long */
extern fnptr syntax8;				/* Routine for generic basic type */
extern fnptr syntax9;				/* Routine for too many generic parameters */

/*
 * Id position managment
 */

extern int start_position, end_position;

/*
 * etc
 */

extern char *rn_ast;				/* Result of a parsing */
extern void internal_error();		/* Internal error */
