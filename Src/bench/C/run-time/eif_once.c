/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

  ####   #    #   ####   ######           ####
 #    #  ##   #  #    #  #               #    #
 #    #  # #  #  #       #####           #
 #    #  #  # #  #       #        ###    #
 #    #  #   ##  #    #  #        ###    #    #
  ####   #    #   ####   ######   ###     ####

	Once per process mechanism (Only in MT-mode)

features implemented so as to allow once per process calls 
in multithreaded mode because the current implementation of
the once mechanism is once per thread. --Manuelt
*/


#include "eif_once.h"
#include "eif_lmalloc.h"
#include "eif_globals.h"	
#include "eif_threads.h"	/* mutex */
#include "eif_hector.h"
#define OP_TABLE_SIZE 15 /* size of Once per Process Tables */

#ifdef __cplusplus
extern "C" {
#endif

#if defined EIF_THREADS && ! defined VXWORKS /* Features making sense only in MT-Mode */
				/* VXWORKS should be undef because mutex doesn't Work on this platform */
/* Public features declarations */

rt_public EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_POINTER function_ptr);

rt_public void eif_global_procedure (EIF_REFERENCE Current, EIF_POINTER proc_ptr);
rt_shared void eif_destroy_once_per_process (void); 

/* Private structures declarations */

/****************************************
 * Structures containing information    *
 * about once features.                 *
 ****************************************/
 
/*
 * Structure used as the Functions computed Once per Process List.
 * This is a linked list used
 * to store the once per process result value and it is indexed by the
 * function addresses of the onces per thread.
 */
 
struct fop_list {
        char *addr;     	 /* Index in the list. Here it is
							*	 the once per thread
                            * function address */
        EIF_REFERENCE * val;             /* Value of the once per process */
        struct fop_list *next;  /* Link to the next element in the list */
};
 
 
/*
 * Structure used as the Procedures computed Once per Process List.
 * This is a linked list used
 * to store the once per process result value and it is indexed by the
 * function addresses of the onces per thread.
 */
 
struct pop_list {
        char *addr;                             /* Index in the list. Here it is the once per thread
                                                         * procedure address */
        struct pop_list *next; /* Link to the next element in the list */
};

rt_private struct pop_list **eif_pop_table = (struct pop_list **) 0; /* Table containing the list of struct pop_list */
rt_private struct fop_list **eif_fop_table = (struct fop_list **) 0; /* Table containing list of struct fop_list */
rt_private EIF_REFERENCE *eif_once_set_addr (EIF_REFERENCE once);
	/* Get stack address of "once" from "once_set". */

/* Private functions declarations */

/****************************************
 * Creations of onces per process lists *
 ****************************************/

/* Mutex for accessing the `eif_pop_table' */
rt_private EIF_MUTEX_TYPE *eif_pop_table_mutex = (EIF_MUTEX_TYPE *) 0;

/* We have to declare a mutex for accessing the `eif_fop_table' 
 * otherwise several threads can access and modify it  */
rt_private EIF_MUTEX_TYPE *eif_fop_table_mutex = (EIF_MUTEX_TYPE *) 0;

rt_private struct fop_list *init_fop_list (EIF_REFERENCE_FUNCTION feature_address); 
	/* Creates and returns a pointer on a new 'fop_list' */
	
rt_private struct pop_list *init_pop_list (EIF_PROCEDURE feature_address); 
	/* creates and returns a pointer on a new 'pop_list' */
 
/* For reclaiming eif_pop_table and eif_fop_table */
rt_private void eif_destroy_fop_list (struct fop_list *list);	/* destroy a fop_list */
rt_private void eif_destroy_pop_list (struct pop_list *list); 	/* destroy a pop_list */ 

/* Implementations */

rt_private struct fop_list *init_fop_list (EIF_REFERENCE_FUNCTION feature_address)
{
	/* Creates and initializes a pointer on a new struct fop_list 
	 * (first call of once function). 		 
	 * The Result of the once function is not computed here.
	 */

	struct fop_list *new;
	 	
		/* call eif_malloc (malloc in MT-mode) instead  of cmalloc
		 * otherwise the fop_list will be allocated in the allocating
		 * thread context (and reclaimed in the end)
		 */
	new = (struct fop_list *) eif_malloc (sizeof (struct fop_list));
	if (new == (struct fop_list *) 0)
		/* Out of memory */
		enomem();

	new->addr = (char *) feature_address ;
	new->val = (EIF_REFERENCE *) 0;
	new->next = (struct fop_list *) 0;
	return new;
} /* init_fop_list */	


