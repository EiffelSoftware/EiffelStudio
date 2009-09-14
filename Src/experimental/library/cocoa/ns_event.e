note
	description: "An NS_EVENT object, or simply an event, contains information about an input action such as a mouse click or a key down."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EVENT

inherit
	NS_OBJECT

create
	key_event,
	mouse_event,
	enter_exit_event,
	other_event,
	event_with_cg_event

create {NS_OBJECT, OBJC_CALLBACK_MARSHAL}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creating Events

	key_event (a_type: INTEGER; a_location: NS_POINT; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: NS_GRAPHICS_CONTEXT; a_keys: NS_STRING; a_ukeys: NS_STRING; a_flag: BOOLEAN; a_code: NATURAL_16)
			-- Returns a new `NSEvent' object describing a key event.
		do
			share_from_pointer ({NS_EVENT_API}.key_event_with_type_location_modifier_flags_timestamp_window_number_context_characters_characters_ignoring_modifiers_is_arepeat_key_code (a_type, a_location.item, a_flags, a_time, a_w_num, a_context.item, a_keys.item, a_ukeys.item, a_flag, a_code))
		end

	mouse_event (a_type: INTEGER; a_location: NS_POINT; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: NS_GRAPHICS_CONTEXT; a_e_num: INTEGER; a_c_num: INTEGER; a_pressure: REAL)
			-- Returns a new NSEvent object describing a mouse-down, -up, -moved, or -dragged event.
		do
			share_from_pointer ({NS_EVENT_API}.mouse_event_with_type_location_modifier_flags_timestamp_window_number_context_event_number_click_count_pressure (a_type, a_location.item, a_flags, a_time, a_w_num, a_context.item, a_e_num, a_c_num, a_pressure))
		end

	enter_exit_event (a_type: INTEGER; a_location: NS_POINT; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: NS_GRAPHICS_CONTEXT; a_e_num: INTEGER; a_t_num: INTEGER; a_data: POINTER)
			-- Returns a new `NSEvent' object describing a tracking-rectangle or cursor-update event.
		do
			share_from_pointer ({NS_EVENT_API}.enter_exit_event_with_type_location_modifier_flags_timestamp_window_number_context_event_number_tracking_number_user_data (a_type, a_location.item, a_flags, a_time, a_w_num, a_context.item, a_e_num, a_t_num, a_data.item))
		end

	other_event (a_type: INTEGER; a_location: NS_POINT; a_flags: INTEGER; a_time: REAL_64; a_w_num: INTEGER; a_context: NS_GRAPHICS_CONTEXT; a_subtype: INTEGER_16; a_d1: INTEGER; a_d2: INTEGER)
			-- Returns a new NSEvent object describing a custom event.
		do
			share_from_pointer ({NS_EVENT_API}.other_event_with_type_location_modifier_flags_timestamp_window_number_context_subtype_data1_data2 (a_type, a_location.item, a_flags, a_time, a_w_num, a_context.item, a_subtype, a_d1, a_d2))
		end
-- Error generating eventWithEventRef:: Message signature for feature not set

	event_with_cg_event (a_cg_event: POINTER)
			-- Creates and returns an event object that is based on a Core Graphics type of event.
		do
			share_from_pointer ({NS_EVENT_API}.event_with_cg_event (a_cg_event))
		end

feature -- Getting General Event Information

	context: NS_GRAPHICS_CONTEXT
			-- Returns the display graphics context of the receiver.
		do
			create Result.share_from_pointer ({NS_EVENT_API}.context (item))
		end

	location_in_window: NS_POINT
			-- Returns the receiver's location in the base coordinate system of the associated window.
		do
			create Result.make
			{NS_EVENT_API}.location_in_window (item, Result.item)
