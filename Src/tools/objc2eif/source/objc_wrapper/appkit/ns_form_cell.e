note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FORM_CELL

inherit
	NS_ACTION_CELL
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

feature -- NSFormCell

	title_width_ (a_size: NS_SIZE): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_width_ (item, a_size.item)
		end

	title_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_width (item)
		end

	set_title_width_ (a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_width_ (item, a_width)
		end

	title_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	title_alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_alignment (item)
		end

	set_title_alignment_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_alignment_ (item, a_mode)
		end

	set_placeholder_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_string_ (item, a_string__item)
		end

	placeholder_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_placeholder_attributed_string_ (a_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_attributed_string_ (item, a_string__item)
		end

	placeholder_attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_attributed_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_attributed_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_attributed_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	title_base_writing_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_base_writing_direction (item)
		end

	set_title_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_base_writing_direction_ (item, a_writing_direction)
		end

feature {NONE} -- NSFormCell Externals

	objc_title_width_ (an_item: POINTER; a_size: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFormCell *)$an_item titleWidth:*((NSSize *)$a_size)];
			 ]"
		end

	objc_title_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFormCell *)$an_item titleWidth];
			 ]"
		end

	objc_set_title_width_ (an_item: POINTER; a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setTitleWidth:$a_width];
			 ]"
		end

	objc_title_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormCell *)$an_item titleFont];
			 ]"
		end

	objc_set_title_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setTitleFont:$a_font_obj];
			 ]"
		end

	objc_title_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFormCell *)$an_item titleAlignment];
			 ]"
		end

	objc_set_title_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setTitleAlignment:$a_mode];
			 ]"
		end

	objc_set_placeholder_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setPlaceholderString:$a_string];
			 ]"
		end

	objc_placeholder_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormCell *)$an_item placeholderString];
			 ]"
		end

	objc_set_placeholder_attributed_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setPlaceholderAttributedString:$a_string];
			 ]"
		end

	objc_placeholder_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormCell *)$an_item placeholderAttributedString];
			 ]"
		end

	objc_title_base_writing_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFormCell *)$an_item titleBaseWritingDirection];
			 ]"
		end

	objc_set_title_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setTitleBaseWritingDirection:$a_writing_direction];
			 ]"
		end

feature -- NSFormCellAttributedStringMethods

	attributed_title: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_title_ (a_obj: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_attributed_title_ (item, a_obj__item)
		end

feature {NONE} -- NSFormCellAttributedStringMethods Externals

	objc_attributed_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormCell *)$an_item attributedTitle];
			 ]"
		end

	objc_set_attributed_title_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFormCell *)$an_item setAttributedTitle:$a_obj];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFormCell"
		end

end
