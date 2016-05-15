note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSTabView

	select_tab_view_item_ (a_tab_view_item: detachable NS_TAB_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_select_tab_view_item_ (item, a_tab_view_item__item)
		end

	select_tab_view_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_tab_view_item_at_index_ (item, a_index)
		end

	select_tab_view_item_with_identifier_ (a_identifier: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			objc_select_tab_view_item_with_identifier_ (item, a_identifier__item)
		end

	take_selected_tab_view_item_from_sender_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_selected_tab_view_item_from_sender_ (item, a_sender__item)
		end

	select_first_tab_view_item_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_first_tab_view_item_ (item, a_sender__item)
		end

	select_last_tab_view_item_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_last_tab_view_item_ (item, a_sender__item)
		end

	select_next_tab_view_item_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_next_tab_view_item_ (item, a_sender__item)
		end

	select_previous_tab_view_item_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_previous_tab_view_item_ (item, a_sender__item)
		end

	selected_tab_view_item: detachable NS_TAB_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_tab_view_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_tab_view_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_tab_view_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tab_view_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tab_view_type (item)
		end

	tab_view_items: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tab_view_items (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tab_view_items} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tab_view_items} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	allows_truncated_labels: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_truncated_labels (item)
		end

	minimum_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_minimum_size (item, Result.item)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	control_tint: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_tint (item)
		end

	control_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_size (item)
		end

	set_font_ (a_font: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			objc_set_font_ (item, a_font__item)
		end

	set_tab_view_type_ (a_tab_view_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tab_view_type_ (item, a_tab_view_type)
		end

	set_allows_truncated_labels_ (a_allow_truncated_labels: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_truncated_labels_ (item, a_allow_truncated_labels)
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	set_control_tint_ (a_control_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_tint_ (item, a_control_tint)
		end

	set_control_size_ (a_control_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_size_ (item, a_control_size)
		end

	add_tab_view_item_ (a_tab_view_item: detachable NS_TAB_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_add_tab_view_item_ (item, a_tab_view_item__item)
		end

	insert_tab_view_item__at_index_ (a_tab_view_item: detachable NS_TAB_VIEW_ITEM; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_insert_tab_view_item__at_index_ (item, a_tab_view_item__item, a_index)
		end

	remove_tab_view_item_ (a_tab_view_item: detachable NS_TAB_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_remove_tab_view_item_ (item, a_tab_view_item__item)
		end

	set_delegate_ (an_object: detachable NS_TAB_VIEW_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_TAB_VIEW_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tab_view_item_at_point_ (a_point: NS_POINT): detachable NS_TAB_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tab_view_item_at_point_ (item, a_point.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tab_view_item_at_point_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tab_view_item_at_point_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	content_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_rect (item, Result.item)
		end

	number_of_tab_view_items: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_tab_view_items (item)
		end

	index_of_tab_view_item_ (a_tab_view_item: detachable NS_TAB_VIEW_ITEM): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			Result := objc_index_of_tab_view_item_ (item, a_tab_view_item__item)
		end

	tab_view_item_at_index_ (a_index: INTEGER_64): detachable NS_TAB_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tab_view_item_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tab_view_item_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tab_view_item_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_of_tab_view_item_with_identifier_ (a_identifier: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			Result := objc_index_of_tab_view_item_with_identifier_ (item, a_identifier__item)
		end

feature {NONE} -- NSTabView Externals

	objc_select_tab_view_item_ (an_item: POINTER; a_tab_view_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_select_tab_view_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectTabViewItemAtIndex:$a_index];
			 ]"
		end

	objc_select_tab_view_item_with_identifier_ (an_item: POINTER; a_identifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectTabViewItemWithIdentifier:$a_identifier];
			 ]"
		end

	objc_take_selected_tab_view_item_from_sender_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item takeSelectedTabViewItemFromSender:$a_sender];
			 ]"
		end

	objc_select_first_tab_view_item_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectFirstTabViewItem:$a_sender];
			 ]"
		end

	objc_select_last_tab_view_item_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectLastTabViewItem:$a_sender];
			 ]"
		end

	objc_select_next_tab_view_item_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectNextTabViewItem:$a_sender];
			 ]"
		end

	objc_select_previous_tab_view_item_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item selectPreviousTabViewItem:$a_sender];
			 ]"
		end

	objc_selected_tab_view_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item selectedTabViewItem];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item font];
			 ]"
		end

	objc_tab_view_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item tabViewType];
			 ]"
		end

	objc_tab_view_items (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item tabViewItems];
			 ]"
		end

	objc_allows_truncated_labels (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item allowsTruncatedLabels];
			 ]"
		end

	objc_minimum_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTabView *)$an_item minimumSize];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item drawsBackground];
			 ]"
		end

	objc_control_tint (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item controlTint];
			 ]"
		end

	objc_control_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item controlSize];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setFont:$a_font];
			 ]"
		end

	objc_set_tab_view_type_ (an_item: POINTER; a_tab_view_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setTabViewType:$a_tab_view_type];
			 ]"
		end

	objc_set_allows_truncated_labels_ (an_item: POINTER; a_allow_truncated_labels: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setAllowsTruncatedLabels:$a_allow_truncated_labels];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_set_control_tint_ (an_item: POINTER; a_control_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setControlTint:$a_control_tint];
			 ]"
		end

	objc_set_control_size_ (an_item: POINTER; a_control_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setControlSize:$a_control_size];
			 ]"
		end

	objc_add_tab_view_item_ (an_item: POINTER; a_tab_view_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item addTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_insert_tab_view_item__at_index_ (an_item: POINTER; a_tab_view_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item insertTabViewItem:$a_tab_view_item atIndex:$a_index];
			 ]"
		end

	objc_remove_tab_view_item_ (an_item: POINTER; a_tab_view_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item removeTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTabView *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item delegate];
			 ]"
		end

	objc_tab_view_item_at_point_ (an_item: POINTER; a_point: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item tabViewItemAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_content_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTabView *)$an_item contentRect];
			 ]"
		end

	objc_number_of_tab_view_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item numberOfTabViewItems];
			 ]"
		end

	objc_index_of_tab_view_item_ (an_item: POINTER; a_tab_view_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item indexOfTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_tab_view_item_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTabView *)$an_item tabViewItemAtIndex:$a_index];
			 ]"
		end

	objc_index_of_tab_view_item_with_identifier_ (an_item: POINTER; a_identifier: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTabView *)$an_item indexOfTabViewItemWithIdentifier:$a_identifier];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTabView"
		end

end
