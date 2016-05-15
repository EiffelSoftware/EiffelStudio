note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RESPONDER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSResponder

	next_responder: detachable NS_RESPONDER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_responder (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_responder} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_responder} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_next_responder_ (a_responder: detachable NS_RESPONDER)
			-- Auto generated Objective-C wrapper.
		local
			a_responder__item: POINTER
		do
			if attached a_responder as a_responder_attached then
				a_responder__item := a_responder_attached.item
			end
			objc_set_next_responder_ (item, a_responder__item)
		end

	try_to_perform__with_ (an_action: detachable OBJC_SELECTOR; an_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			an_action__item: POINTER
			an_object__item: POINTER
		do
			if attached an_action as an_action_attached then
				an_action__item := an_action_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_try_to_perform__with_ (item, an_action__item, an_object__item)
		end

	perform_key_equivalent_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_perform_key_equivalent_ (item, a_the_event__item)
		end

	valid_requestor_for_send_type__return_type_ (a_send_type: detachable NS_STRING; a_return_type: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_send_type__item: POINTER
			a_return_type__item: POINTER
		do
			if attached a_send_type as a_send_type_attached then
				a_send_type__item := a_send_type_attached.item
			end
			if attached a_return_type as a_return_type_attached then
				a_return_type__item := a_return_type_attached.item
			end
			result_pointer := objc_valid_requestor_for_send_type__return_type_ (item, a_send_type__item, a_return_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like valid_requestor_for_send_type__return_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like valid_requestor_for_send_type__return_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mouse_down_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_down_ (item, a_the_event__item)
		end

	right_mouse_down_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_right_mouse_down_ (item, a_the_event__item)
		end

	other_mouse_down_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_other_mouse_down_ (item, a_the_event__item)
		end

	mouse_up_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_up_ (item, a_the_event__item)
		end

	right_mouse_up_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_right_mouse_up_ (item, a_the_event__item)
		end

	other_mouse_up_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_other_mouse_up_ (item, a_the_event__item)
		end

	mouse_moved_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_moved_ (item, a_the_event__item)
		end

	mouse_dragged_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_dragged_ (item, a_the_event__item)
		end

	scroll_wheel_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_scroll_wheel_ (item, a_the_event__item)
		end

	right_mouse_dragged_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_right_mouse_dragged_ (item, a_the_event__item)
		end

	other_mouse_dragged_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_other_mouse_dragged_ (item, a_the_event__item)
		end

	mouse_entered_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_entered_ (item, a_the_event__item)
		end

	mouse_exited_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_exited_ (item, a_the_event__item)
		end

	key_down_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_key_down_ (item, a_the_event__item)
		end

	key_up_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_key_up_ (item, a_the_event__item)
		end

	flags_changed_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_flags_changed_ (item, a_the_event__item)
		end

	tablet_point_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_tablet_point_ (item, a_the_event__item)
		end

	tablet_proximity_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_tablet_proximity_ (item, a_the_event__item)
		end

	cursor_update_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_cursor_update_ (item, a_event__item)
		end

	magnify_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_magnify_with_event_ (item, a_event__item)
		end

	rotate_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_rotate_with_event_ (item, a_event__item)
		end

	swipe_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_swipe_with_event_ (item, a_event__item)
		end

	begin_gesture_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_begin_gesture_with_event_ (item, a_event__item)
		end

	end_gesture_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_end_gesture_with_event_ (item, a_event__item)
		end

	touches_began_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_touches_began_with_event_ (item, a_event__item)
		end

	touches_moved_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_touches_moved_with_event_ (item, a_event__item)
		end

	touches_ended_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_touches_ended_with_event_ (item, a_event__item)
		end

	touches_cancelled_with_event_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_touches_cancelled_with_event_ (item, a_event__item)
		end

	no_responder_for_ (a_event_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_event_selector__item: POINTER
		do
			if attached a_event_selector as a_event_selector_attached then
				a_event_selector__item := a_event_selector_attached.item
			end
			objc_no_responder_for_ (item, a_event_selector__item)
		end

	accepts_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accepts_first_responder (item)
		end

	become_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_become_first_responder (item)
		end

	resign_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resign_first_responder (item)
		end

	interpret_key_events_ (a_event_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_event_array__item: POINTER
		do
			if attached a_event_array as a_event_array_attached then
				a_event_array__item := a_event_array_attached.item
			end
			objc_interpret_key_events_ (item, a_event_array__item)
		end

	flush_buffered_key_events
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_flush_buffered_key_events (item)
		end

	set_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_menu_ (item, a_menu__item)
		end

	menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	show_context_help_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_show_context_help_ (item, a_sender__item)
		end

	help_requested_ (a_event_ptr: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event_ptr__item: POINTER
		do
			if attached a_event_ptr as a_event_ptr_attached then
				a_event_ptr__item := a_event_ptr_attached.item
			end
			objc_help_requested_ (item, a_event_ptr__item)
		end

	should_be_treated_as_ink_event_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_should_be_treated_as_ink_event_ (item, a_the_event__item)
		end

feature {NONE} -- NSResponder Externals

	objc_next_responder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSResponder *)$an_item nextResponder];
			 ]"
		end

	objc_set_next_responder_ (an_item: POINTER; a_responder: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item setNextResponder:$a_responder];
			 ]"
		end

	objc_try_to_perform__with_ (an_item: POINTER; an_action: POINTER; an_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item tryToPerform:$an_action with:$an_object];
			 ]"
		end

	objc_perform_key_equivalent_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item performKeyEquivalent:$a_the_event];
			 ]"
		end

	objc_valid_requestor_for_send_type__return_type_ (an_item: POINTER; a_send_type: POINTER; a_return_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSResponder *)$an_item validRequestorForSendType:$a_send_type returnType:$a_return_type];
			 ]"
		end

	objc_mouse_down_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseDown:$a_the_event];
			 ]"
		end

	objc_right_mouse_down_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item rightMouseDown:$a_the_event];
			 ]"
		end

	objc_other_mouse_down_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item otherMouseDown:$a_the_event];
			 ]"
		end

	objc_mouse_up_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseUp:$a_the_event];
			 ]"
		end

	objc_right_mouse_up_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item rightMouseUp:$a_the_event];
			 ]"
		end

	objc_other_mouse_up_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item otherMouseUp:$a_the_event];
			 ]"
		end

	objc_mouse_moved_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseMoved:$a_the_event];
			 ]"
		end

	objc_mouse_dragged_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseDragged:$a_the_event];
			 ]"
		end

	objc_scroll_wheel_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollWheel:$a_the_event];
			 ]"
		end

	objc_right_mouse_dragged_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item rightMouseDragged:$a_the_event];
			 ]"
		end

	objc_other_mouse_dragged_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item otherMouseDragged:$a_the_event];
			 ]"
		end

	objc_mouse_entered_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseEntered:$a_the_event];
			 ]"
		end

	objc_mouse_exited_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item mouseExited:$a_the_event];
			 ]"
		end

	objc_key_down_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item keyDown:$a_the_event];
			 ]"
		end

	objc_key_up_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item keyUp:$a_the_event];
			 ]"
		end

	objc_flags_changed_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item flagsChanged:$a_the_event];
			 ]"
		end

	objc_tablet_point_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item tabletPoint:$a_the_event];
			 ]"
		end

	objc_tablet_proximity_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item tabletProximity:$a_the_event];
			 ]"
		end

	objc_cursor_update_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item cursorUpdate:$a_event];
			 ]"
		end

	objc_magnify_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item magnifyWithEvent:$a_event];
			 ]"
		end

	objc_rotate_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item rotateWithEvent:$a_event];
			 ]"
		end

	objc_swipe_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item swipeWithEvent:$a_event];
			 ]"
		end

	objc_begin_gesture_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item beginGestureWithEvent:$a_event];
			 ]"
		end

	objc_end_gesture_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item endGestureWithEvent:$a_event];
			 ]"
		end

	objc_touches_began_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item touchesBeganWithEvent:$a_event];
			 ]"
		end

	objc_touches_moved_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item touchesMovedWithEvent:$a_event];
			 ]"
		end

	objc_touches_ended_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item touchesEndedWithEvent:$a_event];
			 ]"
		end

	objc_touches_cancelled_with_event_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item touchesCancelledWithEvent:$a_event];
			 ]"
		end

	objc_no_responder_for_ (an_item: POINTER; a_event_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item noResponderFor:$a_event_selector];
			 ]"
		end

	objc_accepts_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item acceptsFirstResponder];
			 ]"
		end

	objc_become_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item becomeFirstResponder];
			 ]"
		end

	objc_resign_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item resignFirstResponder];
			 ]"
		end

	objc_interpret_key_events_ (an_item: POINTER; a_event_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item interpretKeyEvents:$a_event_array];
			 ]"
		end

	objc_flush_buffered_key_events (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item flushBufferedKeyEvents];
			 ]"
		end

	objc_set_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item setMenu:$a_menu];
			 ]"
		end

	objc_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSResponder *)$an_item menu];
			 ]"
		end

	objc_show_context_help_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item showContextHelp:$a_sender];
			 ]"
		end

	objc_help_requested_ (an_item: POINTER; a_event_ptr: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item helpRequested:$a_event_ptr];
			 ]"
		end

	objc_should_be_treated_as_ink_event_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item shouldBeTreatedAsInkEvent:$a_the_event];
			 ]"
		end

