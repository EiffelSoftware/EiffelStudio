note
	description: "Low-level Objective-C interface for NSEvent."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EVENT_API

feature -- Creating Events

	frozen key_event_with_type_location_modifier_flags_timestamp_window_number_context_characters_characters_ignoring_modifiers_is_arepeat_key_code (a_type: INTEGER; a_location: POINTER; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: POINTER; a_keys: POINTER; a_ukeys: POINTER; a_flag: BOOLEAN; a_code: NATURAL_16): POINTER
			-- + (NSEvent *)keyEventWithType: (NSEventType) type location: (NSPoint) location modifierFlags: (NSUInteger) flags timestamp: (NSTimeInterval) time windowNumber: (NSInteger) wNum context: (NSGraphicsContext*) context characters: (NSString *) keys charactersIgnoringModifiers: (NSString *) ukeys isARepeat: (BOOL) flag keyCode: (unsigned short) code
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent keyEventWithType: $a_type location: *(NSPoint*)$a_location modifierFlags: $a_flags timestamp: $a_time windowNumber: $a_w_num context: $a_context characters: $a_keys charactersIgnoringModifiers: $a_ukeys isARepeat: $a_flag keyCode: $a_code];"
		end

	frozen mouse_event_with_type_location_modifier_flags_timestamp_window_number_context_event_number_click_count_pressure (a_type: INTEGER; a_location: POINTER; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: POINTER; a_e_num: INTEGER; a_c_num: INTEGER; a_pressure: REAL): POINTER
			-- + (NSEvent *)mouseEventWithType: (NSEventType) type location: (NSPoint) location modifierFlags: (NSUInteger) flags timestamp: (NSTimeInterval) time windowNumber: (NSInteger) wNum context: (NSGraphicsContext*) context eventNumber: (NSInteger) eNum clickCount: (NSInteger) cNum pressure: (float) pressure
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent mouseEventWithType: $a_type location: *(NSPoint*)$a_location modifierFlags: $a_flags timestamp: $a_time windowNumber: $a_w_num context: $a_context eventNumber: $a_e_num clickCount: $a_c_num pressure: $a_pressure];"
		end

	frozen enter_exit_event_with_type_location_modifier_flags_timestamp_window_number_context_event_number_tracking_number_user_data (a_type: INTEGER; a_location: POINTER; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: POINTER; a_e_num: INTEGER; a_t_num: INTEGER; a_data: POINTER): POINTER
			-- + (NSEvent *)enterExitEventWithType: (NSEventType) type location: (NSPoint) location modifierFlags: (NSUInteger) flags timestamp: (NSTimeInterval) time windowNumber: (NSInteger) wNum context: (NSGraphicsContext*) context eventNumber: (NSInteger) eNum trackingNumber: (NSInteger) tNum userData: (void *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent enterExitEventWithType: $a_type location: *(NSPoint*)$a_location modifierFlags: $a_flags timestamp: $a_time windowNumber: $a_w_num context: $a_context eventNumber: $a_e_num trackingNumber: $a_t_num userData: $a_data];"
		end

	frozen other_event_with_type_location_modifier_flags_timestamp_window_number_context_subtype_data1_data2 (a_type: INTEGER; a_location: POINTER; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: POINTER; a_subtype: INTEGER_16; a_d1: INTEGER; a_d2: INTEGER): POINTER
			-- + (NSEvent *)otherEventWithType: (NSEventType) type location: (NSPoint) location modifierFlags: (NSUInteger) flags timestamp: (NSTimeInterval) time windowNumber: (NSInteger) wNum context: (NSGraphicsContext*) context subtype: (short) subtype data1: (NSInteger) d1 data2: (NSInteger) d2
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent otherEventWithType: $a_type location: *(NSPoint*)$a_location modifierFlags: $a_flags timestamp: $a_time windowNumber: $a_w_num context: $a_context subtype: $a_subtype data1: $a_d1 data2: $a_d2];"
		end
-- Error generating eventWithEventRef:: Message signature for feature not set

	frozen event_with_cg_event (a_cg_event: POINTER): POINTER
			-- + (NSEvent *)eventWithCGEvent: (CGEventRef) cgEvent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent eventWithCGEvent: $a_cg_event];"
		end

feature -- Getting General Event Information

	frozen context (a_ns_event: POINTER): POINTER
			-- - (NSGraphicsContext*)context
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event context];"
		end

	frozen location_in_window (a_event: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSEvent*)$a_event locationInWindow]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen modifier_flags (a_ns_event: POINTER): NATURAL
			-- - (NSUInteger)modifierFlags
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event modifierFlags];"
		end

	frozen timestamp (a_ns_event: POINTER): REAL_64
			-- - (NSTimeInterval)timestamp
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event timestamp];"
		end

	frozen type (a_ns_event: POINTER): INTEGER
			-- - (NSEventType)type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event type];"
		end

	frozen window (a_ns_event: POINTER): POINTER
			-- - (NSWindow *)window
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event window];"
		end

	frozen window_number (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)windowNumber
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event windowNumber];"
		end
-- Error generating eventRef: Message signature for feature not set

	frozen cg_event (a_ns_event: POINTER): POINTER
			-- - (CGEventRef)CGEvent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event CGEvent];"
		end