-- This postcondition doesn't seem to hold
--		ensure
--			x_position_valid: 0 < Result.x
--			y_position_valid: 0 < Result.y
		end

	modifier_flags: NATURAL
			-- Returns an integer bit field indicating the modifier keys in effect for the receiver.
		do
			Result := {NS_EVENT_API}.modifier_flags (item)
		end

	timestamp: REAL_64
			-- Returns the time the receiver occurred in seconds since system startup.
		do
			Result := {NS_EVENT_API}.timestamp (item)
		end

	type: INTEGER
			-- Returns the type of the receiving event.
		do
			Result := {NS_EVENT_API}.type (item)
		end

	window: detachable NS_WINDOW
			-- Returns the window object associated with the receiver.
			-- This is Void if the event is periodic and, strangely, may even be Void ofr mouse events
		require
			type_not_periodic: type /= periodic
		do
			if attached {NS_EVENT_API}.window (item) as l_window then
				if attached {NS_WINDOW} callback_marshal.get_eiffel_object (l_window) as res then
					Result := res
				else
					create Result.share_from_pointer (l_window)
				end
			end
		end

	window_number: INTEGER
			-- Returns the identifier for the window device associated with the receiver.
		do
			Result := {NS_EVENT_API}.window_number (item)
		end
-- Error generating eventRef: Message signature for feature not set

	cg_event: POINTER
			-- Returns a Core Graphics event object corresponding to the receiver.
		do
			Result := {NS_EVENT_API}.cg_event (item)
		end

feature -- Getting Key Event Information

	characters: NS_STRING
			-- Returns the characters associated with the receiving key-up or key-down event.
		do
			create Result.share_from_pointer ({NS_EVENT_API}.characters (item))
		end

	characters_ignoring_modifiers: NS_STRING
			-- Returns the characters generated by the receiving key event as if no modifier key (except for Shift) applies.
		do
			create Result.share_from_pointer ({NS_EVENT_API}.characters_ignoring_modifiers (item))
		end

	is_arepeat: BOOLEAN
			-- Returns `YES' if the receiving key event is a repeat caused by the user holding the key down, `NO' if the key event is new.
		do
			Result := {NS_EVENT_API}.is_arepeat (item)
		end

	key_code: NATURAL_16
			-- Returns the virtual key code for the keyboard key associated with the receiving key event.
		do
			Result := {NS_EVENT_API}.key_code (item)
		end

feature -- Getting Mouse Event Information

	mouse_location: NS_POINT
			-- Reports the current mouse position in screen coordinates.
		do
			create Result.make
			{NS_EVENT_API}.mouse_location (Result.item)
		end

	button_number: INTEGER
			-- Returns the button number for the mouse button that generated an `NSOtherMouse...' event.
		do
			Result := {NS_EVENT_API}.button_number (item)
		end

	click_count: INTEGER
			-- Returns the number of mouse clicks associated with the receiver, which represents a mouse-down or mouse-up event.
		do
			Result := {NS_EVENT_API}.click_count (item)
		end

	pressure: REAL
			-- Returns a value from 0.0 through 1.0 indicating the pressure applied to the input device (used for appropriate devices).
		do
			Result := {NS_EVENT_API}.pressure (item)
		end

	set_mouse_coalescing_enabled (a_flag: BOOLEAN)
			-- Controls whether mouse-movement event coalescing is enabled.
		do
			{NS_EVENT_API}.set_mouse_coalescing_enabled (a_flag)
		end

	is_mouse_coalescing_enabled: BOOLEAN
			-- Indicates whether mouse-movement event coalescing is enabled.
		do
			Result := {NS_EVENT_API}.is_mouse_coalescing_enabled ()
		end

feature -- Getting Mouse-Tracking Event Information

	event_number: INTEGER
			-- Returns the counter value of the latest mouse or tracking-rectangle event object; every system-generated mouse and tracking-rectangle event increments this counter.
		do
			Result := {NS_EVENT_API}.event_number (item)
		end

	tracking_number: INTEGER
			-- Returns the identifier of  a mouse-tracking event.
		do
			Result := {NS_EVENT_API}.tracking_number (item)
		end

	tracking_area: NS_TRACKING_AREA
			-- Returns the `NSTrackingArea' object that generated the event represented by the receiver.
		do
			create Result.share_from_pointer ({NS_EVENT_API}.tracking_area (item))
		end

	user_data: POINTER
			-- Returns data associated with a mouse-tracking event,
		do
			Result := {NS_EVENT_API}.user_data (item)
		end

