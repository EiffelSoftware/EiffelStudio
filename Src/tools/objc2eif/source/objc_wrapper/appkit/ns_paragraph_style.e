note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PARAGRAPH_STYLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSParagraphStyle

	line_spacing: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_spacing (item)
		end

	paragraph_spacing: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_paragraph_spacing (item)
		end

	alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alignment (item)
		end

	head_indent: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_head_indent (item)
		end

	tail_indent: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tail_indent (item)
		end

	first_line_head_indent: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_line_head_indent (item)
		end

	tab_stops: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tab_stops (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tab_stops} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tab_stops} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	minimum_line_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_line_height (item)
		end

	maximum_line_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_line_height (item)
		end

	line_break_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_break_mode (item)
		end

	base_writing_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_base_writing_direction (item)
		end

	line_height_multiple: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_height_multiple (item)
		end

	paragraph_spacing_before: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_paragraph_spacing_before (item)
		end

	default_tab_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_default_tab_interval (item)
		end

	text_blocks: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_blocks (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_blocks} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_blocks} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_lists: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_lists (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_lists} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_lists} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	hyphenation_factor: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hyphenation_factor (item)
		end

	tightening_factor_for_truncation: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tightening_factor_for_truncation (item)
		end

	header_level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_header_level (item)
		end

feature {NONE} -- NSParagraphStyle Externals

	objc_line_spacing (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item lineSpacing];
			 ]"
		end

	objc_paragraph_spacing (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item paragraphSpacing];
			 ]"
		end

	objc_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item alignment];
			 ]"
		end

	objc_head_indent (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item headIndent];
			 ]"
		end

	objc_tail_indent (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item tailIndent];
			 ]"
		end

	objc_first_line_head_indent (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item firstLineHeadIndent];
			 ]"
		end

	objc_tab_stops (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSParagraphStyle *)$an_item tabStops];
			 ]"
		end

	objc_minimum_line_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item minimumLineHeight];
			 ]"
		end

	objc_maximum_line_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item maximumLineHeight];
			 ]"
		end

	objc_line_break_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item lineBreakMode];
			 ]"
		end

	objc_base_writing_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item baseWritingDirection];
			 ]"
		end

	objc_line_height_multiple (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item lineHeightMultiple];
			 ]"
		end

	objc_paragraph_spacing_before (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item paragraphSpacingBefore];
			 ]"
		end

	objc_default_tab_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item defaultTabInterval];
			 ]"
		end

	objc_text_blocks (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSParagraphStyle *)$an_item textBlocks];
			 ]"
		end

	objc_text_lists (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSParagraphStyle *)$an_item textLists];
			 ]"
		end

	objc_hyphenation_factor (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item hyphenationFactor];
			 ]"
		end

	objc_tightening_factor_for_truncation (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item tighteningFactorForTruncation];
			 ]"
		end

	objc_header_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSParagraphStyle *)$an_item headerLevel];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSParagraphStyle"
		end

end
