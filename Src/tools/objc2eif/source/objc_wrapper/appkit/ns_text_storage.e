note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_STORAGE

inherit
	NS_MUTABLE_ATTRIBUTED_STRING
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_string_,
	make_with_string__attributes_,
	make_with_attributed_string_,
	make

feature -- NSTextStorage

	add_layout_manager_ (a_obj: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_add_layout_manager_ (item, a_obj__item)
		end

	remove_layout_manager_ (a_obj: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_remove_layout_manager_ (item, a_obj__item)
		end

	layout_managers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layout_managers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layout_managers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layout_managers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	edited__range__change_in_length_ (a_edited_mask: NATURAL_64; a_range: NS_RANGE; a_delta: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_edited__range__change_in_length_ (item, a_edited_mask, a_range.item, a_delta)
		end

	process_editing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_process_editing (item)
		end

	invalidate_attributes_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_attributes_in_range_ (item, a_range.item)
		end

	ensure_attributes_are_fixed_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_ensure_attributes_are_fixed_in_range_ (item, a_range.item)
		end

	fixes_attributes_lazily: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_fixes_attributes_lazily (item)
		end

	edited_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_edited_mask (item)
		end

	edited_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_edited_range (item, Result.item)
		end

	change_in_length: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_change_in_length (item)
		end

	set_delegate_ (a_delegate: detachable NS_TEXT_STORAGE_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_TEXT_STORAGE_DELEGATE_PROTOCOL
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

feature {NONE} -- NSTextStorage Externals

	objc_add_layout_manager_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item addLayoutManager:$a_obj];
			 ]"
		end

	objc_remove_layout_manager_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item removeLayoutManager:$a_obj];
			 ]"
		end

	objc_layout_managers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item layoutManagers];
			 ]"
		end

	objc_edited__range__change_in_length_ (an_item: POINTER; a_edited_mask: NATURAL_64; a_range: POINTER; a_delta: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item edited:$a_edited_mask range:*((NSRange *)$a_range) changeInLength:$a_delta];
			 ]"
		end

	objc_process_editing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item processEditing];
			 ]"
		end

	objc_invalidate_attributes_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item invalidateAttributesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_ensure_attributes_are_fixed_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item ensureAttributesAreFixedInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_fixes_attributes_lazily (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextStorage *)$an_item fixesAttributesLazily];
			 ]"
		end

	objc_edited_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextStorage *)$an_item editedMask];
			 ]"
		end

	objc_edited_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextStorage *)$an_item editedRange];
			 ]"
		end

	objc_change_in_length (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextStorage *)$an_item changeInLength];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item delegate];
			 ]"
		end

feature -- Scripting

	attribute_runs: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_runs (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_runs} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_runs} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attribute_runs_ (a_attribute_runs: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_attribute_runs__item: POINTER
		do
			if attached a_attribute_runs as a_attribute_runs_attached then
				a_attribute_runs__item := a_attribute_runs_attached.item
			end
			objc_set_attribute_runs_ (item, a_attribute_runs__item)
		end

	paragraphs: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_paragraphs (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like paragraphs} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like paragraphs} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_paragraphs_ (a_paragraphs: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_paragraphs__item: POINTER
		do
			if attached a_paragraphs as a_paragraphs_attached then
				a_paragraphs__item := a_paragraphs_attached.item
			end
			objc_set_paragraphs_ (item, a_paragraphs__item)
		end

	words: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_words (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like words} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like words} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_words_ (a_words: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_words__item: POINTER
		do
			if attached a_words as a_words_attached then
				a_words__item := a_words_attached.item
			end
			objc_set_words_ (item, a_words__item)
		end

	characters: detachable NS_ARRAY
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

	set_characters_ (a_characters: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_characters__item: POINTER
		do
			if attached a_characters as a_characters_attached then
				a_characters__item := a_characters_attached.item
			end
			objc_set_characters_ (item, a_characters__item)
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

	foreground_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_foreground_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like foreground_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like foreground_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_foreground_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_foreground_color_ (item, a_color__item)
		end

feature {NONE} -- Scripting Externals

	objc_attribute_runs (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item attributeRuns];
			 ]"
		end

	objc_set_attribute_runs_ (an_item: POINTER; a_attribute_runs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setAttributeRuns:$a_attribute_runs];
			 ]"
		end

	objc_paragraphs (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item paragraphs];
			 ]"
		end

	objc_set_paragraphs_ (an_item: POINTER; a_paragraphs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setParagraphs:$a_paragraphs];
			 ]"
		end

	objc_words (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item words];
			 ]"
		end

	objc_set_words_ (an_item: POINTER; a_words: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setWords:$a_words];
			 ]"
		end

	objc_characters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item characters];
			 ]"
		end

	objc_set_characters_ (an_item: POINTER; a_characters: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setCharacters:$a_characters];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item font];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setFont:$a_font];
			 ]"
		end

	objc_foreground_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextStorage *)$an_item foregroundColor];
			 ]"
		end

	objc_set_foreground_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextStorage *)$an_item setForegroundColor:$a_color];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextStorage"
		end

end
