/*
indexing
	description: "C features for Application Delegate"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2009, Eiffel Software and Others."
*/

#include "eiffel_iphone.h"

/*********************************************************************************/
/*********************************************************************************/
/* Eiffel/C interface                                                            */
/*********************************************************************************/
/*********************************************************************************/

static EIF_NOTIFY_PROC eiffel_dispatcher_proc = NULL;
static EIF_OBJECT eiffel_dispatcher_obj = NULL;

rt_public void eiffel_iphone_set_dispatcher (EIF_OBJECT disp, EIF_NOTIFY_PROC proc)
{
	eiffel_dispatcher_obj = eif_adopt(disp);
	eiffel_dispatcher_proc = proc;
}

rt_public EIF_INTEGER eiffel_object_id (EIF_POINTER obj) {
	if ([(id)obj conformsToProtocol:@protocol(EiffelIdentified)]) {
		int *m = (int *) object_getIndexedIvars((id)obj);
		return (EIF_INTEGER) *m;
	} else {
		return -1;
	}
}

/*********************************************************************************/
/*********************************************************************************/
/* Cocoa Interfaces used for wrapper                                             */
/*********************************************************************************/
/*********************************************************************************/

@interface EiffeliPhoneDelegate : NSObject <UIApplicationDelegate,UIAccelerometerDelegate> {
}
@end

@interface EiffelUIApplication : UIApplication {
}
@end

/*********************************************************************************/
/*********************************************************************************/
/* Cocoa Classes used for wrapper                                                */
/*********************************************************************************/
/*********************************************************************************/

@implementation EiffeliPhoneDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_APPLICATION_DID_FINISH_LAUNCHING, application);
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_ACCELEROMETER_MSG, acceleration);
}

@end

@implementation EiffelUIApplication
- (int) eiffel_object_id
{
	int *m = (int *) object_getIndexedIvars(self);
	return *m;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	eif_touches_event_t data;
	data.obj = self;
	data.touches = touches;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_TOUCHES_BEGAN, &data);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	eif_touches_event_t data;
	data.obj = self;
	data.touches = touches;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_TOUCHES_MOVED, &data);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	eif_touches_event_t data;
	data.obj = self;
	data.touches = touches;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_TOUCHES_CANCELLED, &data);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	eif_touches_event_t data;
	data.obj = self;
	data.touches = touches;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_TOUCHES_ENDED, &data);
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	eif_motion_event_t data;
	data.obj = self;
	data.motion = motion;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_MOTION_BEGAN, &data);
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	eif_motion_event_t data;
	data.obj = self;
	data.motion = motion;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_MOTION_CANCELLED, &data);
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	eif_motion_event_t data;
	data.obj = self;
	data.motion = motion;
	data.event = event;
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_RESPONDER_MOTION_ENDED, &data);
}

@end
