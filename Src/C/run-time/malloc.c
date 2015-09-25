/*
	description: "Memory allocation management routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2015, Eiffel Software."
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

/*
doc:<file name="malloc.c" header="eif_malloc.h" version="$Id$" summary="Memory allocation management routines">
*/

/*#define MEMCHK */
/*#define MEM_STAT */

#include "eif_portable.h"
#include "eif_project.h"
#include "rt_lmalloc.h"	/* for eif_calloc, eif_malloc, eif_free */
#include <errno.h>			/* For system calls error report */
#include <sys/types.h>		/* For caddr_t */
#include "rt_assert.h"
#include <stdio.h>			/* For eif_trace_types() */
#include <signal.h>

#include "eif_eiffel.h"			/* For bcopy/memcpy */
#include "rt_timer.h"			/* For getcputime */
#include "rt_malloc.h"
#include "rt_macros.h"
#include "rt_garcol.h"			/* For Eiffel flags and function declarations */
#include "rt_threads.h"
#include "rt_gen_types.h"
#include "rt_gen_conf.h"
#include "eif_except.h"			/* For exception raising */
#include "eif_local.h"			/* For epop() */
#include "rt_sig.h"
#include "rt_err_msg.h"
#include "rt_globals.h"
#include "rt_globals_access.h"
#include "rt_struct.h"
#include "rt_hashin.h"
#include "eif_stack.h"
#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#include "rt_object_id.h"	/* For the object id and separate stacks */
#endif
#ifdef VXWORKS
#include <string.h>
#endif
#include "rt_main.h"

#ifdef BOEHM_GC
#include "rt_boehm.h"
#ifdef WORKBENCH
#include "rt_interp.h"	/* For definition of `call_disp' */
#endif
#endif

#ifdef ISE_GC
/* Provides red-black tree implementation for free list management. */
#include "sglib.h"
#endif

/* For debugging */
#define dprintf(n)		if (DEBUG & (n)) printf
#define flush			fflush(stdout)

/*#define MEMCHK */		/* Define for memory checker */
/*#define EMCHK */		/* Define for calls to memck */
/*#define MEMPANIC */		/* Panic if memck reports a trouble */
/*#define DEBUG 63 */		/* Activate debugging code */

#ifdef MEMPANIC
#define mempanic	eif_panic("memory inconsistency")
#else
#define mempanic	fflush(stdout);
#endif

#ifdef ISE_GC

/*
doc:<description>
doc:We have 2 types of free lists: one for Eiffel allocated memory, one for C allocated memory. Both behaves the same way. When we talk about the size of a block in the free lists, we always ignore the size of the header. So it means that for a N-sized block, we actually use (ALIGNMAX + N) bytes. Also it is very important to know that N can only be a multiple of ALIGNMAX.
doc:
doc:The free list is mostly a segregated free list. Mostly because for small sizes, we just have a list containing blocks of a given size. For all the other sizes, the head is the root of a red-black tree ordered by size, and for each node of the tree (i.e. matching a certain size) we have a list containing blocks of the size associated to the tree node.
doc:
doc:The list for 0-sized blocks is a single linked list as we do not have enough space to store a back pointer in the header (a pointer is used for the next element, the remaining space for storing the size and flags of the memory block). All other lists are bi-linkable.
doc:
doc:All lists are LIFO for typical insertion/deletion thus a complexity of O(1). When coalescing free memory, we need to remove entries in the middle of the list. In this case, the complexity is O(N) for 0-sized block, and otherwise in O(1) since lists are bi-linkable.
doc:
doc:Searches in the free list are done using the Best-fit algorithm. That is to say if we have a list for blocks of a given size, we stop at the first free block. In the event there is no such block, we look for the list that contains blocks of the immediate larger size and we use that block and perform a split to not waste memory. The remaining part of the split block is stored back to the free list.
doc:
doc:In the average case, searches are in O(log N) complexity (sometime faster for smaller blocks not in the tree).
doc:
doc:Insertions in the free list are done via `rt_connect_free_list'. Deletion via `rt_disconnect_free_list'.
doc:
doc:To summarize the various lists behavior and structure:
doc: * [c|e]_free_list [0] contains entries of 0 size, it is a single linked list.
doc: * [c|e]_free_list [1] contains entries of ALIGNMAX size, it is a doubly linked list.
doc: * [c|e]_free_list [2] contains entries of 2 * ALIGNMAX size, it is a doubly linked list.
doc: * [c|e]_free_list [3] contains entries of sizes larger or equal to 3 * ALIGNMAX size, it is a red-black tree.
doc:
doc:We define the macro FREE_LIST_INDEX_LIMIT to be the highest entry index that is not a red-black tree.
doc:
doc:</description>
*/

/*
doc:	<struct name="rt_tree" export="private">
doc:		<summary>Node of a red-black tree for blocks of size `nbytes'. The blocks are stored in a doubly-linked list whose head is `current'. It is also used to represent the root of the tree. By approximation, its size is smaller than 3 * ALIGNMAX: ALIGNMAX for `current', ALIGNMAX for `left' and `right', ALIGNMAX for `nbytes' and `color'. Note that the `nbytes' field is not strictly necessary but it is quite convenient.</summary>
doc:		<field name="current" type="union overhead">Head of the list containing all blocks of size `nbytes'.</field>
doc:		<field name="left" type="rt_tree *">Pointer to the left child. If NULL, the current element is the smallest element in the tree.</field>
doc:		<field name="right" type="rt_tree *">Pointer to the right child. If NULL, the current element is the largest element in the tree.</field>
doc:		<field name="nbytes" type="size_t">Size of blocks stored in `current'. The tree is ordered by `nbytes'.</field>
doc:		<field name="color" type="int">Color of nodes. Used to maintain consistency of the red-black tree.</field>
doc:	</struct>
*/
typedef struct _rt_tree {
	union overhead current;
	struct _rt_tree *left;
	struct _rt_tree *right;
	size_t nbytes;
	int color;
} rt_tree;

#define FREE_LIST_INDEX_LIMIT	3

/*
doc:	<struct name="rt_free_list" export="private">
doc:		<summary>Representation of a free list. For blocks strictly smaller than FREE_LIST_INDEX_LIMIT * ALIGNMAX, it is stored in `lists' (a segragated free list). Otherwise stored in `tree', a red-black tree.</summary>
doc:		<field name="lists" type="union overhead *">Head of lists.</field>
doc:		<field name="tree" type="rt_tree *">Head of red-black tree.</field>
doc:	</struct>
*/
struct rt_free_list {
	union overhead *lists [FREE_LIST_INDEX_LIMIT];
	rt_tree *tree;
};


/* Give the type of a free list, by doing pointer comparaison (classic).
 * Also give the address of the free list of a given type.
 */
#define FREE_LIST_TYPE(fl)	(((fl) == &c_free_list)? C_T : EIFFEL_T)
#define FREE_LIST(zone)		(((zone)->ov_size & B_CTYPE)? &c_free_list : &e_free_list)

/* Macros to give the next and previous elements of a list. Note that NEXT is always available
 * if `block' is not NULL. PREVIOUS is only available when `block' has a non-zero size. */
#define NEXT(block)			(block)->ov_next
#define PREVIOUS(block)		(*(union overhead **) (block + 1))

/*
doc:	<routine name="rt_tree_node_comparator" return_type="int" export="private">
doc:		<summary>Comparator for elements in the tree. We use `1' if x > y, 0 if x == y, and -1 otherwise.</summary>
doc:		<param name="x" type="rt_tree *">Tree node</param>
doc:		<param name="y" type="rt_tree *">Tree node</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/
rt_private rt_inline int rt_tree_node_comparator (rt_tree *x, rt_tree *y)
{
	REQUIRE("x not null", x);
	REQUIRE("y not null", y);

	if (y->nbytes > x->nbytes) {
		return -1;
	} else {
			/* Remember that in C, comparison operators returns 0 (false) or 1 (true). */
		return x->nbytes != y->nbytes;
	}
}

/* We provide a definition for the red-black tree routines we are using. */
SGLIB_DEFINE_RBTREE_PROTOTYPES(rt_tree, left, right, color, rt_tree_node_comparator)
SGLIB_DEFINE_RBTREE_FUNCTIONS(rt_tree, left, right, color, rt_tree_node_comparator)

/* Objects of size smaller than ALIGNMAX are very expensive to manage in the free-list, thus by default
 * we allocate always ALIGNMAX bytes. When freed they will be large enough to hold a pointer to the
 * previous block. */
#define MIN_OBJECT_SIZE(n) ((n) > ALIGNMAX ? (n) : ALIGNMAX)

/* The main data-structures for eif_malloc are filled-in statically at
 * compiled time, so that no special initialization routine is
 * necessary. (Except in MT mode --ZS)
 */

/*
doc:	<attribute name="rt_m_data" return_type="struct emallinfo" export="shared">
doc:		<summary>This structure records some general information about the memory, the number of chunck, etc... These informations are available via the eif_rt_meminfo() routine. Only used by current and garcol.c</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex' or GC synchronization.</synchronization>
doc:		<eiffel_classes>MEM_INFO</eiffel_classes>
doc:	</attribute>
*/
rt_shared struct emallinfo rt_m_data = {
	0,		/* ml_chunk */
	0,		/* ml_total */
	0,		/* ml_used */
	0,		/* ml_over */
};

/*
doc:	<attribute name="rt_c_data" return_type="struct emallinfo" export="shared">
doc:		<summary>For C memory, we keep track of general informations too. This enables us to pilot the garbage collector correctly or to call coalescing over the memory only if it is has a chance to succeed. Only used by current and garcol.c</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex' or GC synchronization.</synchronization>
doc:		<eiffel_classes>MEM_INFO</eiffel_classes>
doc:	</attribute>
*/
rt_shared struct emallinfo rt_c_data = { /* Informations on C memory */
	0,		/* ml_chunk */
	0,		/* ml_total */
	0,		/* ml_used */
	0,		/* ml_over */
};

/*
doc:	<attribute name="rt_e_data" return_type="struct emallinfo" export="shared">
doc:		<summary>For Eiffel memory, we keep track of general informations too. This enables us to pilot the garbage collector correctly or to call coalescing over the memory only if it is has a chance to succeed. Only used by current and garcol.c</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex' or GC synchronization.</synchronization>
doc:		<eiffel_classes>MEM_INFO</eiffel_classes>
doc:		<fixme>Unsafe access to `rt_e_data' from `acollect' when compiled with `-DEIF_CONDITIONAL_COLLECT' option.</fixme>
doc:	</attribute>
*/
rt_shared struct emallinfo rt_e_data = { /* Informations on Eiffel memory */
	0,		/* ml_chunk */
	0,		/* ml_total */
	0,		/* ml_used */
	0,		/* ml_over */
};

/*  */
/*
doc:	<attribute name="cklst" return_type="struct ck_list" export="shared">
doc:		<summary>Record head and tail of the chunk list. Only used by current and garcol.c</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex' or GC synchronization.</synchronization>
doc:	</attribute>
*/
rt_shared struct ck_list cklst = {
	(struct chunk *) 0,			/* ck_head */
	(struct chunk *) 0,			/* ck_tail */
	(struct chunk *) 0,			/* cck_head */
	(struct chunk *) 0,			/* cck_tail */
	(struct chunk *) 0,			/* eck_head */
	(struct chunk *) 0,			/* eck_tail */
	(struct chunk *) 0,			/* cursor */
	(struct chunk *) 0,			/* c_cursor */
	(struct chunk *) 0,			/* e_cursor */
};

/*
doc:	<attribute name="c_free_list" return_type="struct rt_free_list" export="private">
doc:		<summary>Records all free C blocks. See description above.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private struct rt_free_list c_free_list;

/*
doc:	<attribute name="e_free_list" return_type="struct rt_free_list" export="private">
doc:		<summary>Records all free Eiffel blocks. See description above.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private struct rt_free_list e_free_list;

/*
doc:	<attribute name="sc_from" return_type="struct sc_zone" export="shared">
doc:		<summary>The sc_from zone is the `from' zone used by the generation scavenging garbage collector. They are shared with the garbage collector. This zone may be put back into the free list in case we are low in RAM.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_gsz_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct sc_zone sc_from;

/*
doc:	<attribute name="sc_to" return_type="struct sc_zone" export="shared">
doc:		<summary>The sc_to zone is the `to' zone used by the generation scavenging garbage collector. They are shared with the garbage collector. This zone may be put back into the free list in case we are low in RAM.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_gsz_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct sc_zone sc_to;

/*
doc:	<attribute name="gen_scavenge" return_type="uint32" export="shared">
doc:		<summary>Generation scavenging status which can be either GS_OFF (disabled) or GS_ON (enabled). When it is GC_ON, it can be temporarly disabled in which case it holds the GS_STOP flag. By default it is GS_OFF, and it will be enabled by `create_scavenge_zones' if `cc_for_speed' is enabled and enough memory is available to allocate the zones.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through GC synchronization.</synchronization>
doc:		<fixme>Is the visibility of the change is not guaranteed among all threads.</fixme>
doc:	</attribute>
*/
rt_shared uint32 gen_scavenge = GS_OFF;

/*
doc:	<attribute name="eiffel_usage" return_type="rt_uint_ptr" export="shared">
doc:		<summary>Monitor Eiffel memory usage. Each time an Eiffel object is created outside the scavenge zone (via emalloc or tenuring), we record its size in eiffel_usage variable. Then, once the amount of allocated data goes beyond th_alloc, a cycle of acollect() is run.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eiffel_usage_mutex' or GC synchronization.</synchronization>
doc:	</attribute>
*/
rt_shared rt_uint_ptr eiffel_usage = 0;

/*
doc:	<attribute name="eif_max_mem" return_type="size_t" export="shared">
doc:		<summary>This variable is the maximum amount of memory the run-time can allocate. If it is null or negative, there is no limit.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Use `eif_memory_mutex' when updating its value in `memory.c'.</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_max_mem = 0;

/*
doc:	<attribute name="eif_tenure_max" return_type="size_t" export="shared">
doc:		<summary>Maximum age of tenuring.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eif_alloc_init' (main.c)</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_tenure_max;

/*
doc:	<attribute name="eif_gs_limit" return_type="size_t" export="shared">
doc:		<summary>Maximum size of object in GSZ.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eif_alloc_init' (main.c)</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_gs_limit;

/*
doc:	<attribute name="eif_scavenge_size" return_type="size_t" export="shared">
doc:		<summary>Size of scavenge zones. Should be a multiple of ALIGNMAX.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eif_alloc_init' (main.c)</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_scavenge_size;
#endif

/*
doc:	<attribute name="eif_stack_chunk" return_type="size_t" export="shared">
doc:		<summary>Size of local stack chunk. Should be a multiple of ALIGNMAX.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eif_alloc_init' (main.c)</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_stack_chunk;

/*
doc:	<attribute name="eif_chunk_size" return_type="size_t" export="shared">
doc:		<summary>Size of memory chunks. Should be a multiple of ALIGNMAX.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eif_alloc_init' (main.c)</synchronization>
doc:	</attribute>
*/
rt_shared size_t eif_chunk_size;

#ifdef ISE_GC
/* Functions handling free list */
rt_private rt_inline size_t rt_compute_free_list_index (size_t nbytes);
rt_shared EIF_REFERENCE eif_rt_xmalloc(size_t nbytes, int type, int gc_flag);		/* General free-list allocation */
rt_shared void rel_core(void);					/* Release core to kernel */
rt_private union overhead *add_core(size_t nbytes, int type);		/* Get more core from kernel */
rt_private void rt_connect_free_list(union overhead * const zone);		/* Insert a block in free list */
rt_private void rt_disconnect_free_list(union overhead * const zone);	/* Remove a block from free list */
rt_private rt_uint_ptr coalesc(union overhead *zone);					/* Coalescing (return # of bytes) */
rt_private EIF_REFERENCE rt_malloc_free_list(size_t nbytes, struct rt_free_list *a_free_list, int type, int gc_flag);		/* Allocate block in one of the lists */
rt_private EIF_REFERENCE rt_allocate_from_free_list(size_t nbytes, struct rt_free_list *a_free_list);		/* Allocate block from free list */
rt_private EIF_REFERENCE rt_allocate_from_core(size_t nbytes, struct rt_free_list *a_free_list, int maximized);		/* Allocate block asking for core */
rt_private EIF_REFERENCE set_up(register union overhead *selected, size_t nbytes);					/* Set up block before public usage */
rt_shared rt_uint_ptr chunk_coalesc(struct chunk *c);				/* Coalescing on a chunk */
rt_private void xfreeblock(union overhead *zone, rt_uint_ptr r);				/* Release block to the free list */
rt_shared rt_uint_ptr full_coalesc(int chunk_type);				/* Coalescing over specified chunks */
rt_private rt_uint_ptr full_coalesc_unsafe(int chunk_type);				/* Coalescing over specified chunks */
rt_private void free_chunk(struct chunk *);			/* Detach chunk from list and release it to core. */

/* Functions handling scavenging zone */
rt_private EIF_REFERENCE malloc_from_eiffel_list (rt_uint_ptr nbytes);
rt_private EIF_REFERENCE malloc_from_zone(rt_uint_ptr nbytes);		/* Allocate block in scavenging zone */
rt_shared void create_scavenge_zones(void);	/* Attempt creating the two zones */
rt_private void explode_scavenge_zone(struct sc_zone *sc);	/* Release objects to free-list */
rt_public void sc_stop(void);					/* Stop the scavenging process */
#endif

/* Eiffel object setting */
rt_private EIF_REFERENCE eif_set(EIF_REFERENCE object, uint16 flags, EIF_TYPE_INDEX dftype, EIF_TYPE_INDEX dtype);					/* Set Eiffel object prior use */
rt_private EIF_REFERENCE eif_spset(EIF_REFERENCE object, EIF_BOOLEAN in_scavenge);				/* Set special Eiffel object */

#ifdef ISE_GC
rt_private int trigger_gc_cycle (void);
rt_private int trigger_smart_gc_cycle (void);
rt_private EIF_REFERENCE add_to_stack (struct ostack *, EIF_REFERENCE);
rt_private EIF_REFERENCE add_to_moved_set (EIF_REFERENCE);

/* Also used by the garbage collector */
rt_shared void lxtract(union overhead *next);					/* Extract a block from free list */
rt_shared EIF_REFERENCE malloc_from_eiffel_list_no_gc (rt_uint_ptr nbytes);			/* Wrapper to eif_rt_xmalloc */
rt_shared EIF_REFERENCE get_to_from_core(void);		/* Get a free eiffel chunk from kernel */
#ifdef EIF_EXPENSIVE_ASSERTIONS
rt_private void rt_check_free_list (size_t nbytes, struct rt_free_list *a_free_list);
#endif
#endif

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST

/* This is to make tests */
#undef References
#undef Size
#undef Disp_rout
#undef XCreate
#define References(type)	2		/* Number of references in object */
#define EIF_Size(type)			40		/* Size of the object */
#define Disp_rout(type)		0		/* No dispose procedure */
#define XCreate(type)		0		/* No creation procedure */
/* char *(**ecreate)(void); FIXME: SEE EIF_PROJECT.C */

#ifndef DEBUG
#define DEBUG	 127		/* Highest debug level */
#endif
#endif

#ifdef BOEHM_GC
/*
doc:	<routine name="boehm_dispose" export="private">
doc:		<summary>Record `dispose' routine for Boehm GC</summary>
doc:		<param name="header" type="union overhead *">Zone allocated by Boehm GC which needs to be recorded so that `dispose' is called by Boehm GC when collectin `header'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_private void boehm_dispose (union overhead *header, void *cd)
	/* Record `dispose' routine fro Boehm GC. */
{
	DISP(header->ov_dtype, (EIF_REFERENCE) (header + 1));
}
#endif

#if defined(BOEHM_GC) || defined(NO_GC)
/*
doc:	<routine name="external_allocation" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Allocate new object using an external allocator such as `Boehm GC' or `standard malloc'.</summary>
doc:		<param name="atomic" type="int">Is object to be allocated empty of references to other objects?</param>
doc:		<param name="has_dispose" type="int">Has object to be allocated a `dispose' routine to be called when object will be collected?</param>
doc:		<param name="nbytes" type="uint32">Size in bytes of object to be allocated.</param>
doc:		<return>A newly allocated object of size `nbytes'.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Performed by external allocator</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE external_allocation (int atomic, int has_dispose, uint32 nbytes)
{
	unsigned int real_nbytes;	/* Real object size */
	int mod;					/* Remainder for padding */
	union overhead *header;

		/* We need to allocate room for the header and
		 * make sure that we won't alignment problems. We
		 * really use at least ALIGNMAX, so even if `nbytes'
		 * is 0, some memory will be used (the header).
		 */
	real_nbytes = nbytes;
	mod = real_nbytes % ALIGNMAX;
	if (mod != 0)
		real_nbytes += ALIGNMAX - mod;
	if (real_nbytes & ~B_SIZE) {
			/* Object too big */
		return NULL;
	} else {
		DISCARD_BREAKPOINTS
#ifdef BOEHM_GC
		if (real_nbytes == 0) {
			real_nbytes++;
		}
		if (atomic) {
			header = (union overhead *) GC_malloc_atomic (real_nbytes + OVERHEAD);
		} else {
			header = (union overhead *) GC_malloc (real_nbytes + OVERHEAD);
		}
#endif
#ifdef NO_GC
		header = (union overhead *) malloc(real_nbytes + OVERHEAD);
#endif
		if (header != NULL) {
			header->ov_size = real_nbytes;
				/* Point to the first data byte, just after the header. */
#ifdef BOEHM_GC
#ifdef EIF_ASSERTIONS
			GC_is_valid_displacement(header);
			GC_is_valid_displacement((EIF_REFERENCE)(header + 1));
#endif
			if (has_dispose) {
				GC_register_finalizer(header, (void (*) (void*, void*)) &boehm_dispose, NULL, NULL, NULL);
			}
#endif
			UNDISCARD_BREAKPOINTS
			return (EIF_REFERENCE)(header + 1);
		} else {
			UNDISCARD_BREAKPOINTS
			return NULL;
		}
	}
}

