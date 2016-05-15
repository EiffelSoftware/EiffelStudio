note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EVENT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSEvent

	type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_type (item)
		end

	modifier_flags: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_modifier_flags (item)
		end

	timestamp: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_timestamp (item)
		end

	window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_window_number (item)
		end

	context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	click_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_click_count (item)
		end

	button_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_button_number (item)
		end

	event_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_event_number (item)
		end

	pressure: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pressure (item)
		end

	location_in_window: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_location_in_window (item, Result.item)
		end

	delta_x: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_delta_x (item)
		end

	delta_y: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_delta_y (item)
		end

	delta_z: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_delta_z (item)
		end

	characters: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_characters (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like characters} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like characters} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	characters_ignoring_modifiers: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_characters_ignoring_modifiers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like characters_ignoring_modifiers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like characters_ignoring_modifiers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_a_repeat: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_a_repeat (item)
		end

	key_code: NATURAL_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_key_code (item)
		end

	tracking_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tracking_number (item)
		end

--	user_data: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_user_data (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like user_data} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like user_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	tracking_area: detachable NS_TRACKING_AREA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tracking_area (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tracking_area} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tracking_area} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	subtype: INTEGER_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_subtype (item)
		end

	data1: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_data1 (item)
		end

	data2: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_data2 (item)
		end

--	event_ref: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_event_ref (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like event_ref} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like event_ref} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	cg_event: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cg_event (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cg_event} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cg_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	magnification: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_magnification (item)
		end

	device_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_device_id (item)
		end

	rotation: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rotation (item)
		end

	absolute_x: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_absolute_x (item)
		end

	absolute_y: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_absolute_y (item)
		end

	absolute_z: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_absolute_z (item)
		end

	button_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_button_mask (item)
		end

	tilt: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_tilt (item, Result.item)
		end

	tangential_pressure: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tangential_pressure (item)
		end

	vendor_defined: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_vendor_defined (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vendor_defined} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vendor_defined} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	vendor_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_vendor_id (item)
		end

	tablet_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tablet_id (item)
		end

	pointing_device_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pointing_device_id (item)
		end

	system_tablet_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_system_tablet_id (item)
		end

	vendor_pointing_device_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_vendor_pointing_device_type (item)
		end

	pointing_device_serial_number: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pointing_device_serial_number (item)
		end

	unique_id: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unique_id (item)
		end

	capability_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_capability_mask (item)
		end

	pointing_device_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pointing_device_type (item)
		end

	is_entering_proximity: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_entering_proximity (item)
		end

	touches_matching_phase__in_view_ (a_phase: NATURAL_64; a_view: detachable NS_VIEW): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_touches_matching_phase__in_view_ (item, a_phase, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like touches_matching_phase__in_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like touches_matching_phase__in_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSEvent Externals

	objc_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item type];
			 ]"
		end

	objc_modifier_flags (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item modifierFlags];
			 ]"
		end

	objc_timestamp (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item timestamp];
			 ]"
		end

	objc_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item window];
			 ]"
		end

	objc_window_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item windowNumber];
			 ]"
		end

	objc_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item context];
			 ]"
		end

	objc_click_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item clickCount];
			 ]"
		end

	objc_button_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item buttonNumber];
			 ]"
		end

	objc_event_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item eventNumber];
			 ]"
		end

	objc_pressure (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item pressure];
			 ]"
		end

	objc_location_in_window (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSEvent *)$an_item locationInWindow];
			 ]"
		end

	objc_delta_x (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item deltaX];
			 ]"
		end

	objc_delta_y (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item deltaY];
			 ]"
		end

	objc_delta_z (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item deltaZ];
			 ]"
		end

	objc_characters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item characters];
			 ]"
		end

	objc_characters_ignoring_modifiers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item charactersIgnoringModifiers];
			 ]"
		end

	objc_is_a_repeat (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item isARepeat];
			 ]"
		end

	objc_key_code (an_item: POINTER): NATURAL_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item keyCode];
			 ]"
		end

	objc_tracking_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item trackingNumber];
			 ]"
		end

--	objc_user_data (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSEvent *)$an_item userData];
--			 ]"
--		end

	objc_tracking_area (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item trackingArea];
			 ]"
		end

	objc_subtype (an_item: POINTER): INTEGER_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item subtype];
			 ]"
		end

	objc_data1 (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item data1];
			 ]"
		end

	objc_data2 (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item data2];
			 ]"
		end

--	objc_event_ref (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSEvent *)$an_item eventRef];
--			 ]"
--		end

--	objc_cg_event (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSEvent *)$an_item CGEvent];
--			 ]"
--		end

	objc_magnification (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item magnification];
			 ]"
		end

	objc_device_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item deviceID];
			 ]"
		end

	objc_rotation (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item rotation];
			 ]"
		end

	objc_absolute_x (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item absoluteX];
			 ]"
		end

	objc_absolute_y (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item absoluteY];
			 ]"
		end

	objc_absolute_z (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item absoluteZ];
			 ]"
		end

	objc_button_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item buttonMask];
			 ]"
		end

	objc_tilt (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSEvent *)$an_item tilt];
			 ]"
		end

	objc_tangential_pressure (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item tangentialPressure];
			 ]"
		end

	objc_vendor_defined (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item vendorDefined];
			 ]"
		end

	objc_vendor_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item vendorID];
			 ]"
		end

	objc_tablet_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item tabletID];
			 ]"
		end

	objc_pointing_device_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item pointingDeviceID];
			 ]"
		end

	objc_system_tablet_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item systemTabletID];
			 ]"
		end

	objc_vendor_pointing_device_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item vendorPointingDeviceType];
			 ]"
		end

	objc_pointing_device_serial_number (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item pointingDeviceSerialNumber];
			 ]"
		end

	objc_unique_id (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item uniqueID];
			 ]"
		end

	objc_capability_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item capabilityMask];
			 ]"
		end

	objc_pointing_device_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item pointingDeviceType];
			 ]"
		end

	objc_is_entering_proximity (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSEvent *)$an_item isEnteringProximity];
			 ]"
		end

	objc_touches_matching_phase__in_view_ (an_item: POINTER; a_phase: NATURAL_64; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEvent *)$an_item touchesMatchingPhase:$a_phase inView:$a_view];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEvent"
		end

end
