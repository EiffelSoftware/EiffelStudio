/*
indexing
	description: "C features for Application Delegate"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2009, Eiffel Software and Others."
*/

#include "eiffel_iphone.h"

#include "UIKit/UIKit.h"

static EIF_NOTIFY_PROC eiffel_dispatcher_proc = NULL;
static EIF_OBJECT eiffel_dispatcher_obj = NULL;

rt_public void eiffel_iphone_set_dispatcher (EIF_OBJECT disp, EIF_NOTIFY_PROC proc) {
	eiffel_dispatcher_obj = eif_adopt(disp);
	eiffel_dispatcher_proc = proc;
}

@interface EiffeliPhoneAppDelegate : NSObject <UIApplicationDelegate> {
}
@end

@implementation EiffeliPhoneAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	eiffel_dispatcher_proc (eif_access(eiffel_dispatcher_obj), EIF_UI_APPLICATION_DID_FINISH_LAUNCHING, application);
}

@end
