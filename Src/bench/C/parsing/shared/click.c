
#include <stdio.h>
#include "yacc.h"

/*
 * Id position managment
 */
 
int start_position;
int end_position;

/*
 * Declarations for click_list managment
 */
 
char **click_stack;					/* Object stack for fixed list creation */
int click_top;						/* Top index of stack `click_stack' */
int click_size;						/* Current object stack size */

void click_list_init ()
{

	click_top = 0;
	if (click_stack == (char **) 0) {
		/* First time */
		click_size += STACK_CHUNK;
		if ((click_stack = (char **) cmalloc(click_size * sizeof(char *))) == 0)
   		internal_error("Memory allocation failed\n");
		}
	bzero (click_stack, click_size * sizeof(char *));
}

char *click_list_new()
{
	char *result;	   /* Eiffel fixed list to create */
	char *area;		 /* Special object */

	if (click_top == 0)
		return (char *) 0;
	result = create_node(CLICK_LIST_SD);
	(*init_array[CLICK_LIST_SD])(result,(long) click_top);
	area = ((char *(*)()) c_list_area)(result);
	bcopy(click_stack, area, click_top * sizeof(char *)); 

	return result;
}

int click_list_push()
{
	char *local_click_indir;

	if (click_top >= click_size) {
		click_size += STACK_CHUNK;
		if ((	click_stack =
				(char **) xrealloc(click_stack,click_size * sizeof(char *), GC_OFF)) == 0)
			internal_error("Memory allocation failed\n");
		}
	int_arg[0]=start_position;
	int_arg[1]=end_position;
	local_click_indir = create_node(CLICK_ELEM_SD);
	(*init_array[CLICK_ELEM_SD])(local_click_indir);
	click_stack[click_top++] = local_click_indir;
	return (click_top - 1);
}

fnptr click_set;			/* click_set routine from CLICK_AST */
fnptr click_get;			/* node_function routine from CLICK_AST */
fnptr click_get_start;		/* start_function routine from CLICK_AST */

void getclick_getset(routine1, routine2, routine3)
fnptr routine1, routine2, routine3;
{
	/* Initialize click set routine */
	click_set = routine1;
	click_get = routine2;
	click_get_start = routine3;
}

char *click_list_elem(remembered_index)
int remembered_index;
{
	return ((char *(*)()) click_get) (click_stack[remembered_index]);
}

int click_list_start(remembered_index)
int remembered_index;
{
	/* start position of element at position `remembered_index' */
	return (int) ((long (*)()) click_get_start) (click_stack[remembered_index]);
}

void click_list_replace (object, index)
char *object;
int index;
{
	/* Replace reference at `index' by `object' */
	click_stack[index] = object;
}
	
void click_list_set(an_ast, index)
char *an_ast;
int index;
{
	object_arg[0] = an_ast;
	((void (*)())click_set) (click_stack[index]);
}
