/*
	description: "Basic structure definitions."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

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
 *  - cn_types is a pointer on an array of attributes' type (non workbench).
 *  - cn_gtypes is a pointer to generic type arrays.
 *  - cn_flags is a set of flags describing current type.
 *  - cn_offsets is a pointer on an array of attributes' offset (non workbench).
 *  - cn_attr is a pointer to an array of attribute keys.
 */
struct cnode {
	long cn_nbattr;				/* Number of attributes */
	long cn_persistent_nbattr;	/* Number of persistent attributes */
	const char *cn_generator;			/* Class name */
	const char **cn_names;			/* Attribute names */
	const uint32 *cn_types;			/* Attribute types */
	const uint16 *cn_attr_flags;		/* Attribute flags */
	const EIF_TYPE_INDEX **cn_gtypes;	/* Attribute generic types (expanded attributes only) */
	uint16 cn_flags;			/* Flags of Current type */
#ifdef WORKBENCH
	const int32 *cn_attr;				/* Array of attribute routine ids */
	long cn_size;				/* Object size */
	long cn_nbref;				/* Number of references in the object */

		/* The following entity `cn_creation_id' is the routine ID used to
		 * identify the the creation procedure for expanded types.
		 */
	int32 cn_creation_id;
	const struct ctable cn_cecil;		/* Cecil hash table */
#else
	void (*cn_inv)();			/* Pointer on invariant routine if any */
	const long *cn_offsets;		/* Attribute offsets */
#endif
	const char *cn_version;			/* Version of the class, used for storable. */
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
#define SK_CHAR8	0x08000000			/* Simple character type */
#define SK_INT8		0x0c000000			/* Simple integer 8 type */
#define SK_INT32	0x10000000			/* Simple integer 32 type */
#define SK_INT16	0x14000000			/* Simple integer 16 type */
#define SK_REAL32	0x18000000			/* Simple real type */
#define SK_CHAR32	0x1c000000			/* Simple unicode character type */
#define SK_REAL64	0x20000000			/* Simple double type */
#define SK_INT64	0x24000000			/* Simple integer 64 types */
#define SK_STRING	0x2c000000			/* String type / Use for debugging only */
#define SK_UINT8	0x30000000			/* Simple unsigned integer 8 type */
#define SK_UINT16	0x34000000			/* Simple unsigned integer 16 type */
#define SK_UINT32	0x38000000			/* Simple unsigned integer 32 type */
#define SK_UINT64	0x3c000000			/* Simple unsigned integer 64 type */
#define SK_POINTER	0x40000000			/* Simple pointer type */
#define SK_STRING32 0x44000000		/* STRING_32 type / Use for debugging only */
#define SK_SIMPLE	0x7c000000			/* Mask to test for simple type */
#define SK_REF		0xf8000000			/* Mask to test for reference type */
#define SK_VOID		0x00000000			/* Mask for void type */
#define SK_DTYPE	0x0000ffff			/* Value of reference type */
#define SK_HEAD		0xff000000			/* Mask for header value */
#define SK_INVALID	0xffffffff			/* Invalid value, may be used as flag */

/* Macros to access `cn_attr_flags'. */
#define EIF_IS_TRANSIENT_ATTRIBUTE_FLAG	0x0001
#define EIF_IS_HIDDEN_ATTRIBUTE_FLAG	0x0002

#define EIF_IS_TRANSIENT_ATTRIBUTE(node,pos)	((((node).cn_attr_flags [pos]) & EIF_IS_TRANSIENT_ATTRIBUTE_FLAG) == EIF_IS_TRANSIENT_ATTRIBUTE_FLAG) 
#define EIF_IS_HIDDEN_ATTRIBUTE(node,pos)	((((node).cn_attr_flags [pos]) & EIF_IS_HIDDEN_ATTRIBUTE_FLAG) == EIF_IS_HIDDEN_ATTRIBUTE_FLAG) 
/*
 * Conformance table
 */

struct conform {
	EIF_TYPE_INDEX co_min;		/* Minimum dynamic type able to conform */
	EIF_TYPE_INDEX co_max;		/* Maximum dynamic type reached by `co_tab' */
	char *co_tab;		/* Conformance table (mapped on eight bits packs) */
};

/* Full type info for parents of a class. For generic conformance
*/

struct eif_par_types {
	EIF_TYPE_INDEX dtype;	/* Dynamic type of this class per esystem */
	EIF_TYPE_INDEX *parents;/* Parent types */
	uint16 nb_parents;		/* Number of parents. */
	uint16 nb_generics;		/* Number of formal generics */
	char is_expanded;		/* Is it expanded? */
};

RT_LNK EIF_TYPE_INDEX scount;				/* Numner of dynamic types */

#ifdef WORKBENCH
/* On old version of VC++, designated initializers are not supported, so we will use
 * a nameless assignment instead.
 * For nameless access, the C standard states that it will use the first field in the union
 * to determine the type. This is why for EIF_NON_GENERIC we have to use some casts to avoid
 * C warnings. */
#if defined(EIF_WINDOWS) && defined(_MSC_VER)
#	if _MSC_VER >= 1800 /* version 18.0+ (VS 2013)  */
#		define EIF_GENERIC(v)		.type.generic = v
#		define EIF_NON_GENERIC(v)	.type.non_generic = v
#	else
#		define EIF_GENERIC(v)		v
#		define EIF_NON_GENERIC(v)	((const EIF_TYPE_INDEX *) (rt_uint_ptr) v)
#	endif
#else
#	define EIF_GENERIC(v)			.type.generic = v
#	define EIF_NON_GENERIC(v)		.type.non_generic = v
#endif

struct desc_info {					/* Descriptor information */
	union {
		const EIF_TYPE_INDEX *generic;	/* Generic type description. */
		rt_uint_ptr non_generic;		/* Non-generic type */
	} type;
	BODY_INDEX body_index;		/* Body index */
	uint32 offset;				/* Attribute offset */
};

struct rout_info {						/* Routine information */
	EIF_TYPE_INDEX origin;				/* Routine origin */
	uint16 offset;						/* Routine offset in origin */
};
#endif

/* Invalid body id used to mark empty invariants (= max uint32) */
#define INVALID_ID 0xFFFFFFFF

typedef void *(*fnptr)(EIF_REFERENCE, ...); /* The function pointer type */

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
	void (*toc)(fnptr);		/* Pattern from interpreter to C code */
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

#ifdef __cplusplus
}
#endif

#endif
