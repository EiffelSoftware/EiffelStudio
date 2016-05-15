note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TOKEN_FIELD_CELL_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

--	token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_substring: detachable NS_STRING; a_token_index: INTEGER_64; a_selected_index: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_: has_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_
--		local
--			result_pointer: POINTER
--			a_token_field_cell__item: POINTER
--			a_substring__item: POINTER
--			a_selected_index__item: POINTER
--		do
--			if attached a_token_field_cell as a_token_field_cell_attached then
--				a_token_field_cell__item := a_token_field_cell_attached.item
--			end
--			if attached a_substring as a_substring_attached then
--				a_substring__item := a_substring_attached.item
--			end
--			if attached a_selected_index as a_selected_index_attached then
--				a_selected_index__item := a_selected_index_attached.item
--			end
--			result_pointer := objc_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_ (item, a_token_field_cell__item, a_substring__item, a_token_index, a_selected_index__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	token_field_cell__should_add_objects__at_index_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_tokens: detachable NS_ARRAY; a_index: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__should_add_objects__at_index_: has_token_field_cell__should_add_objects__at_index_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_tokens__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_tokens as a_tokens_attached then
				a_tokens__item := a_tokens_attached.item
			end
			result_pointer := objc_token_field_cell__should_add_objects__at_index_ (item, a_token_field_cell__item, a_tokens__item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__should_add_objects__at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__should_add_objects__at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__display_string_for_represented_object_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_represented_object: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__display_string_for_represented_object_: has_token_field_cell__display_string_for_represented_object_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_represented_object__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			result_pointer := objc_token_field_cell__display_string_for_represented_object_ (item, a_token_field_cell__item, a_represented_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__display_string_for_represented_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__display_string_for_represented_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__editing_string_for_represented_object_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_represented_object: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__editing_string_for_represented_object_: has_token_field_cell__editing_string_for_represented_object_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_represented_object__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			result_pointer := objc_token_field_cell__editing_string_for_represented_object_ (item, a_token_field_cell__item, a_represented_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__editing_string_for_represented_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__editing_string_for_represented_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__represented_object_for_editing_string_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_editing_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__represented_object_for_editing_string_: has_token_field_cell__represented_object_for_editing_string_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_editing_string__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_editing_string as a_editing_string_attached then
				a_editing_string__item := a_editing_string_attached.item
			end
			result_pointer := objc_token_field_cell__represented_object_for_editing_string_ (item, a_token_field_cell__item, a_editing_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__represented_object_for_editing_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__represented_object_for_editing_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__write_represented_objects__to_pasteboard_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_objects: detachable NS_ARRAY; a_pboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__write_represented_objects__to_pasteboard_: has_token_field_cell__write_represented_objects__to_pasteboard_
		local
			a_token_field_cell__item: POINTER
			a_objects__item: POINTER
			a_pboard__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			Result := objc_token_field_cell__write_represented_objects__to_pasteboard_ (item, a_token_field_cell__item, a_objects__item, a_pboard__item)
		end

	token_field_cell__read_from_pasteboard_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_pboard: detachable NS_PASTEBOARD): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__read_from_pasteboard_: has_token_field_cell__read_from_pasteboard_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_pboard__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			result_pointer := objc_token_field_cell__read_from_pasteboard_ (item, a_token_field_cell__item, a_pboard__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__read_from_pasteboard_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__read_from_pasteboard_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__menu_for_represented_object_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_represented_object: detachable NS_OBJECT): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__menu_for_represented_object_: has_token_field_cell__menu_for_represented_object_
		local
			result_pointer: POINTER
			a_token_field_cell__item: POINTER
			a_represented_object__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			result_pointer := objc_token_field_cell__menu_for_represented_object_ (item, a_token_field_cell__item, a_represented_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like token_field_cell__menu_for_represented_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like token_field_cell__menu_for_represented_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	token_field_cell__has_menu_for_represented_object_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_represented_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__has_menu_for_represented_object_: has_token_field_cell__has_menu_for_represented_object_
		local
			a_token_field_cell__item: POINTER
			a_represented_object__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			Result := objc_token_field_cell__has_menu_for_represented_object_ (item, a_token_field_cell__item, a_represented_object__item)
		end

	token_field_cell__style_for_represented_object_ (a_token_field_cell: detachable NS_TOKEN_FIELD_CELL; a_represented_object: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_token_field_cell__style_for_represented_object_: has_token_field_cell__style_for_represented_object_
		local
			a_token_field_cell__item: POINTER
			a_represented_object__item: POINTER
		do
			if attached a_token_field_cell as a_token_field_cell_attached then
				a_token_field_cell__item := a_token_field_cell_attached.item
			end
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			Result := objc_token_field_cell__style_for_represented_object_ (item, a_token_field_cell__item, a_represented_object__item)
		end

feature -- Status Report

--	has_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_ (item)
--		end

	has_token_field_cell__should_add_objects__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__should_add_objects__at_index_ (item)
		end

	has_token_field_cell__display_string_for_represented_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__display_string_for_represented_object_ (item)
		end

	has_token_field_cell__editing_string_for_represented_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__editing_string_for_represented_object_ (item)
		end

	has_token_field_cell__represented_object_for_editing_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__represented_object_for_editing_string_ (item)
		end

	has_token_field_cell__write_represented_objects__to_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__write_represented_objects__to_pasteboard_ (item)
		end

	has_token_field_cell__read_from_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__read_from_pasteboard_ (item)
		end

	has_token_field_cell__menu_for_represented_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__menu_for_represented_object_ (item)
		end

	has_token_field_cell__has_menu_for_represented_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__has_menu_for_represented_object_ (item)
		end

	has_token_field_cell__style_for_represented_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_token_field_cell__style_for_represented_object_ (item)
		end

feature -- Status Report Externals

--	objc_has_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:completionsForSubstring:indexOfToken:indexOfSelectedItem:)];
--			 ]"
--		end

	objc_has_token_field_cell__should_add_objects__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:shouldAddObjects:atIndex:)];
			 ]"
		end

	objc_has_token_field_cell__display_string_for_represented_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:displayStringForRepresentedObject:)];
			 ]"
		end

	objc_has_token_field_cell__editing_string_for_represented_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:editingStringForRepresentedObject:)];
			 ]"
		end

	objc_has_token_field_cell__represented_object_for_editing_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:representedObjectForEditingString:)];
			 ]"
		end

	objc_has_token_field_cell__write_represented_objects__to_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:writeRepresentedObjects:toPasteboard:)];
			 ]"
		end

	objc_has_token_field_cell__read_from_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:readFromPasteboard:)];
			 ]"
		end

	objc_has_token_field_cell__menu_for_represented_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:menuForRepresentedObject:)];
			 ]"
		end

	objc_has_token_field_cell__has_menu_for_represented_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:hasMenuForRepresentedObject:)];
			 ]"
		end

	objc_has_token_field_cell__style_for_represented_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tokenFieldCell:styleForRepresentedObject:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

