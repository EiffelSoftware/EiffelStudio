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
extern char *create_class(char *, char, char, char, char *, char *, char *, char *, char *, char *, char *, char *, int);
extern char *create_id(char *);
extern char *create_char(char *);
extern char *create_bool(int);
extern char *create_int(char *, int);
extern char *create_real(char *, int);
extern char *create_string(char *);
extern char *create_type_class(char *, char *);
extern char *create_feature_as(char *, char *, int, int);
extern char *create_exp_class_type(char *, char *);
extern char *create_separate_class_type(char *, char *);
extern char *create_feature_name(int, char *, char);
extern char *create_fclause_as(char *, char *, int);
extern char *create_routine_as(char *, int, char *, char *, char *, char *, char *);
extern char *create_routine_object(char *, char *, char *);

/*
 * Formal generic parameter managment
 */

extern void generic_inc(void);
extern char *create_generic (char *, char *, char *);

/*
 * Miscellaneous
 */

extern char *str_save(char *);			/* String duplication */
extern char *inspect_else(void);        /* Inspect default list */

extern char *rescue_instr(void);      /* Rescue instruction list */
