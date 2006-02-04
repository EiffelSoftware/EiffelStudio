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
	uint32	ck_age;			/* Age of chunk. */
	struct chunk *ck_next;	/* Next chunk in list */
	struct chunk *ck_prev;	/* Previous chunk in list */
	struct chunk *ck_lnext;	/* Next chunk of same type */
	struct chunk *ck_lprev;	/* Previous chunk of same type */
	size_t ck_length;		/* Length of block (w/o size of this struct) */
							/* int's are split around the chunk pointers */
							/*to provide correct padding for 64 bit machines*/
#if MEM_ALIGNBYTES > 8
	double ck_padding;		/* Alignment restrictions */
#endif
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
	char *sc_end;				/* First location beyond space */
	rt_uint_ptr sc_flags;		/* ov_size in the selected malloc block */
};

#ifdef EIF_THREADS
	/* Structure used for keep stacks that are thread specific, so GC knows about all
	 * stacks in all threads and traverse them when performing a collection. */
struct stack_list {
	int count;						/* Number of stacks in Current */
	int capacity;					/* Number of possible stacks in Current */
	union {
		void ** volatile data;				/* Array of data */
		struct stack ** volatile sstack;		/* Typed array of stack - GC stack */
		struct xstack ** volatile xstack;		/* Typed array of xtack - exception stack */
#ifdef WORKBENCH
		struct opstack ** volatile opstack;	/* Typed array of opstack - interpreter */
#endif
	} threads;
};

#endif



#ifdef __cplusplus
}
#endif

#endif	 /* _rt_types_h */
