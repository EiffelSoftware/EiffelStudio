/*

  #   #    ##     ####    ####           ######  #####   #####            ####
   # #    #  #   #    #  #    #          #       #    #  #    #          #    #
    #    #    #  #       #               #####   #    #  #    #          #
    #    ######  #       #               #       #####   #####    ###    #
    #    #    #  #    #  #    #          #       #   #   #   #    ###    #    #
    #    #    #   ####    ####  #######  ######  #    #  #    #   ###     ####

*/
#include "eif_cecil.h" 	/* %%ss added for cast in efreeze */
#include "yacc.h"
#include "eif_hector.h"

char *Error_handler;			/* Compiler error handler */

fnptr syntax1;					/* Routine for syntax error */
fnptr syntax2;					/* Routine for manifest string too long */
fnptr syntax3;					/* Routine for bad string extension */
fnptr syntax4;					/* Routine for uncompleted string */
fnptr syntax5;					/* Routine for bad character */
fnptr syntax6;					/* Routine for empty string */
fnptr syntax7;					/* Routine for identifier too long */
fnptr syntax8;					/* Routine for generic basic type */
fnptr syntax9;					/* Routine for too many generic parameters */

int yacc_error_code = 0 ; /* JOCE */
#include "yacc_error_message.h"
/* extern char** yacc_error_message_list; /* JOCE */ 

char *yacc_file_name;			/* File name of the parsed file */

/* 
 * Initialization of Yacc error mechanism
 */

void error_init( char *error_obj, fnptr rout1, fnptr rout2, fnptr rout3, fnptr rout4, fnptr rout5, fnptr rout6, fnptr rout7, fnptr rout8, fnptr rout9)
{
	Error_handler = error_obj;
	Error_handler = eif_freeze((EIF_OBJ) (&Error_handler));	/* Object should not move */
	syntax1 = rout1;
	syntax2 = rout2;
	syntax3 = rout3;
	syntax4 = rout4;
	syntax5 = rout5;
	syntax6 = rout6;
	syntax7 = rout7;
	syntax8 = rout8;
	syntax9 = rout9;
}


/*
 * Initialization of Eiffel syntax error messages 
 */

long get_start_position(void)
{
	/* Return `start_position'. */

	return (long) current_location->start_position;
}

long get_end_position(void)
{
	/* Return `end_position'. */

	return (long) current_location->end_position;
}

char *get_yacc_file_name(void)
{
	/* Return `yacc_file_name'. */
		
	return yacc_file_name;
}

int get_yacc_error_code(void)
{
	/* Return `yacc_error_code'. */

	return yacc_error_code;	
}

EIF_REFERENCE get_yacc_error_message(void)
{
		/* Return `yacc_error_code'. */
	
		return RTMS( yacc_error_message_list[yacc_error_code] );	
}

