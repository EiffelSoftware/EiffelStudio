note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU

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
	make_with_title_,
	make

feature {NONE} -- Initialization

	make_with_title_ (a_title: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			make_with_pointer (objc_init_with_title_(allocate_object, a_title__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMenu Externals

	objc_init_with_title_ (an_item: POINTER; a_title: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item initWithTitle:$a_title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item title];
			 ]"
		end

	objc_pop_up_menu_positioning_item__at_location__in_view_ (an_item: POINTER; a_item: POINTER; a_location: POINTER; a_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item popUpMenuPositioningItem:$a_item atLocation:*((NSPoint *)$a_location) inView:$a_view];
			 ]"
		end

	objc_supermenu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item supermenu];
			 ]"
		end

	objc_set_supermenu_ (an_item: POINTER; a_supermenu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setSupermenu:$a_supermenu];
			 ]"
		end

	objc_insert_item__at_index_ (an_item: POINTER; a_new_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item insertItem:$a_new_item atIndex:$a_index];
			 ]"
		end

	objc_add_item_ (an_item: POINTER; a_new_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item addItem:$a_new_item];
			 ]"
		end

	objc_insert_item_with_title__action__key_equivalent__at_index_ (an_item: POINTER; a_string: POINTER; a_selector: POINTER; a_char_code: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item insertItemWithTitle:$a_string action:$a_selector keyEquivalent:$a_char_code atIndex:$a_index];
			 ]"
		end

	objc_add_item_with_title__action__key_equivalent_ (an_item: POINTER; a_string: POINTER; a_selector: POINTER; a_char_code: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item addItemWithTitle:$a_string action:$a_selector keyEquivalent:$a_char_code];
			 ]"
		end

	objc_remove_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item removeItemAtIndex:$a_index];
			 ]"
		end

	objc_remove_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item removeItem:$a_item];
			 ]"
		end

	objc_set_submenu__for_item_ (an_item: POINTER; a_menu: POINTER; an_item_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setSubmenu:$a_menu forItem:$an_item_arg];
			 ]"
		end

	objc_remove_all_items (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item removeAllItems];
			 ]"
		end

	objc_item_array (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item itemArray];
			 ]"
		end

	objc_number_of_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item numberOfItems];
			 ]"
		end

	objc_item_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item itemAtIndex:$a_index];
			 ]"
		end

	objc_index_of_item_ (an_item: POINTER; a_index: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItem:$a_index];
			 ]"
		end

	objc_index_of_item_with_title_ (an_item: POINTER; a_title: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItemWithTitle:$a_title];
			 ]"
		end

	objc_index_of_item_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItemWithTag:$a_tag];
			 ]"
		end

	objc_index_of_item_with_represented_object_ (an_item: POINTER; a_object: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItemWithRepresentedObject:$a_object];
			 ]"
		end

	objc_index_of_item_with_submenu_ (an_item: POINTER; a_submenu: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItemWithSubmenu:$a_submenu];
			 ]"
		end

	objc_index_of_item_with_target__and_action_ (an_item: POINTER; a_target: POINTER; a_action_selector: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item indexOfItemWithTarget:$a_target andAction:$a_action_selector];
			 ]"
		end

	objc_item_with_title_ (an_item: POINTER; a_title: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item itemWithTitle:$a_title];
			 ]"
		end

	objc_item_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item itemWithTag:$a_tag];
			 ]"
		end

	objc_set_autoenables_items_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setAutoenablesItems:$a_flag];
			 ]"
		end

	objc_autoenables_items (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item autoenablesItems];
			 ]"
		end

	objc_update (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item update];
			 ]"
		end

	objc_perform_key_equivalent_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item performKeyEquivalent:$a_the_event];
			 ]"
		end

	objc_item_changed_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item itemChanged:$a_item];
			 ]"
		end

	objc_perform_action_for_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item performActionForItemAtIndex:$a_index];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item delegate];
			 ]"
		end

	objc_menu_bar_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item menuBarHeight];
			 ]"
		end

	objc_cancel_tracking (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item cancelTracking];
			 ]"
		end

	objc_cancel_tracking_without_animation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item cancelTrackingWithoutAnimation];
			 ]"
		end

	objc_highlighted_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item highlightedItem];
			 ]"
		end

	objc_minimum_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item minimumWidth];
			 ]"
		end

	objc_set_minimum_width_ (an_item: POINTER; a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setMinimumWidth:$a_width];
			 ]"
		end

	objc_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSMenu *)$an_item size];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenu *)$an_item font];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setFont:$a_font];
			 ]"
		end

	objc_allows_context_menu_plug_ins (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item allowsContextMenuPlugIns];
			 ]"
		end

	objc_set_allows_context_menu_plug_ins_ (an_item: POINTER; a_allows: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setAllowsContextMenuPlugIns:$a_allows];
			 ]"
		end

	objc_set_shows_state_column_ (an_item: POINTER; a_shows_state: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setShowsStateColumn:$a_shows_state];
			 ]"
		end

	objc_shows_state_column (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item showsStateColumn];
			 ]"
		end

	objc_set_menu_changed_messages_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item setMenuChangedMessagesEnabled:$a_flag];
			 ]"
		end

	objc_menu_changed_messages_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item menuChangedMessagesEnabled];
			 ]"
		end

	objc_help_requested_ (an_item: POINTER; a_event_ptr: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item helpRequested:$a_event_ptr];
			 ]"
		end

	objc_is_torn_off (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item isTornOff];
			 ]"
		end