/*
doc:	<routine name="external_reallocation" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Reallocate a given object with a  bigger size using external allocator.</summary>
doc:		<param name="obj" type="EIF_REFERENCE">Object to be reallocated</param>
doc:		<param name="nbytes" type="uint32">New size in bytes of `obj'.</param>
doc:		<return>A reallocated object of size `nbytes'.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Performed by external allocator</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE external_reallocation (EIF_REFERENCE obj, uint32 nbytes) {
	unsigned int real_nbytes;	/* Real object size */
	int mod;					/* Remainder for padding */
	union overhead *header;

		/* We need to allocate room for the header and
		 * make sure that we won't alignment problems. We
		 * really use at least ALIGNMAX, so even if `nbytes'
		 * is 0, some memory will be used (the header).
		 */
	real_nbytes = nbytes;
	mod = real_nbytes % ALIGNMAX;
	if (mod != 0)
		real_nbytes += ALIGNMAX - mod;
	if (real_nbytes & ~B_SIZE) {
			/* Object too big */
		return NULL;
	} else {
		DISCARD_BREAKPOINTS
#ifdef BOEHM_GC
		header = (union overhead *) GC_realloc((union overhead *) obj - 1, real_nbytes + OVERHEAD);
#endif
#ifdef NO_GC
		header = (union overhead *) realloc((union overhead *) obj - 1, real_nbytes + OVERHEAD);
#endif
		UNDISCARD_BREAKPOINTS

		if (header != NULL) {
			header->ov_size = real_nbytes;
				/* Point to the first data byte, just after the header. */
			return (EIF_REFERENCE)(header + 1);
		} else {
			return NULL;
		}
	}
}

#endif

#if defined(ISE_GC) && defined(EIF_THREADS)
/*
doc:	<attribute name="eif_gc_gsz_mutex" return_type="EIF_CS_TYPE *" export="shared">
doc:		<summary>Mutex used to protect GC allocation in scavenge zone.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_shared EIF_CS_TYPE *eif_gc_gsz_mutex = NULL;
#define EIF_GC_GSZ_LOCK		EIF_ASYNC_SAFE_CS_LOCK(eif_gc_gsz_mutex)
#define EIF_GC_GSZ_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_gc_gsz_mutex)

/*
doc:	<attribute name="eif_free_list_mutex" return_type="EIF_CS_TYPE *" export="shared">
doc:		<summary>Mutex used to protect access and update to private/shared member of this module.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared EIF_CS_TYPE *eif_free_list_mutex = NULL;
#define EIF_FREE_LIST_MUTEX_LOCK	EIF_ASYNC_SAFE_CS_LOCK(eif_free_list_mutex)
#define EIF_FREE_LIST_MUTEX_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_free_list_mutex)

/*
doc:	<attribute name="eiffel_usage_mutex" return_type="EIF_CS_TYPE *" export="shared">
doc:		<summary>Mutex used to protect access and update `eiffel_usage'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared EIF_CS_TYPE *eiffel_usage_mutex = NULL;
#define EIFFEL_USAGE_MUTEX_LOCK		EIF_ASYNC_SAFE_CS_LOCK(eiffel_usage_mutex)
#define EIFFEL_USAGE_MUTEX_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eiffel_usage_mutex)

/*
doc:	<attribute name="trigger_gc_mutex" return_type="EIF_CS_TYPE *" export="shared">
doc:		<summary>Mutex used to protect execution of `trigger_gc' routines. So that even if more than one threads enter this routine because there is a need to launch a GC cycle, hopefully one will run it, and not all of them.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared EIF_CS_TYPE *trigger_gc_mutex = NULL;
#define TRIGGER_GC_LOCK		EIF_ASYNC_SAFE_CS_LOCK(trigger_gc_mutex)
#define TRIGGER_GC_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(trigger_gc_mutex)
#endif

#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_type_set_mutex" return_type="EIF_CS_TYPE *" export="public">
doc:		<summary>Mutex used to guarantee unique access to `rt_type_set'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_shared EIF_CS_TYPE *eif_type_set_mutex = NULL;
#define TYPE_SET_MUTEX_LOCK		EIF_ASYNC_SAFE_CS_LOCK(eif_type_set_mutex)
#define TYPE_SET_MUTEX_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_type_set_mutex)
#endif


/*
doc:	<routine name="smart_emalloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Perform smart allocation of either a TUPLE object or a normal object. It does not take into account SPECIAL creation as a size is required for that. See `emalloc' comments for me details.</summary>
doc:		<param name="ftype" type="EIF_TYPE_INDEX">Full dynamic type used to determine if we are creating a TUPLE or a normal object.</param>
doc:		<return>A newly allocated object if successful, otherwise throw an exception</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE smart_emalloc (EIF_TYPE_INDEX ftype)
{
	EIF_TYPE_INDEX type = To_dtype(ftype);
	if (type == egc_tup_dtype) {
		return tuple_malloc (ftype);
	} else {
		return emalloc_size (ftype, type, EIF_Size(type));
	}
}

/*
doc:	<routine name="emalloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Perform allocation of normal object (i.e. not a SPECIAL or TUPLE object) based on `ftype' full dynamic type which is used to find out object's size in bytes. Note that the size of all the Eiffel objects is correctly padded, but do not take into account the header's size.</summary>
doc:		<param name="ftype" type="uint32">Full dynamic type used to determine if we are creating a TUPLE or a normal object.</param>
doc:		<return>A newly allocated object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE emalloc (EIF_TYPE_INDEX ftype)
{
	EIF_TYPE_INDEX type = To_dtype(ftype);
	return emalloc_size (ftype, type, EIF_Size(type));
}

/*
doc:	<routine name="emalloc_size" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Memory allocation for a normal Eiffel object (i.e. not SPECIAL or TUPLE).</summary>
doc:		<param name="ftype" type="EIF_TYPE_INDEX">Full dynamic type used to initialize full dynamic type overhead part of Eiffel object.</param>
doc:		<param name="type" type="EIF_TYPE_INDEX">Dynamic type used to initialize flags overhead part of Eiffel object, mostly used if type is a deferred one, or if it is an expanded one, or if it has a dispose routine.</param>
doc:		<param name="nbytes" type="uint32">Number of bytes to allocate for this type.</param>
doc:		<return>A newly allocated object holding at least `nbytes' if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE emalloc_size(EIF_TYPE_INDEX ftype, EIF_TYPE_INDEX type, uint32 nbytes)
{
	EIF_REFERENCE object;				/* Pointer to the freshly created object */
#ifdef ISE_GC
	uint32 mod;							/* Remainder for padding */
#endif

#ifdef WORKBENCH
	if (EIF_IS_DEFERRED_TYPE(System(type))) {	/* Cannot create deferred */
		eraise(System(type).cn_generator, EN_CDEF);
		return (EIF_REFERENCE) 0;			/* In case they chose to ignore EN_CDEF */
	}
#endif

#if defined(BOEHM_GC) || defined(NO_GC)
	object = external_allocation (References(type) == 0, (int) Disp_rout(type), nbytes);
	if (object != NULL) {
		return eif_set(object, EO_NEW, ftype, type);
	} else {
		eraise("object allocation", EN_MEM);	/* Signals no more memory */
		return NULL;
	}
#endif

#ifdef ISE_GC
		/* Objects of tiny size are very expensive to manage in the free-list, thus we make them not tiny. */
	nbytes = MIN_OBJECT_SIZE(nbytes);

		/* We really use at least ALIGNMAX, to avoid alignement problems.
		 * So even if nbytes is 0, some memory will be used (the header), he he !!
		 */
	mod = nbytes % ALIGNMAX;
	if (mod != 0)
		nbytes += ALIGNMAX - mod;

	/* Depending on the optimization chosen, we allocate the object in
	 * the Generational Scavenge Zone (GSZ) or in the free-list.
	 * All the objects smaller than `eif_gs_limit' are allocated
	 * in the the GSZ, otherwise they are allocated in the free-list.
	 */

	if ((gen_scavenge == GS_ON) && (nbytes <= eif_gs_limit)) {
		object = malloc_from_zone(nbytes);
		if (object) {
			return eif_set(object, 0, ftype, type);	/* Set for Eiffel use */
		} else if (trigger_smart_gc_cycle()) {
				/* First allocation in scavenge zone failed. If `trigger_smart_gc_cycle' was
				 * successful, let's try again as this is a more efficient way to allocate
				 * in the scavenge zone. */
			object = malloc_from_zone (nbytes);
			if (object) {
				return eif_set(object, 0, ftype, type);	/* Set for Eiffel use */
			}
		}
	}

	/* Try an allocation in the free list, with garbage collection turned on. */
	CHECK("Not too big", !(nbytes & ~B_SIZE));
	object = malloc_from_eiffel_list (nbytes);
	if (object) {
		return eif_set(object, EO_NEW, ftype, type);		/* Set for Eiffel use */
	} else {
			/*
			 * Allocation failed even if GC was requested. We can only make some space
			 * by turning off generation scavenging and getting the two scavenge zones
			 * back for next allocation. A last attempt is then made before raising
			 * an exception if it also failed.
			 */
		if (gen_scavenge & GS_ON)		/* If generation scaveging was on */
			sc_stop();					/* Free 'to' and explode 'from' space */

		object = malloc_from_eiffel_list_no_gc (nbytes);		/* Retry with GC off this time */

		if (object) {
			return eif_set(object, EO_NEW, ftype, type);		/* Set for Eiffel use */
		}
	}


	eraise("object allocation", EN_MEM);	/* Signals no more memory */

	/* NOTREACHED, to avoid C compilation warning. */
	return NULL;
#endif /* ISE_GC */
}

/*
doc:	<routine name="emalloc_as_old" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Memory allocation for a normal Eiffel object (i.e. not SPECIAL or TUPLE) as an old object. Useful for once manifest strings for example which we know are going to stay alive for a while.</summary>
doc:		<param name="ftype" type="uint32">Full dynamic type used to initialize full dynamic type overhead part of Eiffel object.</param>
doc:		<return>A newly allocated object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE emalloc_as_old(EIF_TYPE_INDEX ftype)
{
	EIF_REFERENCE object;				/* Pointer to the freshly created object */
	EIF_TYPE_INDEX type = To_dtype(ftype);
	uint32 nbytes = EIF_Size(type);

#ifdef ISE_GC
	uint32 mod;							/* Remainder for padding */
#endif

#ifdef WORKBENCH
	if (EIF_IS_DEFERRED_TYPE(System(type))) {	/* Cannot create deferred */
		eraise(System(type).cn_generator, EN_CDEF);
		return (EIF_REFERENCE) 0;			/* In case they chose to ignore EN_CDEF */
	}
#endif

#if defined(BOEHM_GC) || defined(NO_GC)
	object = external_allocation (References(type) == 0, (int) Disp_rout(type), nbytes);
	if (object != NULL) {
		return eif_set(object, EO_OLD, ftype, type);
	} else {
		eraise("object allocation", EN_MEM);	/* Signals no more memory */
		return NULL;
	}
#endif

#ifdef ISE_GC
		/* We really use at least ALIGNMAX, to avoid alignement problems.
		 * So even if nbytes is 0, some memory will be used (the header), he he !!
		 */
	mod = nbytes % ALIGNMAX;
	if (mod != 0)
		nbytes += ALIGNMAX - mod;

	/* Direct allocation in the free list, with garbage collection turned on. */
	CHECK("Not too big", !(nbytes & ~B_SIZE));
	object = malloc_from_eiffel_list (nbytes);
	if (object) {
		return eif_set(object, EO_OLD, ftype, type);		/* Set for Eiffel use */
	} else {
			/*
			 * Allocation failed even if GC was requested. We can only make some space
			 * by turning off generation scavenging and getting the two scavenge zones
			 * back for next allocation. A last attempt is then made before raising
			 * an exception if it also failed.
			 */
		if (gen_scavenge & GS_ON)		/* If generation scaveging was on */
			sc_stop();					/* Free 'to' and explode 'from' space */

		object = malloc_from_eiffel_list_no_gc (nbytes);		/* Retry with GC off this time */

		if (object) {
			return eif_set(object, EO_OLD, ftype, type);		/* Set for Eiffel use */
		}
	}

	eraise("object allocation", EN_MEM);	/* Signals no more memory */

	/* NOTREACHED, to avoid C compilation warning. */
	return NULL;
#endif /* ISE_GC */
}

/*
doc:	<routine name="sp_init" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Initialize special object of expanded `obj' from `lower' position to `upper' position. I.e. creating new instances of expanded objects and assigning them from `obj [lower]' to `obj [upper]'.</summary>
doc:		<param name="obj" type="EIF_REFERENCE">Special object of expanded which will be initialized.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Dynamic type of expanded object to create for each entry of special object `obj'.</param>
doc:		<param name="lower" type="EIF_INTEGER">Lower bound of `obj'.</param>
doc:		<param name="upper" type="EIF_INTEGER">Upper bound of `obj'.</param>
doc:		<return>New address of `obj' in case a GC collection was performed.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE sp_init (EIF_REFERENCE obj, EIF_TYPE_INDEX dftype, EIF_INTEGER lower, EIF_INTEGER upper)
{
	EIF_GET_CONTEXT

	EIF_INTEGER i;
	rt_uint_ptr elem_size, offset;
	union overhead *zone;
	EIF_TYPE_INDEX dtype = To_dtype(dftype);
	void (*cp) (EIF_REFERENCE);
	void (*init) (EIF_REFERENCE, EIF_REFERENCE);

	REQUIRE ("obj not null", obj != (EIF_REFERENCE) 0);
	REQUIRE ("Not forwarded", !(HEADER (obj)->ov_size & B_FWD));
	REQUIRE ("Special object", HEADER (obj)->ov_flags & EO_SPEC);
	REQUIRE ("Special object of expanded", HEADER (obj)->ov_flags & EO_COMP);
	REQUIRE ("Valid lower", ((lower >= 0) && (lower <= RT_SPECIAL_CAPACITY(obj))));
	REQUIRE ("Valid upper", ((upper >= lower - 1) && (upper <= RT_SPECIAL_CAPACITY(obj))));

	if (upper >= lower) {
#ifdef WORKBENCH
		cp = init_exp;
#else
		cp = egc_exp_create [dtype];
#endif
		init = XCreate(dtype);

		elem_size = RT_SPECIAL_ELEM_SIZE(obj);
#ifndef WORKBENCH
		if (References(dtype) > 0) {
#endif
			if (init) {
				if (cp) {
					RT_GC_PROTECT(obj);
					for (i = lower, offset = elem_size * i; i <= upper; i++) {
						zone = (union overhead *) (obj + offset);
						zone->ov_size = OVERHEAD + offset;	/* For GC */
						zone->ov_flags = EO_EXP;	/* Expanded type */
						zone->ov_dftype = dftype;
						zone->ov_dtype = dtype;
						(init) (obj + OVERHEAD + offset, obj + OVERHEAD + offset);
						(cp) (obj + OVERHEAD + offset);
						offset += elem_size;
					}
					RT_GC_WEAN(obj);
				} else {
					RT_GC_PROTECT(obj);
					for (i = lower, offset = elem_size * i; i <= upper; i++) {
						zone = (union overhead *) (obj + offset);
						zone->ov_size = OVERHEAD + offset;	/* For GC */
						zone->ov_flags = EO_EXP;	/* Expanded type */
						zone->ov_dftype = dftype;
						zone->ov_dtype = dtype;
						(init) (obj + OVERHEAD + offset, obj + OVERHEAD + offset);
						offset += elem_size;
					}
					RT_GC_WEAN(obj);
				}
			} else {
				if (cp) {
					RT_GC_PROTECT(obj);
					for (i = lower, offset = elem_size * i; i <= upper; i++) {
						zone = (union overhead *) (obj + offset);
						zone->ov_size = OVERHEAD + offset;	/* For GC */
						zone->ov_flags = EO_EXP;	/* Expanded type */
						zone->ov_dftype = dftype;
						zone->ov_dtype = dtype;
						(cp) (obj + OVERHEAD + offset);
						offset += elem_size;
					}
					RT_GC_WEAN(obj);
				} else {
					for (i = lower, offset = elem_size * i; i <= upper; i++) {
						zone = (union overhead *) (obj + offset);
						zone->ov_size = OVERHEAD + offset;	/* For GC */
						zone->ov_flags = EO_EXP;	/* Expanded type */
						zone->ov_dftype = dftype;
						zone->ov_dtype = dtype;
						offset += elem_size;
					}
				}
			}
#ifndef WORKBENCH
		} else {
			if (cp) {
				RT_GC_PROTECT(obj);
				for (i = lower, offset = elem_size * i; i <= upper; i++) {
					cp (obj + offset);
					offset += elem_size;
				}
				RT_GC_WEAN(obj);
			}
		}
#endif
	}

	return obj;
}

/*
doc:	<routine name="special_malloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Allocated new SPECIAL object with flags `flags' (flags includes the full dynamic type). Elements are zeroed, It initializes elements of a special of expanded.</summary>
doc:		<param name="flags" type="uint16">Flags of SPECIAL.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Full dynamic type of SPECIAL.</param>
doc:		<param name="nb" type="EIF_INTEGER">Number of element in special.</param>
doc:		<param name="element_size" type="uint32">Size of element in special.</param>
doc:		<param name="atomic" type="EIF_BOOLEAN">Is this a special of basic types?</param>
doc:		<return>A newly allocated SPECIAL object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE special_malloc (uint16 flags, EIF_TYPE_INDEX dftype, EIF_INTEGER nb, uint32 element_size, EIF_BOOLEAN atomic)
{
	EIF_REFERENCE result = NULL;
	union overhead *zone;

	result = spmalloc (nb, element_size, atomic);

		/* At this stage we are garanteed to have an initialized object, otherwise an
		 * exception would have been thrown by the call to `spmalloc'. */
	CHECK("result not null", result);

	zone = HEADER(result);
	zone->ov_flags |= flags;
	zone->ov_dftype = dftype;
	zone->ov_dtype = To_dtype(dftype);

	if (egc_has_old_special_semantic) {
		RT_SPECIAL_COUNT(result) = nb;
	} else {
		RT_SPECIAL_COUNT(result) = 0;
	}
	RT_SPECIAL_ELEM_SIZE(result) = element_size;
	RT_SPECIAL_CAPACITY(result) = nb;

	if (flags & EO_COMP) {
			/* It is a composite object, that is to say a special of expanded,
			 * we need to initialize every entry properly. */
		result = sp_init (result, eif_gen_param(dftype, 1).id, 0, nb - 1);
	}
	return result;
}

/*
doc:	<routine name="tuple_malloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Allocated new TUPLE object of type `ftype'. It internally calls `tuple_malloc_specific' therefore it computes `count' of TUPLE to create as wekl as determines if TUPLE is atomic or not.</summary>
doc:		<param name="ftype" type="EIF_TYPE_INDEX">Dynamic type of TUPLE object to create.</param>
doc:		<return>A newly allocated TUPLE object of type `ftype' if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE tuple_malloc (EIF_TYPE_INDEX ftype)
{
	uint32 i, count;
	EIF_BOOLEAN is_atomic = EIF_TRUE;

	REQUIRE("Is a tuple type", To_dtype(ftype) == egc_tup_dtype);

		/* We add + 1 since TUPLE objects have `count + 1' element
		 * to avoid doing -1 each time we try to access an item at position `pos'.
		 */
	count = eif_gen_count_with_dftype (ftype) + 1;

		/* Let's find out if this is a tuple which contains some reference
		 * when there is no reference then `is_atomic' is True which enables
		 * us to do some optimization at the level of the GC */
	for (i = 1; (i < count) && (is_atomic); i++) {
		if (eif_gen_typecode_with_dftype(ftype, i) == EIF_REFERENCE_CODE) {
			is_atomic = EIF_FALSE;
		}
	}

	return tuple_malloc_specific(ftype, count, is_atomic);
}

