/*

 #         ##     ####           ######  #####   #####            ####
 #        #  #   #    #          #       #    #  #    #          #    #
 #       #    #  #               #####   #    #  #    #          #
 #       ######  #               #       #####   #####    ###    #
 #       #    #  #    #          #       #   #   #   #    ###    #    #
 ######  #    #   ####  #######  ######  #    #  #    #   ###     ####

			Syntax error managment for Lace lexical analyzer
*/

#include "yacc.h"
#include "lace_y.h"

void xxerror(s)
{
	extern int yychar;			/* Last token */

	switch (yychar){
	case LAC_ERROR2:
		/* String too long: call feature `make_string_too_long' of
		 * class ERROR_HANDLER.
		 */
		((void (*)()) syntax2)(Error_handler);
		break;
	case LAC_ERROR3:
		/* Bad string: call feature `make_string_extension'
		 * of class ERROR_HANDLER.
		 */
		((void (*)()) syntax3)(Error_handler);
		break;
	case LAC_ERROR4:
		/* Uncompleted string: call feature `make_string_uncompleted'
		 * of class ERROR_HANDLER.
		 */
		((void (*)()) syntax4)(Error_handler);
	case LAC_ERROR6:
		/* Empty string: call feature `make_string_empty'
		 * of class ERROR_HANDLER.
		 */
		((void (*)()) syntax6)(Error_handler);
	default:
		/* Common syntax error */
		((void (*)()) syntax1)(Error_handler);
	}
}

