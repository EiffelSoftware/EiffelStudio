/*

  #   #    ##     ####    ####           #    #
   # #    #  #   #    #  #    #          #    #
    #    #    #  #       #               ######
    #    ######  #       #        ###    #    #
    #    #    #  #    #  #    #   ###    #    #
    #    #    #   ####    ####    ###    #    #

	Include file for basics of Eiffel-Yacc interface
*/

#ifndef _yacc_h_
#define _yacc_h_

#include "eif_macros.h"
#include "eif_struct.h"
#include "typenode.h"
#include "eif_rtlimits.h"

struct location {
	int32 start_position, end_position;
	int32 line_number;
	};

/*
 * Eiffel object (Abstract Systac Nodes) creation
 */

extern char	*create_node(int dyn_type);
extern char *create_node1(int dyn_type, char * arg1);
extern char *create_node2(int dyn_type, char *arg1, char *arg2);
extern char *create_node3(int dyn_type, char *arg1, char *arg2, char *arg3);
extern char *create_node4(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4);
extern char *create_node5(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5);
extern char *create_node6(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5, char *arg6);
extern char *create_node7(int dyn_type, char *arg1, char *arg2, char *arg3, char *arg4, char *arg5, char *arg6, char *arg7);


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
extern int yacc_line_number;			/* Line number recorded in AST */
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

extern void list_init(void);
extern void list_push(char *obj);
extern char *list_new(int list_type);

/*
 * Click list managment
 */
extern char **click_stack;			/* Object stack for fixed list creation */
extern int click_top;				/* Top index of stack `click_stack' */
extern int click_size;				/* Current object stack size */

extern int click_list_push(void);
extern char *click_list_new(void);
extern void click_list_init(void);
extern struct location *current_location;
extern void click_list_set(char *an_ast, int index);	/* click_set routine for CLICK_INDIR */
extern int click_list_start(int remembered_index);		/* start_position function of CLICK_INDIR */
extern char *click_list_elem(int remembered_index);     /* node_function routine for CLICK_INDIR */

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
extern int yacc_error_code;

/*
 * Id position managment
 */

extern struct location *current_location;


/*
 * etc
 */

extern char *rn_ast;					/* Result of a parsing */
extern void internal_error(char *s);	/* Internal error */

#endif /* _yacc_h_ */