/*
doc:	<routine name="eif_type_malloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Create a new TYPE [like ftype] instance for type `ftype' if it was not yet created, otherwise return an already existing one. Objects are created as old object since once allocated they cannot be garbage collected.</summary>
doc:		<param name="ftype" type="EIF_TYPE">Dynamic type of the type for which we want to create the `TYPE [like ftype]' instance to return.</param>
doc:		<param name="annotations" type="EIF_TYPE_INDEX">Annotations if in front of `ftype'. Used for declaring something like "detachable like x", then "like x" is described by `ftype' and "detachable" by annotations.</param>
doc:		<return>A TYPE instance for `ftype' if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_type_set_mutex'</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE eif_type_malloc (EIF_TYPE ftype, EIF_TYPE_INDEX annotations)
{
	RT_GET_CONTEXT
	EIF_REFERENCE *result;
	rt_uint_ptr l_array_index;

	REQUIRE("Valid actual generic type", (ftype.id <= MAX_DTYPE) || (RT_CONF_IS_NONE_TYPE(ftype.id)));

		/* We use the encoded version of the type to build the search key in `rt_type_set'.
		 * We add +1 because our hash-table implementation does not handle 0 for the key. */
	ftype.annotations = rt_merged_annotation (annotations, ftype.annotations);
	l_array_index = eif_encoded_type (ftype) + 1;

		/* Synchronization required to access `rt_type_set'. */

		/* NOTE: For acquiring the lock, we quickly deregister with the GC to avoid
		 * unnecessary waiting. The following code must not be executed while the
		 * garbage collector runs however, so we synchronize again right afterwards.
		 * See also test#scoop059. */
 	EIF_ENTER_C;
	GC_THREAD_PROTECT(TYPE_SET_MUTEX_LOCK);
 	EIF_EXIT_C;
 	RTGC;

	result = (EIF_REFERENCE *) ht_first (&rt_type_set, l_array_index);
	if (!result) {
			/* Per documentation, the table is full and we could not find the key `l_array_index'. */
		if (ht_resize (&rt_type_set, rt_type_set.h_capacity + rt_type_set.h_capacity / 2)) {
			enomem();
		} else {
				/* We reiterate the lookup in the resized table. */
			result = (EIF_REFERENCE *) ht_first (&rt_type_set, l_array_index);
			CHECK("has_result", result);
		}
	}
	CHECK("has_result", result);
	if (!*result) {
			/* TYPE instance was not yet computed. We compute it and store it immediately
			 * in location pointed by `result'. This is the beauty of using `ht_first' as we 
			 * avoid a second lookup. */
		*result = emalloc_as_old(rt_typeof_type_of (ftype));
		CHECK("Not in scavenge `from' zone", (*result < sc_from.sc_arena) || (*result > sc_from.sc_top));
		CHECK("Not in scavenge `to' zone", (*result < sc_to.sc_arena) || (*result > sc_to.sc_top));
	}

	GC_THREAD_PROTECT(TYPE_SET_MUTEX_UNLOCK);
	return *result;
}

/*
doc:	<routine name="tuple_malloc_specific" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Allocated new TUPLE object of type `ftype', of count `count' and `atomic'. TUPLE is alloated through `spmalloc', but the element size is the one of TUPLE element, i.e. sizeof (EIF_TYPED_VALUE).</summary>
doc:		<param name="ftype" type="EIF_TYPE_INDEX">Dynamic type of TUPLE object to create.</param>
doc:		<param name="count" type="uint32">Number of elements in TUPLE object to create.</param>
doc:		<param name="atomic" type="EIF_BOOLEAN">Does current TUPLE object to create has reference or not? True means no.</param>
doc:		<return>A newly allocated TUPLE object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE tuple_malloc_specific (EIF_TYPE_INDEX ftype, uint32 count, EIF_BOOLEAN atomic)
{
	EIF_REFERENCE object;
	uint32 t;
	REQUIRE("Is a tuple type", To_dtype(ftype) == egc_tup_dtype);

	object = spmalloc(count, sizeof(EIF_TYPED_VALUE), atomic);

	if (object == NULL) {
		eraise ("Tuple allocation", EN_MEM);	/* signals no more memory */
	} else {
			/* Initialize TUPLE headers and end of special object */
		union overhead * zone = HEADER(object);
		unsigned int i;
		EIF_TYPED_VALUE *l_item = (EIF_TYPED_VALUE *) object;
		RT_SPECIAL_COUNT(object) = count;
		RT_SPECIAL_ELEM_SIZE(object) = sizeof(EIF_TYPED_VALUE);
		RT_SPECIAL_CAPACITY(object) = count;
		if (!egc_has_old_special_semantic) {
				/* If by default allocation does not clear the data of a TUPLE,
				 * we actually need to do it otherwise we end up with TUPLE objects
				 * with invalid data. */
			memset(object, 0, RT_SPECIAL_VISIBLE_SIZE(object));
		}
			/* Mark it is a tuple object */
		zone->ov_flags |= EO_TUPLE;
		zone->ov_dftype = ftype;
		zone->ov_dtype = To_dtype(ftype);
		if (!atomic) {
			zone->ov_flags |= EO_REF;
		}
			/* Initialize type information held in TUPLE instance*/
			/* Don't forget that first element of TUPLE is the BOOLEAN
			 * `object_comparison' attribute. */
		eif_tuple_item_sk_type(l_item) = SK_BOOL;
		l_item++;
		for (i = 1; i < count; i++,l_item++) {
			switch (eif_gen_typecode_with_dftype(ftype, i)) {
				case EIF_BOOLEAN_CODE:    t = SK_BOOL; break;
				case EIF_CHARACTER_8_CODE:  t = SK_CHAR8; break;
				case EIF_CHARACTER_32_CODE:  t = SK_CHAR32; break;
				case EIF_INTEGER_8_CODE:  t = SK_INT8; break;
				case EIF_INTEGER_16_CODE: t = SK_INT16; break;
				case EIF_INTEGER_32_CODE: t = SK_INT32; break;
				case EIF_INTEGER_64_CODE: t = SK_INT64; break;
				case EIF_NATURAL_8_CODE:  t = SK_UINT8; break;
				case EIF_NATURAL_16_CODE: t = SK_UINT16; break;
				case EIF_NATURAL_32_CODE: t = SK_UINT32; break;
				case EIF_NATURAL_64_CODE: t = SK_UINT64; break;
				case EIF_REAL_32_CODE:    t = SK_REAL32; break;
				case EIF_REAL_64_CODE:    t = SK_REAL64; break;
				case EIF_POINTER_CODE:    t = SK_POINTER; break;
				case EIF_REFERENCE_CODE:  t = SK_REF; break;
				default: t = 0;
			}
			eif_tuple_item_sk_type(l_item) = t;
		}
	}
	return object;
}

/*
doc:	<routine name="spmalloc" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Memory allocation for an Eiffel special object. It either succeeds or raises the "No more memory" exception. The routine returns the pointer on a new special object holding at least 'nbytes'. `atomic' means that it is a special object without references.</summary>
doc:		<param name="nb" type="EIF_INTEGER">Number of elements to allocate.</param>
doc:		<param name="element_size" type="uint32">Element size.</param>
doc:		<param name="atomic" type="EIF_BOOLEAN">Does current special object to create has reference or not? True means no.</param>
doc:		<return>A newly allocated TUPLE object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE spmalloc(EIF_INTEGER nb, uint32 element_size, EIF_BOOLEAN atomic)
{
	EIF_REFERENCE object;		/* Pointer to the freshly created special object */
#ifdef ISE_GC
	rt_uint_ptr mod;
#endif
	rt_uint_ptr n = (rt_uint_ptr) nb * (rt_uint_ptr) element_size;
	rt_uint_ptr nbytes = CHRPAD(n) + RT_SPECIAL_PADDED_DATA_SIZE;
		/* Check if there is no overflow. */
		/* The check should avoid division by zero when `element_size == 0' */
	if (((element_size > 0) && (n / (rt_uint_ptr) element_size != (rt_uint_ptr) nb)) || (nbytes < n)) {
		eraise("Special allocation", EN_MEM);	/* Overflow in calculating memory size. */
	}

#if defined(BOEHM_GC) || defined(NO_GC)
		/* No dispose routine associated, therefore `0' for second argument */
	object = external_allocation (atomic, 0, nbytes);
	if (object != NULL) {
		return eif_spset(object, EIF_FALSE);
	} else {
		eraise("Special allocation", EN_MEM);	/* Signals no more memory */
		return NULL;
	}
#endif

#ifdef ISE_GC
		/* Objects of tiny size are very expensive to manage in the free-list, thus we make them not tiny. */
	nbytes = MIN_OBJECT_SIZE(nbytes);

		/* We really use at least ALIGNMAX, to avoid alignement problems.
		 * So even if nbytes is 0, some memory will be used (the header), he he !!
		 */
	mod = nbytes % ALIGNMAX;
	if (mod != 0)
		nbytes += ALIGNMAX - mod;

	if ((gen_scavenge == GS_ON) && (nbytes <= eif_gs_limit)) {
		object = malloc_from_zone (nbytes);	/* allocate it in scavenge zone. */
		if (object) {
			return  eif_spset(object, EIF_TRUE);
		} else if (trigger_smart_gc_cycle()) {
			object = malloc_from_zone (nbytes);
			if (object) {
				return eif_spset(object, EIF_TRUE);
			}
		}
	}

		/* New special object is too big to be created in generational scavenge zone or there is
		 * more space in scavenge zone. So we allocate it in free list only if it is less
		 * than the authorized size `2^27'. */
	if (!(nbytes & ~B_SIZE)) {
		object = malloc_from_eiffel_list (nbytes);
		if (object) {
			return eif_spset(object, EIF_FALSE);
		} else {
				/*
				 * Allocation failed even if GC was requested. We can only make some space
				 * by turning off generation scavenging and getting the two scavenge zones
				 * back for next allocation. A last attempt is then made before raising
				 * an exception if it also failed.
				 */
			if (gen_scavenge & GS_ON)		/* If generation scaveging was on */
				sc_stop();					/* Free 'to' and explode 'from' space */

			object = malloc_from_eiffel_list_no_gc (nbytes);		/* Retry with GC off this time */

			if (object) {
				return eif_spset(object, EIF_FALSE);		/* Set for Eiffel use */
			}
		}
	}

	eraise("Special allocation", EN_MEM);	/* No more memory */

	/* Not reached - to avoid C compilation warning */
	return NULL;
#endif
}

/*
doc:	<routine name="sprealloc" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Reallocate a special object `ptr' so that it can hold at least `nbitems'.</summary>
doc:		<param name="ptr" type="EIF_REFERENCE">Special object which will be reallocated.</param>
doc:		<param name="nbitems" type="unsigned int">New number of items wanted.</param>
doc:		<return>A newly allocated special object if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required, it is done by the features we are calling.</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE sprealloc(EIF_REFERENCE ptr, unsigned int nbitems)
{
	EIF_GET_CONTEXT
	union overhead *zone;		/* Malloc information zone */
	EIF_REFERENCE object;
	unsigned int count, elem_size, capacity;
	rt_uint_ptr old_size, new_size;					/* New and old size of special object. */
	rt_uint_ptr old_real_size, new_real_size;		/* Size occupied by items of special */
#ifdef ISE_GC
	EIF_BOOLEAN need_update = EIF_FALSE;	/* Do we need to remember content of special? */
#endif
	EIF_BOOLEAN need_expanded_initialization = EIF_FALSE;	/* Do we need to initialize new entries? */

	REQUIRE ("ptr not null", ptr != (EIF_REFERENCE) 0);
	REQUIRE ("Not forwarded", !(HEADER (ptr)->ov_size & B_FWD));
	REQUIRE ("Special object:", HEADER (ptr)->ov_flags & EO_SPEC);

	/* At the end of the special object arena, there are two long values which
	 * are kept up-to-date: the actual number of items held and the size in
	 * byte of each item (the same for all items).
	 */
	zone = HEADER(ptr);
	old_size = zone->ov_size & B_SIZE;	/* Old size of array */
	count = RT_SPECIAL_COUNT(ptr);		/* Current number of elements */
	elem_size = RT_SPECIAL_ELEM_SIZE(ptr);
	capacity = RT_SPECIAL_CAPACITY(ptr);
	old_real_size = (rt_uint_ptr) capacity * (rt_uint_ptr) elem_size;	/* Size occupied by items in old special */
	new_real_size = nbitems * (rt_uint_ptr) elem_size;	/* Size occupied by items in new special */
	new_size = new_real_size + RT_SPECIAL_PADDED_DATA_SIZE;		/* New required size */

	if (nbitems == capacity) {		/* OPTIMIZATION: Does resized object have same size? */
		return ptr;				/* If so, we return unchanged `ptr'. */
	}

	RT_GC_PROTECT(ptr);	/* Object may move if GC called */

	CHECK ("Stil not forwarded", !(HEADER(ptr)->ov_size & B_FWD));

#ifdef ISE_GC
#ifdef EIF_GSZ_ALLOC_OPTIMIZATION
	if (zone->ov_flags & (EO_NEW | EO_OLD)) {	/* Is it out of GSZ? */
#endif
			/* It is very important to give the GC_FREE flag to xrealloc, as if the
			 * special object happens to move during the reallocing operation, its
			 * old "location" must not be freed in case it is in the moved_set or
			 * whatever GC stack. This old copy will be normally reclaimed by the
			 * GC. Also, this prevents a nasty bug when Eiffel objects share the area.
			 * When one of this area is resized and moved, the other object still
			 * references somthing valid (although the area is no longer shared)--RAM.
			 */

		object = xrealloc (ptr, new_size, GC_ON | GC_FREE);
#endif

#if defined(BOEHM_GC) || defined(NO_GC)
		object = external_reallocation (ptr, new_size);
#endif

		if ((EIF_REFERENCE) 0 == object) {
			eraise("special reallocation", EN_MEM);
			return (EIF_REFERENCE) 0;
		}

		zone = HEADER (object);
		new_size = zone->ov_size & B_SIZE;	/* `xrealloc' can change the `new_size' value for padding */

		CHECK("Valid_size", new_size >= new_real_size);

		CHECK ("Not forwarded", !(HEADER(ptr)->ov_size & B_FWD));

			/* Reset extra-items with zeros or default expanded value if any */
		if (new_real_size > old_real_size) {
				/* When the actual memory actually increased, we need to reset
				 * the various new element to their default value. */
			memset (object + old_real_size, 0, new_size - old_real_size);
			if (zone->ov_flags & EO_COMP)
				need_expanded_initialization = EIF_TRUE;
		} else { 	/* Smaller object requested. */
				/* We need to remove existing elements between `new_real_size'
				 * and `new_size'. Above `new_size' it has been taken care
				 * by `xrealloc' when moving the memory area above `new_size'
				 * in the free list.
				 */
			memset (object + new_real_size, 0, new_size - new_real_size);
		}

#ifdef ISE_GC
		if (ptr != object) {		/* Has ptr moved in the reallocation? */
				/* If the reallocation had to allocate a new object, then we have to do
				 * some further settings: if the original object was marked EO_NEW, we
				 * must push the new object into the moved set. Also we must reset the B_C
				 * flags set by malloc (which makes it impossible to freeze a special
				 * object, but it cannot be achieved anyway since a reallocation may
				 * have to move it).
				 */

			zone->ov_size &= ~B_C;		/* Cannot freeze a special object */
			need_update = EIF_TRUE;
		}
#ifdef EIF_GSZ_ALLOC_OPTIMIZATION
	} else {	/* Was allocated in the GSZ. */
		CHECK ("In scavenge zone", !(HEADER (ptr)->ov_size & B_BUSY));

			/* We do not need to reallocate an array if the existing one has enough
			 * space to accomadate the resizing */
		if (new_size > old_size) {
				/* Reserve `new_size' bytes in GSZ if possible. */
			object = spmalloc (nbitems, elem_size, EIF_TEST(!(zone->ov_flags & EO_REF)));
		} else
			object = ptr;

		if (object == (EIF_REFERENCE) 0) {
			eraise("Special reallocation", EN_MEM);
			return (EIF_REFERENCE) 0;
		}

			/* Set flags of newly created object */
		zone = HEADER (object);
		new_size = zone->ov_size & B_SIZE;	/* `spmalloc' can change the `new_size' value for padding */

				/* Copy only dynamic type and object nature and age from old object
				 * We cannot copy HEADER(ptr)->ov_flags because `ptr' might have
				 * moved outside the GSZ during reallocation of `object'. */
		zone->ov_flags |= HEADER(ptr)->ov_flags & (EO_REF | EO_COMP);
		zone->ov_dftype = HEADER(ptr)->ov_dftype;
		zone->ov_dtype = HEADER(ptr)->ov_dtype;
		zone->ov_pid = HEADER(ptr)->ov_pid;

			/* Update flags of new object if it contains references and the object is not
			 * in the scavenge zone anymore. */
		if ((zone->ov_flags & (EO_NEW | EO_OLD)) && (zone->ov_flags & (EO_REF | EO_COMP))) {
				/* New object has been created outside the scavenge zone. Although it might
				 * contains no references to young objects, we need to remember it just in case. */
			erembq (object);	/* Usual remembrance process. */
		}

		CHECK ("Not forwarded", !(HEADER (ptr)->ov_size & B_FWD));

			/* Copy `ptr' in `object'.	*/
		if (new_real_size > old_real_size) {
			CHECK ("New size bigger than old one", new_size >= old_size);
				/* If object has been resized we do not need to clean the new
				 * allocated memory because `spmalloc' does it for us. */
			if (object != ptr)
			  		/* Object has been resized to grow, we need to copy old items. */
				memcpy (object, ptr, old_real_size);
			else {
				CHECK ("New size same as old one", new_size == old_size);
			  		/* We need to clean area between `old_real_size' and
					 * `new_real_size'.
					 */
				memset (object + old_real_size, 0, new_size - old_real_size);
			}

			if (zone->ov_flags & EO_COMP)
					/* Object has been resized and contains expanded objects.
					 * We need to initialize the newly allocated area. */
				need_expanded_initialization = EIF_TRUE;
		} else {				/* Smaller object requested. */
			CHECK ("New size smaller than old one", new_size <= old_size);
				/* We need to remove existing elements between `new_real_size'
				 * and `new_size'. Above `new_size' we do not care since it
				 * is in the scavenge zone and no one is going to access it
				 */
			memset (object + new_real_size, 0, new_size - new_real_size);
		}
	}
#endif
#endif

	RT_GC_WEAN(ptr);	/* Unprotect `ptr'. No more collection is expected. */

		/* Update special attributes count and element size at the end */
	if (egc_has_old_special_semantic) {
			/* New count equal to capacity. */
		RT_SPECIAL_COUNT(object) = nbitems;
	} else {
			/* We preserve the count if smaller than new capacity, otherwise new capacity. */
		RT_SPECIAL_COUNT(object) = (nbitems < count ? nbitems : count);
	}
	RT_SPECIAL_ELEM_SIZE(object) = elem_size; 	/* New item size */
	RT_SPECIAL_CAPACITY(object) = nbitems;		/* New capacity */

	if (need_expanded_initialization) {
	   		/* Case of a special object of expanded structures. */
			/* Initialize remaining items. */
		object = sp_init(object, eif_gen_param (Dftype(object), 1).id, count, nbitems - 1);
	}

#ifdef ISE_GC
	if (need_update) {
			/* If the object has moved in the reallocation process and was in the
			 * remembered set, we must re-issue a memorization call otherwise all the
			 * old contents of the area could be freed. Note that the test below is
			 * NOT perfect, since the area could have been moved by the GC and still
			 * have not been moved around wrt the GC stacks. But it doen't hurt--RAM.
			 */

		if (HEADER (ptr)->ov_flags & EO_REM) {
			erembq (object);	/* Usual remembrance process. */
					/* A simple remembering for other special objects. */
		}

		if (HEADER(ptr)->ov_flags & EO_NEW) {	/* Original was new, ie not allocated in GSZ. */
			object = add_to_stack (&moved_set, object);
		}
	}
#endif

	ENSURE ("Special object", HEADER (object)->ov_flags & EO_SPEC);
	ENSURE ("Valid new size", (HEADER (object)->ov_size & B_SIZE) >= new_size);

		/* The accounting of memory used by Eiffel is not accurate here, but it is
		 * not easy to know at this level whether the block was merely extended or
		 * whether we had to allocate a new block. However, if the reallocation
		 * shrinks the object, we know xrealloc will not move the block but shrink
		 * it in place, so there is no need to update the usage.
		 */

#ifdef ISE_GC
	if (new_size > old_size) {				/* Then update memory usage. */
		RT_GET_CONTEXT
		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_LOCK);
		eiffel_usage += (new_size - old_size);
		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_UNLOCK);
	}
#endif

	return object;
}

