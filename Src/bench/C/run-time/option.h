/*

  ####   #####    #####     #     ####   #    #          #    #
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          ######
 #    #  #####      #       #    #    #  #  # #   ###    #    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###    #    #

	Include file for options queries in workbench mode
*/

#ifndef _option_h_
#define _option_h_

/*
 * Options in workbench mode
 */

struct dbg_opt {
	int16 debug_level;			/* debug level */
	int16 nb_keys;				/* keys number */
	char **keys;				/* debug keys */
};

struct eif_opt {
	int16 assert_level;			  /* Assertion level */
	int16 trace_level;			  /* Tracing level */
	struct dbg_opt debug_level;	  /* Debug level */
};

/* Assertion flags for tests */
#define CK_CHECK	  	128
#define CK_LOOP			 64
#define CK_REQUIRE		 32
#define CK_ENSURE	 	 16
#define CK_INVARIANT	  8

/* Assertion level values */

/* The order is no, require, ensure, invariant, loop, check
 * and for example, specifying ensure implies verifying require so
 * AS_ENSURE is AS_REQUIRE+CK_ENSURE and so on for all the
 * different levels.
 */

#define AS_NO				0
#define AS_REQUIRE			CK_REQUIRE
#define AS_ENSURE			(AS_REQUIRE+CK_ENSURE)
#define AS_INVARIANT		(AS_ENSURE+CK_INVARIANT)
#define AS_LOOP		  		(AS_INVARIANT+CK_LOOP)
#define AS_CHECK	  		(AS_LOOP+CK_CHECK)
#define AS_ALL				AS_CHECK

/* Debug level values */
#define DB_NO				0		 /* No debug */
#define DB_ALL				1		 /* Debug all */

extern struct eif_opt foption[];	/* Frozen option table */
extern struct eif_opt *eoption;		/* Melted option table */

extern int is_debug();		/* Debug level query */

#endif
