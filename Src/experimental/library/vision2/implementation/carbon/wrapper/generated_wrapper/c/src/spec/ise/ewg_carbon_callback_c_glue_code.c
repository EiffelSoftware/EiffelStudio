#include <ewg_eiffel.h>
#include <ewg_carbon_callback_c_glue_code.h>

#ifdef _MSC_VER
#pragma warning (disable:4715) // Not all control paths return a value
#endif
struct cgdata_provider_release_data_callback_entry_struct cgdata_provider_release_data_callback_entry = {NULL, NULL};

void cgdata_provider_release_data_callback_stub (void *info, void const *data, size_t size)
{
	if (cgdata_provider_release_data_callback_entry.a_class != NULL && cgdata_provider_release_data_callback_entry.feature != NULL)
	{
		cgdata_provider_release_data_callback_entry.feature (eif_access(cgdata_provider_release_data_callback_entry.a_class), info, data, size);
	}
}

void set_cgdata_provider_release_data_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_release_data_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_release_data_callback_entry.feature = (cgdata_provider_release_data_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_release_data_callback_stub ()
{
	return (void*) cgdata_provider_release_data_callback_stub;
}

void call_cgdata_provider_release_data_callback (void *a_function, void *info, void const *data, size_t size)
{
	((void (*) (void *info, void const *data, size_t size))a_function) (info, data, size);
}

struct cgpath_applier_function_entry_struct cgpath_applier_function_entry = {NULL, NULL};

void cgpath_applier_function_stub (void *info, CGPathElement const *element)
{
	if (cgpath_applier_function_entry.a_class != NULL && cgpath_applier_function_entry.feature != NULL)
	{
		cgpath_applier_function_entry.feature (eif_access(cgpath_applier_function_entry.a_class), info, element);
	}
}

void set_cgpath_applier_function_entry (void* a_class, void* a_feature)
{
	cgpath_applier_function_entry.a_class = eif_adopt(a_class);
	cgpath_applier_function_entry.feature = (cgpath_applier_function_eiffel_feature) a_feature;
}

void* get_cgpath_applier_function_stub ()
{
	return (void*) cgpath_applier_function_stub;
}

void call_cgpath_applier_function (void *a_function, void *info, CGPathElement const *element)
{
	((void (*) (void *info, CGPathElement const *element))a_function) (info, element);
}

struct aecoerce_desc_proc_ptr_entry_struct aecoerce_desc_proc_ptr_entry = {NULL, NULL};

OSErr aecoerce_desc_proc_ptr_stub (AEDesc const *fromDesc, DescType toType, long handlerRefcon, AEDesc *toDesc)
{
	if (aecoerce_desc_proc_ptr_entry.a_class != NULL && aecoerce_desc_proc_ptr_entry.feature != NULL)
	{
		return aecoerce_desc_proc_ptr_entry.feature (eif_access(aecoerce_desc_proc_ptr_entry.a_class), fromDesc, toType, handlerRefcon, toDesc);
	}
}

void set_aecoerce_desc_proc_ptr_entry (void* a_class, void* a_feature)
{
	aecoerce_desc_proc_ptr_entry.a_class = eif_adopt(a_class);
	aecoerce_desc_proc_ptr_entry.feature = (aecoerce_desc_proc_ptr_eiffel_feature) a_feature;
}

void* get_aecoerce_desc_proc_ptr_stub ()
{
	return (void*) aecoerce_desc_proc_ptr_stub;
}

OSErr call_aecoerce_desc_proc_ptr (void *a_function, AEDesc const *fromDesc, DescType toType, long handlerRefcon, AEDesc *toDesc)
{
	return ((OSErr (*) (AEDesc const *fromDesc, DescType toType, long handlerRefcon, AEDesc *toDesc))a_function) (fromDesc, toType, handlerRefcon, toDesc);
}

struct aecoerce_ptr_proc_ptr_entry_struct aecoerce_ptr_proc_ptr_entry = {NULL, NULL};

OSErr aecoerce_ptr_proc_ptr_stub (DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, long handlerRefcon, AEDesc *result)
{
	if (aecoerce_ptr_proc_ptr_entry.a_class != NULL && aecoerce_ptr_proc_ptr_entry.feature != NULL)
	{
		return aecoerce_ptr_proc_ptr_entry.feature (eif_access(aecoerce_ptr_proc_ptr_entry.a_class), typeCode, dataPtr, dataSize, toType, handlerRefcon, result);
	}
}

void set_aecoerce_ptr_proc_ptr_entry (void* a_class, void* a_feature)
{
	aecoerce_ptr_proc_ptr_entry.a_class = eif_adopt(a_class);
	aecoerce_ptr_proc_ptr_entry.feature = (aecoerce_ptr_proc_ptr_eiffel_feature) a_feature;
}

void* get_aecoerce_ptr_proc_ptr_stub ()
{
	return (void*) aecoerce_ptr_proc_ptr_stub;
}

OSErr call_aecoerce_ptr_proc_ptr (void *a_function, DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, long handlerRefcon, AEDesc *result)
{
	return ((OSErr (*) (DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, long handlerRefcon, AEDesc *result))a_function) (typeCode, dataPtr, dataSize, toType, handlerRefcon, result);
}

struct aedispose_external_proc_ptr_entry_struct aedispose_external_proc_ptr_entry = {NULL, NULL};

void aedispose_external_proc_ptr_stub (void const *dataPtr, Size dataLength, long refcon)
{
	if (aedispose_external_proc_ptr_entry.a_class != NULL && aedispose_external_proc_ptr_entry.feature != NULL)
	{
		aedispose_external_proc_ptr_entry.feature (eif_access(aedispose_external_proc_ptr_entry.a_class), dataPtr, dataLength, refcon);
	}
}

void set_aedispose_external_proc_ptr_entry (void* a_class, void* a_feature)
{
	aedispose_external_proc_ptr_entry.a_class = eif_adopt(a_class);
	aedispose_external_proc_ptr_entry.feature = (aedispose_external_proc_ptr_eiffel_feature) a_feature;
}

void* get_aedispose_external_proc_ptr_stub ()
{
	return (void*) aedispose_external_proc_ptr_stub;
}

void call_aedispose_external_proc_ptr (void *a_function, void const *dataPtr, Size dataLength, long refcon)
{
	((void (*) (void const *dataPtr, Size dataLength, long refcon))a_function) (dataPtr, dataLength, refcon);
}

struct aeevent_handler_proc_ptr_entry_struct aeevent_handler_proc_ptr_entry = {NULL, NULL};

OSErr aeevent_handler_proc_ptr_stub (AppleEvent const *theAppleEvent, AppleEvent *reply, long handlerRefcon)
{
	if (aeevent_handler_proc_ptr_entry.a_class != NULL && aeevent_handler_proc_ptr_entry.feature != NULL)
	{
		return aeevent_handler_proc_ptr_entry.feature (eif_access(aeevent_handler_proc_ptr_entry.a_class), theAppleEvent, reply, handlerRefcon);
	}
}

void set_aeevent_handler_proc_ptr_entry (void* a_class, void* a_feature)
{
	aeevent_handler_proc_ptr_entry.a_class = eif_adopt(a_class);
	aeevent_handler_proc_ptr_entry.feature = (aeevent_handler_proc_ptr_eiffel_feature) a_feature;
}

void* get_aeevent_handler_proc_ptr_stub ()
{
	return (void*) aeevent_handler_proc_ptr_stub;
}

OSErr call_aeevent_handler_proc_ptr (void *a_function, AppleEvent const *theAppleEvent, AppleEvent *reply, long handlerRefcon)
{
	return ((OSErr (*) (AppleEvent const *theAppleEvent, AppleEvent *reply, long handlerRefcon))a_function) (theAppleEvent, reply, handlerRefcon);
}

struct aeremote_process_resolver_callback_entry_struct aeremote_process_resolver_callback_entry = {NULL, NULL};

void aeremote_process_resolver_callback_stub (AERemoteProcessResolverRef ref, void *info)
{
	if (aeremote_process_resolver_callback_entry.a_class != NULL && aeremote_process_resolver_callback_entry.feature != NULL)
	{
		aeremote_process_resolver_callback_entry.feature (eif_access(aeremote_process_resolver_callback_entry.a_class), ref, info);
	}
}

void set_aeremote_process_resolver_callback_entry (void* a_class, void* a_feature)
{
	aeremote_process_resolver_callback_entry.a_class = eif_adopt(a_class);
	aeremote_process_resolver_callback_entry.feature = (aeremote_process_resolver_callback_eiffel_feature) a_feature;
}

void* get_aeremote_process_resolver_callback_stub ()
{
	return (void*) aeremote_process_resolver_callback_stub;
}

void call_aeremote_process_resolver_callback (void *a_function, AERemoteProcessResolverRef ref, void *info)
{
	((void (*) (AERemoteProcessResolverRef ref, void *info))a_function) (ref, info);
}

struct event_comparator_proc_ptr_entry_struct event_comparator_proc_ptr_entry = {NULL, NULL};

Boolean event_comparator_proc_ptr_stub (EventRef inEvent, void *inCompareData)
{
	if (event_comparator_proc_ptr_entry.a_class != NULL && event_comparator_proc_ptr_entry.feature != NULL)
	{
		return event_comparator_proc_ptr_entry.feature (eif_access(event_comparator_proc_ptr_entry.a_class), inEvent, inCompareData);
	}
}

void set_event_comparator_proc_ptr_entry (void* a_class, void* a_feature)
{
	event_comparator_proc_ptr_entry.a_class = eif_adopt(a_class);
	event_comparator_proc_ptr_entry.feature = (event_comparator_proc_ptr_eiffel_feature) a_feature;
}

void* get_event_comparator_proc_ptr_stub ()
{
	return (void*) event_comparator_proc_ptr_stub;
}

Boolean call_event_comparator_proc_ptr (void *a_function, EventRef inEvent, void *inCompareData)
{
	return ((Boolean (*) (EventRef inEvent, void *inCompareData))a_function) (inEvent, inCompareData);
}

struct event_loop_timer_proc_ptr_entry_struct event_loop_timer_proc_ptr_entry = {NULL, NULL};

void event_loop_timer_proc_ptr_stub (EventLoopTimerRef inTimer, void *inUserData)
{
	if (event_loop_timer_proc_ptr_entry.a_class != NULL && event_loop_timer_proc_ptr_entry.feature != NULL)
	{
		event_loop_timer_proc_ptr_entry.feature (eif_access(event_loop_timer_proc_ptr_entry.a_class), inTimer, inUserData);
	}
}

void set_event_loop_timer_proc_ptr_entry (void* a_class, void* a_feature)
{
	event_loop_timer_proc_ptr_entry.a_class = eif_adopt(a_class);
	event_loop_timer_proc_ptr_entry.feature = (event_loop_timer_proc_ptr_eiffel_feature) a_feature;
}

void* get_event_loop_timer_proc_ptr_stub ()
{
	return (void*) event_loop_timer_proc_ptr_stub;
}

void call_event_loop_timer_proc_ptr (void *a_function, EventLoopTimerRef inTimer, void *inUserData)
{
	((void (*) (EventLoopTimerRef inTimer, void *inUserData))a_function) (inTimer, inUserData);
}

struct event_loop_idle_timer_proc_ptr_entry_struct event_loop_idle_timer_proc_ptr_entry = {NULL, NULL};

void event_loop_idle_timer_proc_ptr_stub (EventLoopTimerRef inTimer, EventLoopIdleTimerMessage inState, void *inUserData)
{
	if (event_loop_idle_timer_proc_ptr_entry.a_class != NULL && event_loop_idle_timer_proc_ptr_entry.feature != NULL)
	{
		event_loop_idle_timer_proc_ptr_entry.feature (eif_access(event_loop_idle_timer_proc_ptr_entry.a_class), inTimer, inState, inUserData);
	}
}

void set_event_loop_idle_timer_proc_ptr_entry (void* a_class, void* a_feature)
{
	event_loop_idle_timer_proc_ptr_entry.a_class = eif_adopt(a_class);
	event_loop_idle_timer_proc_ptr_entry.feature = (event_loop_idle_timer_proc_ptr_eiffel_feature) a_feature;
}

void* get_event_loop_idle_timer_proc_ptr_stub ()
{
	return (void*) event_loop_idle_timer_proc_ptr_stub;
}

void call_event_loop_idle_timer_proc_ptr (void *a_function, EventLoopTimerRef inTimer, EventLoopIdleTimerMessage inState, void *inUserData)
{
	((void (*) (EventLoopTimerRef inTimer, EventLoopIdleTimerMessage inState, void *inUserData))a_function) (inTimer, inState, inUserData);
}

struct event_handler_proc_ptr_entry_struct event_handler_proc_ptr_entry = {NULL, NULL};

OSStatus event_handler_proc_ptr_stub (EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData)
{
	if (event_handler_proc_ptr_entry.a_class != NULL && event_handler_proc_ptr_entry.feature != NULL)
	{
		return event_handler_proc_ptr_entry.feature (eif_access(event_handler_proc_ptr_entry.a_class), inHandlerCallRef, inEvent, inUserData);
	}
}

void set_event_handler_proc_ptr_entry (void* a_class, void* a_feature)
{
	event_handler_proc_ptr_entry.a_class = eif_adopt(a_class);
	event_handler_proc_ptr_entry.feature = (event_handler_proc_ptr_eiffel_feature) a_feature;
}

void* get_event_handler_proc_ptr_stub ()
{
	return (void*) event_handler_proc_ptr_stub;
}

OSStatus call_event_handler_proc_ptr (void *a_function, EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData)
{
	return ((OSStatus (*) (EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData))a_function) (inHandlerCallRef, inEvent, inUserData);
}

struct menu_def_proc_ptr_entry_struct menu_def_proc_ptr_entry = {NULL, NULL};

void menu_def_proc_ptr_stub (short message, MenuRef theMenu, Rect *menuRect, Point hitPt, short *whichItem)
{
	if (menu_def_proc_ptr_entry.a_class != NULL && menu_def_proc_ptr_entry.feature != NULL)
	{
		menu_def_proc_ptr_entry.feature (eif_access(menu_def_proc_ptr_entry.a_class), message, theMenu, menuRect, hitPt, whichItem);
	}
}

void set_menu_def_proc_ptr_entry (void* a_class, void* a_feature)
{
	menu_def_proc_ptr_entry.a_class = eif_adopt(a_class);
	menu_def_proc_ptr_entry.feature = (menu_def_proc_ptr_eiffel_feature) a_feature;
}

void* get_menu_def_proc_ptr_stub ()
{
	return (void*) menu_def_proc_ptr_stub;
}

void call_menu_def_proc_ptr (void *a_function, short message, MenuRef theMenu, Rect *menuRect, Point hitPt, short *whichItem)
{
	((void (*) (short message, MenuRef theMenu, Rect *menuRect, Point hitPt, short *whichItem))a_function) (message, theMenu, menuRect, hitPt, whichItem);
}

struct control_action_proc_ptr_entry_struct control_action_proc_ptr_entry = {NULL, NULL};

void control_action_proc_ptr_stub (ControlRef theControl, ControlPartCode partCode)
{
	if (control_action_proc_ptr_entry.a_class != NULL && control_action_proc_ptr_entry.feature != NULL)
	{
		control_action_proc_ptr_entry.feature (eif_access(control_action_proc_ptr_entry.a_class), theControl, partCode);
	}
}

void set_control_action_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_action_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_action_proc_ptr_entry.feature = (control_action_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_action_proc_ptr_stub ()
{
	return (void*) control_action_proc_ptr_stub;
}

void call_control_action_proc_ptr (void *a_function, ControlRef theControl, ControlPartCode partCode)
{
	((void (*) (ControlRef theControl, ControlPartCode partCode))a_function) (theControl, partCode);
}

struct control_def_proc_ptr_entry_struct control_def_proc_ptr_entry = {NULL, NULL};

SInt32 control_def_proc_ptr_stub (SInt16 varCode, ControlRef theControl, ControlDefProcMessage message, SInt32 param)
{
	if (control_def_proc_ptr_entry.a_class != NULL && control_def_proc_ptr_entry.feature != NULL)
	{
		return control_def_proc_ptr_entry.feature (eif_access(control_def_proc_ptr_entry.a_class), varCode, theControl, message, param);
	}
}

void set_control_def_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_def_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_def_proc_ptr_entry.feature = (control_def_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_def_proc_ptr_stub ()
{
	return (void*) control_def_proc_ptr_stub;
}

SInt32 call_control_def_proc_ptr (void *a_function, SInt16 varCode, ControlRef theControl, ControlDefProcMessage message, SInt32 param)
{
	return ((SInt32 (*) (SInt16 varCode, ControlRef theControl, ControlDefProcMessage message, SInt32 param))a_function) (varCode, theControl, message, param);
}

struct control_key_filter_proc_ptr_entry_struct control_key_filter_proc_ptr_entry = {NULL, NULL};

ControlKeyFilterResult control_key_filter_proc_ptr_stub (ControlRef theControl, SInt16 *keyCode, SInt16 *charCode, EventModifiers *modifiers)
{
	if (control_key_filter_proc_ptr_entry.a_class != NULL && control_key_filter_proc_ptr_entry.feature != NULL)
	{
		return control_key_filter_proc_ptr_entry.feature (eif_access(control_key_filter_proc_ptr_entry.a_class), theControl, keyCode, charCode, modifiers);
	}
}

void set_control_key_filter_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_key_filter_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_key_filter_proc_ptr_entry.feature = (control_key_filter_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_key_filter_proc_ptr_stub ()
{
	return (void*) control_key_filter_proc_ptr_stub;
}

ControlKeyFilterResult call_control_key_filter_proc_ptr (void *a_function, ControlRef theControl, SInt16 *keyCode, SInt16 *charCode, EventModifiers *modifiers)
{
	return ((ControlKeyFilterResult (*) (ControlRef theControl, SInt16 *keyCode, SInt16 *charCode, EventModifiers *modifiers))a_function) (theControl, keyCode, charCode, modifiers);
}

struct control_cntlto_collection_proc_ptr_entry_struct control_cntlto_collection_proc_ptr_entry = {NULL, NULL};

OSStatus control_cntlto_collection_proc_ptr_stub (Rect const *bounds, SInt16 value, Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon, ConstStr255Param title, Collection collection)
{
	if (control_cntlto_collection_proc_ptr_entry.a_class != NULL && control_cntlto_collection_proc_ptr_entry.feature != NULL)
	{
		return control_cntlto_collection_proc_ptr_entry.feature (eif_access(control_cntlto_collection_proc_ptr_entry.a_class), bounds, value, visible, max, min, procID, refCon, title, collection);
	}
}

void set_control_cntlto_collection_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_cntlto_collection_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_cntlto_collection_proc_ptr_entry.feature = (control_cntlto_collection_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_cntlto_collection_proc_ptr_stub ()
{
	return (void*) control_cntlto_collection_proc_ptr_stub;
}

OSStatus call_control_cntlto_collection_proc_ptr (void *a_function, Rect const *bounds, SInt16 value, Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon, ConstStr255Param title, Collection collection)
{
	return ((OSStatus (*) (Rect const *bounds, SInt16 value, Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon, ConstStr255Param title, Collection collection))a_function) (bounds, value, visible, max, min, procID, refCon, title, collection);
}

struct control_color_proc_ptr_entry_struct control_color_proc_ptr_entry = {NULL, NULL};

OSStatus control_color_proc_ptr_stub (ControlRef inControl, SInt16 inMessage, SInt16 inDrawDepth, Boolean inDrawInColor)
{
	if (control_color_proc_ptr_entry.a_class != NULL && control_color_proc_ptr_entry.feature != NULL)
	{
		return control_color_proc_ptr_entry.feature (eif_access(control_color_proc_ptr_entry.a_class), inControl, inMessage, inDrawDepth, inDrawInColor);
	}
}

void set_control_color_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_color_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_color_proc_ptr_entry.feature = (control_color_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_color_proc_ptr_stub ()
{
	return (void*) control_color_proc_ptr_stub;
}

OSStatus call_control_color_proc_ptr (void *a_function, ControlRef inControl, SInt16 inMessage, SInt16 inDrawDepth, Boolean inDrawInColor)
{
	return ((OSStatus (*) (ControlRef inControl, SInt16 inMessage, SInt16 inDrawDepth, Boolean inDrawInColor))a_function) (inControl, inMessage, inDrawDepth, inDrawInColor);
}

struct window_def_proc_ptr_entry_struct window_def_proc_ptr_entry = {NULL, NULL};

long window_def_proc_ptr_stub (short varCode, WindowRef window, short message, long param)
{
	if (window_def_proc_ptr_entry.a_class != NULL && window_def_proc_ptr_entry.feature != NULL)
	{
		return window_def_proc_ptr_entry.feature (eif_access(window_def_proc_ptr_entry.a_class), varCode, window, message, param);
	}
}

void set_window_def_proc_ptr_entry (void* a_class, void* a_feature)
{
	window_def_proc_ptr_entry.a_class = eif_adopt(a_class);
	window_def_proc_ptr_entry.feature = (window_def_proc_ptr_eiffel_feature) a_feature;
}

void* get_window_def_proc_ptr_stub ()
{
	return (void*) window_def_proc_ptr_stub;
}

long call_window_def_proc_ptr (void *a_function, short varCode, WindowRef window, short message, long param)
{
	return ((long (*) (short varCode, WindowRef window, short message, long param))a_function) (varCode, window, message, param);
}

struct window_paint_proc_ptr_entry_struct window_paint_proc_ptr_entry = {NULL, NULL};

OSStatus window_paint_proc_ptr_stub (GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon)
{
	if (window_paint_proc_ptr_entry.a_class != NULL && window_paint_proc_ptr_entry.feature != NULL)
	{
		return window_paint_proc_ptr_entry.feature (eif_access(window_paint_proc_ptr_entry.a_class), device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon);
	}
}

void set_window_paint_proc_ptr_entry (void* a_class, void* a_feature)
{
	window_paint_proc_ptr_entry.a_class = eif_adopt(a_class);
	window_paint_proc_ptr_entry.feature = (window_paint_proc_ptr_eiffel_feature) a_feature;
}

void* get_window_paint_proc_ptr_stub ()
{
	return (void*) window_paint_proc_ptr_stub;
}

OSStatus call_window_paint_proc_ptr (void *a_function, GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon)
{
	return ((OSStatus (*) (GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon))a_function) (device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon);
}

struct txnfind_proc_ptr_entry_struct txnfind_proc_ptr_entry = {NULL, NULL};

OSStatus txnfind_proc_ptr_stub (TXNMatchTextRecord const *matchData, TXNDataType iDataType, TXNMatchOptions iMatchOptions, void const *iSearchTextPtr, TextEncoding encoding, TXNOffset absStartOffset, ByteCount searchTextLength, TXNOffset *oStartMatch, TXNOffset *oEndMatch, Boolean *ofound, UInt32 refCon)
{
	if (txnfind_proc_ptr_entry.a_class != NULL && txnfind_proc_ptr_entry.feature != NULL)
	{
		return txnfind_proc_ptr_entry.feature (eif_access(txnfind_proc_ptr_entry.a_class), matchData, iDataType, iMatchOptions, iSearchTextPtr, encoding, absStartOffset, searchTextLength, oStartMatch, oEndMatch, ofound, refCon);
	}
}

void set_txnfind_proc_ptr_entry (void* a_class, void* a_feature)
{
	txnfind_proc_ptr_entry.a_class = eif_adopt(a_class);
	txnfind_proc_ptr_entry.feature = (txnfind_proc_ptr_eiffel_feature) a_feature;
}

void* get_txnfind_proc_ptr_stub ()
{
	return (void*) txnfind_proc_ptr_stub;
}

OSStatus call_txnfind_proc_ptr (void *a_function, TXNMatchTextRecord const *matchData, TXNDataType iDataType, TXNMatchOptions iMatchOptions, void const *iSearchTextPtr, TextEncoding encoding, TXNOffset absStartOffset, ByteCount searchTextLength, TXNOffset *oStartMatch, TXNOffset *oEndMatch, Boolean *ofound, UInt32 refCon)
{
	return ((OSStatus (*) (TXNMatchTextRecord const *matchData, TXNDataType iDataType, TXNMatchOptions iMatchOptions, void const *iSearchTextPtr, TextEncoding encoding, TXNOffset absStartOffset, ByteCount searchTextLength, TXNOffset *oStartMatch, TXNOffset *oEndMatch, Boolean *ofound, UInt32 refCon))a_function) (matchData, iDataType, iMatchOptions, iSearchTextPtr, encoding, absStartOffset, searchTextLength, oStartMatch, oEndMatch, ofound, refCon);
}

struct txnaction_name_mapper_proc_ptr_entry_struct txnaction_name_mapper_proc_ptr_entry = {NULL, NULL};

CFStringRef txnaction_name_mapper_proc_ptr_stub (CFStringRef actionName, UInt32 commandID, void *inUserData)
{
	if (txnaction_name_mapper_proc_ptr_entry.a_class != NULL && txnaction_name_mapper_proc_ptr_entry.feature != NULL)
	{
		return txnaction_name_mapper_proc_ptr_entry.feature (eif_access(txnaction_name_mapper_proc_ptr_entry.a_class), actionName, commandID, inUserData);
	}
}

void set_txnaction_name_mapper_proc_ptr_entry (void* a_class, void* a_feature)
{
	txnaction_name_mapper_proc_ptr_entry.a_class = eif_adopt(a_class);
	txnaction_name_mapper_proc_ptr_entry.feature = (txnaction_name_mapper_proc_ptr_eiffel_feature) a_feature;
}

void* get_txnaction_name_mapper_proc_ptr_stub ()
{
	return (void*) txnaction_name_mapper_proc_ptr_stub;
}

CFStringRef call_txnaction_name_mapper_proc_ptr (void *a_function, CFStringRef actionName, UInt32 commandID, void *inUserData)
{
	return ((CFStringRef (*) (CFStringRef actionName, UInt32 commandID, void *inUserData))a_function) (actionName, commandID, inUserData);
}

struct txncontextual_menu_setup_proc_ptr_entry_struct txncontextual_menu_setup_proc_ptr_entry = {NULL, NULL};

void txncontextual_menu_setup_proc_ptr_stub (MenuRef iContextualMenu, TXNObject object, void *inUserData)
{
	if (txncontextual_menu_setup_proc_ptr_entry.a_class != NULL && txncontextual_menu_setup_proc_ptr_entry.feature != NULL)
	{
		txncontextual_menu_setup_proc_ptr_entry.feature (eif_access(txncontextual_menu_setup_proc_ptr_entry.a_class), iContextualMenu, object, inUserData);
	}
}

void set_txncontextual_menu_setup_proc_ptr_entry (void* a_class, void* a_feature)
{
	txncontextual_menu_setup_proc_ptr_entry.a_class = eif_adopt(a_class);
	txncontextual_menu_setup_proc_ptr_entry.feature = (txncontextual_menu_setup_proc_ptr_eiffel_feature) a_feature;
}

void* get_txncontextual_menu_setup_proc_ptr_stub ()
{
	return (void*) txncontextual_menu_setup_proc_ptr_stub;
}

void call_txncontextual_menu_setup_proc_ptr (void *a_function, MenuRef iContextualMenu, TXNObject object, void *inUserData)
{
	((void (*) (MenuRef iContextualMenu, TXNObject object, void *inUserData))a_function) (iContextualMenu, object, inUserData);
}

struct txnscroll_info_proc_ptr_entry_struct txnscroll_info_proc_ptr_entry = {NULL, NULL};

void txnscroll_info_proc_ptr_stub (SInt32 iValue, SInt32 iMaximumValue, TXNScrollBarOrientation iScrollBarOrientation, SInt32 iRefCon)
{
	if (txnscroll_info_proc_ptr_entry.a_class != NULL && txnscroll_info_proc_ptr_entry.feature != NULL)
	{
		txnscroll_info_proc_ptr_entry.feature (eif_access(txnscroll_info_proc_ptr_entry.a_class), iValue, iMaximumValue, iScrollBarOrientation, iRefCon);
	}
}

void set_txnscroll_info_proc_ptr_entry (void* a_class, void* a_feature)
{
	txnscroll_info_proc_ptr_entry.a_class = eif_adopt(a_class);
	txnscroll_info_proc_ptr_entry.feature = (txnscroll_info_proc_ptr_eiffel_feature) a_feature;
}

void* get_txnscroll_info_proc_ptr_stub ()
{
	return (void*) txnscroll_info_proc_ptr_stub;
}

void call_txnscroll_info_proc_ptr (void *a_function, SInt32 iValue, SInt32 iMaximumValue, TXNScrollBarOrientation iScrollBarOrientation, SInt32 iRefCon)
{
	((void (*) (SInt32 iValue, SInt32 iMaximumValue, TXNScrollBarOrientation iScrollBarOrientation, SInt32 iRefCon))a_function) (iValue, iMaximumValue, iScrollBarOrientation, iRefCon);
}

struct txnaction_key_mapper_proc_ptr_entry_struct txnaction_key_mapper_proc_ptr_entry = {NULL, NULL};

CFStringRef txnaction_key_mapper_proc_ptr_stub (TXNActionKey actionKey, UInt32 commandID)
{
	if (txnaction_key_mapper_proc_ptr_entry.a_class != NULL && txnaction_key_mapper_proc_ptr_entry.feature != NULL)
	{
		return txnaction_key_mapper_proc_ptr_entry.feature (eif_access(txnaction_key_mapper_proc_ptr_entry.a_class), actionKey, commandID);
	}
}

void set_txnaction_key_mapper_proc_ptr_entry (void* a_class, void* a_feature)
{
	txnaction_key_mapper_proc_ptr_entry.a_class = eif_adopt(a_class);
	txnaction_key_mapper_proc_ptr_entry.feature = (txnaction_key_mapper_proc_ptr_eiffel_feature) a_feature;
}

void* get_txnaction_key_mapper_proc_ptr_stub ()
{
	return (void*) txnaction_key_mapper_proc_ptr_stub;
}

CFStringRef call_txnaction_key_mapper_proc_ptr (void *a_function, TXNActionKey actionKey, UInt32 commandID)
{
	return ((CFStringRef (*) (TXNActionKey actionKey, UInt32 commandID))a_function) (actionKey, commandID);
}

struct hmcontrol_content_proc_ptr_entry_struct hmcontrol_content_proc_ptr_entry = {NULL, NULL};

OSStatus hmcontrol_content_proc_ptr_stub (ControlRef inControl, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	if (hmcontrol_content_proc_ptr_entry.a_class != NULL && hmcontrol_content_proc_ptr_entry.feature != NULL)
	{
		return hmcontrol_content_proc_ptr_entry.feature (eif_access(hmcontrol_content_proc_ptr_entry.a_class), inControl, inGlobalMouse, inRequest, outContentProvided, ioHelpContent);
	}
}

void set_hmcontrol_content_proc_ptr_entry (void* a_class, void* a_feature)
{
	hmcontrol_content_proc_ptr_entry.a_class = eif_adopt(a_class);
	hmcontrol_content_proc_ptr_entry.feature = (hmcontrol_content_proc_ptr_eiffel_feature) a_feature;
}

void* get_hmcontrol_content_proc_ptr_stub ()
{
	return (void*) hmcontrol_content_proc_ptr_stub;
}

OSStatus call_hmcontrol_content_proc_ptr (void *a_function, ControlRef inControl, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	return ((OSStatus (*) (ControlRef inControl, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent))a_function) (inControl, inGlobalMouse, inRequest, outContentProvided, ioHelpContent);
}

struct hmwindow_content_proc_ptr_entry_struct hmwindow_content_proc_ptr_entry = {NULL, NULL};

OSStatus hmwindow_content_proc_ptr_stub (WindowRef inWindow, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	if (hmwindow_content_proc_ptr_entry.a_class != NULL && hmwindow_content_proc_ptr_entry.feature != NULL)
	{
		return hmwindow_content_proc_ptr_entry.feature (eif_access(hmwindow_content_proc_ptr_entry.a_class), inWindow, inGlobalMouse, inRequest, outContentProvided, ioHelpContent);
	}
}

void set_hmwindow_content_proc_ptr_entry (void* a_class, void* a_feature)
{
	hmwindow_content_proc_ptr_entry.a_class = eif_adopt(a_class);
	hmwindow_content_proc_ptr_entry.feature = (hmwindow_content_proc_ptr_eiffel_feature) a_feature;
}

void* get_hmwindow_content_proc_ptr_stub ()
{
	return (void*) hmwindow_content_proc_ptr_stub;
}

OSStatus call_hmwindow_content_proc_ptr (void *a_function, WindowRef inWindow, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	return ((OSStatus (*) (WindowRef inWindow, Point inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent))a_function) (inWindow, inGlobalMouse, inRequest, outContentProvided, ioHelpContent);
}

struct hmmenu_title_content_proc_ptr_entry_struct hmmenu_title_content_proc_ptr_entry = {NULL, NULL};

OSStatus hmmenu_title_content_proc_ptr_stub (MenuRef inMenu, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	if (hmmenu_title_content_proc_ptr_entry.a_class != NULL && hmmenu_title_content_proc_ptr_entry.feature != NULL)
	{
		return hmmenu_title_content_proc_ptr_entry.feature (eif_access(hmmenu_title_content_proc_ptr_entry.a_class), inMenu, inRequest, outContentProvided, ioHelpContent);
	}
}

void set_hmmenu_title_content_proc_ptr_entry (void* a_class, void* a_feature)
{
	hmmenu_title_content_proc_ptr_entry.a_class = eif_adopt(a_class);
	hmmenu_title_content_proc_ptr_entry.feature = (hmmenu_title_content_proc_ptr_eiffel_feature) a_feature;
}

void* get_hmmenu_title_content_proc_ptr_stub ()
{
	return (void*) hmmenu_title_content_proc_ptr_stub;
}

OSStatus call_hmmenu_title_content_proc_ptr (void *a_function, MenuRef inMenu, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	return ((OSStatus (*) (MenuRef inMenu, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent))a_function) (inMenu, inRequest, outContentProvided, ioHelpContent);
}

struct hmmenu_item_content_proc_ptr_entry_struct hmmenu_item_content_proc_ptr_entry = {NULL, NULL};

OSStatus hmmenu_item_content_proc_ptr_stub (MenuTrackingData const *inTrackingData, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	if (hmmenu_item_content_proc_ptr_entry.a_class != NULL && hmmenu_item_content_proc_ptr_entry.feature != NULL)
	{
		return hmmenu_item_content_proc_ptr_entry.feature (eif_access(hmmenu_item_content_proc_ptr_entry.a_class), inTrackingData, inRequest, outContentProvided, ioHelpContent);
	}
}

void set_hmmenu_item_content_proc_ptr_entry (void* a_class, void* a_feature)
{
	hmmenu_item_content_proc_ptr_entry.a_class = eif_adopt(a_class);
	hmmenu_item_content_proc_ptr_entry.feature = (hmmenu_item_content_proc_ptr_eiffel_feature) a_feature;
}

void* get_hmmenu_item_content_proc_ptr_stub ()
{
	return (void*) hmmenu_item_content_proc_ptr_stub;
}

OSStatus call_hmmenu_item_content_proc_ptr (void *a_function, MenuTrackingData const *inTrackingData, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	return ((OSStatus (*) (MenuTrackingData const *inTrackingData, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent))a_function) (inTrackingData, inRequest, outContentProvided, ioHelpContent);
}

struct control_user_pane_draw_proc_ptr_entry_struct control_user_pane_draw_proc_ptr_entry = {NULL, NULL};

void control_user_pane_draw_proc_ptr_stub (ControlRef control, SInt16 part)
{
	if (control_user_pane_draw_proc_ptr_entry.a_class != NULL && control_user_pane_draw_proc_ptr_entry.feature != NULL)
	{
		control_user_pane_draw_proc_ptr_entry.feature (eif_access(control_user_pane_draw_proc_ptr_entry.a_class), control, part);
	}
}

void set_control_user_pane_draw_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_draw_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_draw_proc_ptr_entry.feature = (control_user_pane_draw_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_draw_proc_ptr_stub ()
{
	return (void*) control_user_pane_draw_proc_ptr_stub;
}

void call_control_user_pane_draw_proc_ptr (void *a_function, ControlRef control, SInt16 part)
{
	((void (*) (ControlRef control, SInt16 part))a_function) (control, part);
}

struct control_user_pane_hit_test_proc_ptr_entry_struct control_user_pane_hit_test_proc_ptr_entry = {NULL, NULL};

ControlPartCode control_user_pane_hit_test_proc_ptr_stub (ControlRef control, Point where)
{
	if (control_user_pane_hit_test_proc_ptr_entry.a_class != NULL && control_user_pane_hit_test_proc_ptr_entry.feature != NULL)
	{
		return control_user_pane_hit_test_proc_ptr_entry.feature (eif_access(control_user_pane_hit_test_proc_ptr_entry.a_class), control, where);
	}
}

void set_control_user_pane_hit_test_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_hit_test_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_hit_test_proc_ptr_entry.feature = (control_user_pane_hit_test_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_hit_test_proc_ptr_stub ()
{
	return (void*) control_user_pane_hit_test_proc_ptr_stub;
}

ControlPartCode call_control_user_pane_hit_test_proc_ptr (void *a_function, ControlRef control, Point where)
{
	return ((ControlPartCode (*) (ControlRef control, Point where))a_function) (control, where);
}

struct control_user_pane_tracking_proc_ptr_entry_struct control_user_pane_tracking_proc_ptr_entry = {NULL, NULL};

ControlPartCode control_user_pane_tracking_proc_ptr_stub (ControlRef control, Point startPt, ControlActionUPP actionProc)
{
	if (control_user_pane_tracking_proc_ptr_entry.a_class != NULL && control_user_pane_tracking_proc_ptr_entry.feature != NULL)
	{
		return control_user_pane_tracking_proc_ptr_entry.feature (eif_access(control_user_pane_tracking_proc_ptr_entry.a_class), control, startPt, actionProc);
	}
}

void set_control_user_pane_tracking_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_tracking_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_tracking_proc_ptr_entry.feature = (control_user_pane_tracking_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_tracking_proc_ptr_stub ()
{
	return (void*) control_user_pane_tracking_proc_ptr_stub;
}

ControlPartCode call_control_user_pane_tracking_proc_ptr (void *a_function, ControlRef control, Point startPt, ControlActionUPP actionProc)
{
	return ((ControlPartCode (*) (ControlRef control, Point startPt, ControlActionUPP actionProc))a_function) (control, startPt, actionProc);
}

struct control_user_pane_idle_proc_ptr_entry_struct control_user_pane_idle_proc_ptr_entry = {NULL, NULL};

void control_user_pane_idle_proc_ptr_stub (ControlRef control)
{
	if (control_user_pane_idle_proc_ptr_entry.a_class != NULL && control_user_pane_idle_proc_ptr_entry.feature != NULL)
	{
		control_user_pane_idle_proc_ptr_entry.feature (eif_access(control_user_pane_idle_proc_ptr_entry.a_class), control);
	}
}

void set_control_user_pane_idle_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_idle_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_idle_proc_ptr_entry.feature = (control_user_pane_idle_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_idle_proc_ptr_stub ()
{
	return (void*) control_user_pane_idle_proc_ptr_stub;
}

void call_control_user_pane_idle_proc_ptr (void *a_function, ControlRef control)
{
	((void (*) (ControlRef control))a_function) (control);
}

struct control_user_pane_key_down_proc_ptr_entry_struct control_user_pane_key_down_proc_ptr_entry = {NULL, NULL};

ControlPartCode control_user_pane_key_down_proc_ptr_stub (ControlRef control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers)
{
	if (control_user_pane_key_down_proc_ptr_entry.a_class != NULL && control_user_pane_key_down_proc_ptr_entry.feature != NULL)
	{
		return control_user_pane_key_down_proc_ptr_entry.feature (eif_access(control_user_pane_key_down_proc_ptr_entry.a_class), control, keyCode, charCode, modifiers);
	}
}

void set_control_user_pane_key_down_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_key_down_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_key_down_proc_ptr_entry.feature = (control_user_pane_key_down_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_key_down_proc_ptr_stub ()
{
	return (void*) control_user_pane_key_down_proc_ptr_stub;
}

ControlPartCode call_control_user_pane_key_down_proc_ptr (void *a_function, ControlRef control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers)
{
	return ((ControlPartCode (*) (ControlRef control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers))a_function) (control, keyCode, charCode, modifiers);
}

struct control_user_pane_activate_proc_ptr_entry_struct control_user_pane_activate_proc_ptr_entry = {NULL, NULL};

void control_user_pane_activate_proc_ptr_stub (ControlRef control, Boolean activating)
{
	if (control_user_pane_activate_proc_ptr_entry.a_class != NULL && control_user_pane_activate_proc_ptr_entry.feature != NULL)
	{
		control_user_pane_activate_proc_ptr_entry.feature (eif_access(control_user_pane_activate_proc_ptr_entry.a_class), control, activating);
	}
}

void set_control_user_pane_activate_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_activate_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_activate_proc_ptr_entry.feature = (control_user_pane_activate_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_activate_proc_ptr_stub ()
{
	return (void*) control_user_pane_activate_proc_ptr_stub;
}

void call_control_user_pane_activate_proc_ptr (void *a_function, ControlRef control, Boolean activating)
{
	((void (*) (ControlRef control, Boolean activating))a_function) (control, activating);
}

struct control_user_pane_focus_proc_ptr_entry_struct control_user_pane_focus_proc_ptr_entry = {NULL, NULL};

ControlPartCode control_user_pane_focus_proc_ptr_stub (ControlRef control, ControlFocusPart action)
{
	if (control_user_pane_focus_proc_ptr_entry.a_class != NULL && control_user_pane_focus_proc_ptr_entry.feature != NULL)
	{
		return control_user_pane_focus_proc_ptr_entry.feature (eif_access(control_user_pane_focus_proc_ptr_entry.a_class), control, action);
	}
}

void set_control_user_pane_focus_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_focus_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_focus_proc_ptr_entry.feature = (control_user_pane_focus_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_focus_proc_ptr_stub ()
{
	return (void*) control_user_pane_focus_proc_ptr_stub;
}

ControlPartCode call_control_user_pane_focus_proc_ptr (void *a_function, ControlRef control, ControlFocusPart action)
{
	return ((ControlPartCode (*) (ControlRef control, ControlFocusPart action))a_function) (control, action);
}

struct control_user_pane_background_proc_ptr_entry_struct control_user_pane_background_proc_ptr_entry = {NULL, NULL};

void control_user_pane_background_proc_ptr_stub (ControlRef control, ControlBackgroundPtr info)
{
	if (control_user_pane_background_proc_ptr_entry.a_class != NULL && control_user_pane_background_proc_ptr_entry.feature != NULL)
	{
		control_user_pane_background_proc_ptr_entry.feature (eif_access(control_user_pane_background_proc_ptr_entry.a_class), control, info);
	}
}

void set_control_user_pane_background_proc_ptr_entry (void* a_class, void* a_feature)
{
	control_user_pane_background_proc_ptr_entry.a_class = eif_adopt(a_class);
	control_user_pane_background_proc_ptr_entry.feature = (control_user_pane_background_proc_ptr_eiffel_feature) a_feature;
}

void* get_control_user_pane_background_proc_ptr_stub ()
{
	return (void*) control_user_pane_background_proc_ptr_stub;
}

void call_control_user_pane_background_proc_ptr (void *a_function, ControlRef control, ControlBackgroundPtr info)
{
	((void (*) (ControlRef control, ControlBackgroundPtr info))a_function) (control, info);
}

struct data_browser_item_proc_ptr_entry_struct data_browser_item_proc_ptr_entry = {NULL, NULL};

void data_browser_item_proc_ptr_stub (DataBrowserItemID item, DataBrowserItemState state, void *clientData)
{
	if (data_browser_item_proc_ptr_entry.a_class != NULL && data_browser_item_proc_ptr_entry.feature != NULL)
	{
		data_browser_item_proc_ptr_entry.feature (eif_access(data_browser_item_proc_ptr_entry.a_class), item, state, clientData);
	}
}

void set_data_browser_item_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_proc_ptr_entry.feature = (data_browser_item_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_proc_ptr_stub ()
{
	return (void*) data_browser_item_proc_ptr_stub;
}

void call_data_browser_item_proc_ptr (void *a_function, DataBrowserItemID item, DataBrowserItemState state, void *clientData)
{
	((void (*) (DataBrowserItemID item, DataBrowserItemState state, void *clientData))a_function) (item, state, clientData);
}

struct data_browser_item_data_proc_ptr_entry_struct data_browser_item_data_proc_ptr_entry = {NULL, NULL};

OSStatus data_browser_item_data_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemDataRef itemData, Boolean setValue)
{
	if (data_browser_item_data_proc_ptr_entry.a_class != NULL && data_browser_item_data_proc_ptr_entry.feature != NULL)
	{
		return data_browser_item_data_proc_ptr_entry.feature (eif_access(data_browser_item_data_proc_ptr_entry.a_class), browser, item, property, itemData, setValue);
	}
}

void set_data_browser_item_data_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_data_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_data_proc_ptr_entry.feature = (data_browser_item_data_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_data_proc_ptr_stub ()
{
	return (void*) data_browser_item_data_proc_ptr_stub;
}

OSStatus call_data_browser_item_data_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemDataRef itemData, Boolean setValue)
{
	return ((OSStatus (*) (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemDataRef itemData, Boolean setValue))a_function) (browser, item, property, itemData, setValue);
}

struct data_browser_item_compare_proc_ptr_entry_struct data_browser_item_compare_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_item_compare_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemOne, DataBrowserItemID itemTwo, DataBrowserPropertyID sortProperty)
{
	if (data_browser_item_compare_proc_ptr_entry.a_class != NULL && data_browser_item_compare_proc_ptr_entry.feature != NULL)
	{
		return data_browser_item_compare_proc_ptr_entry.feature (eif_access(data_browser_item_compare_proc_ptr_entry.a_class), browser, itemOne, itemTwo, sortProperty);
	}
}

void set_data_browser_item_compare_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_compare_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_compare_proc_ptr_entry.feature = (data_browser_item_compare_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_compare_proc_ptr_stub ()
{
	return (void*) data_browser_item_compare_proc_ptr_stub;
}

Boolean call_data_browser_item_compare_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemOne, DataBrowserItemID itemTwo, DataBrowserPropertyID sortProperty)
{
	return ((Boolean (*) (ControlRef browser, DataBrowserItemID itemOne, DataBrowserItemID itemTwo, DataBrowserPropertyID sortProperty))a_function) (browser, itemOne, itemTwo, sortProperty);
}

struct data_browser_item_notification_with_item_proc_ptr_entry_struct data_browser_item_notification_with_item_proc_ptr_entry = {NULL, NULL};

void data_browser_item_notification_with_item_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemDataRef itemData)
{
	if (data_browser_item_notification_with_item_proc_ptr_entry.a_class != NULL && data_browser_item_notification_with_item_proc_ptr_entry.feature != NULL)
	{
		data_browser_item_notification_with_item_proc_ptr_entry.feature (eif_access(data_browser_item_notification_with_item_proc_ptr_entry.a_class), browser, item, message, itemData);
	}
}

void set_data_browser_item_notification_with_item_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_notification_with_item_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_notification_with_item_proc_ptr_entry.feature = (data_browser_item_notification_with_item_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_notification_with_item_proc_ptr_stub ()
{
	return (void*) data_browser_item_notification_with_item_proc_ptr_stub;
}

void call_data_browser_item_notification_with_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemDataRef itemData)
{
	((void (*) (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemDataRef itemData))a_function) (browser, item, message, itemData);
}

struct data_browser_item_notification_proc_ptr_entry_struct data_browser_item_notification_proc_ptr_entry = {NULL, NULL};

void data_browser_item_notification_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message)
{
	if (data_browser_item_notification_proc_ptr_entry.a_class != NULL && data_browser_item_notification_proc_ptr_entry.feature != NULL)
	{
		data_browser_item_notification_proc_ptr_entry.feature (eif_access(data_browser_item_notification_proc_ptr_entry.a_class), browser, item, message);
	}
}

void set_data_browser_item_notification_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_notification_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_notification_proc_ptr_entry.feature = (data_browser_item_notification_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_notification_proc_ptr_stub ()
{
	return (void*) data_browser_item_notification_proc_ptr_stub;
}

void call_data_browser_item_notification_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message)
{
	((void (*) (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message))a_function) (browser, item, message);
}

struct data_browser_add_drag_item_proc_ptr_entry_struct data_browser_add_drag_item_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_add_drag_item_proc_ptr_stub (ControlRef browser, DragReference theDrag, DataBrowserItemID item, ItemReference *itemRef)
{
	if (data_browser_add_drag_item_proc_ptr_entry.a_class != NULL && data_browser_add_drag_item_proc_ptr_entry.feature != NULL)
	{
		return data_browser_add_drag_item_proc_ptr_entry.feature (eif_access(data_browser_add_drag_item_proc_ptr_entry.a_class), browser, theDrag, item, itemRef);
	}
}

void set_data_browser_add_drag_item_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_add_drag_item_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_add_drag_item_proc_ptr_entry.feature = (data_browser_add_drag_item_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_add_drag_item_proc_ptr_stub ()
{
	return (void*) data_browser_add_drag_item_proc_ptr_stub;
}

Boolean call_data_browser_add_drag_item_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, DataBrowserItemID item, ItemReference *itemRef)
{
	return ((Boolean (*) (ControlRef browser, DragReference theDrag, DataBrowserItemID item, ItemReference *itemRef))a_function) (browser, theDrag, item, itemRef);
}

struct data_browser_accept_drag_proc_ptr_entry_struct data_browser_accept_drag_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_accept_drag_proc_ptr_stub (ControlRef browser, DragReference theDrag, DataBrowserItemID item)
{
	if (data_browser_accept_drag_proc_ptr_entry.a_class != NULL && data_browser_accept_drag_proc_ptr_entry.feature != NULL)
	{
		return data_browser_accept_drag_proc_ptr_entry.feature (eif_access(data_browser_accept_drag_proc_ptr_entry.a_class), browser, theDrag, item);
	}
}

void set_data_browser_accept_drag_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_accept_drag_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_accept_drag_proc_ptr_entry.feature = (data_browser_accept_drag_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_accept_drag_proc_ptr_stub ()
{
	return (void*) data_browser_accept_drag_proc_ptr_stub;
}

Boolean call_data_browser_accept_drag_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, DataBrowserItemID item)
{
	return ((Boolean (*) (ControlRef browser, DragReference theDrag, DataBrowserItemID item))a_function) (browser, theDrag, item);
}

struct data_browser_post_process_drag_proc_ptr_entry_struct data_browser_post_process_drag_proc_ptr_entry = {NULL, NULL};

void data_browser_post_process_drag_proc_ptr_stub (ControlRef browser, DragReference theDrag, OSStatus trackDragResult)
{
	if (data_browser_post_process_drag_proc_ptr_entry.a_class != NULL && data_browser_post_process_drag_proc_ptr_entry.feature != NULL)
	{
		data_browser_post_process_drag_proc_ptr_entry.feature (eif_access(data_browser_post_process_drag_proc_ptr_entry.a_class), browser, theDrag, trackDragResult);
	}
}

void set_data_browser_post_process_drag_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_post_process_drag_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_post_process_drag_proc_ptr_entry.feature = (data_browser_post_process_drag_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_post_process_drag_proc_ptr_stub ()
{
	return (void*) data_browser_post_process_drag_proc_ptr_stub;
}

void call_data_browser_post_process_drag_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, OSStatus trackDragResult)
{
	((void (*) (ControlRef browser, DragReference theDrag, OSStatus trackDragResult))a_function) (browser, theDrag, trackDragResult);
}

struct data_browser_get_contextual_menu_proc_ptr_entry_struct data_browser_get_contextual_menu_proc_ptr_entry = {NULL, NULL};

void data_browser_get_contextual_menu_proc_ptr_stub (ControlRef browser, MenuRef *menu, UInt32 *helpType, CFStringRef *helpItemString, AEDesc *selection)
{
	if (data_browser_get_contextual_menu_proc_ptr_entry.a_class != NULL && data_browser_get_contextual_menu_proc_ptr_entry.feature != NULL)
	{
		data_browser_get_contextual_menu_proc_ptr_entry.feature (eif_access(data_browser_get_contextual_menu_proc_ptr_entry.a_class), browser, menu, helpType, helpItemString, selection);
	}
}

void set_data_browser_get_contextual_menu_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_get_contextual_menu_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_get_contextual_menu_proc_ptr_entry.feature = (data_browser_get_contextual_menu_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_get_contextual_menu_proc_ptr_stub ()
{
	return (void*) data_browser_get_contextual_menu_proc_ptr_stub;
}

void call_data_browser_get_contextual_menu_proc_ptr (void *a_function, ControlRef browser, MenuRef *menu, UInt32 *helpType, CFStringRef *helpItemString, AEDesc *selection)
{
	((void (*) (ControlRef browser, MenuRef *menu, UInt32 *helpType, CFStringRef *helpItemString, AEDesc *selection))a_function) (browser, menu, helpType, helpItemString, selection);
}

struct data_browser_select_contextual_menu_proc_ptr_entry_struct data_browser_select_contextual_menu_proc_ptr_entry = {NULL, NULL};

void data_browser_select_contextual_menu_proc_ptr_stub (ControlRef browser, MenuRef menu, UInt32 selectionType, SInt16 menuID, MenuItemIndex menuItem)
{
	if (data_browser_select_contextual_menu_proc_ptr_entry.a_class != NULL && data_browser_select_contextual_menu_proc_ptr_entry.feature != NULL)
	{
		data_browser_select_contextual_menu_proc_ptr_entry.feature (eif_access(data_browser_select_contextual_menu_proc_ptr_entry.a_class), browser, menu, selectionType, menuID, menuItem);
	}
}

void set_data_browser_select_contextual_menu_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_select_contextual_menu_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_select_contextual_menu_proc_ptr_entry.feature = (data_browser_select_contextual_menu_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_select_contextual_menu_proc_ptr_stub ()
{
	return (void*) data_browser_select_contextual_menu_proc_ptr_stub;
}

void call_data_browser_select_contextual_menu_proc_ptr (void *a_function, ControlRef browser, MenuRef menu, UInt32 selectionType, SInt16 menuID, MenuItemIndex menuItem)
{
	((void (*) (ControlRef browser, MenuRef menu, UInt32 selectionType, SInt16 menuID, MenuItemIndex menuItem))a_function) (browser, menu, selectionType, menuID, menuItem);
}

struct data_browser_item_help_content_proc_ptr_entry_struct data_browser_item_help_content_proc_ptr_entry = {NULL, NULL};

void data_browser_item_help_content_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	if (data_browser_item_help_content_proc_ptr_entry.a_class != NULL && data_browser_item_help_content_proc_ptr_entry.feature != NULL)
	{
		data_browser_item_help_content_proc_ptr_entry.feature (eif_access(data_browser_item_help_content_proc_ptr_entry.a_class), browser, item, property, inRequest, outContentProvided, ioHelpContent);
	}
}

void set_data_browser_item_help_content_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_help_content_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_help_content_proc_ptr_entry.feature = (data_browser_item_help_content_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_help_content_proc_ptr_stub ()
{
	return (void*) data_browser_item_help_content_proc_ptr_stub;
}

void call_data_browser_item_help_content_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent)
{
	((void (*) (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent))a_function) (browser, item, property, inRequest, outContentProvided, ioHelpContent);
}

struct data_browser_draw_item_proc_ptr_entry_struct data_browser_draw_item_proc_ptr_entry = {NULL, NULL};

void data_browser_draw_item_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemState itemState, Rect const *theRect, SInt16 gdDepth, Boolean colorDevice)
{
	if (data_browser_draw_item_proc_ptr_entry.a_class != NULL && data_browser_draw_item_proc_ptr_entry.feature != NULL)
	{
		data_browser_draw_item_proc_ptr_entry.feature (eif_access(data_browser_draw_item_proc_ptr_entry.a_class), browser, item, property, itemState, theRect, gdDepth, colorDevice);
	}
}

void set_data_browser_draw_item_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_draw_item_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_draw_item_proc_ptr_entry.feature = (data_browser_draw_item_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_draw_item_proc_ptr_stub ()
{
	return (void*) data_browser_draw_item_proc_ptr_stub;
}

void call_data_browser_draw_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemState itemState, Rect const *theRect, SInt16 gdDepth, Boolean colorDevice)
{
	((void (*) (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemState itemState, Rect const *theRect, SInt16 gdDepth, Boolean colorDevice))a_function) (browser, item, property, itemState, theRect, gdDepth, colorDevice);
}

struct data_browser_edit_item_proc_ptr_entry_struct data_browser_edit_item_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_edit_item_proc_ptr_stub (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, CFStringRef theString, Rect *maxEditTextRect, Boolean *shrinkToFit)
{
	if (data_browser_edit_item_proc_ptr_entry.a_class != NULL && data_browser_edit_item_proc_ptr_entry.feature != NULL)
	{
		return data_browser_edit_item_proc_ptr_entry.feature (eif_access(data_browser_edit_item_proc_ptr_entry.a_class), browser, item, property, theString, maxEditTextRect, shrinkToFit);
	}
}

void set_data_browser_edit_item_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_edit_item_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_edit_item_proc_ptr_entry.feature = (data_browser_edit_item_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_edit_item_proc_ptr_stub ()
{
	return (void*) data_browser_edit_item_proc_ptr_stub;
}

Boolean call_data_browser_edit_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, CFStringRef theString, Rect *maxEditTextRect, Boolean *shrinkToFit)
{
	return ((Boolean (*) (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, CFStringRef theString, Rect *maxEditTextRect, Boolean *shrinkToFit))a_function) (browser, item, property, theString, maxEditTextRect, shrinkToFit);
}

struct data_browser_hit_test_proc_ptr_entry_struct data_browser_hit_test_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_hit_test_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Rect const *mouseRect)
{
	if (data_browser_hit_test_proc_ptr_entry.a_class != NULL && data_browser_hit_test_proc_ptr_entry.feature != NULL)
	{
		return data_browser_hit_test_proc_ptr_entry.feature (eif_access(data_browser_hit_test_proc_ptr_entry.a_class), browser, itemID, property, theRect, mouseRect);
	}
}

void set_data_browser_hit_test_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_hit_test_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_hit_test_proc_ptr_entry.feature = (data_browser_hit_test_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_hit_test_proc_ptr_stub ()
{
	return (void*) data_browser_hit_test_proc_ptr_stub;
}

Boolean call_data_browser_hit_test_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Rect const *mouseRect)
{
	return ((Boolean (*) (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Rect const *mouseRect))a_function) (browser, itemID, property, theRect, mouseRect);
}

struct data_browser_tracking_proc_ptr_entry_struct data_browser_tracking_proc_ptr_entry = {NULL, NULL};

DataBrowserTrackingResult data_browser_tracking_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Point startPt, EventModifiers modifiers)
{
	if (data_browser_tracking_proc_ptr_entry.a_class != NULL && data_browser_tracking_proc_ptr_entry.feature != NULL)
	{
		return data_browser_tracking_proc_ptr_entry.feature (eif_access(data_browser_tracking_proc_ptr_entry.a_class), browser, itemID, property, theRect, startPt, modifiers);
	}
}

void set_data_browser_tracking_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_tracking_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_tracking_proc_ptr_entry.feature = (data_browser_tracking_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_tracking_proc_ptr_stub ()
{
	return (void*) data_browser_tracking_proc_ptr_stub;
}

DataBrowserTrackingResult call_data_browser_tracking_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Point startPt, EventModifiers modifiers)
{
	return ((DataBrowserTrackingResult (*) (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Point startPt, EventModifiers modifiers))a_function) (browser, itemID, property, theRect, startPt, modifiers);
}

struct data_browser_item_drag_rgn_proc_ptr_entry_struct data_browser_item_drag_rgn_proc_ptr_entry = {NULL, NULL};

void data_browser_item_drag_rgn_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, RgnHandle dragRgn)
{
	if (data_browser_item_drag_rgn_proc_ptr_entry.a_class != NULL && data_browser_item_drag_rgn_proc_ptr_entry.feature != NULL)
	{
		data_browser_item_drag_rgn_proc_ptr_entry.feature (eif_access(data_browser_item_drag_rgn_proc_ptr_entry.a_class), browser, itemID, property, theRect, dragRgn);
	}
}

void set_data_browser_item_drag_rgn_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_drag_rgn_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_drag_rgn_proc_ptr_entry.feature = (data_browser_item_drag_rgn_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_drag_rgn_proc_ptr_stub ()
{
	return (void*) data_browser_item_drag_rgn_proc_ptr_stub;
}

void call_data_browser_item_drag_rgn_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, RgnHandle dragRgn)
{
	((void (*) (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, RgnHandle dragRgn))a_function) (browser, itemID, property, theRect, dragRgn);
}

struct data_browser_item_accept_drag_proc_ptr_entry_struct data_browser_item_accept_drag_proc_ptr_entry = {NULL, NULL};

DataBrowserDragFlags data_browser_item_accept_drag_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, DragReference theDrag)
{
	if (data_browser_item_accept_drag_proc_ptr_entry.a_class != NULL && data_browser_item_accept_drag_proc_ptr_entry.feature != NULL)
	{
		return data_browser_item_accept_drag_proc_ptr_entry.feature (eif_access(data_browser_item_accept_drag_proc_ptr_entry.a_class), browser, itemID, property, theRect, theDrag);
	}
}

void set_data_browser_item_accept_drag_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_accept_drag_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_accept_drag_proc_ptr_entry.feature = (data_browser_item_accept_drag_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_accept_drag_proc_ptr_stub ()
{
	return (void*) data_browser_item_accept_drag_proc_ptr_stub;
}

DataBrowserDragFlags call_data_browser_item_accept_drag_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, DragReference theDrag)
{
	return ((DataBrowserDragFlags (*) (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, DragReference theDrag))a_function) (browser, itemID, property, theRect, theDrag);
}

struct data_browser_item_receive_drag_proc_ptr_entry_struct data_browser_item_receive_drag_proc_ptr_entry = {NULL, NULL};

Boolean data_browser_item_receive_drag_proc_ptr_stub (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, DataBrowserDragFlags dragFlags, DragReference theDrag)
{
	if (data_browser_item_receive_drag_proc_ptr_entry.a_class != NULL && data_browser_item_receive_drag_proc_ptr_entry.feature != NULL)
	{
		return data_browser_item_receive_drag_proc_ptr_entry.feature (eif_access(data_browser_item_receive_drag_proc_ptr_entry.a_class), browser, itemID, property, dragFlags, theDrag);
	}
}

void set_data_browser_item_receive_drag_proc_ptr_entry (void* a_class, void* a_feature)
{
	data_browser_item_receive_drag_proc_ptr_entry.a_class = eif_adopt(a_class);
	data_browser_item_receive_drag_proc_ptr_entry.feature = (data_browser_item_receive_drag_proc_ptr_eiffel_feature) a_feature;
}

void* get_data_browser_item_receive_drag_proc_ptr_stub ()
{
	return (void*) data_browser_item_receive_drag_proc_ptr_stub;
}

Boolean call_data_browser_item_receive_drag_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, DataBrowserDragFlags dragFlags, DragReference theDrag)
{
	return ((Boolean (*) (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, DataBrowserDragFlags dragFlags, DragReference theDrag))a_function) (browser, itemID, property, dragFlags, theDrag);
}

struct edit_unicode_post_update_proc_ptr_entry_struct edit_unicode_post_update_proc_ptr_entry = {NULL, NULL};

Boolean edit_unicode_post_update_proc_ptr_stub (UniCharArrayHandle uniText, UniCharCount uniTextLength, UniCharArrayOffset iStartOffset, UniCharArrayOffset iEndOffset, void *refcon)
{
	if (edit_unicode_post_update_proc_ptr_entry.a_class != NULL && edit_unicode_post_update_proc_ptr_entry.feature != NULL)
	{
		return edit_unicode_post_update_proc_ptr_entry.feature (eif_access(edit_unicode_post_update_proc_ptr_entry.a_class), uniText, uniTextLength, iStartOffset, iEndOffset, refcon);
	}
}

void set_edit_unicode_post_update_proc_ptr_entry (void* a_class, void* a_feature)
{
	edit_unicode_post_update_proc_ptr_entry.a_class = eif_adopt(a_class);
	edit_unicode_post_update_proc_ptr_entry.feature = (edit_unicode_post_update_proc_ptr_eiffel_feature) a_feature;
}

void* get_edit_unicode_post_update_proc_ptr_stub ()
{
	return (void*) edit_unicode_post_update_proc_ptr_stub;
}

Boolean call_edit_unicode_post_update_proc_ptr (void *a_function, UniCharArrayHandle uniText, UniCharCount uniTextLength, UniCharArrayOffset iStartOffset, UniCharArrayOffset iEndOffset, void *refcon)
{
	return ((Boolean (*) (UniCharArrayHandle uniText, UniCharCount uniTextLength, UniCharArrayOffset iStartOffset, UniCharArrayOffset iEndOffset, void *refcon))a_function) (uniText, uniTextLength, iStartOffset, iEndOffset, refcon);
}

struct nav_event_proc_ptr_entry_struct nav_event_proc_ptr_entry = {NULL, NULL};

void nav_event_proc_ptr_stub (NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD)
{
	if (nav_event_proc_ptr_entry.a_class != NULL && nav_event_proc_ptr_entry.feature != NULL)
	{
		nav_event_proc_ptr_entry.feature (eif_access(nav_event_proc_ptr_entry.a_class), callBackSelector, callBackParms, callBackUD);
	}
}

void set_nav_event_proc_ptr_entry (void* a_class, void* a_feature)
{
	nav_event_proc_ptr_entry.a_class = eif_adopt(a_class);
	nav_event_proc_ptr_entry.feature = (nav_event_proc_ptr_eiffel_feature) a_feature;
}

void* get_nav_event_proc_ptr_stub ()
{
	return (void*) nav_event_proc_ptr_stub;
}

void call_nav_event_proc_ptr (void *a_function, NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD)
{
	((void (*) (NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD))a_function) (callBackSelector, callBackParms, callBackUD);
}

struct nav_preview_proc_ptr_entry_struct nav_preview_proc_ptr_entry = {NULL, NULL};

Boolean nav_preview_proc_ptr_stub (NavCBRecPtr callBackParms, void *callBackUD)
{
	if (nav_preview_proc_ptr_entry.a_class != NULL && nav_preview_proc_ptr_entry.feature != NULL)
	{
		return nav_preview_proc_ptr_entry.feature (eif_access(nav_preview_proc_ptr_entry.a_class), callBackParms, callBackUD);
	}
}

void set_nav_preview_proc_ptr_entry (void* a_class, void* a_feature)
{
	nav_preview_proc_ptr_entry.a_class = eif_adopt(a_class);
	nav_preview_proc_ptr_entry.feature = (nav_preview_proc_ptr_eiffel_feature) a_feature;
}

void* get_nav_preview_proc_ptr_stub ()
{
	return (void*) nav_preview_proc_ptr_stub;
}

Boolean call_nav_preview_proc_ptr (void *a_function, NavCBRecPtr callBackParms, void *callBackUD)
{
	return ((Boolean (*) (NavCBRecPtr callBackParms, void *callBackUD))a_function) (callBackParms, callBackUD);
}

struct nav_object_filter_proc_ptr_entry_struct nav_object_filter_proc_ptr_entry = {NULL, NULL};

Boolean nav_object_filter_proc_ptr_stub (AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode)
{
	if (nav_object_filter_proc_ptr_entry.a_class != NULL && nav_object_filter_proc_ptr_entry.feature != NULL)
	{
		return nav_object_filter_proc_ptr_entry.feature (eif_access(nav_object_filter_proc_ptr_entry.a_class), theItem, info, callBackUD, filterMode);
	}
}

void set_nav_object_filter_proc_ptr_entry (void* a_class, void* a_feature)
{
	nav_object_filter_proc_ptr_entry.a_class = eif_adopt(a_class);
	nav_object_filter_proc_ptr_entry.feature = (nav_object_filter_proc_ptr_eiffel_feature) a_feature;
}

void* get_nav_object_filter_proc_ptr_stub ()
{
	return (void*) nav_object_filter_proc_ptr_stub;
}

Boolean call_nav_object_filter_proc_ptr (void *a_function, AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode)
{
	return ((Boolean (*) (AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode))a_function) (theItem, info, callBackUD, filterMode);
}

struct color_changed_proc_ptr_entry_struct color_changed_proc_ptr_entry = {NULL, NULL};

void color_changed_proc_ptr_stub (long userData, PMColor *newColor)
{
	if (color_changed_proc_ptr_entry.a_class != NULL && color_changed_proc_ptr_entry.feature != NULL)
	{
		color_changed_proc_ptr_entry.feature (eif_access(color_changed_proc_ptr_entry.a_class), userData, newColor);
	}
}

void set_color_changed_proc_ptr_entry (void* a_class, void* a_feature)
{
	color_changed_proc_ptr_entry.a_class = eif_adopt(a_class);
	color_changed_proc_ptr_entry.feature = (color_changed_proc_ptr_eiffel_feature) a_feature;
}

void* get_color_changed_proc_ptr_stub ()
{
	return (void*) color_changed_proc_ptr_stub;
}

void call_color_changed_proc_ptr (void *a_function, long userData, PMColor *newColor)
{
	((void (*) (long userData, PMColor *newColor))a_function) (userData, newColor);
}

struct ncolor_changed_proc_ptr_entry_struct ncolor_changed_proc_ptr_entry = {NULL, NULL};

void ncolor_changed_proc_ptr_stub (long userData, NPMColor *newColor)
{
	if (ncolor_changed_proc_ptr_entry.a_class != NULL && ncolor_changed_proc_ptr_entry.feature != NULL)
	{
		ncolor_changed_proc_ptr_entry.feature (eif_access(ncolor_changed_proc_ptr_entry.a_class), userData, newColor);
	}
}

void set_ncolor_changed_proc_ptr_entry (void* a_class, void* a_feature)
{
	ncolor_changed_proc_ptr_entry.a_class = eif_adopt(a_class);
	ncolor_changed_proc_ptr_entry.feature = (ncolor_changed_proc_ptr_eiffel_feature) a_feature;
}

void* get_ncolor_changed_proc_ptr_stub ()
{
	return (void*) ncolor_changed_proc_ptr_stub;
}

void call_ncolor_changed_proc_ptr (void *a_function, long userData, NPMColor *newColor)
{
	((void (*) (long userData, NPMColor *newColor))a_function) (userData, newColor);
}

struct user_event_proc_ptr_entry_struct user_event_proc_ptr_entry = {NULL, NULL};

Boolean user_event_proc_ptr_stub (EventRecord *event)
{
	if (user_event_proc_ptr_entry.a_class != NULL && user_event_proc_ptr_entry.feature != NULL)
	{
		return user_event_proc_ptr_entry.feature (eif_access(user_event_proc_ptr_entry.a_class), event);
	}
}

void set_user_event_proc_ptr_entry (void* a_class, void* a_feature)
{
	user_event_proc_ptr_entry.a_class = eif_adopt(a_class);
	user_event_proc_ptr_entry.feature = (user_event_proc_ptr_eiffel_feature) a_feature;
}

void* get_user_event_proc_ptr_stub ()
{
	return (void*) user_event_proc_ptr_stub;
}

Boolean call_user_event_proc_ptr (void *a_function, EventRecord *event)
{
	return ((Boolean (*) (EventRecord *event))a_function) (event);
}

struct cfcomparator_function_entry_struct cfcomparator_function_entry = {NULL, NULL};

CFComparisonResult cfcomparator_function_stub (void const *val1, void const *val2, void *context)
{
	if (cfcomparator_function_entry.a_class != NULL && cfcomparator_function_entry.feature != NULL)
	{
		return cfcomparator_function_entry.feature (eif_access(cfcomparator_function_entry.a_class), val1, val2, context);
	}
}

void set_cfcomparator_function_entry (void* a_class, void* a_feature)
{
	cfcomparator_function_entry.a_class = eif_adopt(a_class);
	cfcomparator_function_entry.feature = (cfcomparator_function_eiffel_feature) a_feature;
}

void* get_cfcomparator_function_stub ()
{
	return (void*) cfcomparator_function_stub;
}

CFComparisonResult call_cfcomparator_function (void *a_function, void const *val1, void const *val2, void *context)
{
	return ((CFComparisonResult (*) (void const *val1, void const *val2, void *context))a_function) (val1, val2, context);
}

struct cfallocator_retain_call_back_entry_struct cfallocator_retain_call_back_entry = {NULL, NULL};

void const *cfallocator_retain_call_back_stub (void const *info)
{
	if (cfallocator_retain_call_back_entry.a_class != NULL && cfallocator_retain_call_back_entry.feature != NULL)
	{
		return cfallocator_retain_call_back_entry.feature (eif_access(cfallocator_retain_call_back_entry.a_class), info);
	}
}

void set_cfallocator_retain_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_retain_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_retain_call_back_entry.feature = (cfallocator_retain_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_retain_call_back_stub ()
{
	return (void*) cfallocator_retain_call_back_stub;
}

void const *call_cfallocator_retain_call_back (void *a_function, void const *info)
{
	return ((void const *(*) (void const *info))a_function) (info);
}

struct cfallocator_release_call_back_entry_struct cfallocator_release_call_back_entry = {NULL, NULL};

void cfallocator_release_call_back_stub (void const *info)
{
	if (cfallocator_release_call_back_entry.a_class != NULL && cfallocator_release_call_back_entry.feature != NULL)
	{
		cfallocator_release_call_back_entry.feature (eif_access(cfallocator_release_call_back_entry.a_class), info);
	}
}

void set_cfallocator_release_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_release_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_release_call_back_entry.feature = (cfallocator_release_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_release_call_back_stub ()
{
	return (void*) cfallocator_release_call_back_stub;
}

void call_cfallocator_release_call_back (void *a_function, void const *info)
{
	((void (*) (void const *info))a_function) (info);
}

struct cfallocator_copy_description_call_back_entry_struct cfallocator_copy_description_call_back_entry = {NULL, NULL};

CFStringRef cfallocator_copy_description_call_back_stub (void const *info)
{
	if (cfallocator_copy_description_call_back_entry.a_class != NULL && cfallocator_copy_description_call_back_entry.feature != NULL)
	{
		return cfallocator_copy_description_call_back_entry.feature (eif_access(cfallocator_copy_description_call_back_entry.a_class), info);
	}
}

void set_cfallocator_copy_description_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_copy_description_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_copy_description_call_back_entry.feature = (cfallocator_copy_description_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_copy_description_call_back_stub ()
{
	return (void*) cfallocator_copy_description_call_back_stub;
}

CFStringRef call_cfallocator_copy_description_call_back (void *a_function, void const *info)
{
	return ((CFStringRef (*) (void const *info))a_function) (info);
}

struct cfallocator_allocate_call_back_entry_struct cfallocator_allocate_call_back_entry = {NULL, NULL};

void *cfallocator_allocate_call_back_stub (CFIndex allocSize, CFOptionFlags hint, void *info)
{
	if (cfallocator_allocate_call_back_entry.a_class != NULL && cfallocator_allocate_call_back_entry.feature != NULL)
	{
		return cfallocator_allocate_call_back_entry.feature (eif_access(cfallocator_allocate_call_back_entry.a_class), allocSize, hint, info);
	}
}

void set_cfallocator_allocate_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_allocate_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_allocate_call_back_entry.feature = (cfallocator_allocate_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_allocate_call_back_stub ()
{
	return (void*) cfallocator_allocate_call_back_stub;
}

void *call_cfallocator_allocate_call_back (void *a_function, CFIndex allocSize, CFOptionFlags hint, void *info)
{
	return ((void *(*) (CFIndex allocSize, CFOptionFlags hint, void *info))a_function) (allocSize, hint, info);
}

struct cfallocator_reallocate_call_back_entry_struct cfallocator_reallocate_call_back_entry = {NULL, NULL};

void *cfallocator_reallocate_call_back_stub (void *ptr, CFIndex newsize, CFOptionFlags hint, void *info)
{
	if (cfallocator_reallocate_call_back_entry.a_class != NULL && cfallocator_reallocate_call_back_entry.feature != NULL)
	{
		return cfallocator_reallocate_call_back_entry.feature (eif_access(cfallocator_reallocate_call_back_entry.a_class), ptr, newsize, hint, info);
	}
}

void set_cfallocator_reallocate_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_reallocate_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_reallocate_call_back_entry.feature = (cfallocator_reallocate_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_reallocate_call_back_stub ()
{
	return (void*) cfallocator_reallocate_call_back_stub;
}

void *call_cfallocator_reallocate_call_back (void *a_function, void *ptr, CFIndex newsize, CFOptionFlags hint, void *info)
{
	return ((void *(*) (void *ptr, CFIndex newsize, CFOptionFlags hint, void *info))a_function) (ptr, newsize, hint, info);
}

struct cfallocator_deallocate_call_back_entry_struct cfallocator_deallocate_call_back_entry = {NULL, NULL};

void cfallocator_deallocate_call_back_stub (void *ptr, void *info)
{
	if (cfallocator_deallocate_call_back_entry.a_class != NULL && cfallocator_deallocate_call_back_entry.feature != NULL)
	{
		cfallocator_deallocate_call_back_entry.feature (eif_access(cfallocator_deallocate_call_back_entry.a_class), ptr, info);
	}
}

void set_cfallocator_deallocate_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_deallocate_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_deallocate_call_back_entry.feature = (cfallocator_deallocate_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_deallocate_call_back_stub ()
{
	return (void*) cfallocator_deallocate_call_back_stub;
}

void call_cfallocator_deallocate_call_back (void *a_function, void *ptr, void *info)
{
	((void (*) (void *ptr, void *info))a_function) (ptr, info);
}

struct cfallocator_preferred_size_call_back_entry_struct cfallocator_preferred_size_call_back_entry = {NULL, NULL};

CFIndex cfallocator_preferred_size_call_back_stub (CFIndex size, CFOptionFlags hint, void *info)
{
	if (cfallocator_preferred_size_call_back_entry.a_class != NULL && cfallocator_preferred_size_call_back_entry.feature != NULL)
	{
		return cfallocator_preferred_size_call_back_entry.feature (eif_access(cfallocator_preferred_size_call_back_entry.a_class), size, hint, info);
	}
}

void set_cfallocator_preferred_size_call_back_entry (void* a_class, void* a_feature)
{
	cfallocator_preferred_size_call_back_entry.a_class = eif_adopt(a_class);
	cfallocator_preferred_size_call_back_entry.feature = (cfallocator_preferred_size_call_back_eiffel_feature) a_feature;
}

void* get_cfallocator_preferred_size_call_back_stub ()
{
	return (void*) cfallocator_preferred_size_call_back_stub;
}

CFIndex call_cfallocator_preferred_size_call_back (void *a_function, CFIndex size, CFOptionFlags hint, void *info)
{
	return ((CFIndex (*) (CFIndex size, CFOptionFlags hint, void *info))a_function) (size, hint, info);
}

struct cgdata_provider_get_bytes_callback_entry_struct cgdata_provider_get_bytes_callback_entry = {NULL, NULL};

size_t cgdata_provider_get_bytes_callback_stub (void *info, void *buffer, size_t count)
{
	if (cgdata_provider_get_bytes_callback_entry.a_class != NULL && cgdata_provider_get_bytes_callback_entry.feature != NULL)
	{
		return cgdata_provider_get_bytes_callback_entry.feature (eif_access(cgdata_provider_get_bytes_callback_entry.a_class), info, buffer, count);
	}
}

void set_cgdata_provider_get_bytes_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_get_bytes_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_get_bytes_callback_entry.feature = (cgdata_provider_get_bytes_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_get_bytes_callback_stub ()
{
	return (void*) cgdata_provider_get_bytes_callback_stub;
}

size_t call_cgdata_provider_get_bytes_callback (void *a_function, void *info, void *buffer, size_t count)
{
	return ((size_t (*) (void *info, void *buffer, size_t count))a_function) (info, buffer, count);
}

struct cgdata_provider_skip_bytes_callback_entry_struct cgdata_provider_skip_bytes_callback_entry = {NULL, NULL};

void cgdata_provider_skip_bytes_callback_stub (void *info, size_t count)
{
	if (cgdata_provider_skip_bytes_callback_entry.a_class != NULL && cgdata_provider_skip_bytes_callback_entry.feature != NULL)
	{
		cgdata_provider_skip_bytes_callback_entry.feature (eif_access(cgdata_provider_skip_bytes_callback_entry.a_class), info, count);
	}
}

void set_cgdata_provider_skip_bytes_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_skip_bytes_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_skip_bytes_callback_entry.feature = (cgdata_provider_skip_bytes_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_skip_bytes_callback_stub ()
{
	return (void*) cgdata_provider_skip_bytes_callback_stub;
}

void call_cgdata_provider_skip_bytes_callback (void *a_function, void *info, size_t count)
{
	((void (*) (void *info, size_t count))a_function) (info, count);
}

struct wsclient_context_release_call_back_proc_ptr_entry_struct wsclient_context_release_call_back_proc_ptr_entry = {NULL, NULL};

void wsclient_context_release_call_back_proc_ptr_stub (void *info)
{
	if (wsclient_context_release_call_back_proc_ptr_entry.a_class != NULL && wsclient_context_release_call_back_proc_ptr_entry.feature != NULL)
	{
		wsclient_context_release_call_back_proc_ptr_entry.feature (eif_access(wsclient_context_release_call_back_proc_ptr_entry.a_class), info);
	}
}

void set_wsclient_context_release_call_back_proc_ptr_entry (void* a_class, void* a_feature)
{
	wsclient_context_release_call_back_proc_ptr_entry.a_class = eif_adopt(a_class);
	wsclient_context_release_call_back_proc_ptr_entry.feature = (wsclient_context_release_call_back_proc_ptr_eiffel_feature) a_feature;
}

void* get_wsclient_context_release_call_back_proc_ptr_stub ()
{
	return (void*) wsclient_context_release_call_back_proc_ptr_stub;
}

void call_wsclient_context_release_call_back_proc_ptr (void *a_function, void *info)
{
	((void (*) (void *info))a_function) (info);
}

struct cgdata_provider_get_byte_pointer_callback_entry_struct cgdata_provider_get_byte_pointer_callback_entry = {NULL, NULL};

void const *cgdata_provider_get_byte_pointer_callback_stub (void *info)
{
	if (cgdata_provider_get_byte_pointer_callback_entry.a_class != NULL && cgdata_provider_get_byte_pointer_callback_entry.feature != NULL)
	{
		return cgdata_provider_get_byte_pointer_callback_entry.feature (eif_access(cgdata_provider_get_byte_pointer_callback_entry.a_class), info);
	}
}

void set_cgdata_provider_get_byte_pointer_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_get_byte_pointer_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_get_byte_pointer_callback_entry.feature = (cgdata_provider_get_byte_pointer_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_get_byte_pointer_callback_stub ()
{
	return (void*) cgdata_provider_get_byte_pointer_callback_stub;
}

void const *call_cgdata_provider_get_byte_pointer_callback (void *a_function, void *info)
{
	return ((void const *(*) (void *info))a_function) (info);
}

struct cgdata_provider_release_byte_pointer_callback_entry_struct cgdata_provider_release_byte_pointer_callback_entry = {NULL, NULL};

void cgdata_provider_release_byte_pointer_callback_stub (void *info, void const *pointer)
{
	if (cgdata_provider_release_byte_pointer_callback_entry.a_class != NULL && cgdata_provider_release_byte_pointer_callback_entry.feature != NULL)
	{
		cgdata_provider_release_byte_pointer_callback_entry.feature (eif_access(cgdata_provider_release_byte_pointer_callback_entry.a_class), info, pointer);
	}
}

void set_cgdata_provider_release_byte_pointer_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_release_byte_pointer_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_release_byte_pointer_callback_entry.feature = (cgdata_provider_release_byte_pointer_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_release_byte_pointer_callback_stub ()
{
	return (void*) cgdata_provider_release_byte_pointer_callback_stub;
}

void call_cgdata_provider_release_byte_pointer_callback (void *a_function, void *info, void const *pointer)
{
	((void (*) (void *info, void const *pointer))a_function) (info, pointer);
}

struct cgdata_provider_get_bytes_at_offset_callback_entry_struct cgdata_provider_get_bytes_at_offset_callback_entry = {NULL, NULL};

size_t cgdata_provider_get_bytes_at_offset_callback_stub (void *info, void *buffer, size_t offset, size_t count)
{
	if (cgdata_provider_get_bytes_at_offset_callback_entry.a_class != NULL && cgdata_provider_get_bytes_at_offset_callback_entry.feature != NULL)
	{
		return cgdata_provider_get_bytes_at_offset_callback_entry.feature (eif_access(cgdata_provider_get_bytes_at_offset_callback_entry.a_class), info, buffer, offset, count);
	}
}

void set_cgdata_provider_get_bytes_at_offset_callback_entry (void* a_class, void* a_feature)
{
	cgdata_provider_get_bytes_at_offset_callback_entry.a_class = eif_adopt(a_class);
	cgdata_provider_get_bytes_at_offset_callback_entry.feature = (cgdata_provider_get_bytes_at_offset_callback_eiffel_feature) a_feature;
}

void* get_cgdata_provider_get_bytes_at_offset_callback_stub ()
{
	return (void*) cgdata_provider_get_bytes_at_offset_callback_stub;
}

size_t call_cgdata_provider_get_bytes_at_offset_callback (void *a_function, void *info, void *buffer, size_t offset, size_t count)
{
	return ((size_t (*) (void *info, void *buffer, size_t offset, size_t count))a_function) (info, buffer, offset, count);
}

struct cfrag_term_procedure_entry_struct cfrag_term_procedure_entry = {NULL, NULL};

void cfrag_term_procedure_stub (void)
{
	if (cfrag_term_procedure_entry.a_class != NULL && cfrag_term_procedure_entry.feature != NULL)
	{
		cfrag_term_procedure_entry.feature (eif_access(cfrag_term_procedure_entry.a_class));
	}
}

void set_cfrag_term_procedure_entry (void* a_class, void* a_feature)
{
	cfrag_term_procedure_entry.a_class = eif_adopt(a_class);
	cfrag_term_procedure_entry.feature = (cfrag_term_procedure_eiffel_feature) a_feature;
}

void* get_cfrag_term_procedure_stub ()
{
	return (void*) cfrag_term_procedure_stub;
}

void call_cfrag_term_procedure (void *a_function)
{
	((void (*) (void))a_function) ();
}

struct get_next_event_filter_proc_ptr_entry_struct get_next_event_filter_proc_ptr_entry = {NULL, NULL};

void get_next_event_filter_proc_ptr_stub (EventRecord *theEvent, Boolean *result)
{
	if (get_next_event_filter_proc_ptr_entry.a_class != NULL && get_next_event_filter_proc_ptr_entry.feature != NULL)
	{
		get_next_event_filter_proc_ptr_entry.feature (eif_access(get_next_event_filter_proc_ptr_entry.a_class), theEvent, result);
	}
}

void set_get_next_event_filter_proc_ptr_entry (void* a_class, void* a_feature)
{
	get_next_event_filter_proc_ptr_entry.a_class = eif_adopt(a_class);
	get_next_event_filter_proc_ptr_entry.feature = (get_next_event_filter_proc_ptr_eiffel_feature) a_feature;
}

void* get_get_next_event_filter_proc_ptr_stub ()
{
	return (void*) get_next_event_filter_proc_ptr_stub;
}

void call_get_next_event_filter_proc_ptr (void *a_function, EventRecord *theEvent, Boolean *result)
{
	((void (*) (EventRecord *theEvent, Boolean *result))a_function) (theEvent, result);
}

struct menu_bar_def_proc_ptr_entry_struct menu_bar_def_proc_ptr_entry = {NULL, NULL};

long menu_bar_def_proc_ptr_stub (short selector, short message, short parameter1, long parameter2)
{
	if (menu_bar_def_proc_ptr_entry.a_class != NULL && menu_bar_def_proc_ptr_entry.feature != NULL)
	{
		return menu_bar_def_proc_ptr_entry.feature (eif_access(menu_bar_def_proc_ptr_entry.a_class), selector, message, parameter1, parameter2);
	}
}

void set_menu_bar_def_proc_ptr_entry (void* a_class, void* a_feature)
{
	menu_bar_def_proc_ptr_entry.a_class = eif_adopt(a_class);
	menu_bar_def_proc_ptr_entry.feature = (menu_bar_def_proc_ptr_eiffel_feature) a_feature;
}

void* get_menu_bar_def_proc_ptr_stub ()
{
	return (void*) menu_bar_def_proc_ptr_stub;
}

long call_menu_bar_def_proc_ptr (void *a_function, short selector, short message, short parameter1, long parameter2)
{
	return ((long (*) (short selector, short message, short parameter1, long parameter2))a_function) (selector, message, parameter1, parameter2);
}

struct mbar_hook_proc_ptr_entry_struct mbar_hook_proc_ptr_entry = {NULL, NULL};

short mbar_hook_proc_ptr_stub (Rect *menuRect)
{
	if (mbar_hook_proc_ptr_entry.a_class != NULL && mbar_hook_proc_ptr_entry.feature != NULL)
	{
		return mbar_hook_proc_ptr_entry.feature (eif_access(mbar_hook_proc_ptr_entry.a_class), menuRect);
	}
}

void set_mbar_hook_proc_ptr_entry (void* a_class, void* a_feature)
{
	mbar_hook_proc_ptr_entry.a_class = eif_adopt(a_class);
	mbar_hook_proc_ptr_entry.feature = (mbar_hook_proc_ptr_eiffel_feature) a_feature;
}

void* get_mbar_hook_proc_ptr_stub ()
{
	return (void*) mbar_hook_proc_ptr_stub;
}

short call_mbar_hook_proc_ptr (void *a_function, Rect *menuRect)
{
	return ((short (*) (Rect *menuRect))a_function) (menuRect);
}

struct sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry_struct sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry = {NULL, NULL};

SInt32 sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub (void *thisPointer, CFUUIDBytes iid, void **ppv)
{
	if (sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.a_class != NULL && sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.feature != NULL)
	{
		return sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.feature (eif_access(sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.a_class), thisPointer, iid, ppv);
	}
}

void set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry (void* a_class, void* a_feature)
{
	sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.a_class = eif_adopt(a_class);
	sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry.feature = (sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_eiffel_feature) a_feature;
}

void* get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub ()
{
	return (void*) sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub;
}

SInt32 call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback (void *a_function, void *thisPointer, CFUUIDBytes iid, void **ppv)
{
	return ((SInt32 (*) (void *thisPointer, CFUUIDBytes iid, void **ppv))a_function) (thisPointer, iid, ppv);
}

struct uint32_voidp_anonymous_callback_entry_struct uint32_voidp_anonymous_callback_entry = {NULL, NULL};

UInt32 uint32_voidp_anonymous_callback_stub (void *thisPointer)
{
	if (uint32_voidp_anonymous_callback_entry.a_class != NULL && uint32_voidp_anonymous_callback_entry.feature != NULL)
	{
		return uint32_voidp_anonymous_callback_entry.feature (eif_access(uint32_voidp_anonymous_callback_entry.a_class), thisPointer);
	}
}

void set_uint32_voidp_anonymous_callback_entry (void* a_class, void* a_feature)
{
	uint32_voidp_anonymous_callback_entry.a_class = eif_adopt(a_class);
	uint32_voidp_anonymous_callback_entry.feature = (uint32_voidp_anonymous_callback_eiffel_feature) a_feature;
}

void* get_uint32_voidp_anonymous_callback_stub ()
{
	return (void*) uint32_voidp_anonymous_callback_stub;
}

UInt32 call_uint32_voidp_anonymous_callback (void *a_function, void *thisPointer)
{
	return ((UInt32 (*) (void *thisPointer))a_function) (thisPointer);
}

struct osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry_struct osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry = {NULL, NULL};

OSStatus osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub (void *thisInstance, AEDesc const *inContext, AEDescList *outCommandPairs)
{
	if (osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.a_class != NULL && osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.feature != NULL)
	{
		return osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.feature (eif_access(osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.a_class), thisInstance, inContext, outCommandPairs);
	}
}

void set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry (void* a_class, void* a_feature)
{
	osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.a_class = eif_adopt(a_class);
	osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry.feature = (osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_eiffel_feature) a_feature;
}

void* get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub ()
{
	return (void*) osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub;
}

OSStatus call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback (void *a_function, void *thisInstance, AEDesc const *inContext, AEDescList *outCommandPairs)
{
	return ((OSStatus (*) (void *thisInstance, AEDesc const *inContext, AEDescList *outCommandPairs))a_function) (thisInstance, inContext, outCommandPairs);
}

struct osstatus_voidp_aedescp_sint32_anonymous_callback_entry_struct osstatus_voidp_aedescp_sint32_anonymous_callback_entry = {NULL, NULL};

OSStatus osstatus_voidp_aedescp_sint32_anonymous_callback_stub (void *thisInstance, AEDesc *inContext, SInt32 inCommandID)
{
	if (osstatus_voidp_aedescp_sint32_anonymous_callback_entry.a_class != NULL && osstatus_voidp_aedescp_sint32_anonymous_callback_entry.feature != NULL)
	{
		return osstatus_voidp_aedescp_sint32_anonymous_callback_entry.feature (eif_access(osstatus_voidp_aedescp_sint32_anonymous_callback_entry.a_class), thisInstance, inContext, inCommandID);
	}
}

void set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry (void* a_class, void* a_feature)
{
	osstatus_voidp_aedescp_sint32_anonymous_callback_entry.a_class = eif_adopt(a_class);
	osstatus_voidp_aedescp_sint32_anonymous_callback_entry.feature = (osstatus_voidp_aedescp_sint32_anonymous_callback_eiffel_feature) a_feature;
}

void* get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub ()
{
	return (void*) osstatus_voidp_aedescp_sint32_anonymous_callback_stub;
}

OSStatus call_osstatus_voidp_aedescp_sint32_anonymous_callback (void *a_function, void *thisInstance, AEDesc *inContext, SInt32 inCommandID)
{
	return ((OSStatus (*) (void *thisInstance, AEDesc *inContext, SInt32 inCommandID))a_function) (thisInstance, inContext, inCommandID);
}

struct void_voidp_anonymous_callback_entry_struct void_voidp_anonymous_callback_entry = {NULL, NULL};

void void_voidp_anonymous_callback_stub (void *thisInstance)
{
	if (void_voidp_anonymous_callback_entry.a_class != NULL && void_voidp_anonymous_callback_entry.feature != NULL)
	{
		void_voidp_anonymous_callback_entry.feature (eif_access(void_voidp_anonymous_callback_entry.a_class), thisInstance);
	}
}

void set_void_voidp_anonymous_callback_entry (void* a_class, void* a_feature)
{
	void_voidp_anonymous_callback_entry.a_class = eif_adopt(a_class);
	void_voidp_anonymous_callback_entry.feature = (void_voidp_anonymous_callback_eiffel_feature) a_feature;
}

void* get_void_voidp_anonymous_callback_stub ()
{
	return (void*) void_voidp_anonymous_callback_stub;
}

void call_void_voidp_anonymous_callback (void *a_function, void *thisInstance)
{
	((void (*) (void *thisInstance))a_function) (thisInstance);
}

struct desk_hook_proc_ptr_entry_struct desk_hook_proc_ptr_entry = {NULL, NULL};

void desk_hook_proc_ptr_stub (Boolean mouseClick, EventRecord *theEvent)
{
	if (desk_hook_proc_ptr_entry.a_class != NULL && desk_hook_proc_ptr_entry.feature != NULL)
	{
		desk_hook_proc_ptr_entry.feature (eif_access(desk_hook_proc_ptr_entry.a_class), mouseClick, theEvent);
	}
}

void set_desk_hook_proc_ptr_entry (void* a_class, void* a_feature)
{
	desk_hook_proc_ptr_entry.a_class = eif_adopt(a_class);
	desk_hook_proc_ptr_entry.feature = (desk_hook_proc_ptr_eiffel_feature) a_feature;
}

void* get_desk_hook_proc_ptr_stub ()
{
	return (void*) desk_hook_proc_ptr_stub;
}

void call_desk_hook_proc_ptr (void *a_function, Boolean mouseClick, EventRecord *theEvent)
{
	((void (*) (Boolean mouseClick, EventRecord *theEvent))a_function) (mouseClick, theEvent);
}

