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
extern struct location *current_location;	/* Record the position of the first, and the
											 * last character in last token
											 * Record also the line number of the token */
