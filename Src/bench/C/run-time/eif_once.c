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
#include "eif_globals.h"	/* EIF_GET_ROOT_CONTEXT */
#include "eif_threads.h"	/* mutex */

#define OP_TABLE_SIZE 0x4 /* size of Once per Process Tables */

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS /* Features making sense only in MT-Mode */

/* Public features declarations */

rt_public EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_REFERENCE (*feature_address) (EIF_REFERENCE));

rt_public void eif_global_procedure (EIF_REFERENCE Current, void * (*feature_address) (EIF_REFERENCE));
rt_shared void eif_destroy_once_per_process (void); /* shared?? FIXME */

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
        EIF_REFERENCE val;             /* Value of the once per process: FIXME * removed on val */
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

/* Private functions declarations */

/****************************************
 * Creations of onces per process lists *
 ****************************************/

/* Mutex for accessing the `eif_pop_table' */
rt_private EIF_MUTEX_TYPE *eif_pop_table_mutex;

/* We have to declare a mutex for accessing the `eif_fop_table' 
 * otherwise several threads can access and modify it  */
rt_private EIF_MUTEX_TYPE *eif_fop_table_mutex;

rt_private struct fop_list *init_fop_list (EIF_REFERENCE (*feature_address) (EIF_REFERENCE)); 
	/* Creates and returns a pointer on a new 'fop_list' */
	
rt_private struct pop_list *init_pop_list (void * (*feature_address) (EIF_REFERENCE)); 
	/* creates and returns a pointer on a new 'pop_list' */
 
/* For reclaiming eif_pop_table and eif_fop_table */
rt_private void eif_destroy_fop_list (struct fop_list *list);	/* destroy a fop_list */
rt_private void eif_destroy_pop_list (struct pop_list *list); 	/* destroy a pop_list */ 

/* Implementations */

rt_private struct fop_list *init_fop_list (EIF_REFERENCE (*feature_address) (EIF_REFERENCE))
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
	new->val = (EIF_REFERENCE) 0;
	new->next = (struct fop_list *) 0;
	return new;
} /* init_fop_list */	


rt_private struct pop_list *init_pop_list(void * (*feature_address) (EIF_REFERENCE))
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



rt_public EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_REFERENCE (*feature_address) (EIF_REFERENCE))
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



	EIF_REFERENCE result;
	struct fop_list *list; /* Current pointer on struct fop_list 
				* containing information about feature */ 


	EIF_MUTEX_CREATE(eif_fop_table_mutex, "Couldn't create mutex for once per process management\n");
	
	EIF_MUTEX_LOCK(eif_fop_table_mutex,"Couldn't lock mutex for once per process management\n");

	if (!eif_fop_table) {
		/* Creates an empty 'eif_fop_table' if necessary*/
		eif_fop_table = (struct fop_list **) eif_malloc (OP_TABLE_SIZE * sizeof (struct fop_list *));

		if (eif_fop_table == (struct fop_list **) 0)
			/* Out of memory */
			enomem();

		bzero((struct fop_list *) eif_fop_table, OP_TABLE_SIZE * sizeof (struct fop_list *));
	}

	list = eif_fop_table [((uint32) feature_address) & OP_TABLE_SIZE]; /* Binary operation so as to point on the correct place in 'eif_fop_table'  */ 
				
	if (list == (struct fop_list *) 0) {
		/* First call of feature once in process*/
		list = (struct fop_list *) init_fop_list (feature_address);
		result = (char *) (FUNCTION_CAST(EIF_REFERENCE, (EIF_REFERENCE)) feature_address (eif_access (Current)));

	   	      /* a copy of result is put in eif_fop_table
		       * we do not want the original object reference 
		       * since it can be removed with the thread that has created it
		       */
		list->val = edclone (result); 
		eif_fop_table [((uint32) feature_address) & OP_TABLE_SIZE] = list;
		EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex");
		return result;

	} else {

		while (list->addr != (char *) feature_address) {
			/* loop skimming the list of struct fop_list */
			if (list->next == (struct fop_list *) 0) {
				list->next =(struct fop_list *) init_fop_list (feature_address);
				result= (char *) (FUNCTION_CAST(EIF_REFERENCE, (EIF_REFERENCE)) feature_address (eif_access (Current)));

					/* same comments as above: a copy is put in eif_fop_table */
				list->next->val = edclone (result);
				EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex\n");
				return result;
			}
			list = list->next;
		}
		/* it is not the first call of feature once in process*/
		EIF_MUTEX_UNLOCK(eif_fop_table_mutex, "Couldn't unlock once per process table mutex\n");

		/* if the thread that created the global once dies,
		 * it will remove the once object when reclaiming. 
		 * In this case, it raises either a segmentation fault,
		 * call to void feature exception or the following exception
		 * (if first call in the thread, i think)
		 */

		if (!(list->val)) eif_thr_panic ("Global once removed with creator thread death\n");
			/* do not return the original because it can 
			 * be NULL if the creator of the object thread
			 * has been removed 
			 */

			
		return list->val;
	}

}

