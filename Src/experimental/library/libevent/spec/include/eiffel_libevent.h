#ifndef _EIFFEL_LIBEVENT_H_
#define _EIFFEL_LIBEVENT_H_

#include "eif_eiffel.h"
#include "event.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Type definition for callback data.*/
typedef struct _eif_ev_callback_data {
	EIF_OBJECT o;  /* Eiffel object to perform callback on. */
	void *func; /* Function pointer to an Eiffel function. */
} eif_ev_callback_data;

#define EIF_EVCBDATA eif_ev_callback_data
#define EIF_EVCBDATAP eif_ev_callback_data*

/* C callback of all events, which will take `arg' as a EIF_EVCBDATAP
   and call the Eiffel routine. */
void c_event_callback(int fd, short event, void *arg);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* _EIFFEL_LIBEVENT_H_ */
