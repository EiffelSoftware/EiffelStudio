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
extern char		*create_class(char *cl_name, char deferred, char expanded, char separate, char *indexes, char *generics, char *obsolete, char *parents, char *creators, char *features, char *invariant, char *cl_list, int end_pos),
				*create_id(char *s),
				*create_char(char *a_char),
				*create_bool(int b),
				*create_int(char *an_int, int sign),
				*create_real(char *a_real, int sign),
				*create_string(char *s),
				*create_type_class(char *id, char *generics),
				*create_feature_as(char *names, char *declaration, int start_pos, int end_pos),
				*create_exp_class_type(char *id, char *generics),
				*create_separate_class_type(char *id, char *generics),
				*create_feature_name(int dyn_type, char *name, char is_frozen),
				*create_fclause_as(char *clients, char *feature_list, int start_pos),
				*create_routine_as(char *obsolete, int start_pos, char *precs, char *locals, char *body, char *posts, char *rescue);

/*
 * Formal generic parameter managment
 */

extern void		generic_inc(void);
extern char		*create_generic(char *gen_name, char *constrained);

/*
 * Miscellaneous
 */

extern char *str_save(char *);			/* String duplication */
extern char *inspect_else(void);        /* Inspect default list */

extern char *rescue_instr(void);      /* Rescue instruction list */
