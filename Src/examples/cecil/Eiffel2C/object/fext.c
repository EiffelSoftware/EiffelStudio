#include <stdio.h>
#include "eif_eiffel.h"	/* for CECIL features */
#include "fext.h"

EIF_OBJECT eiffel_object = (EIF_OBJECT) 0;	/* Eiffel object given to C */

EIF_REFERENCE reference_from_c () {
	/* Return the saved Eiffel reference */
	if (eiffel_object == (EIF_OBJECT) 0) {
		printf (" No reference given to C \n");
		return (EIF_REFERENCE) 0;
	}
	return eif_access (eiffel_object);
}

void give_to_c_by_pointer (EIF_POINTER p) {
	/* Reference from C the direct reference to the Eiffel object `p'*/
	eiffel_object = eif_protect ((EIF_REFERENCE) p);	/* Protect `p' */
}

void give_to_c (EIF_OBJECT o) {
	/* Reference from C the given Eiffel object */
	eiffel_object = eif_adopt (o);	/* Protect `o' */
}

void forget_from_c () {
	/* Release the reference to the Eiffel object from C */
	eif_wean (eiffel_object);	/* Release static indirection to eiffel object */
}	

void notice_dispose () {
	/* Notice that we are disposing an Eiffel object of type OBJECT 
	 * We cannot call `io.put_string' directly from the Eiffel side
	 * since `io' can be already collected.
	 */

	printf ("An Eiffel object of type OBJECT is collected\n");
}

