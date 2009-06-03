#include "eif_eiffel.h"

/* Types */
typedef void (* EIF_NOTIFY_PROC) (EIF_REFERENCE, EIF_INTEGER, EIF_POINTER);

/* Messages */
#define EIF_UI_APPLICATION_DID_FINISH_LAUNCHING 1

/* Routines */
extern void eiffel_iphone_set_dispatcher (EIF_OBJECT, EIF_NOTIFY_PROC);