feature -- NSMenu

	set_title_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_title_ (item, a_string__item)
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pop_up_menu_positioning_item__at_location__in_view_ (a_item: detachable NS_MENU_ITEM; a_location: NS_POINT; a_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
			a_view__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			Result := objc_pop_up_menu_positioning_item__at_location__in_view_ (item, a_item__item, a_location.item, a_view__item)
		end

	supermenu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_supermenu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like supermenu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like supermenu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_supermenu_ (a_supermenu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_supermenu__item: POINTER
		do
			if attached a_supermenu as a_supermenu_attached then
				a_supermenu__item := a_supermenu_attached.item
			end
			objc_set_supermenu_ (item, a_supermenu__item)
		end

	insert_item__at_index_ (a_new_item: detachable NS_MENU_ITEM; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_new_item__item: POINTER
		do
			if attached a_new_item as a_new_item_attached then
				a_new_item__item := a_new_item_attached.item
			end
			objc_insert_item__at_index_ (item, a_new_item__item, a_index)
		end

	add_item_ (a_new_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_new_item__item: POINTER
		do
			if attached a_new_item as a_new_item_attached then
				a_new_item__item := a_new_item_attached.item
			end
			objc_add_item_ (item, a_new_item__item)
		end

	insert_item_with_title__action__key_equivalent__at_index_ (a_string: detachable NS_STRING; a_selector: detachable OBJC_SELECTOR; a_char_code: detachable NS_STRING; a_index: INTEGER_64): detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
			a_selector__item: POINTER
			a_char_code__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_char_code as a_char_code_attached then
				a_char_code__item := a_char_code_attached.item
			end
			result_pointer := objc_insert_item_with_title__action__key_equivalent__at_index_ (item, a_string__item, a_selector__item, a_char_code__item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insert_item_with_title__action__key_equivalent__at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insert_item_with_title__action__key_equivalent__at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_item_with_title__action__key_equivalent_ (a_string: detachable NS_STRING; a_selector: detachable OBJC_SELECTOR; a_char_code: detachable NS_STRING): detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
			a_selector__item: POINTER
			a_char_code__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_char_code as a_char_code_attached then
				a_char_code__item := a_char_code_attached.item
			end
			result_pointer := objc_add_item_with_title__action__key_equivalent_ (item, a_string__item, a_selector__item, a_char_code__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_item_with_title__action__key_equivalent_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_item_with_title__action__key_equivalent_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_item_at_index_ (item, a_index)
		end

	remove_item_ (a_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_remove_item_ (item, a_item__item)
		end

	set_submenu__for_item_ (a_menu: detachable NS_MENU; an_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
			an_item__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached an_item as an_item_attached then
				an_item__item := an_item_attached.item
			end
			objc_set_submenu__for_item_ (item, a_menu__item, an_item__item)
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

	index_of_item_ (a_index: detachable NS_MENU_ITEM): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_index__item: POINTER
		do
			if attached a_index as a_index_attached then
				a_index__item := a_index_attached.item
			end
			Result := objc_index_of_item_ (item, a_index__item)
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

	index_of_item_with_represented_object_ (a_object: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_index_of_item_with_represented_object_ (item, a_object__item)
		end

	index_of_item_with_submenu_ (a_submenu: detachable NS_MENU): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_submenu__item: POINTER
		do
			if attached a_submenu as a_submenu_attached then
				a_submenu__item := a_submenu_attached.item
			end
			Result := objc_index_of_item_with_submenu_ (item, a_submenu__item)
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

	item_with_tag_ (a_tag: INTEGER_64): detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_with_tag_ (item, a_tag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	update
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update (item)
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

	item_changed_ (a_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_item_changed_ (item, a_item__item)
		end

	perform_action_for_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_perform_action_for_item_at_index_ (item, a_index)
		end

	set_delegate_ (an_object: detachable NS_MENU_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_MENU_DELEGATE_PROTOCOL
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

	menu_bar_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_menu_bar_height (item)
		end

	cancel_tracking
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel_tracking (item)
		end

	cancel_tracking_without_animation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel_tracking_without_animation (item)
		end

	highlighted_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_highlighted_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlighted_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlighted_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	minimum_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_width (item)
		end

	set_minimum_width_ (a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_width_ (item, a_width)
		end

	size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_size (item, Result.item)
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

	allows_context_menu_plug_ins: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_context_menu_plug_ins (item)
		end

	set_allows_context_menu_plug_ins_ (a_allows: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_context_menu_plug_ins_ (item, a_allows)
		end

	set_shows_state_column_ (a_shows_state: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_state_column_ (item, a_shows_state)
		end

	shows_state_column: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_state_column (item)
		end

	set_menu_changed_messages_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_menu_changed_messages_enabled_ (item, a_flag)
		end

	menu_changed_messages_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_menu_changed_messages_enabled (item)
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

	is_torn_off: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_torn_off (item)
		end

feature -- NSSubmenuAction

	submenu_action_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_submenu_action_ (item, a_sender__item)
		end

feature {NONE} -- NSSubmenuAction Externals

	objc_submenu_action_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenu *)$an_item submenuAction:$a_sender];
			 ]"
		end

feature -- NSMenuPropertiesToUpdate

	properties_to_update: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_properties_to_update (item)
		end

feature {NONE} -- NSMenuPropertiesToUpdate Externals

	objc_properties_to_update (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenu *)$an_item propertiesToUpdate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMenu"
		end

end
