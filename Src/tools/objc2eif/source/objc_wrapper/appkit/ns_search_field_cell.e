note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEARCH_FIELD_CELL

inherit
	NS_TEXT_FIELD_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSSearchFieldCell

	search_button_cell: detachable NS_BUTTON_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_search_button_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like search_button_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like search_button_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_search_button_cell_ (a_cell: detachable NS_BUTTON_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_search_button_cell_ (item, a_cell__item)
		end

	cancel_button_cell: detachable NS_BUTTON_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cancel_button_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cancel_button_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cancel_button_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cancel_button_cell_ (a_cell: detachable NS_BUTTON_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_cancel_button_cell_ (item, a_cell__item)
		end

	reset_search_button_cell
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset_search_button_cell (item)
		end

	reset_cancel_button_cell
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset_cancel_button_cell (item)
		end

	search_text_rect_for_bounds_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_search_text_rect_for_bounds_ (item, Result.item, a_rect.item)
		end

	search_button_rect_for_bounds_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_search_button_rect_for_bounds_ (item, Result.item, a_rect.item)
		end

	cancel_button_rect_for_bounds_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cancel_button_rect_for_bounds_ (item, Result.item, a_rect.item)
		end

	set_search_menu_template_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_search_menu_template_ (item, a_menu__item)
		end

	search_menu_template: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_search_menu_template (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like search_menu_template} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like search_menu_template} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_sends_whole_search_string_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sends_whole_search_string_ (item, a_flag)
		end

	sends_whole_search_string: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_sends_whole_search_string (item)
		end

	set_maximum_recents_ (a_max_recents: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_maximum_recents_ (item, a_max_recents)
		end

	maximum_recents: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_recents (item)
		end

	set_recent_searches_ (a_searches: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_searches__item: POINTER
		do
			if attached a_searches as a_searches_attached then
				a_searches__item := a_searches_attached.item
			end
			objc_set_recent_searches_ (item, a_searches__item)
		end

	recent_searches: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recent_searches (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recent_searches} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recent_searches} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_recents_autosave_name_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_recents_autosave_name_ (item, a_string__item)
		end

	recents_autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recents_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recents_autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recents_autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sends_search_string_immediately: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_sends_search_string_immediately (item)
		end

	set_sends_search_string_immediately_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sends_search_string_immediately_ (item, a_flag)
		end

feature {NONE} -- NSSearchFieldCell Externals

	objc_search_button_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchFieldCell *)$an_item searchButtonCell];
			 ]"
		end

	objc_set_search_button_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setSearchButtonCell:$a_cell];
			 ]"
		end

	objc_cancel_button_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchFieldCell *)$an_item cancelButtonCell];
			 ]"
		end

	objc_set_cancel_button_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setCancelButtonCell:$a_cell];
			 ]"
		end

	objc_reset_search_button_cell (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item resetSearchButtonCell];
			 ]"
		end

	objc_reset_cancel_button_cell (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item resetCancelButtonCell];
			 ]"
		end

	objc_search_text_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSearchFieldCell *)$an_item searchTextRectForBounds:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_search_button_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSearchFieldCell *)$an_item searchButtonRectForBounds:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_cancel_button_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSearchFieldCell *)$an_item cancelButtonRectForBounds:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_set_search_menu_template_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setSearchMenuTemplate:$a_menu];
			 ]"
		end

	objc_search_menu_template (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchFieldCell *)$an_item searchMenuTemplate];
			 ]"
		end

	objc_set_sends_whole_search_string_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setSendsWholeSearchString:$a_flag];
			 ]"
		end

	objc_sends_whole_search_string (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSearchFieldCell *)$an_item sendsWholeSearchString];
			 ]"
		end

	objc_set_maximum_recents_ (an_item: POINTER; a_max_recents: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setMaximumRecents:$a_max_recents];
			 ]"
		end

	objc_maximum_recents (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSearchFieldCell *)$an_item maximumRecents];
			 ]"
		end

	objc_set_recent_searches_ (an_item: POINTER; a_searches: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setRecentSearches:$a_searches];
			 ]"
		end

	objc_recent_searches (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchFieldCell *)$an_item recentSearches];
			 ]"
		end

	objc_set_recents_autosave_name_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setRecentsAutosaveName:$a_string];
			 ]"
		end

	objc_recents_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchFieldCell *)$an_item recentsAutosaveName];
			 ]"
		end

	objc_sends_search_string_immediately (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSearchFieldCell *)$an_item sendsSearchStringImmediately];
			 ]"
		end

	objc_set_sends_search_string_immediately_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchFieldCell *)$an_item setSendsSearchStringImmediately:$a_flag];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSearchFieldCell"
		end

end
