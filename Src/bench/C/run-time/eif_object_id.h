
/*
    Object id externals
*/

#ifndef _eif_object_id_h_
#define _eif_object_id_h_

#ifdef __cplusplus
extern "C" {
#endif
 
extern struct stack object_id_stack;	/* Stack where objects referenced through `object_id' are stored
										 * See class IDENTIFIED */	

extern EIF_INTEGER eif_object_id(EIF_REFERENCE object);			/* Get a new id for the object, assuming it is NOT in the stack*/
extern EIF_INTEGER eif_general_object_id(EIF_REFERENCE object); /* Get an id for the object, sequential search first */
extern EIF_REFERENCE eif_id_object(EIF_INTEGER id);		/* returns the object associated with the id */
extern void eif_object_id_free(EIF_INTEGER id);			/* removes the object from the stack */

/* externals for class IDENTIFIED_CONTROLLER */

extern EIF_INTEGER eif_object_id_stack_size (void); /* retruns the size in chunk of the object_id stack */
extern void eif_extend_object_id_stack (EIF_INTEGER nb_chunks);	/* extends of `nb_chunks' the size of the object_id_stack */

extern void print_object_id_stack (void);
#ifdef CONCURRENT_EIFFEL
extern struct stack separate_object_id_set; /* keeps track of objects referenced in other processors */

extern EIF_INTEGER eif_separate_object_id(EIF_REFERENCE object);	/* Get an id for the object, sequential search first */
extern EIF_REFERENCE eif_separate_id_object(EIF_INTEGER id);	/* returns the object associated with the id */
extern void eif_separate_object_id_free(EIF_INTEGER id);		/* removes the object from the stack */

#endif

#ifdef __cplusplus
}
#endif

#endif
