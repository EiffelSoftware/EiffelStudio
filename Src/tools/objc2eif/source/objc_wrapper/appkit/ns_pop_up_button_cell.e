note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POP_UP_BUTTON_CELL

inherit
	NS_MENU_ITEM_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell__pulls_down_,
	make_text_cell_,
	make_image_cell_,
	make

feature {NONE} -- Initialization

	make_text_cell__pulls_down_ (a_string_value: detachable NS_STRING; a_pull_down: BOOLEAN)
			-- Initialize `Current'.
		local
			a_string_value__item: POINTER
		do
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			make_with_pointer (objc_init_text_cell__pulls_down_(allocate_object, a_string_value__item, a_pull_down))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPopUpButtonCell Externals

	objc_init_text_cell__pulls_down_ (an_item: POINTER; a_string_value: POINTER; a_pull_down: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item initTextCell:$a_string_value pullsDown:$a_pull_down];
			 ]"
		end

	objc_set_pulls_down_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setPullsDown:$a_flag];
			 ]"
		end

	objc_pulls_down (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item pullsDown];
			 ]"
		end

	objc_set_autoenables_items_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setAutoenablesItems:$a_flag];
			 ]"
		end

	objc_autoenables_items (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item autoenablesItems];
			 ]"
		end

	objc_set_preferred_edge_ (an_item: POINTER; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setPreferredEdge:$a_edge];
			 ]"
		end

	objc_preferred_edge (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item preferredEdge];
			 ]"
		end

	objc_set_uses_item_from_menu_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setUsesItemFromMenu:$a_flag];
			 ]"
		end

	objc_uses_item_from_menu (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item usesItemFromMenu];
			 ]"
		end

	objc_set_alters_state_of_selected_item_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setAltersStateOfSelectedItem:$a_flag];
			 ]"
		end

	objc_alters_state_of_selected_item (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item altersStateOfSelectedItem];
			 ]"
		end

	objc_add_item_with_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item addItemWithTitle:$a_title];
			 ]"
		end

	objc_add_items_with_titles_ (an_item: POINTER; a_item_titles: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item addItemsWithTitles:$a_item_titles];
			 ]"
		end

	objc_insert_item_with_title__at_index_ (an_item: POINTER; a_title: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item insertItemWithTitle:$a_title atIndex:$a_index];
			 ]"
		end

	objc_remove_item_with_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item removeItemWithTitle:$a_title];
			 ]"
		end

	objc_remove_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item removeItemAtIndex:$a_index];
			 ]"
		end

	objc_remove_all_items (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item removeAllItems];
			 ]"
		end

	objc_item_array (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item itemArray];
			 ]"
		end

	objc_number_of_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item numberOfItems];
			 ]"
		end

	objc_index_of_item_ (an_item: POINTER; a_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfItem:$a_item];
			 ]"
		end

	objc_index_of_item_with_title_ (an_item: POINTER; a_title: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfItemWithTitle:$a_title];
			 ]"
		end

	objc_index_of_item_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfItemWithTag:$a_tag];
			 ]"
		end

	objc_index_of_item_with_represented_object_ (an_item: POINTER; a_obj: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfItemWithRepresentedObject:$a_obj];
			 ]"
		end

	objc_index_of_item_with_target__and_action_ (an_item: POINTER; a_target: POINTER; a_action_selector: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfItemWithTarget:$a_target andAction:$a_action_selector];
			 ]"
		end

	objc_item_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item itemAtIndex:$a_index];
			 ]"
		end

	objc_item_with_title_ (an_item: POINTER; a_title: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item itemWithTitle:$a_title];
			 ]"
		end

	objc_last_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item lastItem];
			 ]"
		end

	objc_select_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item selectItem:$a_item];
			 ]"
		end

	objc_select_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item selectItemAtIndex:$a_index];
			 ]"
		end

	objc_select_item_with_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item selectItemWithTitle:$a_title];
			 ]"
		end

	objc_select_item_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item selectItemWithTag:$a_tag];
			 ]"
		end

	objc_selected_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item selectedItem];
			 ]"
		end

	objc_index_of_selected_item (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item indexOfSelectedItem];
			 ]"
		end

	objc_synchronize_title_and_selected_item (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item synchronizeTitleAndSelectedItem];
			 ]"
		end

	objc_item_title_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item itemTitleAtIndex:$a_index];
			 ]"
		end

	objc_item_titles (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item itemTitles];
			 ]"
		end

	objc_title_of_selected_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPopUpButtonCell *)$an_item titleOfSelectedItem];
			 ]"
		end

	objc_attach_pop_up_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item attachPopUpWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_dismiss_pop_up (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item dismissPopUp];
			 ]"
		end

	objc_perform_click_with_frame__in_view_ (an_item: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item performClickWithFrame:*((NSRect *)$a_frame) inView:$a_control_view];
			 ]"
		end

	objc_arrow_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPopUpButtonCell *)$an_item arrowPosition];
			 ]"
		end

	objc_set_arrow_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPopUpButtonCell *)$an_item setArrowPosition:$a_position];
			 ]"
		end

feature -- NSPopUpButtonCell

	set_pulls_down_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_pulls_down_ (item, a_flag)
		end

	pulls_down: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pulls_down (item)
		end

	set_autoenables_items_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoenables_items_ (item, a_flag)
		end

	autoenables_items: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autoenables_items (item)
		end

	set_preferred_edge_ (a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_preferred_edge_ (item, a_edge)
		end

	preferred_edge: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preferred_edge (item)
		end

	set_uses_item_from_menu_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_item_from_menu_ (item, a_flag)
		end

	uses_item_from_menu: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_item_from_menu (item)
		end

	set_alters_state_of_selected_item_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alters_state_of_selected_item_ (item, a_flag)
		end

	alters_state_of_selected_item: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alters_state_of_selected_item (item)
		end

	add_item_with_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_add_item_with_title_ (item, a_title__item)
		end

	add_items_with_titles_ (a_item_titles: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_item_titles__item: POINTER
		do
			if attached a_item_titles as a_item_titles_attached then
				a_item_titles__item := a_item_titles_attached.item
			end
			objc_add_items_with_titles_ (item, a_item_titles__item)
		end

	insert_item_with_title__at_index_ (a_title: detachable NS_STRING; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_insert_item_with_title__at_index_ (item, a_title__item, a_index)
		end

	remove_item_with_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_remove_item_with_title_ (item, a_title__item)
		end

	remove_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_item_at_index_ (item, a_index)
		end

	remove_all_items
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_items (item)
		end

	item_array: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_array (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_array} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_array} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_items: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_items (item)
		end

	index_of_item_ (a_item: detachable NS_MENU_ITEM): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_index_of_item_ (item, a_item__item)
		end

	index_of_item_with_title_ (a_title: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			Result := objc_index_of_item_with_title_ (item, a_title__item)
		end

	index_of_item_with_tag_ (a_tag: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_item_with_tag_ (item, a_tag)
		end

	index_of_item_with_represented_object_ (a_obj: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			Result := objc_index_of_item_with_represented_object_ (item, a_obj__item)
		end

	index_of_item_with_target__and_action_ (a_target: detachable NS_OBJECT; a_action_selector: detachable OBJC_SELECTOR): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
			a_action_selector__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_action_selector as a_action_selector_attached then
				a_action_selector__item := a_action_selector_attached.item
			end
			Result := objc_index_of_item_with_target__and_action_ (item, a_target__item, a_action_selector__item)
		end

	item_at_index_ (a_index: INTEGER_64): detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	item_with_title_ (a_title: detachable NS_STRING): detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			result_pointer := objc_item_with_title_ (item, a_title__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_with_title_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_with_title_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	last_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_last_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like last_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like last_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	select_item_ (a_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_select_item_ (item, a_item__item)
		end

	select_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_item_at_index_ (item, a_index)
		end

	select_item_with_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_select_item_with_title_ (item, a_title__item)
		end

	select_item_with_tag_ (a_tag: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_select_item_with_tag_ (item, a_tag)
		end

	selected_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_of_selected_item: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_selected_item (item)
		end

	synchronize_title_and_selected_item
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_synchronize_title_and_selected_item (item)
		end

	item_title_at_index_ (a_index: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_title_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_title_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_title_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	item_titles: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_titles (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_titles} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_titles} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	title_of_selected_item: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_of_selected_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_of_selected_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_of_selected_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attach_pop_up_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_attach_pop_up_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	dismiss_pop_up
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_dismiss_pop_up (item)
		end

	perform_click_with_frame__in_view_ (a_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_perform_click_with_frame__in_view_ (item, a_frame.item, a_control_view__item)
		end

	arrow_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_arrow_position (item)
		end

	set_arrow_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_arrow_position_ (item, a_position)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPopUpButtonCell"
		end

end