/*
doc:	<routine name="cmalloc" return_type="void *" export="public">
doc:		<summary>Memory allocation for a C object. This is the same as the traditional malloc routine, excepted that the memory management is done by the Eiffel run time, so Eiffel keeps a kind of control over this memory.</summary>
doc:		<param name="nbytes" type="size_t">Number of bytes to allocated.</param>
doc:		<return>Upon success, it returns a pointer on a new free zone holding at least 'nbytes' free. Otherwise, a null pointer is returned.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public void *cmalloc(size_t nbytes)
{
#ifdef ISE_GC
	return eif_rt_xmalloc(nbytes, C_T, GC_OFF);
#else
	return eif_malloc (nbytes);
#endif
}

#ifdef ISE_GC
/*
doc:	<routine name="malloc_from_eiffel_list_no_gc" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Requests 'nbytes' from the free-list (Eiffel if possible), garbage collection turned off. This entry point is used by some garbage collector routines, so it is really important to turn the GC off. This routine being called from within the garbage collector, there is no need to make it a critical section with SIGBLOCK / SIGRESUME.</summary>
doc:		<param name="nbytes" type="rt_uint_ptr">Number of bytes to allocated, should be properly aligned an no greater than the maximum size we can allocate (i.e. 2^27 currently).</param>
doc:		<return>Upon success, it returns a pointer on a new free zone holding at least 'nbytes' free. Otherwise, a null pointer is returned.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE malloc_from_eiffel_list_no_gc (rt_uint_ptr nbytes)
{
	EIF_REFERENCE result;

	REQUIRE("nbytes properly padded", (nbytes % ALIGNMAX) == 0);
	REQUIRE("nbytes not too big (less than 2^27)", !(nbytes & ~B_SIZE));

		/* We try to find an empty spot in the free list. If not found, we
		 * will try `rt_malloc_free_list' which will either allocate more
		 * memory or coalesc some zone of the free list to create a bigger
		 * one that will be able to accommodate `nbytes'.
		 */
	result = rt_allocate_from_free_list (nbytes, &e_free_list);
	if (!result) {
		RT_GET_CONTEXT
		result = rt_malloc_free_list (nbytes, &e_free_list, EIFFEL_T, GC_OFF);

		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_LOCK);
			/* Increment allocated bytes outside scavenge zone. */
		eiffel_usage += nbytes;
			/* No more space found in free memory, we force a full collection next time
			 * we do a collect. */
		force_plsc++;
		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_UNLOCK);
	}

	ENSURE ("Allocated size big enough", !result || (nbytes <= (HEADER(result)->ov_size & B_SIZE)));
	return result;
}

/*
doc:	<routine name="malloc_from_eiffel_list" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Requests 'nbytes' from the free-list (Eiffel if possible), garbage collection turned on. If no more space is found in the free list, we will launch a GC cycle to make some room and then try again, if it fails we try one more time with garbage collection turned off.</summary>
doc:		<param name="nbytes" type="rt_uint_ptr">Number of bytes to allocated, should be properly aligned an no greater than the maximum size we can allocate (i.e. 2^27 currently).</param>
doc:		<return>Upon success, it returns a pointer on a new free zone holding at least 'nbytes' free. Otherwise, a null pointer is returned.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Use `eiffel_usage_mutex' to perform safe update to `eiffel_usage', otherwise rest is naturally thread safe.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE malloc_from_eiffel_list (rt_uint_ptr nbytes)
{
	EIF_REFERENCE result;

	REQUIRE("nbytes properly padded", (nbytes % ALIGNMAX) == 0);
	REQUIRE("nbytes not too big (less than 2^27)", !(nbytes & ~B_SIZE));

		/* Perform allocation in free list. If not successful, we try again
		 * by trying a GC cycle. */
	result = rt_allocate_from_free_list(nbytes, &e_free_list);

	if (!result) {
		if (trigger_gc_cycle()) {
			result = rt_allocate_from_free_list(nbytes, &e_free_list);
		}
		if (!result) {
				/* We try to put Eiffel blocks in Eiffel chunks
				 * If the free list cannot hold the block, switch to the C chunks list.
				 */
			result = rt_malloc_free_list(nbytes, &e_free_list, EIFFEL_T, GC_ON);
			if (!result) {
				result = rt_allocate_from_free_list (nbytes, &c_free_list);
				if (!result) {
					result = rt_malloc_free_list(nbytes, &c_free_list, C_T, GC_OFF);
				}
			}
		}
	}

	if (result) {
		RT_GET_CONTEXT
		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_LOCK);
		eiffel_usage += nbytes + OVERHEAD;	/* Memory used by Eiffel */
		GC_THREAD_PROTECT(EIFFEL_USAGE_MUTEX_UNLOCK);
	}

	ENSURE ("Allocated size big enough", !result || (nbytes <= (HEADER(result)->ov_size & B_SIZE)));
	return result;
}
#endif

/*
doc:	<routine name="eif_rt_xmalloc" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>This routine is the main entry point for free-list driven memory allocation. It allocates 'nbytes' of type 'type' (Eiffel or C) and will call the garbage collector if necessary, unless it is turned off. The function returns a pointer to the free location found, or a null pointer if there is no memory available.</summary>
doc:		<param name="nbytes" type="size_t">Number of bytes requested.</param>
doc:		<param name="type" type="int">Type of block (C_T or EIFFEL_T).</param>
doc:		<param name="gc_flag" type="int">Is GC on or off?</param>
doc:		<return>New block of memory if successful, otherwise a null pointer.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE eif_rt_xmalloc(size_t nbytes, int type, int gc_flag)
{
#ifdef ISE_GC
	size_t mod;			/* Remainder for padding */
	EIF_REFERENCE result;		/* Pointer to the free memory location we found */
	struct rt_free_list *first_free_list, *second_free_list;
	int second_type;
#ifdef EIF_ASSERTIONS
	size_t old_nbytes = nbytes;
#endif

	/* We really use at least ALIGNMAX, to avoid alignement problems.
	 * So even if nbytes is 0, some memory will be used (the header), he he !!
	 * The maximum size for nbytes is 2^27, because the upper 5 bits ot the
	 * size field are used to mark the blocks.
	 */
	mod = nbytes % ALIGNMAX;
	if (mod != 0)
		nbytes += ALIGNMAX - mod;

	if (nbytes & ~B_SIZE)
		return (EIF_REFERENCE) 0;		/* I guess we can't malloc more than 2^27 */

#ifdef DEBUG
	dprintf(1)("eif_rt_xmalloc: requesting %d bytes from %s list (GC %s)\n", nbytes,
		type == C_T ? "C" : "Eiffel", gc_flag == GC_ON ? "on" : "off");
	flush;
#endif

	/* We try to put Eiffel blocks in Eiffel chunks and C blocks in C chunks.
	 * That way, we do not spoil the Eiffel chunks for scavenging (C blocks
	 * cannot be moved). The Eiffel objects that are referenced from C must
	 * be moved to C chunks and become C blocks (so that the GC skips them).
	 * If the free list cannot hold the block, switch to the other list. Note
	 * that the GC flag makes sense only when allocating from a free list for
	 * the first time (it does make sense for the C list in case we had to
	 * allocate Eiffel blocks in the C list due to a "low on memory" condition).
	 */

	if (type == EIFFEL_T) {
		first_free_list = &e_free_list;
		second_free_list = &c_free_list;
		second_type = C_T;
	} else {
		first_free_list = &c_free_list;
		second_free_list = &e_free_list;
		second_type = EIFFEL_T;
	}

	result = rt_allocate_from_free_list (nbytes, first_free_list);
	if (!result) {
		if (gc_flag && (type == EIFFEL_T)) {
			if (trigger_gc_cycle()) {
				result = rt_allocate_from_free_list(nbytes, &e_free_list);
			}
		}
		if (!result) {
			result = rt_malloc_free_list (nbytes, first_free_list, type, gc_flag);
			if (result == (EIF_REFERENCE) 0 && gc_flag != GC_OFF) {
				result = rt_allocate_from_free_list (nbytes, second_free_list);
				if (!result) {
					result = rt_malloc_free_list(nbytes, second_free_list, second_type, GC_OFF);
				}
			}
		}
	}

	ENSURE ("Allocated size big enough", !result || (old_nbytes <= (HEADER(result)->ov_size & B_SIZE)));
	return result;	/* Pointer to free data space or null if out of memory */
#else
	return (EIF_REFERENCE) eif_malloc (nbytes);
#endif
}

#ifdef ISE_GC
/*
doc:	<routine name="rt_malloc_free_list" return_type="EIF_REFERENCE" export="private">
doc:		<summary>We tried to find a free block in free list before calling this routine but could not find any. Therefore here we will try to launch a GC cycle if permitted, or we will try to coalesc the memory so that bigger blocks of memory can be found in the free list.</summary>
doc:		<param name="nbytes" type="unsigned int">Number of bytes to allocated, should be properly aligned.</param>
doc:		<param name="a_free_list" type="struct rt_free_list *">List from which we try to find a free block or allocated a new block.</param>
doc:		<param name="type" type="int">Type of list (EIFFEL_T or C_T).</param>
doc:		<param name="gc_flag" type="int">Is GC on or off?</param>
doc:		<return>An aligned block of 'nbytes' bytes or null if no more memory is available.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE rt_malloc_free_list (size_t nbytes, struct rt_free_list *a_free_list, int type, int gc_flag)
{
	RT_GET_CONTEXT
	EIF_REFERENCE result;					/* Location of the malloc'ed block */
	unsigned int estimated_free_space;

	REQUIRE("Valid list", FREE_LIST_TYPE(a_free_list) == type);

	if (cc_for_speed) {
			/* They asked for speed (over memory, of course), so we first try
			 * to allocate by requesting some core from the kernel. If this fails,
			 * we try to do block coalescing before attempting a new allocation
			 * from the free list if the coalescing brought a big enough bloc.
			 */
		result = rt_allocate_from_core (nbytes, a_free_list, 0);	/* Ask for more core */
		if (result) {
			return result;				/* We got it */
		}
	}

		/* Call garbage collector if it is not turned off and restart our
		 * attempt from the beginning. We always call the partial scavenging
		 * collector to benefit from the memory compaction, if possible.
		 */
	if (gc_flag == GC_ON) {
#ifdef EIF_THREADS
		if ((gc_thread_status == EIF_THREAD_GC_RUNNING) || thread_can_launch_gc) {
			plsc();						/* Call garbage collector */
			return rt_malloc_free_list (nbytes, a_free_list, type, GC_OFF);
		}
#else
		plsc();						/* Call garbage collector */
		return rt_malloc_free_list (nbytes, a_free_list, type, GC_OFF);
#endif
	}

	/* Optimize: do not try to run a full coalescing if there is not
	 * enough free memory anyway. To give an estimation of the amount of
	 * free memory, we substract the amount used from the total allocated:
	 * in a perfect world, the amount of overhead would be zero... Anyway,
	 * the coalescing operation will reduce the overhead, so we must not
	 * deal with it or we may wrongly reject some situtations--RAM.
	 */

	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);
	if (type == C_T) {
		estimated_free_space = (unsigned int) (rt_c_data.ml_total - rt_c_data.ml_used);
	} else {
		estimated_free_space = (unsigned int) (rt_e_data.ml_total - rt_e_data.ml_used);
	}

	if ((nbytes <= estimated_free_space) && (nbytes < (unsigned int) full_coalesc_unsafe (type))) {
#ifdef EIF_ASSERTIONS
		EIF_REFERENCE l_result;
		GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
		l_result = rt_allocate_from_free_list (nbytes, a_free_list);
		CHECK ("allocated from free list", l_result);
		return l_result;
#else
		GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
		return rt_allocate_from_free_list (nbytes, a_free_list);
#endif
	} else {
		GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
			/* No other choice but to request for more core */
		return rt_allocate_from_core (nbytes, a_free_list, 0);
	}
}

/*
doc:	<routine name="rt_list_remove_head" return_type="union overhead *" export="private">
doc:		<summary>Given a list retrieve the first entry in the list, remove it and update the list.</summary>
doc:		<param name="a_list" type="union overhead **">Pointer to a list on which removal will occurs.</param>
doc:		<param name="a_is_zero_sized" type="int">Is the list for 0-sized blocks which don't have space for a back pointers?</param>
doc:		<return>Return the first block if any, otherwise a null pointer.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'</synchronization>
doc:	</routine>
*/
rt_private union overhead *rt_list_remove_head (union overhead **a_list, int a_is_zero_sized)
{
	union overhead *result, *n;

	REQUIRE("a_list not null", a_list);
	REQUIRE("valid size", !*a_list || !a_is_zero_sized || ((*a_list)->ov_size & B_SIZE) == 0);

	result = *a_list;
	if (result) {
			/* Retrieve the next element after `result'. */
		n = NEXT(result);
			/* Update head of list to point to the next element `n'. */
		*a_list = n;
			/* If there was a next element `n', we need to update its previous
			 * pointer, but only if it is possible. */
		if (n && !a_is_zero_sized) {
			PREVIOUS(n) = NULL;
		}
	}
	return result;
}

/*
doc:	<routine name="rt_tree_remove" return_type="union overhead *" export="private">
doc:		<summary>Given a tree `a_tree' and a node `a_node', remove a block from the list of available blocks associated with `a_node'. If `a_node' is the only block, remove it from the tree.</summary>
doc:		<param name="a_tree" type="rt_tree *">Tree where `a_node' belongs to. It is required in case tree is rebalanced if `a_node' is actually removed.</param>
doc:		<param name="a_node" type="rt_tree *">Node of `a_tree' where we are going to remove a block of size `a_node->nbytes'.</param>
doc:		<return>If `a_node' has only one element in the list, remove `a_node' from `a_tree' and returns `&a_node->current'. Otherwise, returns the next element of the list whose head is `a_node->current' and update the list properly.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'</synchronization>
doc:	</routine>
*/
rt_private union overhead *rt_tree_remove (rt_tree **a_tree, rt_tree *a_node)
{
	union overhead *l_head, *l_result, *l_next;
#ifdef EIF_ASSERTIONS
	size_t l_nbytes = a_node->nbytes;
#endif

	REQUIRE("Tree pointer not null", a_tree);
	REQUIRE("Has tree", *a_tree);
	REQUIRE("Node not null", a_node);

	l_head = &a_node->current;
	l_result = NEXT(l_head);
	if (l_result) {
			/* Perform LIFO removal of `l_result', no change to the tree. */
		l_next = NEXT(l_result);
		NEXT(l_head) = l_next;
		if (l_next) {
			PREVIOUS(l_next) = l_head;
			CHECK ("Same offset", l_head == (union overhead *) a_node);
		}
	} else {
			/* The node of the tree is the only block of the requested size.
			 * so we have to remove that node from the tree. */
		l_result = l_head;
		CHECK ("Same offset", l_head == (union overhead *) a_node);
		sglib_rt_tree_delete (a_tree, a_node);
	}

	ENSURE("Result not null", l_result);
	ENSURE("Result consistent", l_nbytes == (l_result->ov_size & B_SIZE));
	return l_result;
}

/*
doc:	<routine name="rt_tree_find_and_remove" return_type="union overhead *" export="private">
doc:		<summary>Given a tree, search for a block of an exact size `nbytes' or the smallest block larger than `nbytes'.</summary>
doc:		<param name="a_tree" type="rt_tree *">Tree where we are going to look for a block of the proper size.</param>
doc:		<param name="nbytes" type="size_t">Size of the block we are looking for.</param>
doc:		<return>Return the first block if any, otherwise a null pointer.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'</synchronization>
doc:	</routine>
*/
rt_private union overhead *rt_tree_find_and_remove (rt_tree **a_tree, size_t nbytes)
{
	union overhead *result;
	rt_tree *l_parent_node = *a_tree;

	REQUIRE("tree not null", a_tree);

	if (l_parent_node) {
		if (l_parent_node->nbytes == nbytes) {
				/* Lucky, the root of the tree is our block. */
			result = rt_tree_remove(a_tree, l_parent_node);
		} else {
			rt_tree *l_tree_node = l_parent_node;
			result = NULL;
				/* Perform a search for a block of `nbytes'. We always keep the parent
				 * node as this will be used in the event where we cannot find an exact match,
				 * as the parent node is the smallest block larger than `nbytes'. */
			while (!result && l_tree_node) {
				if (l_tree_node->nbytes == nbytes) {
						/* We found our match. */
					result = rt_tree_remove(a_tree, l_tree_node);
				} else if (l_tree_node->nbytes > nbytes) {
						/* We keep `l_parent_node' as our best fit node. */
					l_parent_node = l_tree_node;
					l_tree_node = l_tree_node->left;
				} else {
						/* Current node was too small, we continue on right. */
					l_tree_node = l_tree_node->right;
				}
			}
				/* We could not find a free block of the exact requested size `nbytes'.
				 * Let's find out if the last node we traversed was big enough to hold `nbytes' (we
				 * have to perform the check in the event we never went on a left branch during the loop.) */
			if (!result && l_parent_node->nbytes >= nbytes) {
				result = rt_tree_remove(a_tree, l_parent_node);
			}
		}
	} else {
		result = NULL;
	}

	ENSURE("Big enough if found", !result || ((result->ov_size & B_SIZE) >= nbytes));
	return result;
}

/*
doc:	<routine name="rt_allocate_from_free_list" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Given a correctly padded size 'nbytes', we try to find a free block from the free list `a_free_list'.</summary>
doc:		<param name="nbytes" type="size_t">Number of bytes requested.</param>
doc:		<param name="a_free_list" type="void **">List from which we try to find a free block.</param>
doc:		<return>Return the address of the (splited) block if found, a null pointer otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'</synchronization>
doc:	</routine>
*/
rt_private EIF_REFERENCE rt_allocate_from_free_list(size_t nbytes, struct rt_free_list *a_free_list)
{
	RT_GET_CONTEXT
	size_t i;
	union overhead *selected;
	EIF_REFERENCE result = NULL;

	REQUIRE("Aligned size", (nbytes % ALIGNMAX) == 0);

		/* Quickly compute the index in the free list array where we have a
		 * chance to find the right block. */
	i = rt_compute_free_list_index(nbytes);

		/* Enter critical section here. */
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);
#ifdef EIF_EXPENSIVE_ASSERTIONS
	rt_check_free_list (nbytes, a_free_list);
#endif

	if (i < FREE_LIST_INDEX_LIMIT) {
			/* We are below the limit `FREE_LIST_INDEX_LIMIT', therefore if the entry of
			 * `a_free_list' at index `i' is not NULL, then it means that we have `nbytes'
			 * available. No need to check the size here. If block is null, then we
			 * go through all other entries to find the first one available. */
		selected = rt_list_remove_head(&a_free_list->lists[i], i == 0);
		while (!selected && (i < FREE_LIST_INDEX_LIMIT)) {
			i++;
			if (i < FREE_LIST_INDEX_LIMIT) {
				selected = rt_list_remove_head(&a_free_list->lists[i], 0);
			} else {
					/* Search the tree for the smallest block that could hold `nbytes'. */
				selected = rt_tree_find_and_remove(&a_free_list->tree, nbytes);
			}
		}
	} else {
			/* Search the tree for the smallest block that could hold `nbytes'. */
		selected = rt_tree_find_and_remove(&a_free_list->tree, nbytes);
	}

	if (selected) {
		if ((selected->ov_size & B_SIZE) == nbytes + ALIGNMAX) {
			/* In the likely event where `set_up' would need to split the block with a remaining
			 * 0-sized block, we fool `set_up' by increasing `nbytes' so that no split occurs.
			 */
			nbytes += ALIGNMAX;
			CHECK("Correct size", nbytes == (selected->ov_size & B_SIZE));
		}

			/* Block is ready to be set up for use of 'nbytes' (eventually after
			 * having been split). Memory accounting is done in set_up(). */
		result = set_up(selected, nbytes);
	} else {
		result = NULL;
	}

		/* Leave critical section. */
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
	return result;
}

#ifdef EIF_EXPENSIVE_ASSERTIONS
/*
doc:	<routine name="rt_check_list" return_type="void" export="private">
doc:		<summary>Verify that the list whose head is `a_list' contains only blocks of size `element_size'. Updates `found' with the number of blocks of `a_list' can fit a block of size `requested_size' and the amount of free memory in `bytes_available'.</summary>
doc:		<param name="requested_nbytes" type="size_t">Number of bytes requested to be found.</param>
doc:		<param name="element_size" type="size_t">Size of the elements of `a_list'.</param>
doc:		<param name="a_list" type="union overhead *">List where check will take place.</param>
doc:		<param name="found" type="int *">Variable that will be increased by the number of blocks that will fit `requested_nbytes'.</param>
doc:		<param name="bytes_available" type="size_t *">Variable that will be increased by the number of free memory available in `a_list'.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/
rt_private void rt_check_list (size_t requested_nbytes, size_t element_size, union overhead *a_list, int *found, size_t *bytes_available)
{
	union overhead *p, *selected = a_list;
	size_t count = 0;
	size_t list_bytes = 0;
	for (
		p = selected;
		selected != NULL;
		p = selected, selected = NEXT(p)
	) {
		CHECK("valid_previous", (requested_nbytes == 0) || ((p == selected) || (element_size == 0) || (p == PREVIOUS(selected))));
		CHECK("Valid size", (selected->ov_size & B_SIZE) == element_size);

		if ((selected->ov_size & B_SIZE) >= requested_nbytes) {
			(*found)++;
		}
		list_bytes += selected->ov_size & B_SIZE;
		count++;
	}
#ifdef DEBUG
	fprintf(stderr, "free_list [%d] has %d elements and %d free bytes.\n", j, count, list_bytes);
#endif
	*bytes_available += list_bytes;
}

/*
doc:	<routine name="rt_check_free_list" return_type="void" export="private">
doc:		<summary>Perform a sanity check of the free list to ensure that content of the X_data accounting match the actual content of the free list.</summary>
doc:		<param name="requested_nbytes" type="size_t">Number of bytes requested to be found.</param>
doc:		<param name="a_free_list" type="struct rt_free_list *">Free list where search will take place.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/
rt_private void rt_check_free_list (size_t requested_nbytes, struct rt_free_list *a_free_list)
{
	union overhead *selected;	/* The selected block */
	size_t bytes_available = 0;
	int j, found = 0;
	rt_tree *l_tree, *l_node;
	struct sglib_rt_tree_iterator l_iterator;

		/* Traverse our lists. */
	for (j = 0; j < FREE_LIST_INDEX_LIMIT; j++) {
		selected = a_free_list->lists [j];
		if (selected) {
			rt_check_list (requested_nbytes, j * ALIGNMAX, selected, &found, &bytes_available);
		} else {
				/* Free list empty. */
		}
	}
		/* Traverse our tree. */
	l_tree = a_free_list->tree;
	if (l_tree) {
		for (l_node = sglib_rt_tree_it_init_inorder(&l_iterator, l_tree); l_node != NULL; l_node = sglib_rt_tree_it_next(&l_iterator)) {
			selected = &l_node->current;
			rt_check_list(requested_nbytes, l_node->nbytes, selected, &found, &bytes_available);
		}
	}

	if (FREE_LIST_TYPE(a_free_list) == EIFFEL_T) {
		CHECK("Consistent", bytes_available == (rt_e_data.ml_total - rt_e_data.ml_over - rt_e_data.ml_used));
	} else {
		CHECK("Consistent", bytes_available == (rt_c_data.ml_total - rt_c_data.ml_over - rt_c_data.ml_used));
	}

