note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BOX

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

feature -- NSBox

	border_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_border_type (item)
		end

	title_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_position (item)
		end

	set_border_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_border_type_ (item, a_type)
		end

	set_box_type_ (a_box_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_box_type_ (item, a_box_type)
		end

	box_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_box_type (item)
		end

	set_title_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_title_position_ (item, a_position)
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

	border_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_border_rect (item, Result.item)
		end

	title_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_title_rect (item, Result.item)
		end

	title_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	size_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_fit (item)
		end

	content_view_margins: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_view_margins (item, Result.item)
		end

	set_content_view_margins_ (a_offset_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_view_margins_ (item, a_offset_size.item)
		end

	set_frame_from_content_frame_ (a_content_frame: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_from_content_frame_ (item, a_content_frame.item)
		end

	content_view: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_content_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_content_view_ (item, a_view__item)
		end

	is_transparent: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_transparent (item)
		end

	set_transparent_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_transparent_ (item, a_flag)
		end

feature {NONE} -- NSBox Externals

	objc_border_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item borderType];
			 ]"
		end

	objc_title_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item titlePosition];
			 ]"
		end

	objc_set_border_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setBorderType:$a_type];
			 ]"
		end

	objc_set_box_type_ (an_item: POINTER; a_box_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setBoxType:$a_box_type];
			 ]"
		end

	objc_box_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item boxType];
			 ]"
		end

	objc_set_title_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setTitlePosition:$a_position];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_title_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item titleFont];
			 ]"
		end

	objc_set_title_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setTitleFont:$a_font_obj];
			 ]"
		end

	objc_border_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBox *)$an_item borderRect];
			 ]"
		end

	objc_title_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBox *)$an_item titleRect];
			 ]"
		end

	objc_title_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item titleCell];
			 ]"
		end

	objc_size_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item sizeToFit];
			 ]"
		end

	objc_content_view_margins (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSBox *)$an_item contentViewMargins];
			 ]"
		end

	objc_set_content_view_margins_ (an_item: POINTER; a_offset_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setContentViewMargins:*((NSSize *)$a_offset_size)];
			 ]"
		end

	objc_set_frame_from_content_frame_ (an_item: POINTER; a_content_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setFrameFromContentFrame:*((NSRect *)$a_content_frame)];
			 ]"
		end

	objc_content_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item contentView];
			 ]"
		end

	objc_set_content_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setContentView:$a_view];
			 ]"
		end

	objc_is_transparent (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item isTransparent];
			 ]"
		end

	objc_set_transparent_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setTransparent:$a_flag];
			 ]"
		end

feature -- NSKeyboardUI

	set_title_with_mnemonic_ (a_string_with_ampersand: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string_with_ampersand__item: POINTER
		do
			if attached a_string_with_ampersand as a_string_with_ampersand_attached then
				a_string_with_ampersand__item := a_string_with_ampersand_attached.item
			end
			objc_set_title_with_mnemonic_ (item, a_string_with_ampersand__item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

feature -- NSCustomBoxTypeProperties

	border_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_border_width (item)
		end

	set_border_width_ (a_border_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_border_width_ (item, a_border_width)
		end

	corner_radius: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_corner_radius (item)
		end

	set_corner_radius_ (a_corner_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_corner_radius_ (item, a_corner_radius)
		end

	border_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_border_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like border_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like border_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_border_color_ (a_border_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_border_color__item: POINTER
		do
			if attached a_border_color as a_border_color_attached then
				a_border_color__item := a_border_color_attached.item
			end
			objc_set_border_color_ (item, a_border_color__item)
		end

	fill_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fill_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fill_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fill_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_fill_color_ (a_fill_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_fill_color__item: POINTER
		do
			if attached a_fill_color as a_fill_color_attached then
				a_fill_color__item := a_fill_color_attached.item
			end
			objc_set_fill_color_ (item, a_fill_color__item)
		end

feature {NONE} -- NSCustomBoxTypeProperties Externals

	objc_border_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item borderWidth];
			 ]"
		end

	objc_set_border_width_ (an_item: POINTER; a_border_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setBorderWidth:$a_border_width];
			 ]"
		end

	objc_corner_radius (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBox *)$an_item cornerRadius];
			 ]"
		end

	objc_set_corner_radius_ (an_item: POINTER; a_corner_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setCornerRadius:$a_corner_radius];
			 ]"
		end

	objc_border_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item borderColor];
			 ]"
		end

	objc_set_border_color_ (an_item: POINTER; a_border_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setBorderColor:$a_border_color];
			 ]"
		end

	objc_fill_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBox *)$an_item fillColor];
			 ]"
		end

	objc_set_fill_color_ (an_item: POINTER; a_fill_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBox *)$an_item setFillColor:$a_fill_color];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBox"
		end

end