rt_private struct pop_list *init_pop_list(EIF_PROCEDURE feature_address)
{
	/* Creates a new 'pop_list'
	 * (first call of once procedure). 				 
	 * The once procedure is not executed here. 
	 */

        struct pop_list *new;
 
		/* call eif_malloc (malloc in MT-mode) instead  of cmalloc
		 * otherwise the fop_list will be allocated in the allocating
		 * thread context (and reclaimed in the end)
		 */
        new = (struct pop_list *) eif_malloc (sizeof (struct pop_list));
        if (new == (struct pop_list *) 0)
                /* Out of memory */
                enomem();
 
        new->addr = (char *) feature_address ;
        new->next = (struct pop_list *) 0;

        return new;
} /* init_pop_list */

rt_private EIF_REFERENCE *eif_once_set_addr (EIF_REFERENCE once) 
{
	/* Similar to "hector_addr" from hector.c. This returns 
	 * the indirection pointer from "once_set" corresponding to 
	 * the once object "once". Maybe we should implement a generic
	 * function instead. 
	 */

	EIF_GET_CONTEXT	/* MT-safe */
	register1 int nb_items;			/* Number of items in arena */
	register2 struct stchunk *s;	/* To walk through each stack's chunk */
	register3 char **arena;			/* Current arena in chunk */
	int done = 0;					/* Top of stack not reached yet */

	for (s = once_set.st_hd; s && !done; s = s->sk_next) 
	{
		arena = s->sk_arena;				/* Start of stack */
		if (s != once_set.st_cur)			/* Before current position? */
			nb_items = s->sk_end - arena;	/* Take the whole chunk */
		else {
			nb_items = once_set.st_top - arena;	/* Stop at the top */
			done = 1;								/* Reached end of stack */
		}
		for (; nb_items > 0; nb_items--, arena++)
			if (*arena == once)						/* Found indirection */
			{
				EIF_END_GET_CONTEXT	/* MT-safe */
				return (EIF_REFERENCE *) arena;				/* Return indirection ptr */
			}
	}	
	
} /* eif_once_set_addr */

