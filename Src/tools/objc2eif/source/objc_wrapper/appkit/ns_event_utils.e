note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EVENT_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSEvent

--	event_with_event_ref_ (a_event_ref: UNSUPPORTED_TYPE): detachable NS_EVENT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_event_ref__item: POINTER
--		do
--			if attached a_event_ref as a_event_ref_attached then
--				a_event_ref__item := a_event_ref_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_event_with_event_ref_ (l_objc_class.item, a_event_ref__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like event_with_event_ref_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like event_with_event_ref_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	event_with_cg_event_ (a_cg_event: UNSUPPORTED_TYPE): detachable NS_EVENT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_cg_event__item: POINTER
--		do
--			if attached a_cg_event as a_cg_event_attached then
--				a_cg_event__item := a_cg_event_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_event_with_cg_event_ (l_objc_class.item, a_cg_event__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like event_with_cg_event_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like event_with_cg_event_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_mouse_coalescing_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_mouse_coalescing_enabled_ (l_objc_class.item, a_flag)
		end

	is_mouse_coalescing_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_is_mouse_coalescing_enabled (l_objc_class.item)
		end

	start_periodic_events_after_delay__with_period_ (a_delay: REAL_64; a_period: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_start_periodic_events_after_delay__with_period_ (l_objc_class.item, a_delay, a_period)
		end

	stop_periodic_events
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_stop_periodic_events (l_objc_class.item)
		end

	mouse_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__click_count__pressure_ (a_type: NATURAL_64; a_location: NS_POINT; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: detachable NS_GRAPHICS_CONTEXT; a_e_num: INTEGER_64; a_c_num: INTEGER_64; a_pressure: REAL_32): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_mouse_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__click_count__pressure_ (l_objc_class.item, a_type, a_location.item, a_flags, a_time, a_w_num, a_context__item, a_e_num, a_c_num, a_pressure)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mouse_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__click_count__pressure_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mouse_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__click_count__pressure_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	key_event_with_type__location__modifier_flags__timestamp__window_number__context__characters__characters_ignoring_modifiers__is_a_repeat__key_code_ (a_type: NATURAL_64; a_location: NS_POINT; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: detachable NS_GRAPHICS_CONTEXT; a_keys: detachable NS_STRING; a_ukeys: detachable NS_STRING; a_flag: BOOLEAN; a_code: NATURAL_16): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_context__item: POINTER
			a_keys__item: POINTER
			a_ukeys__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			if attached a_ukeys as a_ukeys_attached then
				a_ukeys__item := a_ukeys_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_key_event_with_type__location__modifier_flags__timestamp__window_number__context__characters__characters_ignoring_modifiers__is_a_repeat__key_code_ (l_objc_class.item, a_type, a_location.item, a_flags, a_time, a_w_num, a_context__item, a_keys__item, a_ukeys__item, a_flag, a_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_event_with_type__location__modifier_flags__timestamp__window_number__context__characters__characters_ignoring_modifiers__is_a_repeat__key_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_event_with_type__location__modifier_flags__timestamp__window_number__context__characters__characters_ignoring_modifiers__is_a_repeat__key_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	enter_exit_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__tracking_number__user_data_ (a_type: NATURAL_64; a_location: NS_POINT; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: detachable NS_GRAPHICS_CONTEXT; a_e_num: INTEGER_64; a_t_num: INTEGER_64; a_data: UNSUPPORTED_TYPE): detachable NS_EVENT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_context__item: POINTER
--			a_data__item: POINTER
--		do
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_enter_exit_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__tracking_number__user_data_ (l_objc_class.item, a_type, a_location.item, a_flags, a_time, a_w_num, a_context__item, a_e_num, a_t_num, a_data__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like enter_exit_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__tracking_number__user_data_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like enter_exit_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__tracking_number__user_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	other_event_with_type__location__modifier_flags__timestamp__window_number__context__subtype__data1__data2_ (a_type: NATURAL_64; a_location: NS_POINT; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: detachable NS_GRAPHICS_CONTEXT; a_subtype: INTEGER_16; a_d1: INTEGER_64; a_d2: INTEGER_64): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_other_event_with_type__location__modifier_flags__timestamp__window_number__context__subtype__data1__data2_ (l_objc_class.item, a_type, a_location.item, a_flags, a_time, a_w_num, a_context__item, a_subtype, a_d1, a_d2)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like other_event_with_type__location__modifier_flags__timestamp__window_number__context__subtype__data1__data2_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like other_event_with_type__location__modifier_flags__timestamp__window_number__context__subtype__data1__data2_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mouse_location: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			create Result.make
			objc_mouse_location (l_objc_class.item, Result.item)
		end

	pressed_mouse_buttons: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_pressed_mouse_buttons (l_objc_class.item)
		end

	double_click_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_double_click_interval (l_objc_class.item)
		end

	key_repeat_delay: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_key_repeat_delay (l_objc_class.item)
		end

	key_repeat_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_key_repeat_interval (l_objc_class.item)
		end

--	add_global_monitor_for_events_matching_mask__handler_ (a_mask: NATURAL_64; a_block: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_add_global_monitor_for_events_matching_mask__handler_ (l_objc_class.item, a_mask, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like add_global_monitor_for_events_matching_mask__handler_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like add_global_monitor_for_events_matching_mask__handler_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	add_local_monitor_for_events_matching_mask__handler_ (a_mask: NATURAL_64; a_block: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_add_local_monitor_for_events_matching_mask__handler_ (l_objc_class.item, a_mask, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like add_local_monitor_for_events_matching_mask__handler_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like add_local_monitor_for_events_matching_mask__handler_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	remove_monitor_ (a_event_monitor: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_event_monitor__item: POINTER
		do
			if attached a_event_monitor as a_event_monitor_attached then
				a_event_monitor__item := a_event_monitor_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_remove_monitor_ (l_objc_class.item, a_event_monitor__item)
		end

feature {NONE} -- NSEvent Externals

--	objc_event_with_event_ref_ (a_class_object: POINTER; a_event_ref: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object eventWithEventRef:];
--			 ]"
--		end

--	objc_event_with_cg_event_ (a_class_object: POINTER; a_cg_event: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object eventWithCGEvent:];
--			 ]"
--		end

	objc_set_mouse_coalescing_enabled_ (a_class_object: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setMouseCoalescingEnabled:$a_flag];
			 ]"
		end

	objc_is_mouse_coalescing_enabled (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object isMouseCoalescingEnabled];
			 ]"
		end

	objc_start_periodic_events_after_delay__with_period_ (a_class_object: POINTER; a_delay: REAL_64; a_period: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object startPeriodicEventsAfterDelay:$a_delay withPeriod:$a_period];
			 ]"
		end

	objc_stop_periodic_events (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object stopPeriodicEvents];
			 ]"
		end

	objc_mouse_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__click_count__pressure_ (a_class_object: POINTER; a_type: NATURAL_64; a_location: POINTER; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: POINTER; a_e_num: INTEGER_64; a_c_num: INTEGER_64; a_pressure: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mouseEventWithType:$a_type location:*((NSPoint *)$a_location) modifierFlags:$a_flags timestamp:$a_time windowNumber:$a_w_num context:$a_context eventNumber:$a_e_num clickCount:$a_c_num pressure:$a_pressure];
			 ]"
		end

	objc_key_event_with_type__location__modifier_flags__timestamp__window_number__context__characters__characters_ignoring_modifiers__is_a_repeat__key_code_ (a_class_object: POINTER; a_type: NATURAL_64; a_location: POINTER; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: POINTER; a_keys: POINTER; a_ukeys: POINTER; a_flag: BOOLEAN; a_code: NATURAL_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object keyEventWithType:$a_type location:*((NSPoint *)$a_location) modifierFlags:$a_flags timestamp:$a_time windowNumber:$a_w_num context:$a_context characters:$a_keys charactersIgnoringModifiers:$a_ukeys isARepeat:$a_flag keyCode:$a_code];
			 ]"
		end

--	objc_enter_exit_event_with_type__location__modifier_flags__timestamp__window_number__context__event_number__tracking_number__user_data_ (a_class_object: POINTER; a_type: NATURAL_64; a_location: POINTER; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: POINTER; a_e_num: INTEGER_64; a_t_num: INTEGER_64; a_data: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object enterExitEventWithType:$a_type location:*((NSPoint *)$a_location) modifierFlags:$a_flags timestamp:$a_time windowNumber:$a_w_num context:$a_context eventNumber:$a_e_num trackingNumber:$a_t_num userData:];
--			 ]"
--		end

	objc_other_event_with_type__location__modifier_flags__timestamp__window_number__context__subtype__data1__data2_ (a_class_object: POINTER; a_type: NATURAL_64; a_location: POINTER; a_flags: NATURAL_64; a_time: REAL_64; a_w_num: INTEGER_64; a_context: POINTER; a_subtype: INTEGER_16; a_d1: INTEGER_64; a_d2: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object otherEventWithType:$a_type location:*((NSPoint *)$a_location) modifierFlags:$a_flags timestamp:$a_time windowNumber:$a_w_num context:$a_context subtype:$a_subtype data1:$a_d1 data2:$a_d2];
			 ]"
		end

	objc_mouse_location (a_class_object: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(Class)$a_class_object mouseLocation];
			 ]"
		end

	objc_pressed_mouse_buttons (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object pressedMouseButtons];
			 ]"
		end

	objc_double_click_interval (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object doubleClickInterval];
			 ]"
		end

	objc_key_repeat_delay (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object keyRepeatDelay];
			 ]"
		end

	objc_key_repeat_interval (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object keyRepeatInterval];
			 ]"
		end

--	objc_add_global_monitor_for_events_matching_mask__handler_ (a_class_object: POINTER; a_mask: NATURAL_64; a_block: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object addGlobalMonitorForEventsMatchingMask:$a_mask handler:];
--			 ]"
--		end

--	objc_add_local_monitor_for_events_matching_mask__handler_ (a_class_object: POINTER; a_mask: NATURAL_64; a_block: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object addLocalMonitorForEventsMatchingMask:$a_mask handler:];
--			 ]"
--		end

	objc_remove_monitor_ (a_class_object: POINTER; a_event_monitor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object removeMonitor:$a_event_monitor];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEvent"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