feature -- NSKeyboardUI

	perform_mnemonic_ (a_the_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_string__item: POINTER
		do
			if attached a_the_string as a_the_string_attached then
				a_the_string__item := a_the_string_attached.item
			end
			Result := objc_perform_mnemonic_ (item, a_the_string__item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_perform_mnemonic_ (an_item: POINTER; a_the_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item performMnemonic:$a_the_string];
			 ]"
		end

feature -- NSStandardKeyBindingMethods

	insert_text_ (a_insert_string: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_insert_string__item: POINTER
		do
			if attached a_insert_string as a_insert_string_attached then
				a_insert_string__item := a_insert_string_attached.item
			end
			objc_insert_text_ (item, a_insert_string__item)
		end

	do_command_by_selector_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_do_command_by_selector_ (item, a_selector__item)
		end

	move_forward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_forward_ (item, a_sender__item)
		end

	move_right_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_right_ (item, a_sender__item)
		end

	move_backward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_backward_ (item, a_sender__item)
		end

	move_left_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_left_ (item, a_sender__item)
		end

	move_up_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_up_ (item, a_sender__item)
		end

	move_down_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_down_ (item, a_sender__item)
		end

	move_word_forward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_forward_ (item, a_sender__item)
		end

	move_word_backward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_backward_ (item, a_sender__item)
		end

	move_to_beginning_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_line_ (item, a_sender__item)
		end

	move_to_end_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_line_ (item, a_sender__item)
		end

	move_to_beginning_of_paragraph_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_paragraph_ (item, a_sender__item)
		end

	move_to_end_of_paragraph_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_paragraph_ (item, a_sender__item)
		end

	move_to_end_of_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_document_ (item, a_sender__item)
		end

	move_to_beginning_of_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_document_ (item, a_sender__item)
		end

	page_down_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_page_down_ (item, a_sender__item)
		end

	page_up_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_page_up_ (item, a_sender__item)
		end

	center_selection_in_visible_area_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_center_selection_in_visible_area_ (item, a_sender__item)
		end

	move_backward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_backward_and_modify_selection_ (item, a_sender__item)
		end

	move_forward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_forward_and_modify_selection_ (item, a_sender__item)
		end

	move_word_forward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_forward_and_modify_selection_ (item, a_sender__item)
		end

	move_word_backward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_backward_and_modify_selection_ (item, a_sender__item)
		end

	move_up_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_up_and_modify_selection_ (item, a_sender__item)
		end

	move_down_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_down_and_modify_selection_ (item, a_sender__item)
		end

	move_to_beginning_of_line_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_line_and_modify_selection_ (item, a_sender__item)
		end

	move_to_end_of_line_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_line_and_modify_selection_ (item, a_sender__item)
		end

	move_to_beginning_of_paragraph_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_paragraph_and_modify_selection_ (item, a_sender__item)
		end

	move_to_end_of_paragraph_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_paragraph_and_modify_selection_ (item, a_sender__item)
		end

	move_to_end_of_document_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_end_of_document_and_modify_selection_ (item, a_sender__item)
		end

	move_to_beginning_of_document_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_beginning_of_document_and_modify_selection_ (item, a_sender__item)
		end

	page_down_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_page_down_and_modify_selection_ (item, a_sender__item)
		end

	page_up_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_page_up_and_modify_selection_ (item, a_sender__item)
		end

	move_paragraph_forward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_paragraph_forward_and_modify_selection_ (item, a_sender__item)
		end

	move_paragraph_backward_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_paragraph_backward_and_modify_selection_ (item, a_sender__item)
		end

	move_word_right_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_right_ (item, a_sender__item)
		end

	move_word_left_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_left_ (item, a_sender__item)
		end

	move_right_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_right_and_modify_selection_ (item, a_sender__item)
		end

	move_left_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_left_and_modify_selection_ (item, a_sender__item)
		end

	move_word_right_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_right_and_modify_selection_ (item, a_sender__item)
		end

	move_word_left_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_word_left_and_modify_selection_ (item, a_sender__item)
		end

	move_to_left_end_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_left_end_of_line_ (item, a_sender__item)
		end

	move_to_right_end_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_right_end_of_line_ (item, a_sender__item)
		end

	move_to_left_end_of_line_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_left_end_of_line_and_modify_selection_ (item, a_sender__item)
		end

	move_to_right_end_of_line_and_modify_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_move_to_right_end_of_line_and_modify_selection_ (item, a_sender__item)
		end

	scroll_page_up_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_page_up_ (item, a_sender__item)
		end

	scroll_page_down_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_page_down_ (item, a_sender__item)
		end

	scroll_line_up_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_line_up_ (item, a_sender__item)
		end

	scroll_line_down_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_line_down_ (item, a_sender__item)
		end

	scroll_to_beginning_of_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_to_beginning_of_document_ (item, a_sender__item)
		end

	scroll_to_end_of_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_scroll_to_end_of_document_ (item, a_sender__item)
		end

	transpose_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_transpose_ (item, a_sender__item)
		end

	transpose_words_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_transpose_words_ (item, a_sender__item)
		end

	select_all_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_all_ (item, a_sender__item)
		end

	select_paragraph_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_paragraph_ (item, a_sender__item)
		end

	select_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_line_ (item, a_sender__item)
		end

	select_word_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_word_ (item, a_sender__item)
		end

	indent_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_indent_ (item, a_sender__item)
		end

	insert_tab_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_tab_ (item, a_sender__item)
		end

	insert_backtab_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_backtab_ (item, a_sender__item)
		end

	insert_newline_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_newline_ (item, a_sender__item)
		end

	insert_paragraph_separator_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_paragraph_separator_ (item, a_sender__item)
		end

	insert_newline_ignoring_field_editor_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_newline_ignoring_field_editor_ (item, a_sender__item)
		end

	insert_tab_ignoring_field_editor_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_tab_ignoring_field_editor_ (item, a_sender__item)
		end

	insert_line_break_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_line_break_ (item, a_sender__item)
		end

	insert_container_break_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_container_break_ (item, a_sender__item)
		end

	insert_single_quote_ignoring_substitution_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_single_quote_ignoring_substitution_ (item, a_sender__item)
		end

	insert_double_quote_ignoring_substitution_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_double_quote_ignoring_substitution_ (item, a_sender__item)
		end

	change_case_of_letter_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_change_case_of_letter_ (item, a_sender__item)
		end

	uppercase_word_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_uppercase_word_ (item, a_sender__item)
		end

	lowercase_word_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_lowercase_word_ (item, a_sender__item)
		end

	capitalize_word_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_capitalize_word_ (item, a_sender__item)
		end

	delete_forward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_forward_ (item, a_sender__item)
		end

	delete_backward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_backward_ (item, a_sender__item)
		end

	delete_backward_by_decomposing_previous_character_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_backward_by_decomposing_previous_character_ (item, a_sender__item)
		end

	delete_word_forward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_word_forward_ (item, a_sender__item)
		end

	delete_word_backward_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_word_backward_ (item, a_sender__item)
		end

	delete_to_beginning_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_to_beginning_of_line_ (item, a_sender__item)
		end

	delete_to_end_of_line_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_to_end_of_line_ (item, a_sender__item)
		end

	delete_to_beginning_of_paragraph_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_to_beginning_of_paragraph_ (item, a_sender__item)
		end

	delete_to_end_of_paragraph_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_to_end_of_paragraph_ (item, a_sender__item)
		end

	yank_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_yank_ (item, a_sender__item)
		end

	complete_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_complete_ (item, a_sender__item)
		end

	set_mark_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_set_mark_ (item, a_sender__item)
		end

	delete_to_mark_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_to_mark_ (item, a_sender__item)
		end

	select_to_mark_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_to_mark_ (item, a_sender__item)
		end

	swap_with_mark_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_swap_with_mark_ (item, a_sender__item)
		end

	cancel_operation_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_cancel_operation_ (item, a_sender__item)
		end

	make_base_writing_direction_natural_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_base_writing_direction_natural_ (item, a_sender__item)
		end

	make_base_writing_direction_left_to_right_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_base_writing_direction_left_to_right_ (item, a_sender__item)
		end

	make_base_writing_direction_right_to_left_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_base_writing_direction_right_to_left_ (item, a_sender__item)
		end

	make_text_writing_direction_natural_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_text_writing_direction_natural_ (item, a_sender__item)
		end

	make_text_writing_direction_left_to_right_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_text_writing_direction_left_to_right_ (item, a_sender__item)
		end

	make_text_writing_direction_right_to_left_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_text_writing_direction_right_to_left_ (item, a_sender__item)
		end

feature {NONE} -- NSStandardKeyBindingMethods Externals

	objc_insert_text_ (an_item: POINTER; a_insert_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertText:$a_insert_string];
			 ]"
		end

	objc_do_command_by_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item doCommandBySelector:$a_selector];
			 ]"
		end

	objc_move_forward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveForward:$a_sender];
			 ]"
		end

	objc_move_right_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveRight:$a_sender];
			 ]"
		end

	objc_move_backward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveBackward:$a_sender];
			 ]"
		end

	objc_move_left_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveLeft:$a_sender];
			 ]"
		end

	objc_move_up_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveUp:$a_sender];
			 ]"
		end

	objc_move_down_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveDown:$a_sender];
			 ]"
		end

	objc_move_word_forward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordForward:$a_sender];
			 ]"
		end

	objc_move_word_backward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordBackward:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfLine:$a_sender];
			 ]"
		end

	objc_move_to_end_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfLine:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_paragraph_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfParagraph:$a_sender];
			 ]"
		end

	objc_move_to_end_of_paragraph_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfParagraph:$a_sender];
			 ]"
		end

	objc_move_to_end_of_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfDocument:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfDocument:$a_sender];
			 ]"
		end

	objc_page_down_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item pageDown:$a_sender];
			 ]"
		end

	objc_page_up_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item pageUp:$a_sender];
			 ]"
		end

	objc_center_selection_in_visible_area_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item centerSelectionInVisibleArea:$a_sender];
			 ]"
		end

	objc_move_backward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveBackwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_forward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveForwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_word_forward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordForwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_word_backward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordBackwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_up_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveUpAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_down_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveDownAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_line_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfLineAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_end_of_line_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfLineAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_paragraph_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfParagraphAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_end_of_paragraph_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfParagraphAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_end_of_document_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToEndOfDocumentAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_beginning_of_document_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToBeginningOfDocumentAndModifySelection:$a_sender];
			 ]"
		end

	objc_page_down_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item pageDownAndModifySelection:$a_sender];
			 ]"
		end

	objc_page_up_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item pageUpAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_paragraph_forward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveParagraphForwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_paragraph_backward_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveParagraphBackwardAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_word_right_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordRight:$a_sender];
			 ]"
		end

	objc_move_word_left_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordLeft:$a_sender];
			 ]"
		end

	objc_move_right_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveRightAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_left_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveLeftAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_word_right_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordRightAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_word_left_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveWordLeftAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_left_end_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToLeftEndOfLine:$a_sender];
			 ]"
		end

	objc_move_to_right_end_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToRightEndOfLine:$a_sender];
			 ]"
		end

	objc_move_to_left_end_of_line_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToLeftEndOfLineAndModifySelection:$a_sender];
			 ]"
		end

	objc_move_to_right_end_of_line_and_modify_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item moveToRightEndOfLineAndModifySelection:$a_sender];
			 ]"
		end

	objc_scroll_page_up_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollPageUp:$a_sender];
			 ]"
		end

	objc_scroll_page_down_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollPageDown:$a_sender];
			 ]"
		end

	objc_scroll_line_up_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollLineUp:$a_sender];
			 ]"
		end

	objc_scroll_line_down_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollLineDown:$a_sender];
			 ]"
		end

	objc_scroll_to_beginning_of_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollToBeginningOfDocument:$a_sender];
			 ]"
		end

	objc_scroll_to_end_of_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item scrollToEndOfDocument:$a_sender];
			 ]"
		end

	objc_transpose_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item transpose:$a_sender];
			 ]"
		end

	objc_transpose_words_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item transposeWords:$a_sender];
			 ]"
		end

	objc_select_all_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item selectAll:$a_sender];
			 ]"
		end

	objc_select_paragraph_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item selectParagraph:$a_sender];
			 ]"
		end

	objc_select_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item selectLine:$a_sender];
			 ]"
		end

	objc_select_word_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item selectWord:$a_sender];
			 ]"
		end

	objc_indent_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item indent:$a_sender];
			 ]"
		end

	objc_insert_tab_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertTab:$a_sender];
			 ]"
		end

	objc_insert_backtab_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertBacktab:$a_sender];
			 ]"
		end

	objc_insert_newline_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertNewline:$a_sender];
			 ]"
		end

	objc_insert_paragraph_separator_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertParagraphSeparator:$a_sender];
			 ]"
		end

	objc_insert_newline_ignoring_field_editor_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertNewlineIgnoringFieldEditor:$a_sender];
			 ]"
		end

	objc_insert_tab_ignoring_field_editor_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertTabIgnoringFieldEditor:$a_sender];
			 ]"
		end

	objc_insert_line_break_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertLineBreak:$a_sender];
			 ]"
		end

	objc_insert_container_break_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertContainerBreak:$a_sender];
			 ]"
		end

	objc_insert_single_quote_ignoring_substitution_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertSingleQuoteIgnoringSubstitution:$a_sender];
			 ]"
		end

	objc_insert_double_quote_ignoring_substitution_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item insertDoubleQuoteIgnoringSubstitution:$a_sender];
			 ]"
		end

	objc_change_case_of_letter_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item changeCaseOfLetter:$a_sender];
			 ]"
		end

	objc_uppercase_word_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item uppercaseWord:$a_sender];
			 ]"
		end

	objc_lowercase_word_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item lowercaseWord:$a_sender];
			 ]"
		end

	objc_capitalize_word_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item capitalizeWord:$a_sender];
			 ]"
		end

	objc_delete_forward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteForward:$a_sender];
			 ]"
		end

	objc_delete_backward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteBackward:$a_sender];
			 ]"
		end

	objc_delete_backward_by_decomposing_previous_character_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteBackwardByDecomposingPreviousCharacter:$a_sender];
			 ]"
		end

	objc_delete_word_forward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteWordForward:$a_sender];
			 ]"
		end

	objc_delete_word_backward_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteWordBackward:$a_sender];
			 ]"
		end

	objc_delete_to_beginning_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteToBeginningOfLine:$a_sender];
			 ]"
		end

	objc_delete_to_end_of_line_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteToEndOfLine:$a_sender];
			 ]"
		end

	objc_delete_to_beginning_of_paragraph_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteToBeginningOfParagraph:$a_sender];
			 ]"
		end

	objc_delete_to_end_of_paragraph_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteToEndOfParagraph:$a_sender];
			 ]"
		end

	objc_yank_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item yank:$a_sender];
			 ]"
		end

	objc_complete_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item complete:$a_sender];
			 ]"
		end

	objc_set_mark_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item setMark:$a_sender];
			 ]"
		end

	objc_delete_to_mark_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item deleteToMark:$a_sender];
			 ]"
		end

	objc_select_to_mark_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item selectToMark:$a_sender];
			 ]"
		end

	objc_swap_with_mark_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item swapWithMark:$a_sender];
			 ]"
		end

	objc_cancel_operation_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item cancelOperation:$a_sender];
			 ]"
		end

	objc_make_base_writing_direction_natural_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeBaseWritingDirectionNatural:$a_sender];
			 ]"
		end

	objc_make_base_writing_direction_left_to_right_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeBaseWritingDirectionLeftToRight:$a_sender];
			 ]"
		end

	objc_make_base_writing_direction_right_to_left_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeBaseWritingDirectionRightToLeft:$a_sender];
			 ]"
		end

	objc_make_text_writing_direction_natural_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeTextWritingDirectionNatural:$a_sender];
			 ]"
		end

	objc_make_text_writing_direction_left_to_right_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeTextWritingDirectionLeftToRight:$a_sender];
			 ]"
		end

	objc_make_text_writing_direction_right_to_left_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item makeTextWritingDirectionRightToLeft:$a_sender];
			 ]"
		end