feature -- Getting Custom Event Information

	data1: INTEGER
			-- Returns additional data associated with the receiver.
		do
			Result := {NS_EVENT_API}.data1 (item)
		end

	data2: INTEGER
			-- Returns additional data associated with the receiver.
		do
			Result := {NS_EVENT_API}.data2 (item)
		end

	subtype: INTEGER_16
			-- Returns the subtype of the receiving event object.
		do
			Result := {NS_EVENT_API}.subtype (item)
		end

feature -- Getting Scroll Wheel Event Information

	delta_x: REAL
			-- Returns the x-coordinate change for a scroll wheel, mouse-move, or mouse-drag event.
		do
			Result := {NS_EVENT_API}.delta_x (item)
		end

	delta_y: REAL
			-- Returns the y-coordinate change for a scroll wheel, mouse-move, or mouse-drag event.
		do
			Result := {NS_EVENT_API}.delta_y (item)
		end

	delta_z: REAL
			-- Returns the z-coordinate change for a scroll wheel, mouse-move, or mouse-drag event.
		do
			Result := {NS_EVENT_API}.delta_z (item)
		end

feature -- Getting Tablet Proximity Information

	capability_mask: INTEGER
			-- Returns a mask whose set bits indicate the capabilities of the tablet device that generated the event represented by the receiver.
		do
			Result := {NS_EVENT_API}.capability_mask (item)
		end

	device_id: INTEGER
			-- Returns a special identifier that is used to match tablet-pointer events with the tablet-proximity event represented by the receiver.
		do
			Result := {NS_EVENT_API}.device_id (item)
		end

	is_entering_proximity: BOOLEAN
			-- Returns `YES' to indicate that a pointing device is entering the proximity of its tablet and `NO' when it is leaving it.
		do
			Result := {NS_EVENT_API}.is_entering_proximity (item)
		end

	pointing_device_id: INTEGER
			-- Returns the index of the pointing device currently in proximity with the tablet.
		do
			Result := {NS_EVENT_API}.pointing_device_id (item)
		end

	pointing_device_serial_number: INTEGER
			-- Returns the vendor-assigned serial number of a pointing device of a certain type.
		do
			Result := {NS_EVENT_API}.pointing_device_serial_number (item)
		end

	pointing_device_type: INTEGER
			-- Returns a NSPointingDeviceType constant indicating the kind of pointing device associated with the receiver.
		do
			Result := {NS_EVENT_API}.pointing_device_type (item)
		end

	system_tablet_id: INTEGER
			-- Returns the index of the tablet device connected to the system.
		do
			Result := {NS_EVENT_API}.system_tablet_id (item)
		end

	tablet_id: INTEGER
			-- Returns the USB model identifier of the tablet device associated with the receiver.
		do
			Result := {NS_EVENT_API}.tablet_id (item)
		end

	unique_id: NATURAL_64
			-- Returns the unique identifier of the pointing device that generated the event represented by the receiver.
		do
			Result := {NS_EVENT_API}.unique_id (item)
		end

	vendor_id: INTEGER
			-- Returns the vendor identifier of the tablet associated with the receiver.
		do
			Result := {NS_EVENT_API}.vendor_id (item)
		end

	vendor_pointing_device_type: INTEGER
			-- Returns a coded bit field whose set bits indicate the type of pointing device (within a vendor selection) associated with the receiver.
		do
			Result := {NS_EVENT_API}.vendor_pointing_device_type (item)
		end

