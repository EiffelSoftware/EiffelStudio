/*

 #         ##     ####   ######           ####           #    #
 #        #  #   #    #  #               #    #          #    #
 #       #    #  #       #####           #               ######
 #       ######  #       #               #        ###    #    #
 #       #    #  #    #  #               #    #   ###    #    #
 ######  #    #   ####   ###### #######   ####    ###    #    #

			Routine for Lace syntax analysis
*/

#include "yacc.h"

/*
 * Eiffel object (AS nodes) creation 
 */
extern char	*lace_id();

/*
 * From the lexical analysis:
 */

extern char *token_string;	/* characters of the last recognized token */
extern int start_position;	/* Position in text of the first character
							 * in last token */
extern int end_position;	/* Position in text of the last character in
							 * last token */