#ifdef DEBUG
	if (found) {
		fprintf(stderr, "We found a possible %d block(s) of size greater than %d bytes.\n", found, requested_nbytes);
	}
	fprintf(stderr, "Total available bytes is %d\n", bytes_available);
	if (FREE_LIST_TYPE(a_free_list) == EIFFEL_T) {
		fprintf(stderr, "Eiffel free list has %d bytes allocated, %d used and %d free.\n",
			rt_e_data.ml_total, rt_e_data.ml_used, rt_e_data.ml_total - rt_e_data.ml_used - rt_e_data.ml_over);
	} else {
		fprintf(stderr, "C free list has %d bytes allocated, %d used and %d free.\n",
			rt_c_data.ml_total, rt_c_data.ml_used, rt_c_data.ml_total - rt_c_data.ml_used - rt_c_data.ml_over);
	}
	flush;
#endif
}
#endif

/*
doc:	<routine name="get_to_from_core" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>For the partial scavenging algorithm, gets a new free chunk for the to_space. The chunk size is `eif_chunk_size', it is not relevant how big is the `from_space' as the partial scavenging handle the case where the `to_space' is smaller than the `from_space'.</summary>
doc:		<return>New block if successful, otherwise a null pointer.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Call to `rt_allocate_from_core' is safe.</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE get_to_from_core (void)
{
	EIF_REFERENCE Result;

		/* We substract OVERHEAD and the size of a chunk, because in `rt_allocate_from_core' which
		 * calls `add_core' we will add `OVERHEAD' and the size of a chunk to make sure we have indeed
		 * the number of bytes allocated.
		 */
	Result = rt_allocate_from_core (eif_chunk_size - OVERHEAD - sizeof(struct chunk), &e_free_list, 1);

	ENSURE("block is indeed of the right size", !Result || ((eif_chunk_size - OVERHEAD) == (HEADER(Result)->ov_size & B_SIZE)));

	return Result;
}

/*
doc:	<routine name="rt_allocate_from_core" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Given a correctly padded size 'nbytes', we ask for some core to be able to make a chunk capable of holding 'nbytes'. The chunk will be placed in the specified free list `a_free_list'.</summary>
doc:		<param name="nbytes" type="size_t">Number of bytes requested.</param>
doc:		<param name="a_free_list" type="struct rt_free_list *">List in which we try to allocated a free block.</param>
doc:		<param name="maximize" type="int">Even though we asked for `nbytes' should we perform the split in case more than `nbytes' were allocated? `0' means yes, '1' means no.</param>
doc:		<return>Address of new block, or null if no more core is available.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE rt_allocate_from_core(size_t nbytes, struct rt_free_list *a_free_list, int maximize)
{
	RT_GET_CONTEXT
	union overhead *selected;		/* The selected block */
	struct chunk *chkbase;		/* Base address of new chunk */
	EIF_REFERENCE result;
	int type = FREE_LIST_TYPE(a_free_list);

#ifdef DEBUG
	dprintf(4)("rt_allocate_from_core: requesting %d bytes from %s list\n", nbytes, (type == C_T) ? "C" : "Eiffel");
	flush;
#endif

	SIGBLOCK;			/* Critical section */
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);

	selected = add_core(nbytes, type);	/* Ask for more core */
	if (!selected) {
		GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
		SIGRESUME;			/* End of critical section */
		return (EIF_REFERENCE) 0;				/* Could not obtain enough memory */
	}

	/* Add_core() returns a pointer of the info zone of the sole block
	 * currently in the new born chunk. We have to set the "type" of the
	 * chunk correctly, along with the type of the block held in it (so that
	 * a free can put the block back into the right eif_free list. Note that an
	 * Eiffel object may well be in a C chunk.
	 */
	chkbase = ((struct chunk *) selected) - 1;	/* Chunk info zone */

	/* Hang on. The following should avoid some useless swapping when
	 * walking through a well defined type of chunk list--RAM.
	 * All the chunks are added to the list at the end of it, so the
	 * addresses are always increasing when walking through the list. This
	 * property is used by the garbage collector, for efficiency reasons
	 * that are too long to be explained here--RAM.
	 */

	if (C_T == type) {
		/* C block chunck */
		if (cklst.cck_head == (struct chunk *) 0) {	/* No C chunk yet */
			cklst.cck_head = chkbase;				/* First C chunk */
			chkbase->ck_lprev = (struct chunk *) 0;	/* First item in list */
		} else {
			cklst.cck_tail->ck_lnext = chkbase;		/* Added at the tail */
			chkbase->ck_lprev = cklst.cck_tail;		/* Previous item */
		}
		cklst.cck_tail = chkbase;					/* New tail */
		chkbase->ck_lnext = (struct chunk *) 0;		/* Last block in list */
		chkbase->ck_type = C_T;						/* Dedicated to C */
		selected->ov_size |= B_CTYPE;				/* Belongs to C free list */
	} else {
		/* Eiffel block chunck */
		if (cklst.eck_head == (struct chunk *) 0) {	/* No Eiffel chunk yet */
			cklst.eck_head = chkbase;				/* First Eiffel chunk */
			chkbase->ck_lprev = (struct chunk *) 0;	/* First item in list */
		} else {
			cklst.eck_tail->ck_lnext = chkbase;		/* Added at the tail */
			chkbase->ck_lprev = cklst.eck_tail;		/* Previous item */
		}
		cklst.eck_tail = chkbase;					/* New tail */
		chkbase->ck_lnext = (struct chunk *) 0;		/* Last block in list */
		chkbase->ck_type = EIFFEL_T;				/* Dedicated to Eiffel */
	}

	SIGRESUME;			/* End of critical section */

#ifdef DEBUG
	dprintf(4)("rt_allocate_from_core: %d user bytes chunk added to %s list\n", chkbase->ck_length, (type == C_T) ? "C" : "Eiffel");
	flush;
#endif

	if (maximize == 1) {
			/* Because we do not want to split the block, we now say
			 * that what we really asked for was the size of the block
			 * returned by `add_core'. This is still necessary to call
			 * `set_up' for the memory accounting. */
		nbytes = selected->ov_size & B_SIZE;
	}

		/* Block is ready to be set up for use of 'nbytes' (eventually after
		 * having been split). Memory accounting is done in set_up().
		 */
	result = set_up(selected, nbytes);

	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
	return result;
}

/*
doc:	<routine name="add_core" return_type="union overhead *" export="private">
doc:		<summary>Get more core from kernel, increasing the data segment of the process by calling mmap() or sbrk() or. We try to request at least CHUNK bytes to allow for efficient scavenging. If more than that amount is requested, the value is padded to the nearest multiple of the system page size. If less than that amount are requested but the system call fails, successive attempts are made, decreasing each time by one system page size. A pointer to a new chunk suitable for at least 'nbytes' bytes is returned, or a null pointer if no more memory is available. The chunk is linked in the main list, but left out of any free list.</summary>
doc:		<param name="nbytes" type="size_t">Number of bytes requested.</param>
doc:		<param name="type" type="int">Type of block to allocated (EIFFEL_T or C_T).</param>
doc:		<return>Address of new block of `nbytes' bytes, or null if no more core is available.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private union overhead *add_core(size_t nbytes, int type)
{
	union overhead *oldbrk; /* Initialized with `failed' value. */
	size_t mod;					/* Remainder for padding */
	size_t asked = nbytes;	/* Bytes requested */

		/* We want at least 'nbytes' bytes for use, so we must add the overhead
		 * for each block and for each chunk. */
	asked += sizeof(struct chunk) + OVERHEAD;

		/* Requesting less than CHUNK implies requesting CHUNK bytes, at least.
		 * Requesting more implies at least CHUNK plus the needed number of
		 * extra pages necessary (tiny fit).
		 */
	if (asked <= eif_chunk_size) {
		asked = eif_chunk_size;
		CHECK("Multiple of ALIGNMAX", (asked % ALIGNMAX) == 0);
	} else {
		asked = eif_chunk_size + (((asked - eif_chunk_size) / PAGESIZE_VALUE) + 1) * PAGESIZE_VALUE;
			/* Make sure that `asked' is a multiple of ALIGNMAX. */
		mod = asked % ALIGNMAX;
		if (mod != 0) {
			asked += ALIGNMAX - mod;
		}
	}

		/* Size of chunk has to be added, otherwise the remaining space
		 * might not be a multiple of ALIGNMAX. */
	asked += sizeof(struct chunk);

		/* We check that we are not asking for more than the limit
		 * the user has fixed:
		 * - eif_max_mem (total allocated memory)
		 * If the value of eif_max_mem is 0, there is no limit.
		 */
	if (eif_max_mem > 0) {
		if (rt_m_data.ml_total + asked > eif_max_mem) {
			return (union overhead *) 0;
		}
	}
	oldbrk = (union overhead *) eif_malloc (asked); /* Use malloc () */
	if (!oldbrk) {
		return NULL;
	}

		/* Accounting informations */
	rt_m_data.ml_chunk++;
	rt_m_data.ml_total += asked;				/* Counts overhead */
	rt_m_data.ml_over += sizeof(struct chunk) + OVERHEAD;

		/* Accounting is also done for each type of memory (C/Eiffel) */
	if (type == EIFFEL_T) {
		rt_e_data.ml_chunk++;
		rt_e_data.ml_total += asked;
		rt_e_data.ml_over += sizeof(struct chunk) + OVERHEAD;
	} else {
		rt_c_data.ml_chunk++;
		rt_c_data.ml_total += asked;
		rt_c_data.ml_over += sizeof(struct chunk) + OVERHEAD;
	}

		/* We got the memory we wanted. Make a chunk out of it, build one
		 * big block inside and return the pointer to that block. This is
		 * a somewhat costly operation, but it is note done very often.
		 */
	asked -= sizeof(struct chunk) + OVERHEAD;	/* Was previously increased */

		/* Update all the pointers for the double linked list. This
		 * is somewhat heavy code, hard to read because of all these
		 * casts, but believe me, it is simple--RAM.
		 */

#define chkstart	((struct chunk *) oldbrk)

	if (cklst.ck_head == (struct chunk *) 0) {	/* No chunk yet */
		cklst.ck_head = chkstart;				/* First chunk */
		chkstart->ck_prev = (struct chunk *) 0;	/* First item in list */
	} else {
		cklst.ck_tail->ck_next = chkstart;		/* Added at the tail */
		chkstart->ck_prev = cklst.ck_tail;		/* Previous item */
	}

	cklst.ck_tail = chkstart;					/* New tail */
	chkstart->ck_next = (struct chunk *) 0;		/* Last block in list */
	chkstart->ck_length = asked + OVERHEAD;		/* Size of chunk */

	/* Address of new block (skip chunck overhead) */
	oldbrk = (union overhead *) (chkstart + 1);

#undef chkstart

		/* Set the size of the new block. Note that this new block
		 * is the first and the last one in the chunk, so we set the
		 * B_LAST bit. All the other flags are set to false.
		 */
	CHECK("asked not too big", asked <= B_SIZE);
	oldbrk->ov_size = asked | B_LAST;

	return oldbrk;			/* Pointer to new free zone */
}

/*
doc:	<routine name="rel_core" export="shared">
doc:		<summary>Release core if possible, giving pages back to the kernel. This will shrink the size of the process accordingly. To release memory, we need at least two free chunks at the end (i.e. near the break), and of course, a chunk not reserved for next partial scavenging as a 'to' zone.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_shared void rel_core(void)
{
	struct chunk *c, *cn;

	for (c = cklst.ck_head; c; c = cn) {
			/* Store next chunk before trying to free `c' as otherwise the
			 * access `c->ck_next' would result in a segfault. */
		cn = c->ck_next;
		free_chunk (c);
	}
}

/*
doc:	<routine name="free_chunk" export="private">
doc:		<summary>If `a_chk' is not used, then it gets removed from `cklst' and given back to the system.</summary>
doc:		<param name="a_chk" type="struct chunk *">Chunk being analyzed for potential removal from `cklst' and returned to system.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private void free_chunk(struct chunk *a_chk)
{
	RT_GET_CONTEXT
	size_t nbytes;				/* Number of bytes to be freed */
	union overhead *arena;	/* The address of the arena enclosed in chunk */
	rt_uint_ptr r;				/* To compute hashing index for released block */

	REQUIRE("a_chk not null", a_chk);

		/* Ok, let's see if this chunk is free. If it holds a free last block,
		 * that's fine. Otherwise, we run a coalescing on the chunk and check again.
		 * If we do not succeed either, then abort the procedure.
		 */
	arena = (union overhead *) ((EIF_REFERENCE) (a_chk + 1));
	if (arena->ov_size & B_BUSY) {
			/* Block is busy, we can forget about freeing this chunk, but
			 * we still try to coalesc the free memory as much as we can
			 * as it speeds up allocation later on. */
		r = chunk_coalesc (a_chk);
		return;
	} else if (!(arena->ov_size & B_LAST)) {
			/* Block is not busy, but it is not the last one of the chunk. We try
			 * to coalesce it and check if it is now the last one. Of course
			 * no need to do the check if we did not coalesce. */
		r = chunk_coalesc (a_chk);		/* Try to coalesc `a_chk'. */
		if ((r == 0) || !(arena->ov_size & B_LAST)) {
				/* Chunk is not free. */
			return;
		}
	}

	CHECK("arena free and last", (arena->ov_size & B_LAST) && !(arena->ov_size & B_BUSY));

	SIGBLOCK;			/* Entering in critical section */

	r = arena->ov_size & B_SIZE;
	rt_disconnect_free_list(arena);		/* Remove arena from free list */

		/* The garbage collectors counts the amount of allocated 'to' zones. A limit
		 * is fixed to avoid a nasty memory leak when all the zones used would be
		 * spoilt by frozen objects. However, each time we successfully decrease
		 * the process size by releasing some core, we may allow a new allocation.
		 */
	if (rt_g_data.gc_to > 0) {
		rt_g_data.gc_to--;					/* Decrease number of allocated 'to' */
	}

		/* Amount of bytes is chunk's length plus the header overhead */
	nbytes = a_chk->ck_length + sizeof(struct chunk);

		/* It's now time to update the internal data structure which keep track of
		 * the memory status. */
	rt_m_data.ml_chunk--;
	rt_m_data.ml_total -= nbytes;			/* Counts overhead */
	rt_m_data.ml_over -= sizeof(struct chunk) + OVERHEAD;
		/* Update list. */
	if (a_chk == cklst.ck_head) {
		cklst.ck_head = a_chk->ck_next;
		if (a_chk->ck_next) {
			a_chk->ck_next->ck_prev = NULL;
		}
	} else if (a_chk == cklst.ck_tail) {
		cklst.ck_tail = a_chk->ck_prev;
		CHECK("Has previous chunk", a_chk->ck_prev);
		a_chk->ck_prev->ck_next = NULL;
	} else {
		a_chk->ck_prev->ck_next = a_chk->ck_next;
		a_chk->ck_next->ck_prev = a_chk->ck_prev;
	}
		/* Update cursor. Cursors are moved to the right.*/
	if (a_chk == cklst.cursor) {
		cklst.cursor = a_chk->ck_next;
	}

		/* Now do the same but for the Eiffel list and the C list. */
	if (a_chk->ck_type == EIFFEL_T) {	/* Chunk was an Eiffel one */
		rt_e_data.ml_chunk--;
		rt_e_data.ml_total -= nbytes;
		rt_e_data.ml_over -= sizeof(struct chunk) + OVERHEAD;
		if (a_chk == cklst.eck_head) {
			cklst.eck_head = a_chk->ck_lnext;
			if (a_chk->ck_lnext) {
				a_chk->ck_lnext->ck_lprev = NULL;
			}
		} else if (a_chk == cklst.eck_tail) {
			cklst.eck_tail = a_chk->ck_lprev;
			CHECK("Has previous chunk", a_chk->ck_lprev);
			a_chk->ck_lprev->ck_lnext = NULL;
		} else {
			a_chk->ck_lprev->ck_lnext = a_chk->ck_lnext;
			a_chk->ck_lnext->ck_lprev = a_chk->ck_lprev;
		}
		if (a_chk == cklst.e_cursor) {
			cklst.e_cursor = a_chk->ck_lnext;
		}
	} else {							/* Chunk was a C one */
		rt_c_data.ml_chunk--;
		rt_c_data.ml_total -= nbytes;
		rt_c_data.ml_over -= sizeof(struct chunk) + OVERHEAD;
		if (a_chk == cklst.cck_head) {
			cklst.cck_head = a_chk->ck_lnext;
			if (a_chk->ck_lnext) {
				a_chk->ck_lnext->ck_lprev = NULL;
			}
		} else if (a_chk == cklst.cck_tail) {
			cklst.cck_tail = a_chk->ck_lprev;
			CHECK("Has previous chunk", a_chk->ck_lprev);
			a_chk->ck_lprev->ck_lnext = NULL;
		} else {
			a_chk->ck_lprev->ck_lnext = a_chk->ck_lnext;
			a_chk->ck_lnext->ck_lprev = a_chk->ck_lprev;
		}
		if (a_chk == cklst.c_cursor) {
			cklst.e_cursor = a_chk->ck_lnext;
		}
	}

		/* We can free our block now. */
	eif_free (a_chk);

	SIGRESUME;							/* Critical section ends */

	return;			/* Signals no error */
}

/*
doc:	<routine name="set_up" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Given a 'selected' block which may be too big to hold 'nbytes', we set it up to, updating memory accounting infos and setting the correct flags in the malloc info zone (header). We then return the address the user will know (points to the first datum byte).</summary>
doc:		<param name="selected" type="union overhead *">Block of memory which is too big to hold `nbytes'.</param>
doc:		<param name="nbytes" type="size_t">Size in bytes of block we should return.</param>
doc:		<return>Address of location of object of size `nbytes' in `selected'.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller is synchronized on `eif_free_list_mutex', or under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE set_up(register union overhead *selected, size_t nbytes)
{
	RT_GET_CONTEXT
	rt_uint_ptr r;		/* For temporary storage */
	rt_uint_ptr i;		/* To store true size */

#ifdef DEBUG
	dprintf(8)("set_up: selected is 0x%lx (%s, %d bytes)\n",
		selected, selected->ov_size & B_LAST ? "last" : "normal",
		selected->ov_size & B_SIZE);
	flush;
#endif

	SIGBLOCK;				/* Critical section, cannot be interrupted */

	(void) eif_rt_split_block(selected, nbytes);	/* Eventually split the area */

	/* The 'selected' block is now in use and the real size is in
	 * the ov_size area. To mark the block as used, we have to set
	 * two bits in the flags part (block is busy and it is a C block).
	 * Another part of the run-time will overwrite this if Eiffel is
	 * to ever use this object.
	 */

	r = selected->ov_size;
#ifdef EIF_TID
#ifdef EIF_THREADS
	selected->ovs_tid = (rt_uint_ptr) eif_thr_context->thread_id; /* tid from eif_thr_context */
#else
	selected->ovs_tid = (rt_uint_ptr) 0; /* In non-MT-mode, it is NULL by convention */
#endif /* EIF_THREADS */
#endif /* EIF_TID */

	selected->ov_size = r | B_NEW;
	i = r & B_SIZE;						/* Keep only true size */
	rt_m_data.ml_used += i;				/* Account for memory used */
	if (r & B_CTYPE) {
		rt_c_data.ml_used += i;
	} else {
		rt_e_data.ml_used += i;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (+%ld) %ld total (set_up)\n",
			rt_e_data.ml_used, i, rt_e_data.ml_total);
#endif
	}

	SIGRESUME;				/* Re-enable signal exceptions */

	/* Now it's done. We return the address of data space, that
	 * is to say (selected + 1) -- yes ! The area holds at least
	 * 'nbytes' (entrance value) of free space.
	 */

#ifdef DEBUG
	dprintf(8)("set_up: returning %s %s block starting at 0x%lx (%d bytes)\n",
		(selected->ov_size & B_CTYPE) ? "C" : "Eiffel",
		(selected->ov_size & B_LAST) ? "last" : "normal",
		(EIF_REFERENCE) (selected + 1), selected->ov_size & B_SIZE);
	flush;
