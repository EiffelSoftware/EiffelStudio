#ifndef _eiffel_iphone_h_
#define _eiffel_iphone_h_

#include "eif_eiffel.h"
#include <UIKit/UIKit.h>

/* Types */
typedef void (* EIF_NOTIFY_PROC) (EIF_REFERENCE, EIF_INTEGER, EIF_POINTER);
typedef struct eif_touches_event_tags
{
	NSSet *touches;
	UIEvent *event;
} eif_touches_event_t;

/* Messages */
#define EIF_UI_APPLICATION_DID_FINISH_LAUNCHING		1
#define EIF_UI_RESPONDER_TOUCHES_BEGAN			2
#define EIF_UI_RESPONDER_TOUCHES_MOVED			3
#define EIF_UI_RESPONDER_TOUCHES_CANCELLED		4
#define EIF_UI_RESPONDER_TOUCHES_ENDED			5

/* Routines */
extern void eiffel_iphone_set_dispatcher (EIF_OBJECT, EIF_NOTIFY_PROC);

#endif
