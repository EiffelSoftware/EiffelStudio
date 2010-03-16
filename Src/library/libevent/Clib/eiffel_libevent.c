/*
indexing
	description: "Functions used by the class LIBEVENT_HANDLER."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eiffel_libevent.h"

typedef void (* EIF_EVCB_FUCTION) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* Eiffel object */
#endif
	EIF_INTEGER
	);

/* Release Eiffel CURL_FUNCTION object address */
//void c_release_object()
//{
	//eif_wean (eiffel_function_object);
//}

/* Direct C callback */
void c_event_callback(int fd, short event, void *arg)
{
	EIF_EVCBDATAP l_cb_data = (EIF_EVCBDATAP)arg;
	EIF_EVCB_FUCTION l_func = (EIF_EVCB_FUCTION)l_cb_data->func;
	if (l_func != NULL) {
		(l_func (
#ifndef EIF_IL_DLL
				eif_access (l_cb_data->o),
#endif
				event
			)
		);
	}
}
