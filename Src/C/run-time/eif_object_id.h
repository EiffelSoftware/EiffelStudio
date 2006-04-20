/*
	description: "Object id externals."
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
