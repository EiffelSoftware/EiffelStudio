/*
	description: "[
			Structures and types defining global variables.
			All type definitions are concentrates here because we need
			to put them in a context when running multithreaded apps.
			]"
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

#ifndef _rt_types_h_
#define _rt_types_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif


/*
 * Structure at the beginning of each big chunk. A chunk usually
 * holds more than one Eiffel object. They are linked together
 * in a double linked list.
 */
struct chunk {
	int32 ck_type;			/* Chunk's type */
	struct chunk *ck_next;	/* Next chunk in list */
	struct chunk *ck_prev;	/* Previous chunk in list */
	struct chunk *ck_lnext;	/* Next chunk of same type */
	struct chunk *ck_lprev;	/* Previous chunk of same type */
	size_t ck_length;		/* Length of block (w/o size of this struct) */
							/* int's are split around the chunk pointers */
							/*to provide correct padding for 64 bit machines*/
	double ck_padding;		/* Alignment restrictions, this entry is not conditioned with
							 * MEM_ALIGNBYTES because it is absolutely necessary
							 * to have this structure aligned in memory (in other words
							 * sizeof(struct chunk) should be a multiple of MEM_ALIGNBYTES).
							 * Also having an extra `double' does not hurt the memory usage. */
};

/* The following structure records the head and the tail of the
 * chunk list (blocks obtained via the sbrk() system call). The
 * list is useful when doing garbage collection, because it is
 * the only way we can walk through all the objects (using the
 * ov_size field and its flags).
 */
struct ck_list {
	struct chunk *ck_head;		/* Head of list */
	struct chunk *ck_tail;		/* Tail of list */
	struct chunk *cck_head;		/* Head of C list */
	struct chunk *cck_tail;		/* Tail of C list */
	struct chunk *eck_head;		/* Head of Eiffel list */
	struct chunk *eck_tail;		/* Tail of Eiffel list */
	struct chunk *cursor;		/* Cursor on element of chunk list. */
	struct chunk *c_cursor;		/* Cursor on element of C chunk list. */
	struct chunk *e_cursor;		/* Cursor on element of Eiffel chunk list. */
};

/* Description of a scavenging space */
struct sc_zone {
	char *sc_arena;				/* Original base address of zone */
	char *sc_top;				/* Pointer to first free location */
	char *sc_mark;				/* Water-mark level */
	char *sc_end;				/* First location beyond space */
};

/* Description of a partial scavenging space */
struct partial_sc_zone {
	size_t sc_size;				/* Space's size (in bytes) */
	char *sc_active_arena;		/* Updated base address of zone */
	char *sc_arena;				/* Original base address of zone */
	char *sc_top;				/* Pointer to first free location */
	char *sc_previous_top;		/* Pointer to previous top location, useful to see the B_LAST flag. */
	char *sc_end;				/* First location beyond space */
	rt_uint_ptr sc_flags;		/* ov_size in the selected malloc block */
	uint32 sc_overflowed_size;	/* How much space did we not move because to_zone was full? */
};

#ifdef EIF_THREADS
	/* Structure used for keep stacks that are thread specific, so GC knows about all
	 * stacks in all threads and traverse them when performing a collection. */
struct stack_list {
	size_t count;						/* Number of stacks in Current */
	size_t capacity;					/* Number of possible stacks in Current */
	union {
		void ** volatile data;				/* Array of data */
		struct oastack ** volatile oastack;		/* Typed array of stack - GC stack */
		struct ostack ** volatile ostack;		/* Typed array of stack - GC stack */
		struct xstack ** volatile xstack;		/* Typed array of xtack - exception stack */
#ifdef WORKBENCH
		struct opstack ** volatile opstack;	/* Typed array of opstack - interpreter */
#endif
	} threads;
};

#endif

/* Structure used while printing the exception trace stack. It is built using
 * some look-ahead inside the stack.
 */
struct exprint {
	unsigned char rescued;	/* Routine entered in a rescue clause */
	unsigned char code;		/* Exception code */
	unsigned char last;		/* The very last exception record */
	unsigned char previous;	/* Previous exception code printed */
	char *rname;			/* Routine name of enclosing call */
	const char *tag;		/* Exception tag of current exception */
	char *obj_id;			/* Object's ID */
	EIF_TYPE_INDEX from;	/* Where the routine comes from */
};

/*
doc:	<struct name="rt_traversal_context" export="shared">
doc:		<summary>Context used and updated during calls to `rt_id_of' computation in `gen_conf.c'.</summary>
doc:		<field name="next_address" type="const EIF_TYPE_INDEX *">If `next_address_requested' is set, address of next entry in type array used by `rt_id_of'. This is useful when you have multiple types encoded one after the other and you do not know when the next type starts.</field>
doc:		<field name="has_no_context" type="int">If we encounter an entity which requires the dynamic type used as context for the call to `rt_id_of', we stop all the computation in `rt_id_of' and we set `is_invalid' to `1'.</field>
doc:		<field name="is_invalid" type="int">If `has_no_context' is set, it contains `1' if there was an element in the type array that refers to the dynamic type. This can be a formal, a routine ID. Callers should initialize this value before calling `rt_id_of'.</field>
doc:		<field name="next_address_requested" type="int">Set it to `1' to updated `next_address' with the address in the type array.</field>
doc:	</struct>
*/

struct rt_id_of_context {
	const EIF_TYPE_INDEX *next_address;
	int has_no_context;
	int is_invalid;
	int next_address_requested;
};

#ifdef __cplusplus
}
#endif

#endif	 /* _rt_types_h */