rt_public EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_POINTER  function_ptr)
{					/* Current object */
								/* feature address of once function (called with $ operator) */

	/* Returns the evaluation of once feature pointed by 'feature_address' 
	 * if it is the first call in the process, 
	 * else returns the value of feature stored in 'eif_fop_table'. 
	 * We use an hash table 'eif_fop_table' which is a table of
	 * list of 'fop_list'; the key of the table is the last
     * four bits of 'feature_address' i.e lists are ordered
	 * by features addresses modulo OP_TABLE_SIZE. Therefore, the features
	 * with the same key are in the same list, then we have to
	 * skim this list  to find the relevant 'fop_list' if it is the first
	 * call, else a new 'fop_list' is added at the end of the list
	 * with 'new_fop_list'. 
	 */ 



	struct fop_list *list; /* Current pointer on struct fop_list 
				* containing information about feature */ 


	EIF_REFERENCE_FUNCTION feature_address = (EIF_REFERENCE_FUNCTION) function_ptr; /* need to cast function_ptr for C-ANSI conformance */

	EIF_MUTEX_CREATE(eif_fop_table_mutex, "Couldn't create mutex for once per process management\n");
	
	EIF_MUTEX_LOCK(eif_fop_table_mutex,"Couldn't lock mutex for once per process management\n");

#ifdef DEBUG
	printf ("DEBUG: Entering eif_global_function\n");
#endif

	if (!eif_fop_table) {
		/* Creates an empty 'eif_fop_table' if necessary*/
#ifdef DEBUG
	printf ("DEBUG: Creation of eif_fop_table\n");
#endif
		eif_fop_table = (struct fop_list **) eif_malloc ((OP_TABLE_SIZE+1) * sizeof (struct fop_list *));

		if (eif_fop_table == (struct fop_list **) 0)
			/* Out of memory */
			enomem();

		bzero((struct fop_list *) eif_fop_table, OP_TABLE_SIZE * sizeof (struct fop_list *));
	}

	list = eif_fop_table [((uint32) feature_address) & OP_TABLE_SIZE]; /* Binary operation so as to point on the correct place in 'eif_fop_table'  */ 
#ifdef DEBUG
	printf ("DEBUG: feature address : %x & OP_TABLE_SIZE: %d\n = %d\n", feature_address, OP_TABLE_SIZE, ((uint32) feature_address) & OP_TABLE_SIZE);
#endif
				
	if (list == (struct fop_list *) 0) {
		/* First call of feature once in process*/
#ifdef DEBUG
	printf ("DEBUG: First call of feature once in process and creation of object\n");
#endif
		list = (struct fop_list *) init_fop_list (feature_address);
		list->val = (EIF_REFERENCE *) eif_once_set_addr ( (char *) (feature_address (eif_access (Current))));

		eif_fop_table [((uint32) feature_address) & OP_TABLE_SIZE] = list;
		EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex");
		return ((EIF_REFERENCE) eif_access (list->val));	

	} else {

		while (list->addr != (char *) feature_address) {
			/* loop skimming the list of struct fop_list */
#ifdef DEBUG
	printf ("DEBUG: Skimming fop_list\n");
#endif
			if (list->next == (struct fop_list *) 0) {
#ifdef DEBUG
	printf ("DEBUG: Not found in fop_list\n");
#endif
				list->next =(struct fop_list *) init_fop_list (feature_address);

#ifdef DEBUG
	printf ("DEBUG: Creation of once object\n");
#endif
				list->next->val = (EIF_REFERENCE *) eif_once_set_addr (feature_address (eif_access (Current)));
				EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex\n");
		return ((EIF_REFERENCE) eif_access (list->next->val));	
			}
#ifdef DEBUG
	printf ("DEBUG: Found in skimming fop list\n");
#endif
			list = list->next;
		}
		/* it is not the first call of feature once in process*/
#ifdef DEBUG
	printf ("DEBUG: Not first call of feature once in process\n");
#endif
		EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex\n");

		/* if the thread that created the global once dies,
		 * it will remove the once object when reclaiming. 
		 * In this case, it raises either a segmentation fault,
		 * call to void feature exception or the following exception
		 * (if first call in the thread, i think)
		 */

		if (!(list->val)) eraise ("Global once removed with creator thread death\n", EN_EXT);
		return (EIF_REFERENCE) eif_access (list->val);
	}

}

rt_public void eif_global_procedure (EIF_REFERENCE Current, EIF_POINTER proc_ptr)
				/* Current object */
							/* Feature address of once procedure (called with $ operator) */
{
	/* Same function as `eif_global_function' but adapted for once
	 * procedure.
	 * Search the address 'feature_address' in the 'eif_pop_table' and	
         * evaluates the once feature pointed by this address  
         * if it is the first call in the process, else does nothing.
	 * 'eif_pop_table' is a hash table of list of list of 'pop_list'
	 * with the 'feature_address' modulo OP_TABLE_SIZE as key as 'eif_fop_table' 
 	 */

        struct pop_list *list; /* current pointer on struct pop_list containing information about feature */
 
	EIF_PROCEDURE feature_address = (EIF_PROCEDURE) proc_ptr; /* need to cast proc_ptr for C-ANSI conformance */

#ifdef DEBUG
	printf ("DEBUG: Entering eif_global_procedure\n");
#endif
	EIF_MUTEX_CREATE(eif_pop_table_mutex, "Couldn't create mutex for once per process table\n");
	
	EIF_MUTEX_LOCK(eif_pop_table_mutex,"Couldn't lock mutex for once per process table\n");


        if (!eif_pop_table) {
                /* Creates an empty eif_pop_table if necessary*/
#ifdef DEBUG
	printf ("DEBUG: Creation of eif_pop_table\n");
#endif
                eif_pop_table = (struct pop_list **) eif_malloc ((OP_TABLE_SIZE+1) * sizeof (struct pop_list *));
 
                if (eif_pop_table == (struct pop_list **) 0)
                        /* Out of memory */
                        enomem();
 
                bzero((struct pop_list *) eif_pop_table, OP_TABLE_SIZE * sizeof (struct pop_list *));
        }
 

        list = eif_pop_table [ (uint32) feature_address & OP_TABLE_SIZE];	/* binary operation so as to 
									 *point on the correct place in 'eif_pop_table'
									 */
 
#ifdef DEBUG
	printf ("DEBUG: procedure address : %x & OP_TABLE_SIZE: %d\n = %d\n", feature_address, OP_TABLE_SIZE, ((uint32) feature_address) & OP_TABLE_SIZE);
#endif
        if (list == (struct pop_list *) 0) {
                /* First call of procedure once in process */
                list = (struct pop_list *) init_pop_list (feature_address);
	        /* The once procedure is executed here. */
		eif_pop_table [((uint32) feature_address) & OP_TABLE_SIZE] = list;
        feature_address (eif_access (Current));

        } else {
 
                while (list->addr != (char *) feature_address) {
                        /* loop skimming the list of struct pop_list */
                        if (list->next == (struct pop_list *) 0) {
                                list->next = (struct pop_list *) init_pop_list (feature_address);
        			/* The once procedure is executed here. */
        			feature_address (eif_access (Current));

                        }
			list = list->next;
                }
        }  

	EIF_MUTEX_UNLOCK(eif_pop_table_mutex, "Couldn't unlock once per process table mutex");
}	/* eif_global_procedure */


