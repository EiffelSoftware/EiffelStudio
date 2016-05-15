note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INPUT_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_TEXT_INPUT_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSInputManager

	marked_text_abandoned_ (a_cli: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_cli__item: POINTER
		do
			if attached a_cli as a_cli_attached then
				a_cli__item := a_cli_attached.item
			end
			objc_marked_text_abandoned_ (item, a_cli__item)
		end

	marked_text_selection_changed__client_ (a_new_sel: NS_RANGE; a_cli: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_cli__item: POINTER
		do
			if attached a_cli as a_cli_attached then
				a_cli__item := a_cli_attached.item
			end
			objc_marked_text_selection_changed__client_ (item, a_new_sel.item, a_cli__item)
		end

	wants_to_handle_mouse_events: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_to_handle_mouse_events (item)
		end

	handle_mouse_event_ (a_the_mouse_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_mouse_event__item: POINTER
		do
			if attached a_the_mouse_event as a_the_mouse_event_attached then
				a_the_mouse_event__item := a_the_mouse_event_attached.item
			end
			Result := objc_handle_mouse_event_ (item, a_the_mouse_event__item)
		end

feature {NONE} -- NSInputManager Externals

	objc_marked_text_abandoned_ (an_item: POINTER; a_cli: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSInputManager *)$an_item markedTextAbandoned:$a_cli];
			 ]"
		end

	objc_marked_text_selection_changed__client_ (an_item: POINTER; a_new_sel: POINTER; a_cli: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSInputManager *)$an_item markedTextSelectionChanged:*((NSRange *)$a_new_sel) client:$a_cli];
			 ]"
		end

	objc_wants_to_handle_mouse_events (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSInputManager *)$an_item wantsToHandleMouseEvents];
			 ]"
		end

	objc_handle_mouse_event_ (an_item: POINTER; a_the_mouse_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSInputManager *)$an_item handleMouseEvent:$a_the_mouse_event];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInputManager"
		end

end
