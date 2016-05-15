note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end

	NS_CHANGE_SPELLING_PROTOCOL
	NS_IGNORE_MISSPELLED_WORDS_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSText

	string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_string_ (item, a_string__item)
		end

	replace_characters_in_range__with_string_ (a_range: NS_RANGE; a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_replace_characters_in_range__with_string_ (item, a_range.item, a_string__item)
		end

	replace_characters_in_range__with_rt_f_ (a_range: NS_RANGE; a_rtf_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_rtf_data__item: POINTER
		do
			if attached a_rtf_data as a_rtf_data_attached then
				a_rtf_data__item := a_rtf_data_attached.item
			end
			objc_replace_characters_in_range__with_rt_f_ (item, a_range.item, a_rtf_data__item)
		end

	replace_characters_in_range__with_rtf_d_ (a_range: NS_RANGE; a_rtfd_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_rtfd_data__item: POINTER
		do
			if attached a_rtfd_data as a_rtfd_data_attached then
				a_rtfd_data__item := a_rtfd_data_attached.item
			end
			objc_replace_characters_in_range__with_rtf_d_ (item, a_range.item, a_rtfd_data__item)
		end

	rtf_from_range_ (a_range: NS_RANGE): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_rtf_from_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rtf_from_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rtf_from_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rtfd_from_range_ (a_range: NS_RANGE): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_rtfd_from_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rtfd_from_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rtfd_from_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_rtfd_to_file__atomically_ (a_path: detachable NS_STRING; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_write_rtfd_to_file__atomically_ (item, a_path__item, a_flag)
		end

	read_rtfd_from_file_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_read_rtfd_from_file_ (item, a_path__item)
		end

	delegate: detachable NS_TEXT_DELEGATE_PROTOCOL
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

	set_delegate_ (an_object: detachable NS_TEXT_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	set_editable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_flag)
		end

	is_selectable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selectable (item)
		end

	set_selectable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selectable_ (item, a_flag)
		end

	is_rich_text: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_rich_text (item)
		end

	set_rich_text_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_rich_text_ (item, a_flag)
		end

	imports_graphics: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_imports_graphics (item)
		end

	set_imports_graphics_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_imports_graphics_ (item, a_flag)
		end

	is_field_editor: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_field_editor (item)
		end

	set_field_editor_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_field_editor_ (item, a_flag)
		end

	uses_font_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_font_panel (item)
		end

	set_uses_font_panel_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_font_panel_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	is_ruler_visible: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_ruler_visible (item)
		end

	selected_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_selected_range (item, Result.item)
		end

	set_selected_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selected_range_ (item, a_range.item)
		end

	scroll_range_to_visible_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_range_to_visible_ (item, a_range.item)
		end

	set_font_ (a_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_font_ (item, a_obj__item)
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

	set_text_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_text_color_ (item, a_color__item)
		end

	text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alignment (item)
		end

	set_alignment_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment_ (item, a_mode)
		end

	base_writing_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_base_writing_direction (item)
		end

	set_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_base_writing_direction_ (item, a_writing_direction)
		end

	set_text_color__range_ (a_color: detachable NS_COLOR; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_text_color__range_ (item, a_color__item, a_range.item)
		end

	set_font__range_ (a_font: detachable NS_FONT; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_font__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			objc_set_font__range_ (item, a_font__item, a_range.item)
		end

	max_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_max_size (item, Result.item)
		end

	set_max_size_ (a_new_max_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_size_ (item, a_new_max_size.item)
		end

	min_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_size (item, Result.item)
		end

	set_min_size_ (a_new_min_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_size_ (item, a_new_min_size.item)
		end

	is_horizontally_resizable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_horizontally_resizable (item)
		end

	set_horizontally_resizable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_horizontally_resizable_ (item, a_flag)
		end

	is_vertically_resizable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertically_resizable (item)
		end

	set_vertically_resizable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertically_resizable_ (item, a_flag)
		end

	size_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_fit (item)
		end

	copy_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_copy_ (item, a_sender__item)
		end

	copy_font_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_copy_font_ (item, a_sender__item)
		end

	copy_ruler_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_copy_ruler_ (item, a_sender__item)
		end

	cut_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_cut_ (item, a_sender__item)
		end

	delete_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_delete_ (item, a_sender__item)
		end

	paste_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_paste_ (item, a_sender__item)
		end

	paste_font_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_paste_font_ (item, a_sender__item)
		end

	paste_ruler_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_paste_ruler_ (item, a_sender__item)
		end

	align_left_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_align_left_ (item, a_sender__item)
		end

	align_right_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_align_right_ (item, a_sender__item)
		end

	align_center_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_align_center_ (item, a_sender__item)
		end

	subscript_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_subscript_ (item, a_sender__item)
		end

	superscript_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_superscript_ (item, a_sender__item)
		end

	underline_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_underline_ (item, a_sender__item)
		end

	unscript_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_unscript_ (item, a_sender__item)
		end

	show_guess_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_show_guess_panel_ (item, a_sender__item)
		end

	check_spelling_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_check_spelling_ (item, a_sender__item)
		end

	toggle_ruler_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_ruler_ (item, a_sender__item)
		end

feature {NONE} -- NSText Externals

	objc_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item string];
			 ]"
		end

	objc_set_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setString:$a_string];
			 ]"
		end

	objc_replace_characters_in_range__with_string_ (an_item: POINTER; a_range: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withString:$a_string];
			 ]"
		end

	objc_replace_characters_in_range__with_rt_f_ (an_item: POINTER; a_range: POINTER; a_rtf_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withRTF:$a_rtf_data];
			 ]"
		end

	objc_replace_characters_in_range__with_rtf_d_ (an_item: POINTER; a_range: POINTER; a_rtfd_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withRTFD:$a_rtfd_data];
			 ]"
		end

	objc_rtf_from_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item RTFFromRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_rtfd_from_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item RTFDFromRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_write_rtfd_to_file__atomically_ (an_item: POINTER; a_path: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item writeRTFDToFile:$a_path atomically:$a_flag];
			 ]"
		end

	objc_read_rtfd_from_file_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item readRTFDFromFile:$a_path];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isEditable];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setEditable:$a_flag];
			 ]"
		end

	objc_is_selectable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isSelectable];
			 ]"
		end

	objc_set_selectable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setSelectable:$a_flag];
			 ]"
		end

	objc_is_rich_text (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isRichText];
			 ]"
		end

	objc_set_rich_text_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setRichText:$a_flag];
			 ]"
		end

	objc_imports_graphics (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item importsGraphics];
			 ]"
		end

	objc_set_imports_graphics_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setImportsGraphics:$a_flag];
			 ]"
		end

	objc_is_field_editor (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isFieldEditor];
			 ]"
		end

	objc_set_field_editor_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setFieldEditor:$a_flag];
			 ]"
		end

	objc_uses_font_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item usesFontPanel];
			 ]"
		end

	objc_set_uses_font_panel_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setUsesFontPanel:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item drawsBackground];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item backgroundColor];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_is_ruler_visible (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isRulerVisible];
			 ]"
		end

	objc_selected_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSText *)$an_item selectedRange];
			 ]"
		end

	objc_set_selected_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setSelectedRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_scroll_range_to_visible_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item scrollRangeToVisible:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setFont:$a_obj];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item font];
			 ]"
		end

	objc_set_text_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setTextColor:$a_color];
			 ]"
		end

	objc_text_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSText *)$an_item textColor];
			 ]"
		end

	objc_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item alignment];
			 ]"
		end

	objc_set_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setAlignment:$a_mode];
			 ]"
		end

	objc_base_writing_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item baseWritingDirection];
			 ]"
		end

	objc_set_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setBaseWritingDirection:$a_writing_direction];
			 ]"
		end

	objc_set_text_color__range_ (an_item: POINTER; a_color: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setTextColor:$a_color range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_font__range_ (an_item: POINTER; a_font: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setFont:$a_font range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_max_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSText *)$an_item maxSize];
			 ]"
		end

	objc_set_max_size_ (an_item: POINTER; a_new_max_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setMaxSize:*((NSSize *)$a_new_max_size)];
			 ]"
		end

	objc_min_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSText *)$an_item minSize];
			 ]"
		end

	objc_set_min_size_ (an_item: POINTER; a_new_min_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setMinSize:*((NSSize *)$a_new_min_size)];
			 ]"
		end

	objc_is_horizontally_resizable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isHorizontallyResizable];
			 ]"
		end

	objc_set_horizontally_resizable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setHorizontallyResizable:$a_flag];
			 ]"
		end

	objc_is_vertically_resizable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSText *)$an_item isVerticallyResizable];
			 ]"
		end

	objc_set_vertically_resizable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item setVerticallyResizable:$a_flag];
			 ]"
		end

	objc_size_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item sizeToFit];
			 ]"
		end

	objc_copy_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item copy:$a_sender];
			 ]"
		end

	objc_copy_font_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item copyFont:$a_sender];
			 ]"
		end

	objc_copy_ruler_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item copyRuler:$a_sender];
			 ]"
		end

	objc_cut_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item cut:$a_sender];
			 ]"
		end

	objc_delete_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item delete:$a_sender];
			 ]"
		end

	objc_paste_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item paste:$a_sender];
			 ]"
		end

	objc_paste_font_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item pasteFont:$a_sender];
			 ]"
		end

	objc_paste_ruler_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item pasteRuler:$a_sender];
			 ]"
		end

	objc_align_left_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item alignLeft:$a_sender];
			 ]"
		end

	objc_align_right_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item alignRight:$a_sender];
			 ]"
		end

	objc_align_center_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item alignCenter:$a_sender];
			 ]"
		end

	objc_subscript_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item subscript:$a_sender];
			 ]"
		end

	objc_superscript_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item superscript:$a_sender];
			 ]"
		end

	objc_underline_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item underline:$a_sender];
			 ]"
		end

	objc_unscript_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item unscript:$a_sender];
			 ]"
		end

	objc_show_guess_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item showGuessPanel:$a_sender];
			 ]"
		end

	objc_check_spelling_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item checkSpelling:$a_sender];
			 ]"
		end

	objc_toggle_ruler_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSText *)$an_item toggleRuler:$a_sender];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSText"
		end

end