feature -- Getting Tablet Pointing Information

	absolute_x: INTEGER
			-- Reports the absolute x coordinate of a pointing device on its tablet at full tablet resolution.
		do
			Result := {NS_EVENT_API}.absolute_x (item)
		end

	absolute_y: INTEGER
			-- Reports the absolute y coordinate of a pointing device on its tablet at full tablet resolution.
		do
			Result := {NS_EVENT_API}.absolute_y (item)
		end

	absolute_z: INTEGER
			-- Reports the absolute z coordinate of pointing device on its tablet at full tablet resolution.
		do
			Result := {NS_EVENT_API}.absolute_z (item)
		end

	button_mask: INTEGER
			-- Returns a bit mask identifying the buttons pressed when the tablet event represented by the receiver was generated.
		do
			Result := {NS_EVENT_API}.button_mask (item)
		end

	rotation: REAL
			-- Returns the rotation in degrees of the tablet pointing device associated with the receiver.
		do
			Result := {NS_EVENT_API}.rotation (item)
		end

	tangential_pressure: REAL
			-- Reports the tangential pressure on the device that generated the event represented by the receiver.
		do
			Result := {NS_EVENT_API}.tangential_pressure (item)
		end

	tilt: NS_POINT
			-- Reports the scaled tilt values of the pointing device that generated the event represented by the receiver.
		do
			create Result.make
			{NS_EVENT_API}.tilt (item, Result.item)
		end

	vendor_defined: NS_OBJECT
			-- Returns an array of three vendor-defined `NSNumber' objects associated with the pointing-type event represented by the receiver.
		do
			create Result.share_from_pointer ({NS_EVENT_API}.vendor_defined (item))
		end

feature -- Requesting and Stopping Periodic Events

	start_periodic_events_after_delay_with_period (a_delay: REAL_64; a_period: REAL_64)
			-- Begins generating periodic events for the current thread.
		do
			{NS_EVENT_API}.start_periodic_events_after_delay_with_period (a_delay, a_period)
		end

	stop_periodic_events
			-- Stops generating periodic events for the current thread and discards any periodic events remaining in the queue.
		do
			{NS_EVENT_API}.stop_periodic_events ()
		end

feature -- Contract Support

feature -- NSEventType Constants

	frozen left_mouse_down: INTEGER
			-- NSLeftMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftMouseDown"
		end

	frozen left_mouse_up: INTEGER
			-- NSLeftMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftMouseUp"
		end

	frozen right_mouse_down: INTEGER
			-- NSRightMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightMouseDown"
		end

	frozen right_mouse_up: INTEGER
			-- NSRightMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightMouseUp"
		end

	frozen other_mouse_down: INTEGER
			-- NSOtherMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOtherMouseDown"
		end

	frozen other_mouse_up: INTEGER
			-- NSOtherMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOtherMouseUp"
		end

	frozen mouse_moved: INTEGER
			-- NSMouseMoved
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseMoved"
		end

	frozen mouse_entered: INTEGER
			-- NSMouseEntered
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseEntered"
		end

	frozen mouse_exited: INTEGER
			-- NSMouseExited
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseExited"
		end

	frozen periodic: INTEGER
			-- NSPeriodic
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPeriodic"
		end

feature -- Modifier flag constants


	frozen alpha_shift_key_mask: NATURAL_32
			-- Set if Caps Lock key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAlphaShiftKeyMask"
		end

	frozen shift_key_mask: NATURAL_32
			-- Set if Shift key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSShiftKeyMask"
		end

	frozen control_key_mask: NATURAL_32
			-- Set if Control key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSControlKeyMask"
		end

	frozen alternate_key_mask: NATURAL_32
			-- Set if Option or Alternate key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAlternateKeyMask"
		end

	frozen command_key_mask: NATURAL_32
			-- Set if Command key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCommandKeyMask"
		end

	frozen numeric_pad_key_mask: NATURAL_32
			-- Set if any key in the numeric keypad is pressed. The numeric keypad is generally on the right side of the keyboard. This is also set if any of the arrow keys are pressed (NSUpArrowFunctionKey, NSDownArrowFunctionKey, NSLeftArrowFunctionKey, and NSRightArrowFunctionKey).
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNumericPadKeyMask"
		end

	frozen help_key_mask: NATURAL_32
			-- Set if the Help key is pressed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHelpKeyMask"
		end

	frozen function_key_mask: NATURAL_32
			-- Set if any function key is pressed. The function keys include the F keys at the top of most keyboards (F1, F2, and so on) and the navigation keys in the center of most keyboards (Help, Forward Delete, Home, End, Page Up, Page Down, and the arrow keys).
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFunctionKeyMask"
		end

	frozen device_independent_modifier_flags_mask: NATURAL_32
			-- Set if any function key is pressed. The function keys include the F keys at the top of most keyboards (F1, F2, and so on) and the navigation keys in the center of most keyboards (Help, Forward Delete, Home, End, Page Up, Page Down, and the arrow keys).
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDeviceIndependentModifierFlagsMask"
		end

end