#endif

	return (EIF_REFERENCE) (selected + 1);		/* Free data space */
}

#endif /* ISE_GC */

/*
doc:	<routine name="eif_rt_xfree" export="public">
doc:		<summary>Frees the memory block which starts at 'ptr'. This has to be a pointer returned by eif_rt_xmalloc, otherwise impredictable results will follow... The contents of the block are preserved, though one should not rely on this as it may change without notice.</summary>
doc:		<param name="ptr" type="void *">Address of memory to be freed.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</routine>
*/

rt_public void eif_rt_xfree(register void * ptr)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	rt_uint_ptr r;					/* For shifting purposes */
	union overhead *zone;		/* The to-be-freed zone */
	rt_uint_ptr nbytes;

	REQUIRE("ptr not null", ptr);
	REQUIRE("ptr aligned", ((rt_uint_ptr)ptr) % MEM_ALIGNBYTES == 0);

#ifdef LMALLOC_CHECK
	if (is_in_lm (ptr))
		fprintf (stderr, "Warning: try to eif_rt_xfree a malloc'ed ptr\n");
#endif	/* LMALLOC_CHECK */
	zone = ((union overhead *) ptr) - 1;	/* Walk backward to header */
	r = zone->ov_size;						/* Size of block */

	/* If the bloc is in the generation scavenge zone, nothing has to be done.
	 * This is easy to detect because objects in the scavenge zone have the
	 * B_BUSY bit reset. Testing for that bit will also enable the routine
	 * to return immediately if the address of a free block is given.
	 */
	if (!(r & B_BUSY))
		return;				/* Nothing to be done */

	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);

	/* Memory accounting */
	nbytes = r & B_SIZE;				/* Amount of memory released */
	rt_m_data.ml_used -= nbytes;		/* At least this is free */
	if (r & B_CTYPE) {
		rt_c_data.ml_used -= nbytes;
	} else {
		rt_e_data.ml_used -= nbytes;
#ifdef MEM_STAT
	printf ("Eiffel: %ld used (-%ld), %ld total (eif_rt_xfree)\n",
		rt_e_data.ml_used, nbytes, rt_e_data.ml_total);
#endif
	}

#ifdef DEBUG
	dprintf(1)("eif_rt_xfree: on a %s %s block starting at 0x%lx (%d bytes)\n",
		(zone->ov_size & B_LAST) ? "last" : "normal",
		(zone->ov_size & B_CTYPE) ? "C" : "Eiffel",
		ptr, zone->ov_size & B_SIZE);
	flush;
#endif

	/* Now put back in the free list a memory block starting at `zone', of
	 * size 'r' bytes.
	 */
	xfreeblock(zone, r);

	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);

#ifdef DEBUG
	dprintf(8)("eif_rt_xfree: %s %s block starting at 0x%lx holds %d bytes free\n",
		(zone->ov_size & B_LAST) ? "last" : "normal",
		(zone->ov_size & B_CTYPE) ? "C" : "Eiffel",
		ptr, zone->ov_size & B_SIZE);
#endif
#else
	eif_free(ptr);
#endif
}

/*
doc:	<routine name="eif_rt_xcalloc" export="shared">
doc:		<summary>Allocate space for 'nelem' elements of 'elsize' bytes and set the new space with zeros. This is NEVER used by the Eiffel run time but it is provided to keep the C interface with the standard malloc package.</summary>
doc:		<param name="nelem" type="size_t">Number of elements to allocate.</param>
doc:		<param name="elsize" type="size_t">Size of element.</param>
doc:		<return>New block of memory of size nelem * elsize if successful, otherwise null pointer.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Handled by `eif_rt_xmalloc'.</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE eif_rt_xcalloc(size_t nelem, size_t elsize)
{
#ifdef ISE_GC
	size_t nbytes;	/* Number of bytes requested */
	EIF_REFERENCE allocated;		/* Address of new arena */

	nbytes = nelem * elsize;
	allocated = eif_rt_xmalloc(nbytes, C_T, GC_ON);	/* Ask for C space */

	if (allocated != (EIF_REFERENCE) 0) {
		memset (allocated, 0, nbytes);		/* Fill arena with zeros */
	}

	return allocated;		/* Pointer to new zero-filled zone */
#else
	return (EIF_REFERENCE) eif_calloc(nelem, elsize);
#endif
}

#ifdef ISE_GC
/*
doc:	<routine name="xfreeblock" export="private">
doc:		<summary>Put the memory block starting at 'zone' into the free_list. Note that zone points at the beginning of the memory block (beginning of the header) and not at an object data area.</summary>
doc:		<param name="zone" type="union overhead *">Zone to be freed.</param>
doc:		<param name="r" type="rt_uint_ptr">Size of block.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private void xfreeblock(union overhead *zone, rt_uint_ptr r)
{
	RT_GET_CONTEXT
	rt_uint_ptr flags;
#ifndef EIF_MALLOC_OPTIMIZATION
	rt_uint_ptr size;				/* Size of the coalesced block */
#endif

	SIGBLOCK;					/* Critical section starts */

	/* The block will be inserted in the sorted hashed free list.
	 * The current size is fetched from the header. If the block
	 * is not the last one in a chunk, we check the next one. If
	 * it happens to be free, then we do coalescing. And so on...
	 */

#ifndef EIF_MALLOC_OPTIMIZATION
	size = coalesc(zone);
	while (size) {		/* Perform coalescing as long as possible */
		r += size;		/* And upadte size of block */
		size = coalesc(zone);
	}
#endif	/* EIF_MALLOC_OPTIMIZATION */

	/* Now 'zone' points to the block to be freed, and 'r' is the
	 * size (eventually, this is a coalesced block). Reset all the
	 * flags but B_LAST and put the block in the free list again.
	 */

	flags = zone->ov_size & ~B_SIZE;	/* Save flags */
	r &= B_SIZE;					/* Clear all flags */
	zone->ov_size = r | (flags & (B_LAST | B_CTYPE));	/* Save size B_LAST & type */

	rt_connect_free_list(zone);		/* Insert block in free list */

	SIGRESUME;					/* Critical section ends */
}
#endif

/*
doc:	<routine name="crealloc" return_type="void *" export="shared">
doc:		<summary>This is the C interface with xrealloc, which is fully compatible with the realloc() function in the standard C library (excepted that no storage compaction is done). The function simply calls xrealloc with garbage collection turned on.</summary>
doc:		<param name="ptr" type="void *">Address that will be reallocated.</param>
doc:		<param name="nbytes" type="size_t">New size in bytes of `ptr'.</param>
doc:		<return>New block of memory of size `nbytes', otherwise null pointer or throw an exception.</return>
doc:		<exception>"No more memory" exception</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared void * crealloc(void * ptr, size_t nbytes)
{

#ifdef ISE_GC
	return xrealloc((EIF_REFERENCE) ptr, nbytes, GC_ON);
#else
	return eif_realloc(ptr, nbytes);
#endif
}

/*
doc:	<routine name="xrealloc" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Modify the size of the block pointed to by 'ptr' to 'nbytes'. The 'storage compaction' mechanism mentionned in the old malloc man page is not implemented (i.e the 'ptr' block has to be an allocated block, and not a freed block). If 'gc_flag' is GC_ON, then the GC is called when mallocing a new block. If GC_FREE is activated, then no free is performed: the GC will take care of the object (this is crucial when reallocing an object which is part of the moved set).</summary>
doc:		<param name="ptr" type="EIF_REFERENCE">Address that will be reallocated.</param>
doc:		<param name="nbytes" type="size_t">New size in bytes of `ptr'.</param>
doc:		<param name="gc_flag" type="int">New size in bytes of `ptr'.</param>
doc:		<return>New block of memory of size `nbytes', otherwise null pointer or throw an exception.</return>
doc:		<exception>"No more memory" exception</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</routine>
*/

rt_shared EIF_REFERENCE xrealloc(register EIF_REFERENCE ptr, size_t nbytes, int gc_flag)
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
#ifdef ISE_GC
	rt_uint_ptr r;					/* For shifting purposes */
	rt_uint_ptr i;					/* Index in free list */
	union overhead *zone;		/* The to-be-reallocated zone */
	EIF_REFERENCE safeptr = NULL;		/* GC-safe pointer */
	size_t size, size_gain;				/* Gain in size brought by coalesc */

	REQUIRE("ptr not null", ptr);

#ifdef LMALLOC_CHECK
	if (is_in_lm (ptr))
		fprintf (stderr, "Warning: try to xrealloc a malloc'ed pointer\n");
#endif
	if (nbytes & ~B_SIZE)
		return (EIF_REFERENCE) 0;		/* I guess we can't malloc more than 2^27 */

	zone = HEADER(ptr);

#ifdef DEBUG
	dprintf(16)("realloc: reallocing block 0x%lx to be %d bytes\n",
		zone, nbytes);
	if (zone->ov_flags & EO_SPEC) {
		dprintf(16)("eif_realloc: special has count = %d, elemsize = %d\n",
			RT_SPECIAL_COUNT(ptr), RT_SPECIAL_ELEM_SIZE(ptr));
		if (zone->ov_flags & EO_REF)
			dprintf(16)("realloc: special has object references\n");
	}
	flush;
#endif

	/* First get the size of the block pointed to by 'ptr'. If, by
	 * chance the size is the same or less than the current size,
	 * we won't have to move the block. However, we may have to split
	 * the block...
	 */

	r = zone->ov_size & B_SIZE;			/* Size of block */
	i = (rt_uint_ptr) (nbytes % ALIGNMAX);
	if (i != 0)
		nbytes += ALIGNMAX - i;		/* Pad nbytes */

	if ((r == nbytes) || (r == nbytes + OVERHEAD)) { 			/* Same size, lucky us... */
		return ptr;				/* That's all I wrote */
	}

	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);
	SIGBLOCK;					/* Beginning of critical section */

	if (r > (nbytes + OVERHEAD)) {			/* New block is smaller */

#ifdef DEBUG
		dprintf(16)("realloc: new size is smaller (%d versus %d bytes)\n",
			nbytes, r);
		flush;
#endif

		r = eif_rt_split_block(zone, nbytes);	/* Split block, r holds size */
		if (r == (rt_uint_ptr) -1) {			/* If we did not split it */
			SIGRESUME;					/* Exiting from critical section */
			GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
			return ptr;					/* Leave block unchanged */
		}

		rt_m_data.ml_used -= r + OVERHEAD;	/* Data we lose in realloc */
		if (zone->ov_size & B_CTYPE) {
			rt_c_data.ml_used -= r + OVERHEAD;
		} else {
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (-%ld), %ld total (xrealloc)\n",
			rt_e_data.ml_used, r + OVERHEAD, rt_e_data.ml_total);
#endif
			rt_e_data.ml_used -= r + OVERHEAD;
		}

#ifdef DEBUG
		dprintf(16)("realloc: shrinked block is now %d bytes (lost %d bytes)\n",
			zone->ov_size & B_SIZE, r + OVERHEAD);
		flush;
#endif

		SIGRESUME;		/* Exiting from critical section */
		GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
		return ptr;		/* Block address did not change */
	}

	/* As we would like to avoid moving the block unless it is
	 * absolutely necessary, we check to see if the block after
	 * us is not, by extraordinary, free.
	 */

#ifdef EIF_MALLOC_OPTIMIZATION
	size_gain = 0;
#else	/* EIF_MALLOC_OPTIMIZATION */
	size_gain = 0;
	size = coalesc(zone);
	while (size) {	/* Perform coalescing as long as possible */
		size_gain += size;
		size = coalesc(zone);
	}
		/* Update memory statistic. No need to handle the overheads,
		 * it was already done in `coalesc'. */
	rt_m_data.ml_used += size_gain;
	if (zone->ov_size & B_CTYPE) {
		rt_c_data.ml_used += size_gain;
	} else {
		rt_e_data.ml_used += size_gain;
	}
#endif	/* EIF_MALLOC_OPTIMIZATION */

#ifdef DEBUG
	dprintf(16)("realloc: coalescing added %d bytes (block is now %d bytes)\n",
		size_gain, zone->ov_size & B_SIZE);
	flush;
#endif

		/* If the garbage collector is on and the object is a SPECIAL, then
		 * after attempting a coalescing we must update those information because
		 * they are now invalid, we copy them from their old location.
		 * Of course, this matters only if coalescing has been done, which is
		 * indicated by a non-zero return value from coalesc.
		 * The reason it is needed is because some other objects might still be
		 * referring to `ptr' and thus the new `ptr' should be valid even if later,
		 * in xrealloc, we end up allocating a new SPECIAL object.
		 */
	if ((size_gain != 0) && (gc_flag & GC_ON) && (zone->ov_flags & EO_SPEC)) {
		EIF_REFERENCE l_info;	/* Pointer to new count/elemsize */
		l_info = RT_SPECIAL_DATA(ptr);
		memmove(l_info, ((char *) l_info - size_gain), RT_SPECIAL_DATA_SIZE);
	}

	i = zone->ov_size & B_SIZE;			/* Coalesc modified data in zone */

	if (i > (nbytes + OVERHEAD)) {					/* Total size is ok ? */
		r = i - r;						/* Amount of memory over-used */
		CHECK("computation correct", size_gain == r);
		i = eif_rt_split_block(zone, nbytes);	/* Split block, i holds size */
		if (i == (rt_uint_ptr) -1) {			/* If we did not split it */
			SIGRESUME;					/* Exiting from critical section */
			GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
			return ptr;					/* Leave block unsplit */
		} else {
				/* Split occurred, return unused part and overhead as free for memory accounting. */
			rt_m_data.ml_used -= i + OVERHEAD;
			if (zone->ov_size & B_CTYPE) {
				rt_c_data.ml_used -= i + OVERHEAD;
			} else {
				rt_e_data.ml_used -= i + OVERHEAD;
			}

#ifdef DEBUG
			dprintf(16)("realloc: block is now %d bytes\n",
				zone->ov_size & B_SIZE);
			flush;
#endif

			SIGRESUME;		/* Exiting from critical section */
			GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
			return ptr;		/* Block address did not change */
		}
	}

	SIGRESUME;			/* End of critical section */
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);

	/* If we come here, we have to use malloc/free. I use 'zone' as
	 * a temporary variable, because in fact, pointers returned by
	 * malloc are (union overhead *) cast to (EIF_REFERENCE) and also
	 * because I do not want to declare another register variable.
	 *
	 * There is no need to update the rt_m_data accounting variables,
	 * because malloc and free will do that for us. We allocate the
	 * block from the correct free list, if at all possible.
	 */

	i = (rt_uint_ptr) ((HEADER(ptr)->ov_size & B_C) ? C_T : EIFFEL_T);	/* Best type */

	if (gc_flag & GC_ON) {
		safeptr = ptr;
		if (-1 == RT_GC_PROTECT(safeptr)) {	/* Protect against moves */
			eraise("object reallocation", EN_MEM);	/* No more memory */
			return (EIF_REFERENCE) 0;						/* They ignored it */
		}
	}

	zone = (union overhead *) eif_rt_xmalloc(nbytes, (int) i, gc_flag);

	if (gc_flag & GC_ON) {
		CHECK("safeptr not null", safeptr);
		ptr = safeptr;
		RT_GC_WEAN(safeptr);			/* Remove protection */
	}

	/* Keep Eiffel flags. If GC was on, it might have run its cycle during
	 * the reallocation process and the original object might have moved.
	 * In that case, we take the flags from the forwarded address and we
	 * do NOT free the object itself, but its forwarded copy!!
	 */

	if (zone != (union overhead *) 0) {
		CHECK("Correct size", (r & B_SIZE) <= (HEADER(zone)->ov_size & B_SIZE));
		memcpy (zone, ptr, r & B_SIZE);	/* Move to new location */
		HEADER(zone)->ov_flags = HEADER(ptr)->ov_flags;		/* Keep Eiffel flags */
		HEADER(zone)->ov_dftype = HEADER(ptr)->ov_dftype;
		HEADER(zone)->ov_dtype = HEADER(ptr)->ov_dtype;
		HEADER(zone)->ov_pid = HEADER(ptr)->ov_pid;
		if (!(gc_flag & GC_FREE)) {		/* Will GC take care of free? */
			eif_rt_xfree(ptr);					/* Free old location */
		} else {
				/* We cannot free the object here, but if the old object size occupied more than
				 * 20MB and more than a quarter of the available memory we should force a full
				 * collection as otherwise if it turns out the the old object is not referenced
				 * anymore, it won't be collected and the memory allocated will not see this huge
				 * free space available. See eweasel test#exec107 for an example. */
			if ((r & B_SIZE) > 20971520) {
				if ((r & B_SIZE) > ((rt_m_data.ml_used + rt_m_data.ml_over) / 4)) {
					force_plsc++;
				}
			}
		}
	} else if (i == EIFFEL_T)			/* Could not reallocate object */
		eraise("object reallocation", EN_MEM);	/* No more memory */


#ifdef DEBUG
	if (zone != (union overhead *) 0)
		dprintf(16)("realloc: malloced a new arena at 0x%lx (%d bytes)\n",
			zone, (zone-1)->ov_size & B_SIZE);
	else
		dprintf(16)("realloc: failed for %d bytes, garbage collector %s\n",
			nbytes, gc_flag == GC_OFF ? "off" : "on");
	flush;
#endif

	return (EIF_REFERENCE) zone;		/* Pointer to new arena or 0 if failed */
#else
	return (EIF_REFERENCE) eif_realloc(ptr, nbytes);
#endif
}

#ifdef ISE_GC
/*
doc:	<routine name="eif_rt_meminfo" return_type="struct emallinfo *" export="public">
doc:		<summary>Return the pointer to the static data held in rt_m_data. The user must not corrupt these data. It will be harmless to malloc, however, but may fool the garbage collector. Type selects the kind of information wanted.</summary>
doc:		<param name="type" type="int">Type of memory (M_C or M_EIFFEL or M_ALL) to get info from.</param>
doc:		<return>Pointer to an internal structure used by `malloc.c'.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_public struct emallinfo *eif_rt_meminfo(int type)
{
	switch(type) {
	case M_C:
		return &rt_c_data;		/* Pointer to static data */
	case M_EIFFEL:
		return &rt_e_data;		/* Pointer to static data */
	}

	return &rt_m_data;		/* Pointer to static data */
}

/*
doc:	<routine name="eif_rt_split_block" return_type="rt_uint_ptr" export="shared">
doc:		<summary>The block 'selected' may be too big to hold only 'nbytes', so it is split and the new block is put in the free list. At the end, 'selected' will hold only 'nbytes'. From the accounting point's of vue, only the overhead is incremented (the split block is assumed to be already free). The function returns -1 if no split occurred, or the length of the split block otherwise (which means it must fit in a signed int, argh!!--RAM). Caller is responsible for issuing a SIGBLOCK before any call to this critical routine.</summary>
doc:		<param name="selected" type="union overhead *">Selected block from which we try to extract a block of `nbytes' bytes.</param>
doc:		<param name="nbytes" type="rt_uint_ptr">Size of block we should retur</param>
doc:		<return>Address of location of object of size `nbytes' in `selected'.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_shared rt_uint_ptr eif_rt_split_block(union overhead *selected, rt_uint_ptr nbytes)
{
	rt_uint_ptr flags;				/* Flags of original block */
	rt_uint_ptr l_remaining_bytes;

	REQUIRE("nbytes less than selected size", (selected->ov_size & B_SIZE) >= nbytes);

	/* Compute residual bytes. The flags bits should remain clear */
	l_remaining_bytes = (selected->ov_size & B_SIZE) - nbytes;

	/* Do the split only if possible.
	 * Note: one could say that to avoid 0-sized block in the free list, we
	 *	could have `l_remaining_bytes <= ALIGNMAX', but the issue is that in `gscavenge'
	 *	it would most likely cause a check violation because `gscavenge'
	 *	assumes that reallocation does not change the size of objects.
	 */
	if (l_remaining_bytes < ALIGNMAX)
		return (rt_uint_ptr) -1;				/* Not enough space to split */

	/* Check wether the block we split was the last one in a
	 * chunk. If so, then the remaining will be the last, but
	 * the 'selected' block is no longer the last one anyway.
	 */
	flags = selected->ov_size;		/* Optimize for speed, phew !! */
		/* Split the block by keeping former flags, except B_LAST as now
		 * we cannot be the last block. We clear the previous size as well. */
	selected->ov_size = (flags & ~(B_SIZE | B_LAST)) | nbytes;		/* Block has been split */

	/* Base address of new block (skip overhead and add nbytes) */
	selected = (union overhead *) (((EIF_REFERENCE) (selected+1)) + nbytes);

	l_remaining_bytes -= OVERHEAD;				/* This is the overhead for split block */
	rt_m_data.ml_over += OVERHEAD;		/* Added overhead */
	if (flags & B_CTYPE) {				/* Holds flags (without B_LAST) */
		rt_c_data.ml_over += OVERHEAD;
		selected->ov_size = l_remaining_bytes | B_CTYPE; /* Propagate the information */
	} else {
		rt_e_data.ml_over += OVERHEAD;
		selected->ov_size = l_remaining_bytes;
	}

	/* If the block we split was the last one in the chunk, the new block is now
	 * the last one. There is no need to clear the B_BUSY flag, as normally the
	 * size fits in 27 bits, thus the upper 5 bits are clear--RAM.
	 */
	if (flags & B_LAST) {
		selected->ov_size |=  B_LAST;				/* Mark it last block */
	}
	rt_connect_free_list(selected);	/* Insert block in free list */