feature -- Getting Key Event Information

	frozen characters (a_ns_event: POINTER): POINTER
			-- - (NSString *)characters
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event characters];"
		end

	frozen characters_ignoring_modifiers (a_ns_event: POINTER): POINTER
			-- - (NSString *)charactersIgnoringModifiers
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event charactersIgnoringModifiers];"
		end

	frozen is_arepeat (a_ns_event: POINTER): BOOLEAN
			-- - (BOOL)isARepeat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event isARepeat];"
		end

	frozen key_code (a_ns_event: POINTER): NATURAL_16
			-- - (unsigned short)keyCode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event keyCode];"
		end

feature -- Getting Mouse Event Information

	frozen mouse_location (res: POINTER)
			-- + (NSPoint)mouseLocation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [NSEvent mouseLocation]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen button_number (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)buttonNumber
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event buttonNumber];"
		end

	frozen click_count (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)clickCount
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event clickCount];"
		end

	frozen pressure (a_ns_event: POINTER): REAL
			-- - (float)pressure
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event pressure];"
		end

	frozen set_mouse_coalescing_enabled (a_flag: BOOLEAN)
			-- + (void)setMouseCoalescingEnabled: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSEvent setMouseCoalescingEnabled: $a_flag];"
		end

	frozen is_mouse_coalescing_enabled : BOOLEAN
			-- + (BOOL)isMouseCoalescingEnabled
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSEvent isMouseCoalescingEnabled];"
		end

feature -- Getting Mouse-Tracking Event Information

	frozen event_number (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)eventNumber
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event eventNumber];"
		end

	frozen tracking_number (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)trackingNumber
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event trackingNumber];"
		end

	frozen tracking_area (a_ns_event: POINTER): POINTER
			-- - (NSTrackingArea *)trackingArea
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event trackingArea];"
		end

	frozen user_data (a_ns_event: POINTER): POINTER
			-- - (void *)userData
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event userData];"
		end

feature -- Getting Custom Event Information

	frozen data1 (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)data1
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event data1];"
		end

	frozen data2 (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)data2
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event data2];"
		end

	frozen subtype (a_ns_event: POINTER): INTEGER_16
			-- - (short)subtype
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event subtype];"
		end

feature -- Getting Scroll Wheel Event Information

	frozen delta_x (a_ns_event: POINTER): REAL
			-- - (CGFloat)deltaX
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event deltaX];"
		end

	frozen delta_y (a_ns_event: POINTER): REAL
			-- - (CGFloat)deltaY
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event deltaY];"
		end

	frozen delta_z (a_ns_event: POINTER): REAL
			-- - (CGFloat)deltaZ
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event deltaZ];"
		end

feature -- Getting Tablet Proximity Information

	frozen capability_mask (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)capabilityMask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event capabilityMask];"
		end

	frozen device_id (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)deviceID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event deviceID];"
		end

	frozen is_entering_proximity (a_ns_event: POINTER): BOOLEAN
			-- - (BOOL)isEnteringProximity
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event isEnteringProximity];"
		end

	frozen pointing_device_id (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)pointingDeviceID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event pointingDeviceID];"
		end

	frozen pointing_device_serial_number (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)pointingDeviceSerialNumber
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event pointingDeviceSerialNumber];"
		end

	frozen pointing_device_type (a_ns_event: POINTER): INTEGER
			-- - (NSPointingDeviceType)pointingDeviceType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event pointingDeviceType];"
		end

	frozen system_tablet_id (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)systemTabletID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event systemTabletID];"
		end

	frozen tablet_id (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)tabletID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event tabletID];"
		end

	frozen unique_id (a_ns_event: POINTER): NATURAL_64
			-- - (unsigned long long)uniqueID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event uniqueID];"
		end

	frozen vendor_id (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)vendorID
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event vendorID];"
		end

	frozen vendor_pointing_device_type (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)vendorPointingDeviceType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event vendorPointingDeviceType];"
		end

feature -- Getting Tablet Pointing Information

	frozen absolute_x (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)absoluteX
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event absoluteX];"
		end

	frozen absolute_y (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)absoluteY
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event absoluteY];"
		end

	frozen absolute_z (a_ns_event: POINTER): INTEGER
			-- - (NSInteger)absoluteZ
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event absoluteZ];"
		end

	frozen button_mask (a_ns_event: POINTER): INTEGER
			-- - (NSUInteger)buttonMask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event buttonMask];"
		end

	frozen rotation (a_ns_event: POINTER): REAL
			-- - (float)rotation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event rotation];"
		end

	frozen tangential_pressure (a_ns_event: POINTER): REAL
			-- - (float)tangentialPressure
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event tangentialPressure];"
		end

	frozen tilt (a_ns_event: POINTER; res: POINTER)
			-- - (NSPoint)tilt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSEvent*)$a_ns_event tilt]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen vendor_defined (a_ns_event: POINTER): POINTER
			-- - (id)vendorDefined
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSEvent*)$a_ns_event vendorDefined];"
		end

feature -- Requesting and Stopping Periodic Events

	frozen start_periodic_events_after_delay_with_period (a_delay: REAL_64; a_period: REAL_64)
			-- + (void)startPeriodicEventsAfterDelay: (NSTimeInterval) delay withPeriod: (NSTimeInterval) period
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSEvent startPeriodicEventsAfterDelay: $a_delay withPeriod: $a_period];"
		end

	frozen stop_periodic_events
			-- + (void)stopPeriodicEvents
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSEvent stopPeriodicEvents];"
		end


end
