note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_LIST

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_marker_format__options_,
	make

feature {NONE} -- Initialization

	make_with_marker_format__options_ (a_format: detachable NS_STRING; a_mask: NATURAL_64)
			-- Initialize `Current'.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			make_with_pointer (objc_init_with_marker_format__options_(allocate_object, a_format__item, a_mask))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextList Externals

	objc_init_with_marker_format__options_ (an_item: POINTER; a_format: POINTER; a_mask: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextList *)$an_item initWithMarkerFormat:$a_format options:$a_mask];
			 ]"
		end

	objc_marker_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextList *)$an_item markerFormat];
			 ]"
		end

	objc_list_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextList *)$an_item listOptions];
			 ]"
		end

	objc_marker_for_item_number_ (an_item: POINTER; a_item_num: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextList *)$an_item markerForItemNumber:$a_item_num];
			 ]"
		end

	objc_set_starting_item_number_ (an_item: POINTER; a_item_num: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextList *)$an_item setStartingItemNumber:$a_item_num];
			 ]"
		end

	objc_starting_item_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextList *)$an_item startingItemNumber];
			 ]"
		end

feature -- NSTextList

	marker_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_marker_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like marker_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like marker_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	list_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_list_options (item)
		end

	marker_for_item_number_ (a_item_num: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_marker_for_item_number_ (item, a_item_num)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like marker_for_item_number_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like marker_for_item_number_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_starting_item_number_ (a_item_num: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_starting_item_number_ (item, a_item_num)
		end

	starting_item_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_starting_item_number (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextList"
		end

end