#ifdef DEBUG
	dprintf(32)("eif_rt_split_block: split %s %s block starts at 0x%lx (%d bytes)\n",
		(selected->ov_size & B_LAST) ? "last" : "normal",
		(selected->ov_size & B_CTYPE) ? "C" : "Eiffel",
		selected, selected->ov_size & B_SIZE);
	flush;
#endif

	ENSURE("Valid size", (l_remaining_bytes & B_SIZE) == l_remaining_bytes);

	return l_remaining_bytes;			/* Length of split block */
}

/*
doc:	<routine name="coalesc" return_type="rt_uint_ptr" export="private">
doc:		<summary>Given a zone which is not in the free list, test whether we can do some coalescing with the next block, if it happens to be free. Overhead accounting is updated. It is up to the caller to put the coalesced block back to the free list (in case this is called by a free operation). It is up to the caller to issue a SIGBLOCK prior any call to this critical routine.</summary>
doc:		<param name="zone" type="union overhead *">Starting block from which we are trying to coalesc next block to it, if next block is free.</param>
doc:		<return>Number of new free bytes available (i.e. the size of the coalesced block plus the overhead) or 0 if no coalescing occurred.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private rt_uint_ptr coalesc(register union overhead *zone)
{
	rt_uint_ptr r;					/* For shifting purposes */
	rt_uint_ptr i;					/* Index in free list */
	union overhead *next;		/* Pointer to next block */


	i = zone->ov_size;			/* Fetch size and flags */
	if (i & B_LAST)
		return 0;				/* Block is the last one in chunk */

	/* Compute address of next block */
	next = (union overhead *) (((EIF_REFERENCE) zone) + (i & B_SIZE) + OVERHEAD);

	if ((next->ov_size & B_BUSY))
		return 0;				/* Next block is not free */

	r = next->ov_size & B_SIZE;			/* Fetch its size */
	zone->ov_size = i + r + OVERHEAD;	/* Update size (no overflow possible) */
	rt_m_data.ml_over -= OVERHEAD;			/* Overhead freed */
	if (i & B_CTYPE) {
		rt_c_data.ml_over -= OVERHEAD;
	} else {
		rt_e_data.ml_over -= OVERHEAD;
	}

#ifdef DEBUG
	dprintf(1)("coalesc: coalescing with a %d bytes %s %s block at 0x%lx\n",
		r, (next->ov_size & B_LAST) ? "last" : "normal",
		(next->ov_size & B_CTYPE) ? "C" : "Eiffel", next);
	flush;
#endif

	/* Now the longest part... We have to find the block we've just merged and
	 * remove it from the free list.
	 */

	/* First, compute the position in hash list */
	rt_disconnect_free_list(next);		/* Remove block from free list */

	/* Finally, we set the new coalesced block correctly, checking for last
	 * position. The other flags were kept from the original block.
	 */

	i = next->ov_size;
	if (i & B_LAST) {	/* Next block was the last one */
		zone->ov_size |= B_LAST;		/* So coalesced is now the last one */
	}

#ifdef DEBUG
	dprintf(1)("coalesc: coalescing provided a %s %d bytes %s block at 0x%lx\n",
		zone->ov_size & B_LAST ? "last" : "normal",
		zone->ov_size & B_SIZE,
		zone->ov_size & B_CTYPE ? "C" : "Eiffel", zone);
	flush;
#endif

	return (i & B_SIZE) + OVERHEAD;		/* Number of coalesced free bytes */
}

/*
doc:	<routine name="rt_connect_free_list" export="private">
doc:		<summary>The block 'zone' is inserted in the free list #i. It is up to the caller to ensure signal exceptions are blocked when entering in this critical routine.</summary>
doc:		<param name="zone" type="union overhead *">Block to insert in free list #`i'.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/
rt_private void rt_connect_free_list(union overhead * const zone)
{
	union overhead *l_previous, *l_head, *l_next;
	struct rt_free_list *l_free_list;
	size_t i;
	rt_tree *l_tree_node;
	rt_tree l_node;
	size_t l_nbytes = zone->ov_size & B_SIZE;

		/* Quickly compute the index in the free list array where we have a
		 * chance to find the right block. */
	i = rt_compute_free_list_index(l_nbytes);
	l_free_list = FREE_LIST(zone);		/* Get right list ptr */

	if (i < FREE_LIST_INDEX_LIMIT) {
		l_previous = l_free_list->lists[i];
		l_free_list->lists[i] = zone;
		NEXT(zone) = l_previous;
			/* Update previous if we have space for one. */
		if (i != 0) {
			PREVIOUS(zone) = NULL;
			if (l_previous) {
				PREVIOUS(l_previous) = zone;
			}
		}
	} else {
		l_node.nbytes = l_nbytes;
		l_tree_node = sglib_rt_tree_find_member (l_free_list->tree, &l_node);
		if (l_tree_node) {
				/* We found an entry. We insert the item in pseudo-first position.
				 * Pseudo because the tree node is the first item we add but will be
				 * the last one to be removed. Other items are in LIFO order. */
			l_head = &l_tree_node->current;
			l_next = NEXT(l_head);
			NEXT(l_head) = zone;
			if (l_next) {
				PREVIOUS(l_next) = zone;
			}
			NEXT(zone) = l_next;
			PREVIOUS(zone) = l_head;
			CHECK ("Same offset", l_head == (union overhead *) l_tree_node);
		} else {
			NEXT(zone) = NULL;
			l_tree_node = (rt_tree *)zone;
			CHECK("Same offset", zone == (union overhead *) l_tree_node);
			CHECK("Same content", !memcmp(&l_tree_node->current, zone, OVERHEAD));
			l_tree_node->nbytes = l_nbytes;
			sglib_rt_tree_add (&l_free_list->tree, l_tree_node);
		}
	}

	ENSURE("Size preserved zone", (zone->ov_size & B_SIZE) == l_nbytes);
}

/*
doc:	<routine name="rt_disconnect_free_list" export="private">
doc:		<summary>Removes block pointed to by 'zone' from free list. It is up to the caller to ensure signal exceptions are blocked when entering in this critical routine.</summary>
doc:		<param name="zone" type="union overhead * const">Block to remove from free list.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private void rt_disconnect_free_list(union overhead * const zone)
{
	union overhead *l_previous, *l_next;		/* To walk along free list */
	struct rt_free_list *l_free_list;	/* The free list */
	size_t i, nbytes;
	rt_tree *l_tree, *l_tree_node;
	rt_tree l_node;

	REQUIRE("zone aligned", ((rt_uint_ptr)zone) % MEM_ALIGNBYTES == 0);

		/* Quickly compute the index in the free list array where we have a
		 * chance to find the right block. */
	nbytes = zone->ov_size & B_SIZE;
	i = rt_compute_free_list_index(nbytes);
	l_free_list = FREE_LIST(zone);		/* Get right list ptr */

	if (i < FREE_LIST_INDEX_LIMIT) {
		CHECK("List not empty", l_free_list->lists[i]);
		if (i != 0) {
				/* Get previous element of the list. */
			l_previous = PREVIOUS(zone);
			l_next = NEXT(zone);
			if (l_previous) {
				NEXT(l_previous) = l_next;
			} else {
					/* There is no previous elements, so we need to update the head of the list. */
				l_free_list->lists[i] = l_next;
			}
			if (l_next) {
				PREVIOUS(l_next) = l_previous;
			}
		} else {
				/* We have to perform a linear search because we do not
				 * have enough space to store the back pointer. */
			l_next = l_free_list->lists[0];
			if (zone != l_next) {
				for (; l_next; l_next = NEXT(l_next)) {
					if (NEXT(l_next) == zone) {			/* Next block is ok */
						NEXT(l_next) = NEXT(zone);		/* Remove from free list */
						return;						/* Exit */
					}
				}
			} else {
					/* We got lucky, this was the first item. */
				l_free_list->lists[0] = NEXT(l_next);
			}
		}
	} else {
		l_node.nbytes = nbytes;
		l_tree = sglib_rt_tree_find_member (l_free_list->tree, &l_node);
		CHECK("has node", l_tree);
		if (l_tree == (rt_tree *) zone) {
				/* `zone' is the head of the list. */
			l_next = NEXT(zone);
				/* We need to remove the current tree node and make `l_next' the new one if it exists. */
			sglib_rt_tree_delete (&l_free_list->tree, l_tree);
			if (l_next) {
				l_tree_node = (rt_tree *) l_next;
				l_tree_node->nbytes = nbytes;
					/* Fixme: maybe we could speed up this if we had a parent link, that way we would
					 * just replace the parent pointer to link to `l_tree_node' instead of `l_tree'. */
				sglib_rt_tree_add (&l_free_list->tree, l_tree_node);
			}
		} else {
				/* Use the same algorithm as normal list except that we are sure there is a previous
				 * element. */
			l_previous = PREVIOUS(zone);
			l_next = NEXT(zone);
			CHECK("has previous", l_previous);
			NEXT(l_previous) = l_next;
			if (l_next) {
				PREVIOUS(l_next) = l_previous;
			}
		}
	}
}


/*
doc:	<routine name="lxtract" export="shared">
doc:		<summary>Remove 'zone' from the free list. This routine is used by the garbage collector, and thus it is visible from the outside world, hence the cryptic name for portability--RAM. Note that the garbage collector performs with signal exceptions blocked.</summary>
doc:		<param name="zone" type="union overhead *">Block to remove from free list.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_shared void lxtract(union overhead *zone)
{
	rt_disconnect_free_list(zone);	/* Remove from free list */
}

/*
doc:	<routine name="chunk_coalesc" return_type="rt_uint_ptr" export="shared">
doc:		<summary>Do block coalescing inside the chunk wherever possible.</summary>
doc:		<param name="c" type="struct chunk *">Block to remove from free list.</param>
doc:		<return>Size of the largest coalesced block or 0 if no coalescing occurred.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_shared rt_uint_ptr chunk_coalesc(struct chunk *c)
{
	RT_GET_CONTEXT
	union overhead *zone;	/* Malloc info zone */
	rt_uint_ptr flags;			/* Malloc flags */
	size_t l_new_size;			/* Size of zone after coalescing. */
	rt_uint_ptr max_size = 0;		/* Size of biggest coalesced block */

	SIGBLOCK;			/* Take no risks with signals */

	for (
		zone = (union overhead *) (c + 1);	/* First malloc block */
		/* empty */;
		zone = (union overhead *)
			(((EIF_REFERENCE) (zone + 1)) + (flags & B_SIZE))
	) {
		flags = zone->ov_size;		/* Size and flags */

#ifdef DEBUG
		dprintf(32)("chunk_coalesc: %s block 0x%lx, %d bytes, %s\n",
			flags & B_LAST ? "last" : "normal",
			zone, flags & B_SIZE,
			flags & B_BUSY ?
			(flags & B_C ? "busy C" : "busy Eiffel") : "free");
		flush;
#endif

		if (flags & B_LAST)
			break;					/* Last block reached */
		if (flags & B_BUSY)			/* Block is busy */
			continue;				/* Skip block */

		/* In case we are coalescsing a block, we have to store the
		 * free list to which it belongs, so that we can remove it
		 * if necessary (i.e. if its size changes).
		 */

			/* Before performing the coalesc we need to remove `zone' from the free list. */
		rt_disconnect_free_list(zone);

		while (!(zone->ov_size & B_LAST)) {		/* Not last block */
			if (0 == coalesc(zone))
				break;					/* Could not merge block */
		}

			/* Add `zone' back to the free list. Hopefully coalescing occurred
			 * otherwise we just lost time removing and adding the same block at
			 * the same place. */
		rt_connect_free_list(zone);	

		flags = zone->ov_size;

		/* Check whether coalescing occurred. If so, we have to remove
		 * 'zone' from free list and then put it back to a possible
		 * different list. Also update the size of the biggest coalesced
		 * block. This value should help malloc in its decisions--RAM.
		 */
		l_new_size = flags & B_SIZE;			/* Size of coalesced block */
		if (max_size < l_new_size) {
			max_size = l_new_size;			/* Update maximum size yielded */
		}


		if (flags & B_LAST)				/* We reached last malloc block */
			break;						/* Finished for that block */
	}

	SIGRESUME;				/* Restore signal handling */

#ifdef DEBUG
	dprintf(32)("chunk_coalesc: %d bytes is the largest coalesced block\n",
		max_size);
	flush;
#endif

	return max_size;		/* Maximum size of coalesced block or 0 */
}

/*
doc:	<routine name="full_coalesc" return_type="rt_uint_ptr" export="shared">
doc:		<summary>Same as `full_coalesc_unsafe' except it is a safe thread version.</summary>
doc:		<param name="chunk_type" type="int">Type of chunk on which we perform coalescing (C_T, EIFFEL_T or ALL_T).</param>
doc:		<return>Size of the largest block made available by coalescing, or 0 if no coalescing ever occurred.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_free_list_mutex'.</synchronization>
doc:	</routine>
*/

rt_shared rt_uint_ptr full_coalesc (int chunk_type)
{
	RT_GET_CONTEXT
	rt_uint_ptr result;
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_LOCK);
	result = full_coalesc_unsafe (chunk_type);
	GC_THREAD_PROTECT(EIF_FREE_LIST_MUTEX_UNLOCK);
	return result;
}

/*
doc:	<routine name="full_coalesc_unsafe" return_type="rt_uint_ptr" export="private">
doc:		<summary>Walks through the designated chunk list (type 'chunk_type') and do block coalescing wherever possible.</summary>
doc:		<param name="chunk_type" type="int">Type of chunk on which we perform coalescing (C_T, EIFFEL_T or ALL_T).</param>
doc:		<return>Size of the largest block made available by coalescing, or 0 if no coalescing ever occurred.</return>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds `eif_free_list_mutex' or is under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private rt_uint_ptr full_coalesc_unsafe(int chunk_type)
{
	struct chunk *c;		/* To walk along chunk list */
	rt_uint_ptr max_size = 0;		/* Size of biggest coalesced block */
	rt_uint_ptr max_coalesced;	/* Size of coalesced block in a chunk */

	/* Choose the correct head for the list depending on the memory type.
	 * If ALL_T is used, then the whole memory is scanned and coalesced.
	 */

	switch (chunk_type) {
	case C_T:						/* Only walk through the C chunks */
		c = cklst.cck_head;
		break;
	case EIFFEL_T:					/* Only walk through the Eiffel chunks */
		c = cklst.eck_head;
		break;
	case ALL_T:						/* Walk through all the memory */
		c = cklst.ck_head;
		break;
	default:
		return (rt_uint_ptr) -1;					/* Invalid request */
	}

	for (
		/* empty */;
		c != (struct chunk *) 0;
		c = chunk_type == ALL_T ? c->ck_next : c->ck_lnext
	) {

#ifdef DEBUG
		dprintf(1+32)("full_coalesc_unsafe: entering %s chunk 0x%lx (%d bytes)\n",
			c->ck_type == C_T ? "C" : "Eiffel", c, c->ck_length);
		flush;
#endif

		max_coalesced = chunk_coalesc(c);	/* Deal with the chunk */
		if (max_coalesced > max_size)		/* Keep track of largest block */
			max_size = max_coalesced;
	}

#ifdef DEBUG
	dprintf(1+8+32)("full_coalesc_unsafe: %d bytes is the largest coalesced block\n",
		max_size);
	flush;
#endif

	return max_size;		/* Maximum size of coalesced block or 0 */
}

/*
doc:	<routine name="trigger_smart_gc_cycle" return_type="int" export="private">
doc:		<summary>Launch a GC cycle. If we have allocated more than `th_alloc' then we perform an automatic collection, otherwise we try a simple generation scavenging. If we are under the control of a complete synchronization, we do not try to acquire mutex. This is useful for `retrieve' which blocks all threads but if one is blocked in here through a lock on `trigger_gc_mutex' then we end up with a dead lock, where actually we didn't need to hold the `trigger_gc_mutex'.</summary>
doc:		<return>1 if collection was successful, 0 otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eiffel_usage_mutex' for getting value of `eiffel_usage'.</synchronization>
doc:	</routine>
*/

rt_private int trigger_smart_gc_cycle (void)
{
	RT_GET_CONTEXT
	int result = 0;

#ifdef EIF_THREADS
	if (gc_thread_status == EIF_THREAD_GC_RUNNING) {
#endif
		if (eiffel_usage > th_alloc) {
			if (0 == acollect()) {
				result = 1;
			}
		} else if (0 == collect()) {
			result = 1;
		}
		return result;
#ifdef EIF_THREADS
	} else if (thread_can_launch_gc) {
		rt_uint_ptr e_usage;
		EIF_ENTER_C;
		TRIGGER_GC_LOCK;
		EIFFEL_USAGE_MUTEX_LOCK;
		e_usage = eiffel_usage;
		EIFFEL_USAGE_MUTEX_UNLOCK;
		if (e_usage > th_alloc) {	/* Above threshold */
			if (0 == acollect()) {		/* Perform automatic collection */
				result = 1;
			}
		} else if (0 == collect()) {	/* Simple generation scavenging */
			result = 1;
		}
		TRIGGER_GC_UNLOCK;
		EIF_EXIT_C;
		RTGC;
		return result;
	} else {
		return result;
	}
#endif
}

/*
doc:	<routine name="trigger_gc_cycle" return_type="int" export="private">
doc:		<summary>Launch a GC cycle. If we have allocated more than `th_alloc' then we perform an automatic collection. If we are under the control of a complete synchronization, we do not try to acquire mutex. This is useful for `retrieve' which blocks all threads but if one is blocked in here through a lock on `trigger_gc_mutex' then we end up with a dead lock, where actually we didn't need to hold the `trigger_gc_mutex'.</summary>
doc:		<return>1 if collection was successful, 0 otherwise</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eiffel_usage_mutex' for getting value of `eiffel_usage'.</synchronization>
doc:	</routine>
*/

rt_private int trigger_gc_cycle (void)
{
	RT_GET_CONTEXT
	int result = 0;
#ifdef EIF_THREADS
	if (gc_thread_status == EIF_THREAD_GC_RUNNING) {
#endif
		if (eiffel_usage > th_alloc) {
			if (0 == acollect()) {
				result = 1;
			}
		}
		return result;
#ifdef EIF_THREADS
	} else if (thread_can_launch_gc) {
		rt_uint_ptr e_usage;
		EIF_ENTER_C;
		TRIGGER_GC_LOCK;
		EIFFEL_USAGE_MUTEX_LOCK;
		e_usage = eiffel_usage;
		EIFFEL_USAGE_MUTEX_UNLOCK;
		if (e_usage > th_alloc) {	/* Above threshold */
			if (0 == acollect()) {		/* Perform automatic collection */
				result = 1;
			}
		}
		TRIGGER_GC_UNLOCK;
		EIF_EXIT_C;
		RTGC;
		return result;
	} else {
		return 0;
	}
#endif
}

/*
doc:	<routine name="malloc_from_zone" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Try to allocate 'nbytes' in the scavenge zone. Returns a pointer to the object's location or a null pointer if an error occurred.</summary>
doc:		<param name="nbytes" type="rt_uint_ptr">Size in bytes of zone to allocated.</param>
doc:		<return>Address of a block in scavenge zone if successful, null pointer otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_gsz_mutex'.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE malloc_from_zone(rt_uint_ptr nbytes)
{
	RT_GET_CONTEXT
	EIF_REFERENCE object;	/* Address of the allocated object */

	REQUIRE("Scavenging enabled", gen_scavenge == GS_ON);
	REQUIRE("Has from zone", sc_from.sc_arena);
	REQUIRE("nbytes properly padded", (nbytes % ALIGNMAX) == 0);

	/* Allocating from a scavenging zone is easy and fast. It's basically a
	 * pointer update... However, if the level in the 'from' zone reaches
	 * the watermark GS_WATERMARK, we return NULL immediately, it is up to
	 * the caller to decide whether or not he will run the generation scavenging
	 * The tenuring threshold for the next scavenge is computed to make the level
	 * of occupation go below the watermark at the next collection so that
	 * the next call to `malloc_from_zone' is most likely to succeed.
	 *
	 * Aslo, if there is not enough space in the scavenge zone, we need to return
	 * immediately.
	 */
	GC_THREAD_PROTECT(EIF_GC_GSZ_LOCK);

	object = sc_from.sc_top;				/* First eif_free location */

	if ((object >= sc_from.sc_mark) || ((ALIGNMAX + nbytes + object) > sc_from.sc_end)) {
		GC_THREAD_PROTECT(EIF_GC_GSZ_UNLOCK);
		return NULL;
	}

	SIGBLOCK;								/* Block signals */
	sc_from.sc_top += nbytes + ALIGNMAX;	/* Update free-location pointer */
	((union overhead *) object)->ov_size = nbytes;	/* All flags cleared */

	/* No account for memory used is to be done. The memory used by the two
	 * scavenge zones is already considered to be in full use.
	 */

