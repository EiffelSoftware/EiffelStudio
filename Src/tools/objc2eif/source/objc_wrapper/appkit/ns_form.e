note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FORM

inherit
	NS_MATRIX
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make_with_frame__mode__prototype__number_of_rows__number_of_columns_,
	make_with_frame__mode__cell_class__number_of_rows__number_of_columns_,
	make

feature -- NSForm

	index_of_selected_item: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_selected_item (item)
		end

	set_entry_width_ (a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_entry_width_ (item, a_width)
		end

	set_interline_spacing_ (a_spacing: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_interline_spacing_ (item, a_spacing)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	set_bezeled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezeled_ (item, a_flag)
		end

	set_title_alignment_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_alignment_ (item, a_mode)
		end

	set_text_alignment_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_text_alignment_ (item, a_mode)
		end

	set_title_font_ (a_font_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_title_font_ (item, a_font_obj__item)
		end

	set_text_font_ (a_font_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_text_font_ (item, a_font_obj__item)
		end

	cell_at_index_ (a_index: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_cell_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_cell_at_index_ (item, a_index)
		end

	add_entry_ (a_title: detachable NS_STRING): detachable NS_FORM_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			result_pointer := objc_add_entry_ (item, a_title__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_entry_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_entry_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_entry__at_index_ (a_title: detachable NS_STRING; a_index: INTEGER_64): detachable NS_FORM_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			result_pointer := objc_insert_entry__at_index_ (item, a_title__item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insert_entry__at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insert_entry__at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_entry_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_entry_at_index_ (item, a_index)
		end

	index_of_cell_with_tag_ (a_tag: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_cell_with_tag_ (item, a_tag)
		end

	select_text_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_text_at_index_ (item, a_index)
		end

	set_title_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_base_writing_direction_ (item, a_writing_direction)
		end

	set_text_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_text_base_writing_direction_ (item, a_writing_direction)
		end

feature {NONE} -- NSForm Externals

	objc_index_of_selected_item (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSForm *)$an_item indexOfSelectedItem];
			 ]"
		end

	objc_set_entry_width_ (an_item: POINTER; a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setEntryWidth:$a_width];
			 ]"
		end

	objc_set_interline_spacing_ (an_item: POINTER; a_spacing: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setInterlineSpacing:$a_spacing];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_set_bezeled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setBezeled:$a_flag];
			 ]"
		end

	objc_set_title_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTitleAlignment:$a_mode];
			 ]"
		end

	objc_set_text_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTextAlignment:$a_mode];
			 ]"
		end

	objc_set_title_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTitleFont:$a_font_obj];
			 ]"
		end

	objc_set_text_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTextFont:$a_font_obj];
			 ]"
		end

	objc_cell_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSForm *)$an_item cellAtIndex:$a_index];
			 ]"
		end

	objc_draw_cell_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item drawCellAtIndex:$a_index];
			 ]"
		end

	objc_add_entry_ (an_item: POINTER; a_title: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSForm *)$an_item addEntry:$a_title];
			 ]"
		end

	objc_insert_entry__at_index_ (an_item: POINTER; a_title: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSForm *)$an_item insertEntry:$a_title atIndex:$a_index];
			 ]"
		end

	objc_remove_entry_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item removeEntryAtIndex:$a_index];
			 ]"
		end

	objc_index_of_cell_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSForm *)$an_item indexOfCellWithTag:$a_tag];
			 ]"
		end

	objc_select_text_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item selectTextAtIndex:$a_index];
			 ]"
		end

	objc_set_title_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTitleBaseWritingDirection:$a_writing_direction];
			 ]"
		end

	objc_set_text_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSForm *)$an_item setTextBaseWritingDirection:$a_writing_direction];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSForm"
		end

end
