/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
 *   Object id externals
 */

#ifndef _eif_object_id_h_
#define _eif_object_id_h_

#ifdef __cplusplus
extern "C" {
#endif
 
RT_LNK EIF_INTEGER eif_object_id(EIF_OBJECT object);			/* Get a new id for the object, assuming it is NOT in the stack*/
extern EIF_INTEGER eif_general_object_id(EIF_OBJECT object); /* Get an id for the object, sequential search first */
RT_LNK EIF_REFERENCE eif_id_object(EIF_INTEGER id);		/* returns the object associated with the id */
RT_LNK void eif_object_id_free(EIF_INTEGER id);			/* removes the object from the stack */

/* externals for class IDENTIFIED_CONTROLLER */

RT_LNK EIF_INTEGER eif_object_id_stack_size (void); /* retruns the size in chunk of the object_id stack */
RT_LNK void eif_extend_object_id_stack (EIF_INTEGER nb_chunks);	/* extends of `nb_chunks' the size of the object_id_stack */

extern void print_object_id_stack (void);

#ifdef CONCURRENT_EIFFEL
extern EIF_INTEGER eif_separate_object_id(EIF_OBJECT object);	/* Get an id for the object, sequential search first */
extern EIF_REFERENCE eif_separate_id_object(EIF_INTEGER id);	/* returns the object associated with the id */
extern void eif_separate_object_id_free(EIF_INTEGER id);		/* removes the object from the stack */
#endif

#ifdef __cplusplus
}
#endif

#endif