rt_shared void eif_destroy_once_per_process (void)
	/* Destroy the mutex `eif_fop_table_mutex' and `eif_pop_table_mutex'
	 * and free the once per process tables
	 */
{   
	int i; /* for loop */

#ifdef DEBUG
	printf ("DEBUG: Entering eif_destroy_once_per_process\n");
#endif

	if (eif_fop_table) {   
#ifdef DEBUG
	printf ("DEBUG: Destroying fop_table\n");
#endif
		for ( i = 0; i <= OP_TABLE_SIZE; i++) {
#ifdef DEBUG
	printf ("DEBUG: destroy fop_list no %d in fop_table\n", i);
#endif
			eif_destroy_fop_list (eif_fop_table[i]); /* destroy the linked list of fop_list */
	}
		eif_free (eif_fop_table);	/* free once per proc. functions table */
		if (eif_fop_table_mutex) /* free access mutex to eif_fop_table */
			EIF_MUTEX_DESTROY(eif_fop_table_mutex,"Couldn't destroy once per process table mutex\n");
	}

	if (eif_pop_table) {   
#ifdef DEBUG
	printf ("DEBUG: Destroying pop_table\n");
#endif
		for ( i = 0; i <= OP_TABLE_SIZE; i++) {
#ifdef DEBUG
	printf ("DEBUG: destroy pop_list no %d in pop_table\n", i);
#endif
			eif_destroy_pop_list (eif_pop_table[i]); /* destroy the linked list of pop_list */

}
		eif_free (eif_pop_table); /* free once per proc. procedures table */
		if (eif_pop_table_mutex) /* free access mutex to eif_pop_table */
			EIF_MUTEX_DESTROY(eif_pop_table_mutex,"Couldn't destroy once per process table mutex\n");
	}
} /* eif_destroy_once_per_process */
	
rt_private void eif_destroy_fop_list (struct fop_list *list)
	/* free recursively the linked list of fop_list pointed by `list' */
{
	struct fop_list *l, *ln; /* for loop */


#ifdef DEBUG
	printf ("-|	DEBUG: Entering eif_destroy_fop_list\n");
#endif
	for (l = list; l != (struct fop_list *) 0; l = ln)
		{
		ln = l->next;
		
		/* do not free l->val because allocated in the chunk list */ 
#ifdef DEBUG
	printf ("-|	DEBUG: Free list %x in fop_list\n", l);
#endif
		eif_free (l);
		}
} /* eif_destroy_fop_list */

rt_private void eif_destroy_pop_list (struct pop_list *list)
	/* free recursively the linked list of pop_list pointed by `list' */
{
	struct pop_list *l, *ln; /* for loop */

#ifdef DEBUG
	printf ("-|	DEBUG: Entering eif_destroy_pop_list\n");
#endif
	for (l = list; l != (struct pop_list *) 0; l = ln)
		{
		ln = l->next;
#ifdef DEBUG
	printf ("-|	DEBUG: Free list %x in pop_list\n", l);
#endif
		eif_free (l);
		}
} /* eif_destroy_pop_list */

#endif /* EIF_THREADS */

#ifdef __cplusplus
}
#endif