--	objc_token_field_cell__completions_for_substring__index_of_token__index_of_selected_item_ (an_item: POINTER; a_token_field_cell: POINTER; a_substring: POINTER; a_token_index: INTEGER_64; a_selected_index: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell completionsForSubstring:$a_substring indexOfToken:$a_token_index indexOfSelectedItem:];
--			 ]"
--		end

	objc_token_field_cell__should_add_objects__at_index_ (an_item: POINTER; a_token_field_cell: POINTER; a_tokens: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell shouldAddObjects:$a_tokens atIndex:$a_index];
			 ]"
		end

	objc_token_field_cell__display_string_for_represented_object_ (an_item: POINTER; a_token_field_cell: POINTER; a_represented_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell displayStringForRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_token_field_cell__editing_string_for_represented_object_ (an_item: POINTER; a_token_field_cell: POINTER; a_represented_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell editingStringForRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_token_field_cell__represented_object_for_editing_string_ (an_item: POINTER; a_token_field_cell: POINTER; a_editing_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell representedObjectForEditingString:$a_editing_string];
			 ]"
		end

	objc_token_field_cell__write_represented_objects__to_pasteboard_ (an_item: POINTER; a_token_field_cell: POINTER; a_objects: POINTER; a_pboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell writeRepresentedObjects:$a_objects toPasteboard:$a_pboard];
			 ]"
		end

	objc_token_field_cell__read_from_pasteboard_ (an_item: POINTER; a_token_field_cell: POINTER; a_pboard: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell readFromPasteboard:$a_pboard];
			 ]"
		end

	objc_token_field_cell__menu_for_represented_object_ (an_item: POINTER; a_token_field_cell: POINTER; a_represented_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell menuForRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_token_field_cell__has_menu_for_represented_object_ (an_item: POINTER; a_token_field_cell: POINTER; a_represented_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell hasMenuForRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_token_field_cell__style_for_represented_object_ (an_item: POINTER; a_token_field_cell: POINTER; a_represented_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTokenFieldCellDelegate>)$an_item tokenFieldCell:$a_token_field_cell styleForRepresentedObject:$a_represented_object];
			 ]"
		end

end