rt_public void eif_global_procedure (EIF_REFERENCE Current, void * (*feature_address) (EIF_REFERENCE))
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
 

	EIF_MUTEX_CREATE(eif_pop_table_mutex, "Couldn't create mutex for once per process table\n");
	
	EIF_MUTEX_LOCK(eif_pop_table_mutex,"Couldn't lock mutex for once per process table\n");


        if (!eif_pop_table) {
                /* Creates an empty eif_pop_table if necessary*/
                eif_pop_table = (struct pop_list **) eif_malloc (OP_TABLE_SIZE * sizeof (struct pop_list *));
 
                if (eif_pop_table == (struct pop_list **) 0)
                        /* Out of memory */
                        enomem();
 
                bzero((struct pop_list *) eif_pop_table, OP_TABLE_SIZE * sizeof (struct pop_list *));
        }
 

        list = eif_pop_table [ (uint32) feature_address & OP_TABLE_SIZE];	/* binary operation so as to 
									 *point on the correct place in 'eif_pop_table'
									 */
 
        if (list == (struct pop_list *) 0) {
                /* First call of procedure once in process */
                list = (struct pop_list *) init_pop_list (feature_address);
	        /* The once procedure is executed here. */
		eif_pop_table [((uint32) feature_address) & OP_TABLE_SIZE] = list;
        	(FUNCTION_CAST (void, (EIF_REFERENCE)) feature_address (eif_access (Current)));

        } else {
 
                while (list->addr != (char *) feature_address) {
                        /* loop skimming the list of struct pop_list */
                        if (list->next == (struct pop_list *) 0) {
                                list->next = (struct pop_list *) init_pop_list (feature_address);
        			/* The once procedure is executed here. */
        			(FUNCTION_CAST (void, (EIF_REFERENCE)) feature_address (eif_access (Current)));

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

	if (eif_fop_table) {   
		for ( i = 0; i < OP_TABLE_SIZE; i++) 
			eif_destroy_fop_list (eif_fop_table[i]); /* destroy the linked list of fop_list */
		eif_free (eif_fop_table);	/* free once per proc. functions table */
		if (eif_fop_table_mutex) /* free access mutex to eif_fop_table */
			EIF_MUTEX_DESTROY(eif_fop_table_mutex,"Couldn't destroy once per process table mutex\n");
	}

	if (eif_pop_table) {   
		for ( i = 0; i < OP_TABLE_SIZE; i++) 
			eif_destroy_pop_list (eif_pop_table[i]); /* destroy the linked list of pop_list */
		eif_free (eif_pop_table); /* free once per proc. procedures table */
		if (eif_pop_table_mutex) /* free access mutex to eif_pop_table */
			EIF_MUTEX_DESTROY(eif_pop_table_mutex,"Couldn't destroy once per process table mutex\n");
	}
} /* eif_destroy_once_per_process */
	
rt_private void eif_destroy_fop_list (struct fop_list *list)
	/* free recursively the linked list of fop_list pointed by `list' */
{
	struct fop_list *l, *ln; /* for loop */

	for (l = list; l != (struct fop_list *) 0; l = ln)
		{
		ln = l->next;
		
		eif_free (l->addr);
		/* do not free l->val because allocated in the chunk list */ 
		eif_free (l);
		}
} /* eif_destroy_fop_list */

rt_private void eif_destroy_pop_list (struct pop_list *list)
	/* free recursively the linked list of pop_list pointed by `list' */
{
	struct pop_list *l, *ln; /* for loop */

	for (l = list; l != (struct pop_list *) 0; l = ln)
		{
		ln = l->next;
		eif_free (l);
		}
} /* eif_destroy_pop_list */

#endif /* EIF_THREADS */

#ifdef __cplusplus
}
#endif
