/*

 ######     #    ######           #####   #   #  #####   ######   ####		   #    #
 #          #    #                  #      # #   #    #  #       #			   #    #
 #####      #    #####              #       #    #    #  #####    ####		   ######
 #          #    #                  #       #    #####   #            #   ###  #    #
 #          #    #                  #       #    #       #       #    #   ###  #    #
 ######     #    #      #######     #       #    #       ######   ####    ###  #    #

	Structures and types defining global variables.

 */

#ifndef _eif_types_h_
#define _eif_types_h_

	/* except.h */
/* Structure used as the execution vector. This is for both the execution
 * stack (eif_stack) and the exception trace stack (eif_trace).
 */
struct ex_vect {
	unsigned char ex_type;		/* Function call, pre-condition, etc... */
	unsigned char ex_retry;		/* True if function has been retried */
	unsigned char ex_rescue;	/* True if function entered its rescue clause */
	union {
		unsigned int exu_lvl;	/* Level for multi-branch backtracking */
		int exu_sig;			/* Signal number */
		int exu_errno;			/* Error number reported by kernel */
		struct {
			char *exua_name;	/* The assertion tag */
			char *exua_where;	/* The routine name where assertion was found */
			int exua_from;		/* And its origin (where it was written) */
			char *exua_oid;		/* Object ID (value of Current) */
		} exua;					/* Used by assertions */
		struct {
			char *exur_jbuf;	/* Execution buffer address, null if none */
			char *exur_id;		/* Object ID (value of Current) */
			char *exur_rout;	/* The routine name */
			int exur_orig;		/* Origin of the routine */
		} exur;					/* Used by routines */
	} exu;
};

/*
 * Stack used by the exception vector of each routine. It is implemented
 * with small chunks linked together. These structure look like the one used
 * by the garbage collector, only the type of the items stored changes...
 */
struct stxchunk {
	struct stxchunk *sk_next;	/* Next chunk in stack */
	struct stxchunk *sk_prev;	/* Previous chunk in stack */
	struct ex_vect *sk_arena;	/* Arena where objects are stored */
	struct ex_vect *sk_end;		/* Pointer to first element beyond the chunk */
};

struct xstack {
	struct stxchunk *st_hd;		/* Head of chunk list */
	struct stxchunk *st_tl;		/* Tail of chunk list */
	struct stxchunk *st_cur;	/* Current chunk in use (where top is) */
	struct ex_vect *st_top;		/* Top in chunk (pointer to next free item) */
	struct ex_vect *st_end;		/* Pointer to first element beyond chunk */
	struct ex_vect *st_bot;		/* Bottom of stack (for eif_trace only) */
};

/* Structure used while printing the exception trace stack. It is built using
 * some look-ahead inside the stack.
 */
struct exprint {
	unsigned char retried;	/* Routine has been retried */
	unsigned char rescued;	/* Routine entered in a rescue clause */
	unsigned char code;		/* Exception code */
	unsigned char last;		/* The very last exception record */
	unsigned char previous;	/* Previous exception code printed */
	char *rname;			/* Routine name of enclosing call */
	char *tag;				/* Exception tag of current exception */
	char *obj_id;			/* Object's ID */
	int from;				/* Where the routine comes from */
};

/* Improved string structure (with number of bytes used and length)
 * for the exception trace string 
 */
typedef struct _smart_string {
	char *area;		/* Pointer to zone where data is stored */
	long used;		/* Number of bytes actually used */
	long size;		/* Length of the area */
} SMART_STRING;



#endif	 /* _eif_types_h */
