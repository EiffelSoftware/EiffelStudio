/*

 ######     #    ######          ######  #####   #####            ####
 #          #    #               #       #    #  #    #          #    #
 #####      #    #####           #####   #    #  #    #          #
 #          #    #               #       #####   #####    ###    #
 #          #    #               #       #   #   #   #    ###    #    #
 ######     #    #      #######  ######  #    #  #    #   ###     ####

			Syntax error managment for Eiffel lexical analyzer
*/

#include "yacc.h"
#include "parser.h"

void yyerror(char *s)
{
	extern int yychar;			/* Last token */

	switch (yychar){
	case EIF_ERROR2:
		/* String too long: call feature `make_string_too_long' of
		 * class ERROR_HANDLER.
		 */
		(*syntax2)(Error_handler);
		break;
	case EIF_ERROR3:
		/* Bad string extension: call feature `make_string_extension'
		 * of class ERROR_HANDLER.
		 */
		(*syntax3)(Error_handler);
		break;
	case EIF_ERROR4:
		/* Bad string: call feature `make_string_uncompleted'
		 * of class ERROR_HANDLER.
		 */
		(*syntax4)(Error_handler);
		break;
	case EIF_ERROR5:
		/* Bad character */
		(*syntax5)(Error_handler);
		break;
	case EIF_ERROR6:
		/* Empty manifest string */
		(*syntax6)(Error_handler);
		break;
	case EIF_ERROR7:
		/* Identifier too long: call feature `make_id_too_long' of
		 * class ERROR_HANDLER.
		 */
		(*syntax7)(Error_handler);
		break;
	default:
		/* Common syntax error */
		(*syntax1)(Error_handler);
	}
}
