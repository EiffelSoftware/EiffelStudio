/*

 ######     #    ######  ######  ######  #                ####           #    #
 #          #    #       #       #       #               #    #          #    #
 #####      #    #####   #####   #####   #               #               ######
 #          #    #       #       #       #               #        ###    #    #
 #          #    #       #       #       #               #    #   ###    #    #
 ######     #    #       #       ######  ###### #######   ####    ###    #    #

		Include file for Eiffel-Yacc interface.
*/

#include "yacc.h" 		/* For basics creation routines */

/*
 * Eiffel object (AS nodes) creation 
 */
extern char		*create_class(),
				*create_id(),
				*create_char(),
				*create_bool(),
				*create_int(),
				*create_real(),
				*create_string(),
				*create_type_class(),
				*create_feature_as(),
				*create_exp_class_type(),
				*create_feature_name(),
				*create_fclause_as(),
				*create_routine_as();

/*
 * Formal generic parameter managment
 */

extern void		generic_inc();
extern char		*create_generic();

/*
 * Miscellaneous
 */

extern char *str_save();				/* String duplication */
extern char *inspect_else();        /* Inspect default list */