feature -- NSUndoSupport

	undo_manager: detachable NS_UNDO_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_undo_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSUndoSupport Externals

	objc_undo_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSResponder *)$an_item undoManager];
			 ]"
		end

feature -- NSErrorPresentation

--	present_error__modal_for_window__delegate__did_present_selector__context_info_ (a_error: detachable NS_ERROR; a_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_present_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--			a_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_present_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			if attached a_window as a_window_attached then
--				a_window__item := a_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_present_selector as a_did_present_selector_attached then
--				a_did_present_selector__item := a_did_present_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_present_error__modal_for_window__delegate__did_present_selector__context_info_ (item, a_error__item, a_window__item, a_delegate__item, a_did_present_selector__item, a_context_info__item)
--		end

	present_error_ (a_error: detachable NS_ERROR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			Result := objc_present_error_ (item, a_error__item)
		end

	will_present_error_ (a_error: detachable NS_ERROR): detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			result_pointer := objc_will_present_error_ (item, a_error__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like will_present_error_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like will_present_error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSErrorPresentation Externals

--	objc_present_error__modal_for_window__delegate__did_present_selector__context_info_ (an_item: POINTER; a_error: POINTER; a_window: POINTER; a_delegate: POINTER; a_did_present_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSResponder *)$an_item presentError:$a_error modalForWindow:$a_window delegate:$a_delegate didPresentSelector:$a_did_present_selector contextInfo:];
--			 ]"
--		end

	objc_present_error_ (an_item: POINTER; a_error: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item presentError:$a_error];
			 ]"
		end

	objc_will_present_error_ (an_item: POINTER; a_error: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSResponder *)$an_item willPresentError:$a_error];
			 ]"
		end

feature -- NSInterfaceStyle

	interface_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_interface_style (item)
		end

	set_interface_style_ (a_interface_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_interface_style_ (item, a_interface_style)
		end

feature {NONE} -- NSInterfaceStyle Externals

	objc_interface_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSResponder *)$an_item interfaceStyle];
			 ]"
		end

	objc_set_interface_style_ (an_item: POINTER; a_interface_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSResponder *)$an_item setInterfaceStyle:$a_interface_style];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSResponder"
		end

end
