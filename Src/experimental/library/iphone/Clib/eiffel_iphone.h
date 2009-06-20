#ifndef _eiffel_iphone_h_
#define _eiffel_iphone_h_

#include "eif_eiffel.h"
#include <UIKit/UIKit.h>

/* Types */
typedef void (* EIF_NOTIFY_PROC) (EIF_REFERENCE, EIF_INTEGER, EIF_POINTER);
typedef struct eif_touches_event_tags
{
	void *obj;
	NSSet *touches;
	UIEvent *event;
} eif_touches_event_t;

typedef struct eif_motion_event_tags
{
	void *obj;
	UIEventSubtype motion;
	UIEvent *event;
} eif_motion_event_t;

/* Messages */
#define EIF_UI_APPLICATION_DID_FINISH_LAUNCHING		1
#define EIF_UI_RESPONDER_TOUCHES_BEGAN			2
#define EIF_UI_RESPONDER_TOUCHES_MOVED			3
#define EIF_UI_RESPONDER_TOUCHES_CANCELLED		4
#define EIF_UI_RESPONDER_TOUCHES_ENDED			5
#define EIF_UI_RESPONDER_MOTION_BEGAN			6
#define EIF_UI_RESPONDER_MOTION_CANCELLED		7
#define EIF_UI_RESPONDER_MOTION_ENDED			8
#define EIF_UI_ACCELEROMETER_MSG			9

/* Routines */
extern void eiffel_iphone_set_dispatcher (EIF_OBJECT, EIF_NOTIFY_PROC);

/* Objective C stuff */
@protocol EiffelIdentified
- (int) eiffel_object_id;
@end



#endif
