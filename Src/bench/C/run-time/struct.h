/*

  ####    #####  #####   #    #   ####    #####          #    #
 #          #    #    #  #    #  #    #     #            #    #
  ####      #    #    #  #    #  #          #            ######
      #     #    #####   #    #  #          #     ###    #    #
 #    #     #    #   #   #    #  #    #     #     ###    #    #
  ####      #    #    #   ####    ####      #     ###    #    #

	Basic structure definitions.
*/

#ifndef _struct_h_
#define _struct_h_

#include "config.h"
#include "portable.h"

#ifdef WORKBENCH
#include "hashin.h"
#include "cecil.h"
#endif

/* Cnode structure: definition of a class by its name and attributes.
 *
 *  - cn_generator is the class name.
 *  - cn_nbattr is the number of attributes in the class.
 *  - cn_names is a pointer to an array of attributes' name.
 *  - cn_types is a pointer on an array of attributes' type (non workbench).
 *  - cn_init is a pointer to a routine which initializes the object.
 *  - cn_offsets is a pointer on an array of attributes' offset (non workbench).
 *  - cn_parents is a sequence of dymanic types, used for invariant checking.
 *  - cn_attr is a pointer to an array of attribute keys.
 */
struct cnode {
	long cn_nbattr;				/* Number of attributes */
	char *cn_generator;			/* Class name */
	char **cn_names;			/* Attribute names */
	int *cn_parents;			/* Dynamic types of parents (-1 marks end) */
	uint32 *cn_types;			/* Attribute types */
#ifdef WORKBENCH
	int32 *cn_attr;				/* Array of attribute routine ids */
	long size;					/* Object size */
	long nb_ref;				/* Number of references in the object */
	char cn_deferred;			/* Is the class type deferred ? */
	char cn_composite;			/* is the class type a composite one ? */

		/* The following two entities (`cn_creation_id' and `static_id')
		 * are used to identify the creation procedure for expanded types.
		 * They have two different meanings depending on whether the
		 * corresponding type is precompiled or not. If the type is not
		 * precompiled, `cn_creation_id' represents the feature_id of the
		 * creation procedure and `static_id' is the static id of the
		 * corresponding class. Otherwise, `cn_creation_id' is origin class
		 * id and `static_id' the offset of the creation procedure in its
		 * origin class.
		 */
	int32 cn_creation_id;
	int32 static_id;

	char cn_disposed;			/* Does class type have a dispose routine? */ 
	int32 *cn_routids;   		/* Pointer on routine id array */
	struct ctable cn_cecil;		/* Cecil hash table */
#else
	void (*cn_inv)();			/* Pointer on invariant routine if any */
	long **cn_offsets;			/* Attribute offsets */
#endif
};

/* Values used to encode the type of each attribute. Dynamic type is encoded on
 * 16 bits, so this leaves the upper 16 bits to encode simple types or flag the
 * expandeds. Following are the flags used. The 31th bit is used to mark an
 * expanded type. The SK_SIMPLE mask can be used to check for simple types,
 * and SK_REF to check for reference type. The dynamic type value (if not a
 * simple type) is available with SK_DTYPE. Values marked as "sensible" have
 * been especially computed for the interpreter, so it should not be wise
 * modifying them: (value >> 27) - 1 directly yields the corresponding IT_xxxx
 * value--RAM.
 */

#define SK_EXP		0x80000000			/* Type is an expanded */
#define SK_MASK		0x7fffffff			/* Mask to get real type */
#define SK_BOOL		0x04000000			/* Simple boolean type */
#define SK_CHAR		0x08000000			/* Simple character type */
#define SK_INT		0x10000000			/* Simple integer type */
#define SK_FLOAT	0x18000000			/* Simple float type */
#define SK_DOUBLE	0x20000000			/* Simple double type */
#define SK_BIT		0x28000000			/* Signals bits type */
#define SK_POINTER	0x40000000			/* Signals pointer type */
#define SK_BMASK	0x07ffffff			/* Bits number (coded on 27 bits) */
#define SK_SIMPLE	0x78000000			/* Mask to test for simple type */
#define SK_REF		0xf8000000			/* Mask to test for reference type */
#define SK_VOID		0x00000000			/* Mask for void type */
#define SK_DTYPE	0x0000ffff			/* Value of reference type */
#define SK_HEAD		0xff000000			/* Mask for header value */
#define SK_INVALID	0xffffffff			/* Invalid value, may be used as flag */