#ifdef DEBUG
	dprintf(4)("malloc_from_zone: returning block starting at 0x%lx (%d bytes)\n",
		(EIF_REFERENCE) (((union overhead *) object ) + 1),
		((union overhead *) object)->ov_size);
	flush;
#endif

	SIGRESUME;								/* Restore signal handling */
	GC_THREAD_PROTECT(EIF_GC_GSZ_UNLOCK);

	ENSURE ("Allocated size big enough", nbytes <= (((union overhead *) object)->ov_size & B_SIZE));

	return (EIF_REFERENCE) (((union overhead *) object ) + 1);	/* Free data space */
}

/*
doc:	<routine name="create_scavenge_zones" export="shared">
doc:		<summary>Attempt creation of two scavenge zones: the 'from' zone and the 'to' zone. If it is successful, `gen_scavenge' is set to `GS_ON' otherwise the value remained unchanged and is `GS_OFF'. Upon success, the routine updates the structures accordingly.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe when under GC synchronization or during run-time initialization.</synchronization>
doc:	</routine>
*/

rt_shared void create_scavenge_zones(void)
{
	REQUIRE("Not already allocated", (sc_from.sc_arena == NULL) && (sc_to.sc_arena == NULL));
	REQUIRE("Generation scavenging off", gen_scavenge == GS_OFF);

		/* Initialize `gen_scavenge' to GS_OFF in case it fails to allocate the scavenge zones. */
	if (cc_for_speed) {
		RT_GET_CONTEXT
		EIF_REFERENCE from;		/* From zone */
		EIF_REFERENCE to;		/* To zone */

		/* I think it's best to allocate the spaces in the C list. Firstly, this
		 * space must never be moved, secondly it should never be reclaimed,
		 * excepted when we are low on memory, but then it does not really matters.
		 * Lastly, the garbage collector will simply ignore the block, which is
		 * just fine--RAM.
		 */
		from = eif_rt_xmalloc(eif_scavenge_size, C_T, GC_OFF);
		if (from) {
			to = eif_rt_xmalloc(eif_scavenge_size, C_T, GC_OFF);
			if (!to) {
				eif_rt_xfree(from);
			} else {
					/* Now set up the zones */
				SIGBLOCK;								/* Critical section */
				sc_from.sc_arena = (char *) ((union overhead *) from);	/* Base address */
				sc_to.sc_arena = (char *) ((union overhead *) to);
				sc_from.sc_top = sc_from.sc_arena;					/* First free address */
				sc_to.sc_top = sc_to.sc_arena;
				sc_from.sc_mark = from + GS_WATERMARK;	/* Water mark (nearly full) */
				sc_to.sc_mark = to + GS_WATERMARK;
				sc_from.sc_end = from + eif_scavenge_size;	/* First free location beyond */
				sc_to.sc_end = to + eif_scavenge_size;
				SIGRESUME;								/* End of critical section */

				gen_scavenge = GS_ON;		/* Generation scavenging activated */
			}
		}
	}

	ENSURE("Correct_value", (gen_scavenge == GS_OFF) || (gen_scavenge == GS_ON));
	ENSURE("Created", !(gen_scavenge == GS_ON) || (sc_from.sc_arena && sc_to.sc_arena));
	ENSURE("Not created", (gen_scavenge == GS_ON) || (!sc_from.sc_arena && !sc_to.sc_arena));
}

/*
doc:	<routine name="explode_scavenge_zones" export="private">
doc:		<summary>Take a scavenge zone and destroy it letting all the objects held in it go back under the free-list management scheme. The memory accounting has to be done exactely: all the zone was handled as being in use for the statistics, but now we have to account for the overhead used by each stored object...</summary>
doc:		<param name="sc" type="struct sc_zone *">Zone to be freed. Usually the from zone of the 2 scavenge zones.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe when under GC synchronization.</synchronization>
doc:	</routine>
*/

rt_private void explode_scavenge_zone(struct sc_zone *sc)
{
	RT_GET_CONTEXT
	rt_uint_ptr flags;				/* Store some flags */
	union overhead *zone;		/* Malloc info zone */
	union overhead *next;		/* Next zone to be studied */
	rt_uint_ptr size = 0;			/* Flags to bo OR'ed on each object */
	EIF_REFERENCE top = sc->sc_top;	/* Top in scavenge space */
	rt_uint_ptr new_objects_overhead = 0;	/* Overhead size corresponding to new objects
											 * which have now a life of their own outside
											 * the scavenge zone. */

	next = (union overhead *) sc->sc_arena;
	if (next == (union overhead *) 0)
			return;
	zone = next - 1;
	flags = zone->ov_size;

	if (flags & B_CTYPE) {				/* This is the usual case */
		size |= B_CTYPE;				/* Scavenge zone is in a C chunk */
	}

	size |= B_BUSY;						/* Every released object is busy */

	/* Loop over the zone and build for each object a header that would have
	 * been given to it if it had been malloc'ed in from the free-list.
	 */

	SIGBLOCK;				/* Beginning of critical section */

	for (zone = next; (EIF_REFERENCE) zone < top; zone = next) {

		/* Set the flags for the new block and compute the location of
		 * the next object in the space.
		 */
		flags = zone->ov_size;
		next = (union overhead *) (((EIF_REFERENCE) zone) + (flags & B_SIZE) + OVERHEAD);
		zone->ov_size = flags | size;

		/* The released object belongs to the new generation so add it
		 * to the moved_set. If it is not possible (stack full), abort. We
		 * do that because there should be room as the 'to' space should have
		 * been released before exploding the 'from' space, thus leaving
		 * room for stack growth.
		 */
		if (eif_ostack_push(&moved_set, (EIF_REFERENCE) (zone + 1)) != T_OK)
			enomem(MTC_NOARG);					/* Critical exception */
		zone->ov_flags |= EO_NEW;		/* Released object is young */
		new_objects_overhead += OVERHEAD;
	}

#ifdef MAY_PANIC
	/* Consitency check. We must have reached the top of the zone */
	if ((EIF_REFERENCE) zone != top)
		eif_panic("scavenge zone botched");
#endif

	/* If we did not reach the end of the scavenge zone, then there is at
	 * least some room for one header. We're going to fake a malloc block and
	 * call eif_rt_xfree() to release it.
	 */

	if ((EIF_REFERENCE) zone != sc->sc_end) {

		/* Everything from 'zone' to the end of the scavenge space is now free.
		 * Set up a normal busy block before calling eif_rt_xfree. If the scavenge zone
		 * was the last block in the chunk, then this remaining space is the
		 * last in the chunk too, so set the flags accordingly.
		 */

		CHECK("new size fits on B_SIZE", ((sc->sc_end - (EIF_REFERENCE) (zone + 1)) & ~B_SIZE) == 0);

		zone->ov_size = size | (sc->sc_end - (EIF_REFERENCE) (zone + 1));
		next = HEADER(sc->sc_arena);
		if (next->ov_size & B_LAST)		/* Scavenge zone was a last block ? */
			zone->ov_size |= B_LAST;	/* So is it for the remainder */

#ifdef DEBUG
		dprintf(1)("explode_scavenge_zone: remainder is a %s%d bytes bloc\n",
			zone->ov_size & B_LAST ? "last " : "", zone->ov_size & B_SIZE);
		flush;
#endif

		eif_rt_xfree((EIF_REFERENCE) (zone + 1));			/* Put remainder back to free-list */
		new_objects_overhead += OVERHEAD;
	} else {
		next = HEADER(sc->sc_arena);	/* Point to the header of the arena */
	}

	/* Freeing the header of the arena (the scavenge zone) is easy. We fake a
	 * zero length block and call free on it. Note that this does not change
	 * statistics at all: this overhead was already accounted for and it remains
	 * an overhead.
	 */

	next->ov_size = size;				/* A zero length bloc */
	eif_rt_xfree((EIF_REFERENCE) (next + 1));			/* Free header of scavenge zone */

	/* Update the statistics: we released 'new_objects_overhead , so we created that
	 * amount of overhead. Note that we do have to change the amount of
	 * memory used as the above call to `eif_rt_xfree' to mark the remaining
	 * zone as free did not take into account the `new_objects_overhead' that was
	 * added (it considered it was a single block).
	 */

	rt_m_data.ml_used -= new_objects_overhead;
	rt_m_data.ml_over += new_objects_overhead;
	if (size & B_CTYPE) {					/* Scavenge zone in a C chunk */
		rt_c_data.ml_used -= new_objects_overhead;
		rt_c_data.ml_over += new_objects_overhead;
	} else {								/* Scavenge zone in an Eiffel chunk */
		rt_e_data.ml_used -= new_objects_overhead;
		rt_e_data.ml_over += new_objects_overhead;
	}

	SIGRESUME;							/* End of critical section */
}

/*
doc:	<routine name="sc_stop" export="shared">
doc:		<summary>Stop the scavenging process by freeing the zones. In MT mode, it forces a GC synchronization as some threads might be still running and trying to allocated in the scavenge zone.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through GC synchronization.</synchronization>
doc:	</routine>
*/

rt_shared void sc_stop(void)
{
	RT_GET_CONTEXT
	GC_THREAD_PROTECT(eif_synchronize_gc(rt_globals));
	gen_scavenge = GS_OFF;				/* Generation scavenging is off */
	eif_rt_xfree(sc_to.sc_arena);				/* This one is completely eif_free */
	explode_scavenge_zone(&sc_from);	/* While this one has to be exploded */
	eif_ostack_reset (&memory_set);
		/* Reset values to their default value */
	memset (&sc_to, 0, sizeof(struct sc_zone));
	memset (&sc_from, 0, sizeof(struct sc_zone));
	GC_THREAD_PROTECT(eif_unsynchronize_gc(rt_globals));
}
#endif

/*
doc:	<routine name="eif_box" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Create a boxed version of a basic value.</summary>
doc:		<param name="v" type="EIF_TYPED_VALUE">Value to be boxed.</param>
doc:		<return>A newly allocated object if successful.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by different allocators to whom we request memory</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE eif_box (EIF_TYPED_VALUE v)
{
	EIF_REFERENCE Result;
	switch (v.type & SK_HEAD)
	{
		case SK_BOOL:    Result = RTLN(egc_bool_dtype);   *                     Result = v.it_b;  break;
		case SK_CHAR8:   Result = RTLN(egc_char_dtype);   *                     Result = v.it_c1; break;
		case SK_CHAR32:  Result = RTLN(egc_wchar_dtype);  *(EIF_CHARACTER_32 *) Result = v.it_c4; break;
		case SK_UINT8:   Result = RTLN(egc_uint8_dtype);  *(EIF_NATURAL_8 *)    Result = v.it_n1; break;
		case SK_UINT16:  Result = RTLN(egc_uint16_dtype); *(EIF_NATURAL_16 *)   Result = v.it_n2; break;
		case SK_UINT32:  Result = RTLN(egc_uint32_dtype); *(EIF_NATURAL_32 *)   Result = v.it_n4; break;
		case SK_UINT64:  Result = RTLN(egc_uint64_dtype); *(EIF_NATURAL_64 *)   Result = v.it_n8; break;
		case SK_INT8:    Result = RTLN(egc_int8_dtype);   *(EIF_INTEGER_8 *)    Result = v.it_i1; break;
		case SK_INT16:   Result = RTLN(egc_int16_dtype);  *(EIF_INTEGER_16 *)   Result = v.it_i2; break;
		case SK_INT32:   Result = RTLN(egc_int32_dtype);  *(EIF_INTEGER_32 *)   Result = v.it_i4; break;
		case SK_INT64:   Result = RTLN(egc_int64_dtype);  *(EIF_INTEGER_64 *)   Result = v.it_i8; break;
		case SK_REAL32:  Result = RTLN(egc_real32_dtype); *(EIF_REAL_32 *)      Result = v.it_r4; break;
		case SK_REAL64:  Result = RTLN(egc_real64_dtype); *(EIF_REAL_64 *)      Result = v.it_r8; break;
		case SK_POINTER: Result = RTLN(egc_point_dtype);  *(EIF_POINTER *)      Result = v.it_p;  break;
		case SK_REF:                                                            Result = v.it_r;  break;
		default:
			Result = NULL;	/* To avoid C warnings. */
			eif_panic("illegal value type");
	}
	return Result;
}

/*
doc:	<routine name="eif_set" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Set an Eiffel object for use: reset the zone with zeros, and try to record the object inside the moved set, if necessary. The function returns the address of the object (it may move if a GC cycle is raised).</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to setup.</param>
doc:		<param name="flags" type="uint16">Full dynamic type of object to setup.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Full dynamic type of object to setup.</param>
doc:		<param name="dtype" type="EIF_TYPE_INDEX">Dynamic type of object to setup.</param>
doc:		<return>New value of `object' as this routine can trigger a GC cycle</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE eif_set(EIF_REFERENCE object, uint16 flags, EIF_TYPE_INDEX dftype, EIF_TYPE_INDEX dtype)
{
	RT_GET_CONTEXT
	union overhead *zone = HEADER(object);		/* Object's header */
	void (*init)(EIF_REFERENCE, EIF_REFERENCE);	/* The optional initialization */

	SIGBLOCK;					/* Critical section */
	memset (object, 0, zone->ov_size & B_SIZE);		/* All set with zeros */

#ifdef EIF_TID
#ifdef EIF_THREADS
	zone->ovs_tid = (rt_uint_ptr) eif_thr_context->thread_id; /* tid from eif_thr_context */
#else
	zone->ovs_tid = (rt_uint_ptr) 0; /* In non-MT-mode, it is NULL by convention */
#endif  /* EIF_THREADS */
#endif  /* EIF_TID */

		/* Set SCOOP region ID. */
#ifdef EIF_THREADS
	CHECK ("valid_region_id", rt_globals->eif_globals->scoop_region_id != EIF_NULL_PROCESSOR);
	zone->ov_pid = rt_globals->eif_globals->scoop_region_id;
#else
 	zone->ov_pid = (EIF_SCP_PID) 0;
#endif
	zone->ov_size &= ~B_C;		/* Object is an Eiffel one */
	zone->ov_flags = flags;
	zone->ov_dftype = dftype;	/* Set Full dynamic type */
	zone->ov_dtype = dtype;		/* Set dynamic type */
	if (EIF_IS_EXPANDED_TYPE(System (dtype))) {
		zone->ov_flags |= EO_EXP | EO_REF;
	}

#ifdef ISE_GC
	if (flags & EO_NEW) {					/* New object outside scavenge zone */
		object = add_to_moved_set (object);
	}
	if (Disp_rout(dtype)) {
			/* Special marking of MEMORY object allocated in scavenge zone */
		if (!(flags & EO_NEW)) {
			object = add_to_stack (&memory_set, object);
		}
		zone->ov_flags |= EO_DISP;
	}
#endif

	/* If the object has an initialization routine, call it now. This routine
	 * is in charge of setting some other flags like EO_COMP and initializing
	 * of expanded inter-references.
	 */


	init = XCreate(dtype);
	if (init) {
		EIF_GET_CONTEXT
		DISCARD_BREAKPOINTS
		RT_GC_PROTECT(object);
		(init)(object, object);
		RT_GC_WEAN(object);
		UNDISCARD_BREAKPOINTS
	}

	SIGRESUME;					/* End of critical section */

#ifdef DEBUG
	dprintf(256)("eif_set: %d bytes for DT %d at 0x%lx%s\n",
		zone->ov_size & B_SIZE, dftype, object, dftype & EO_NEW ? " (new)" : "");
	flush;
#endif

#ifdef EIF_EXPENSIVE_ASSERTIONS
	CHECK ("Cannot be in object ID stack", !eif_ostack_has(&object_id_stack, object));
#endif

	return object;
}

/*
doc:	<routine name="eif_spset" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Set the special Eiffel object for use: reset the zone with zeros. If special object not allocated in scavenge zone, we also try to remember the object (has to be in the new generation outside scavenge zone). The dynamic type of the special object is left blank. It is up to the caller of spmalloc() to set a proper dynamic type. The function returns the location of the object (it may move if a GC cycle has been raised to remember the object).</summary>
doc:		<param name="object" type="EIF_REFERENCE">Special object to setup.</param>
doc:		<param name="in_scavenge" type="EIF_BOOLEAN">Is new special object in scavenge zone?</param>
doc:		<return>New value of `object' as this routine can trigger a GC cycle</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE eif_spset(EIF_REFERENCE object, EIF_BOOLEAN in_scavenge)
{
	RT_GET_CONTEXT
	union overhead *zone = HEADER(object);		/* Malloc info zone */

	SIGBLOCK;					/* Critical section */
	if (egc_has_old_special_semantic) {
		memset (object, 0, zone->ov_size & B_SIZE);		/* All set with zeros */
	}

#ifdef EIF_TID
#ifdef EIF_THREADS
	zone->ovs_tid = (rt_uint_ptr) eif_thr_context->thread_id; /* tid from eif_thr_context */
#else
	zone->ovs_tid = (rt_uint_ptr) 0; /* In non-MT-mode, it is NULL by convention */
#endif  /* EIF_THREADS */
#endif  /* EIF_TID */

		/* Set SCOOP region ID. */
#ifdef EIF_THREADS
	CHECK ("valid_region_id", rt_globals->eif_globals->scoop_region_id != EIF_NULL_PROCESSOR);
	zone->ov_pid = rt_globals->eif_globals->scoop_region_id;
#else
 	zone->ov_pid = (EIF_SCP_PID) 0;
#endif
	zone->ov_size &= ~B_C;				/* Object is an Eiffel one */

#ifdef ISE_GC
	if (in_scavenge == EIF_FALSE) {
		zone->ov_flags = EO_SPEC | EO_NEW;	/* Object is special and new */
		object = add_to_moved_set (object);
	} else
#endif
		zone->ov_flags = EO_SPEC;	/* Object is special */

	SIGRESUME;					/* End of critical section */

#ifdef DEBUG
	dprintf(256)("eif_spset: %d bytes special at 0x%lx\n", zone->ov_size & B_SIZE, object);
	flush;
#endif

#ifdef EIF_EXPENSIVE_ASSERTIONS
	CHECK ("Cannot be in object ID stack", !eif_ostack_has(&object_id_stack, object));
#endif

	return object;
}

#ifdef ISE_GC

/*
doc:	<routine name="add_to_moved_set" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Add `object' into `moved_set' but only if `moved_set' is not full. At the moment `not full' means simply that the first chunk of the set is full. The reason is that we noticed that if too many objects are allocated as EO_NEW, then we will spend a lot of time in `update_moved_set'.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to add in `memory_set'.</param>
doc:		<return>Location of `object' as it might have moved.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_set_mutex'.</synchronization>
doc:		<fixme>Refine notion of `full'.</fixme>
doc:	</routine>
*/

rt_private EIF_REFERENCE add_to_moved_set (EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	union overhead * zone;

	REQUIRE("object not null", object);
	REQUIRE("object has EO_NEW", HEADER(object)->ov_flags & EO_NEW);

	GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
		/* Check that we can actually add something to the stack. */
	if ((moved_set.st_cur == NULL) || (moved_set.st_cur->sk_top < moved_set.st_cur->sk_end)) {
		if (eif_ostack_push(&moved_set, object) != T_OK) {		/* Cannot record object */
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
				/* We don't bother, we simply remove the EO_NEW flag from the object
				 * and mark it old. */
			zone = HEADER(object);
			zone->ov_flags &= ~EO_NEW;
			zone->ov_flags |= EO_OLD;
		} else {
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		}
	} else {
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
			/* `moved_set' was full so we don't bother, we simply remove the EO_NEW flag from the object
			 * and mark it old. */
		zone = HEADER(object);
		zone->ov_flags &= ~EO_NEW;
		zone->ov_flags |= EO_OLD;
	}
	return object;
}

/*
doc:	<routine name="add_to_stack" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Add `object' into `stk'.</summary>
doc:		<param name="stk" type="struct ostack *">Stack in which we wish to add `object'.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object to add in `memory_set'.</param>
doc:		<return>Location of `object' as it might have moved.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_set_mutex'.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE add_to_stack (struct ostack *stk, EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
	if (eif_ostack_push(stk, object) != T_OK) {		/* Cannot record object */
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		urgent_plsc(&object);					/* Full collection */
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
		if (eif_ostack_push(stk, object) != T_OK) {	/* Still failed */
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
			enomem(MTC_NOARG);							/* Critical exception */
		} else {
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		}
	} else {
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
	}
	return object;
}

/*
doc:	<routine name="rt_compute_free_list_index" return_type="size_t" export="private">
doc:		<summary>Quickly compute the index in the free list where we have a chance to find the right block, otherwise FREE_LIST_INDEX_LIMIT.</summary>
doc:		<param name="nbytes" type="size_t">Size of block from which we want to find its associated index in free list.</param>
doc:		<return>Index of free list where block of size `nbytes' will be found.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_private rt_inline size_t rt_compute_free_list_index (size_t nbytes)
{
	size_t result;

	REQUIRE("Aligned size", (nbytes % ALIGNMAX) == 0);

	result = nbytes / ALIGNMAX;
	if (result >= FREE_LIST_INDEX_LIMIT) {
		return FREE_LIST_INDEX_LIMIT;
	} else {
		return result;
	}
}

#endif
/*
doc:</file>
*/
