note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_PARAGRAPH_STYLE

inherit
	NS_PARAGRAPH_STYLE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSMutableParagraphStyle

	set_line_spacing_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_spacing_ (item, a_float)
		end

	set_paragraph_spacing_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_paragraph_spacing_ (item, a_float)
		end

	set_alignment_ (a_alignment: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment_ (item, a_alignment)
		end

	set_first_line_head_indent_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_first_line_head_indent_ (item, a_float)
		end

	set_head_indent_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_head_indent_ (item, a_float)
		end

	set_tail_indent_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tail_indent_ (item, a_float)
		end

	set_line_break_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_break_mode_ (item, a_mode)
		end

	set_minimum_line_height_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_line_height_ (item, a_float)
		end

	set_maximum_line_height_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_maximum_line_height_ (item, a_float)
		end

	add_tab_stop_ (an_object: detachable NS_TEXT_TAB)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_add_tab_stop_ (item, an_object__item)
		end

	remove_tab_stop_ (an_object: detachable NS_TEXT_TAB)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_tab_stop_ (item, an_object__item)
		end

	set_tab_stops_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_tab_stops_ (item, a_array__item)
		end

	set_paragraph_style_ (a_obj: detachable NS_PARAGRAPH_STYLE)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_paragraph_style_ (item, a_obj__item)
		end

	set_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_base_writing_direction_ (item, a_writing_direction)
		end

	set_line_height_multiple_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_height_multiple_ (item, a_float)
		end

	set_paragraph_spacing_before_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_paragraph_spacing_before_ (item, a_float)
		end

	set_default_tab_interval_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_default_tab_interval_ (item, a_float)
		end

	set_text_blocks_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_text_blocks_ (item, a_array__item)
		end

	set_text_lists_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_text_lists_ (item, a_array__item)
		end

	set_hyphenation_factor_ (a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hyphenation_factor_ (item, a_factor)
		end

	set_tightening_factor_for_truncation_ (a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tightening_factor_for_truncation_ (item, a_factor)
		end

	set_header_level_ (a_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_header_level_ (item, a_level)
		end

feature {NONE} -- NSMutableParagraphStyle Externals

	objc_set_line_spacing_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setLineSpacing:$a_float];
			 ]"
		end

	objc_set_paragraph_spacing_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setParagraphSpacing:$a_float];
			 ]"
		end

	objc_set_alignment_ (an_item: POINTER; a_alignment: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setAlignment:$a_alignment];
			 ]"
		end

	objc_set_first_line_head_indent_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setFirstLineHeadIndent:$a_float];
			 ]"
		end

	objc_set_head_indent_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setHeadIndent:$a_float];
			 ]"
		end

	objc_set_tail_indent_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setTailIndent:$a_float];
			 ]"
		end

	objc_set_line_break_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setLineBreakMode:$a_mode];
			 ]"
		end

	objc_set_minimum_line_height_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setMinimumLineHeight:$a_float];
			 ]"
		end

	objc_set_maximum_line_height_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setMaximumLineHeight:$a_float];
			 ]"
		end

	objc_add_tab_stop_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item addTabStop:$an_object];
			 ]"
		end

	objc_remove_tab_stop_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item removeTabStop:$an_object];
			 ]"
		end

	objc_set_tab_stops_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setTabStops:$a_array];
			 ]"
		end

	objc_set_paragraph_style_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setParagraphStyle:$a_obj];
			 ]"
		end

	objc_set_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setBaseWritingDirection:$a_writing_direction];
			 ]"
		end

	objc_set_line_height_multiple_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setLineHeightMultiple:$a_float];
			 ]"
		end

	objc_set_paragraph_spacing_before_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setParagraphSpacingBefore:$a_float];
			 ]"
		end

	objc_set_default_tab_interval_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setDefaultTabInterval:$a_float];
			 ]"
		end

	objc_set_text_blocks_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setTextBlocks:$a_array];
			 ]"
		end

	objc_set_text_lists_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setTextLists:$a_array];
			 ]"
		end

	objc_set_hyphenation_factor_ (an_item: POINTER; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setHyphenationFactor:$a_factor];
			 ]"
		end

	objc_set_tightening_factor_for_truncation_ (an_item: POINTER; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setTighteningFactorForTruncation:$a_factor];
			 ]"
		end

	objc_set_header_level_ (an_item: POINTER; a_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableParagraphStyle *)$an_item setHeaderLevel:$a_level];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableParagraphStyle"
		end

end
