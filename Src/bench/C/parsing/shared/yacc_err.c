/*

  #   #    ##     ####    ####           ######  #####   #####            ####
   # #    #  #   #    #  #    #          #       #    #  #    #          #    #
    #    #    #  #       #               #####   #    #  #    #          #
    #    ######  #       #               #       #####   #####    ###    #
    #    #    #  #    #  #    #          #       #   #   #   #    ###    #    #
    #    #    #   ####    ####  #######  ######  #    #  #    #   ###     ####

*/
#include "yacc.h"
#include "hector.h"

char *Error_handler;			/* Compiler error handler */

fnptr syntax1;					/* Routine for syntax error */
fnptr syntax2;					/* Routine for manifest string too long */
fnptr syntax3;					/* Routine for bad string extension */
fnptr syntax4;					/* Routine for uncompleted string */
fnptr syntax5;					/* Routine for bad character */
fnptr syntax6;					/* Routine for empty string */

char *yacc_file_name;			/* File name of the parsed file */

/* 
 * Initialization of Yacc error mechanism
 */

void error_init(error_obj, rout1, rout2, rout3, rout4, rout5, rout6)
char *error_obj;
fnptr rout1, rout2, rout3, rout4, rout5, rout6;
{
	Error_handler = error_obj;
	Error_handler = eif_freeze(&Error_handler);	/* Object should not move */
	syntax1 = rout1;
	syntax2 = rout2;
	syntax3 = rout3;
	syntax4 = rout4;
	syntax5 = rout5;
	syntax6 = rout6;
}


/*
 * Initialization of Eiffel syntax error messages 
 */

long get_start_position()
{
	/* Return `start_position'. */

	return (long) start_position;
}

long get_end_position()
{
	/* Return `end_position'. */

	return (long) end_position;
}

char *get_yacc_file_name()
{
	/* Return `yacc_file_name'. */
		
	return yacc_file_name;
}
