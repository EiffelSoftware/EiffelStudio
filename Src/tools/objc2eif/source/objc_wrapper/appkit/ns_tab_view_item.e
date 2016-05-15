note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM

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
	make_with_identifier_,
	makeial_first_responder,
	make

feature {NONE} -- Initialization

	make_with_identifier_ (a_identifier: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			make_with_pointer (objc_init_with_identifier_(allocate_object, a_identifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	makeial_first_responder
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_initial_first_responder(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTabViewItem Externals

	objc_init_with_identifier_ (an_item: POINTER; a_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item initWithIdentifier:$a_identifier];
			 ]"
		end

	objc_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item identifier];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item view];
			 ]"
		end

	objc_initial_first_responder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item initialFirstResponder];
			 ]"
		end

	objc_label (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item label];
			 ]"
		end

	objc_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item color];
			 ]"
		end

	objc_tab_state (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabViewItem *)$an_item tabState];
			 ]"
		end

	objc_tab_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item tabView];
			 ]"
		end

	objc_set_identifier_ (an_item: POINTER; a_identifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setIdentifier:$a_identifier];
			 ]"
		end

	objc_set_label_ (an_item: POINTER; a_label: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setLabel:$a_label];
			 ]"
		end

	objc_set_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setColor:$a_color];
			 ]"
		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setView:$a_view];
			 ]"
		end

	objc_set_initial_first_responder_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setInitialFirstResponder:$a_view];
			 ]"
		end

	objc_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabViewItem *)$an_item toolTip];
			 ]"
		end

	objc_set_tool_tip_ (an_item: POINTER; a_tool_tip: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item setToolTip:$a_tool_tip];
			 ]"
		end

	objc_draw_label__in_rect_ (an_item: POINTER; a_should_truncate_label: BOOLEAN; a_label_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabViewItem *)$an_item drawLabel:$a_should_truncate_label inRect:*((NSRect *)$a_label_rect)];
			 ]"
		end

	objc_size_of_label_ (an_item: POINTER; result_pointer: POINTER; a_compute_min: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTabViewItem *)$an_item sizeOfLabel:$a_compute_min];
			 ]"
		end

feature -- NSTabViewItem

	identifier: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	view: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	label: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_label (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like label} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like label} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tab_state: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tab_state (item)
		end

	tab_view: detachable NS_TAB_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tab_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tab_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tab_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_identifier_ (a_identifier: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			objc_set_identifier_ (item, a_identifier__item)
		end

	set_label_ (a_label: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_label__item: POINTER
		do
			if attached a_label as a_label_attached then
				a_label__item := a_label_attached.item
			end
			objc_set_label_ (item, a_label__item)
		end

	set_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_color_ (item, a_color__item)
		end

	set_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_view_ (item, a_view__item)
		end

	set_initial_first_responder_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_initial_first_responder_ (item, a_view__item)
		end

	tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tool_tip_ (a_tool_tip: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_tool_tip__item: POINTER
		do
			if attached a_tool_tip as a_tool_tip_attached then
				a_tool_tip__item := a_tool_tip_attached.item
			end
			objc_set_tool_tip_ (item, a_tool_tip__item)
		end

	draw_label__in_rect_ (a_should_truncate_label: BOOLEAN; a_label_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_label__in_rect_ (item, a_should_truncate_label, a_label_rect.item)
		end

	size_of_label_ (a_compute_min: BOOLEAN): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_size_of_label_ (item, Result.item, a_compute_min)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTabViewItem"
		end

end