/*
 * Conformance table
 */

struct conform {
	int16 co_min;		/* Minimum dynamic type able to conform */
	int16 co_max;		/* Maximum dynamic type reached by `co_tab' */
	char *co_tab;		/* Conformance table (mapped on eight bits packs) */
};

extern int scount;				/* Numner of dynamic types */

#ifdef WORKBENCH
struct desc_info {						/* Descriptor information */
	uint16 info;						/* Body index or attribute offset */
	int16 type;							/* Feature type */
};

struct rout_info {						/* Routine information */
	int16 origin;						/* Routine origin */
	int16 offset;						/* Routine offset in origin */
};
#endif

/* Invalid body index used to mark empty invariants (= max uint16) */
#define INVALID_INDEX 0xFFFF

/* Array of class node (indexed by dynamic type). It is statically allocated
 * in production mode and dynamically in workbench mode.
 */
#ifndef WORKBENCH
extern struct cnode *esystem;	/* Describes a full Eiffel system (with DLE) */
extern struct cnode fsystem[];	/* Describes the full static Eiffel system */
#else
extern struct cnode fsystem[];			/* Describes the full frozen Eiffel system */
extern struct cnode *esystem;			/* Pointer to updated Eiffel system */
extern int32 *fcall[];					/* Routine id arrays indexed by feature id's */
extern int32 **ecall;					/* Updated pointer */
extern struct rout_info forg_table[];	/* Routine origin/offset table */
extern struct rout_info *eorg_table;	/* Updated pointer */
extern struct desc_info ***desc_tab;	/* Global descriptor table */
extern int16 fdtypes[];					/* Dynamic type  array indexed by old
								 		 * dynamic types (for re-freezing) */

#define Routids(x)	ecall[x]	/* Routine id array */
#endif

/*
 * Nested call global variable: signals a nested call and trigger an
 * invariant check in generated C routines.
 */
extern int nstcall;

/* Conformance table array used by Eiffel feature `conforms_to' of
 * class ANY.
 */
#ifdef WORKBENCH
extern struct conform **co_table;
extern struct conform *fco_table[];
#else
extern struct conform **co_table;
extern struct conform *fco_table[];
#endif

typedef char *(*fnptr)();       /* The function pointer type */

#ifdef WORKBENCH
#include "option.h"

/* Flags for for raising an exception when a precondition is violated */
#define PRAISE		1
#define NPRAISE		0

/* Predefined invariant routine id */
#define INVARIANT_ID	1

struct p_interface {
	void (*toc)();		/* Pattern from interpreter to C code */
	fnptr toi;			/* Pattern from C code to interpreter */
};

extern int ccount;				/* Number of classes */
extern long dcount;				/* Size of `dispatch' */
extern long melt_count;			/* Size of `melt' table */
extern long dle_melt_count;		/* Size of `dle_melt' table */

/*
 * Dispatch table: array of body ids indexed by body indexes
 */
extern uint32 fdispatch[];		/* Frozen disaptch table */
extern uint32 *dispatch;		/* Updated dispatch table */

/*
 * Melting ice technology heart.
 */
extern fnptr frozen[];			/* C routine array (frozen routines) */
extern char **melt;				/* Byte code array of melted eiffel features */
extern fnptr *dle_frozen;		/* DLE C routine array (frozen routines) */
extern char **dle_melt;			/* Byte code array of DLE melted features */
extern uint32 zeroc;			/* Frozen level */
extern uint32 dle_level;		/* DLE level */
extern uint32 dle_zeroc;		/* DLE frozen level */

extern int *mpatidtab;			/* Table of pattern id's indexed by body id's */
extern int fpatidtab[];			/* Table of pattern id's indexed by body id's */
extern int *dle_mpatidtab;		/* Table of pattern id's indexed by body id's */
extern int *dle_fpatidtab;		/* Table of pattern id's indexed by body id's */

/*
 * Pattern table for interface between C code and the interpreter
 */
extern struct p_interface *pattern;
extern struct p_interface fpattern[];

#endif

#ifdef CONCURRENT_EIFFEL
extern fnptr separate_pattern[];
#endif

#endif

