/*
	description: "Basic structure definitions."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_struct_h_
#define _eif_struct_h_

#include "eif_portable.h"
#include "eif_cecil.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Cnode structure: definition of a class by its name and attributes.
 *
 *  - cn_nbattr is the number of attributes in the class.
 *  - cn_generator is the class name.
 *  - cn_names is a pointer to an array of attributes' name.
 *  - cn_parents is a sequence of dymanic types, used for invariant checking.
 *  - cn_types is a pointer on an array of attributes' type (non workbench).
 *  - cn_gtypes is a pointer to generic type arrays.
 *  - cn_flags is a set of flags describing current type.
 *  - cn_offsets is a pointer on an array of attributes' offset (non workbench).
 *  - cn_attr is a pointer to an array of attribute keys.
 */
struct cnode {
	long cn_nbattr;				/* Number of attributes */
	char *cn_generator;			/* Class name */
	char **cn_names;			/* Attribute names */
	int *cn_parents;			/* Dynamic types of parents (-1 marks end) */
	uint32 *cn_types;			/* Attribute types */
	int16 **cn_gtypes;			/* Attribute generic types (expanded attributes only) */
	uint16 cn_flags;			/* Flags of Current type */
#ifdef WORKBENCH
	int32 *cn_attr;				/* Array of attribute routine ids */
	long cn_size;				/* Object size */
	long cn_nbref;				/* Number of references in the object */

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
	int32 cn_static_id;

	int32 *cn_routids;   		/* Pointer on routine id array */
	struct ctable cn_cecil;		/* Cecil hash table */
#else
	void (*cn_inv)();			/* Pointer on invariant routine if any */
	long *cn_offsets;			/* Attribute offsets */
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
 * 
 * However, if you change (or add) a value, do not forget to update the Eiffel
 * counterpart (class SK_CONST) -- Arnaud.
 *
 * SK_ for basic types are ordered their value and not following their
 * run-time representation in Eiffel objects. They are some holes so if you
 * add a new basic types, do not forget to fill the holes first. Values
 * go from 0x04 to 0x7C
 */

#define SK_EXP		0x80000000			/* Type is an expanded */
#define SK_MASK		0x7fffffff			/* Mask to get real type */
#define SK_BOOL		0x04000000			/* Simple boolean type */
#define SK_CHAR		0x08000000			/* Simple character type */
#define SK_INT8		0x0c000000			/* Simple integer 8 type */
#define SK_INT32	0x10000000			/* Simple integer 32 type */
#define SK_INT16	0x14000000			/* Simple integer 16 type */
#define SK_REAL32	0x18000000			/* Simple real type */
#define SK_WCHAR	0x1c000000			/* Simple unicode character type */
#define SK_REAL64	0x20000000			/* Simple double type */
#define SK_INT64	0x24000000			/* Simple integer 64 types */
#define SK_BIT		0x28000000			/* Signals bits type */
#define SK_STRING	0x2c000000			/* String type / Use for debugging only */
#define SK_UINT8	0x30000000			/* Simple unsigned integer 8 type */
#define SK_UINT16	0x34000000			/* Simple unsigned integer 16 type */
#define SK_UINT32	0x38000000			/* Simple unsigned integer 32 type */
#define SK_UINT64	0x3c000000			/* Simple unsigned integer 64 type */
#define SK_POINTER	0x40000000			/* Simple pointer type */
#define SK_CHAR32	0x44000000			/* Simple 32 bits character type */
#define SK_BMASK	0x00007fff			/* Bits number (coded on 15 bits) */
#define SK_SIMPLE	0x7c000000			/* Mask to test for simple type */
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

/* Full type info for parents of a class. For generic conformance
*/

struct eif_par_types {
	char    *class_name;    /* Name of this class */
	int16   *parents;       /* Parent types */
	int16   nb_generics;    /* Number of formal generics */
	char    is_expanded;    /* Is it expanded? */
};

RT_LNK int scount;				/* Numner of dynamic types */

#ifdef WORKBENCH
struct desc_info {						/* Descriptor information */
	BODY_INDEX info;					/* Body index or attribute offset */
	int16 type;							/* Feature type */
	int16 *gen_type;					/* Generics, if any */
};

struct rout_info {						/* Routine information */
	int16 origin;						/* Routine origin */
	int16 offset;						/* Routine offset in origin */
};
#endif

/* Invalid body id used to mark empty invariants (= max uint32) */
#define INVALID_ID 0xFFFFFFFF

typedef char *(*fnptr)(EIF_REFERENCE, ...); /* The function pointer type */

#if defined(WORKBENCH) || defined(EIF_THREADS)
/*
 * Number of original routine bodies, i.e. routine bodies
 * as declared in classes, not those generated for generic derivations.
 */
RT_LNK uint32 eif_nb_org_routines;
#endif

#ifdef WORKBENCH

/* Flags for for raising an exception when a precondition is violated */
#define PRAISE		1
#define NPRAISE		0

/* Predefined invariant routine id */
#define INVARIANT_ID	1

struct p_interface {
	void (*toc)();		/* Pattern from interpreter to C code */
	fnptr toi;			/* Pattern from C code to interpreter */
};

RT_LNK int ccount;				/* Number of classes */

/*
 * Melting ice technology heart.
 */
RT_LNK uint32 eif_nb_features;	/* Nb of features in frozen system */

/*
 * Pattern table for interface between C code and the interpreter
 */
extern struct p_interface *pattern;

#endif

#ifdef CONCURRENT_EIFFEL
extern fnptr separate_pattern[];
#endif

#ifdef __cplusplus
}
#endif

#endif
